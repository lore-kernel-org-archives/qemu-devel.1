Received: from eggs.gnu.org ([2001:4830:134:3::10]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyl4-0001I0-7y
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyl0-0001ol-5n
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:14 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:27 +0300
Message-ID: <20161230143142.18214-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 03/18] util/rbcache: range-based cache core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, armbru@redhat.com

RBCache provides functionality to cache the data from block devices
(basically). The range here is used as the main key for searching and storing
data. The cache is based on red-black trees, so basic operations search,
insert, delete are performed for O(log n).

It is important to note that QEMU usually does not require a data cache, but
in reality, there are already some cases where a cache of small amounts can
increase performance, so as the data structure was selected red-black trees,
this is a fairly simple data structure and show high efficiency on a small
number of elements. Therefore, when the minimum range is 512 bytes, the
recommended size of the cache memory no more than 8-16mb.  Also note
that this cache implementation allows to store ranges of different lengths
without alignment.

Generic cache core can easily be used to implement different caching policies at
the block level, such as read-ahed. Also it can be used in some special cases,
for example for caching data in qcow2 when sequential allocating writes to image
with backing file.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 MAINTAINERS            |   6 ++
 include/qemu/rbcache.h | 128 +++++++++++++++++++++++++
 util/Makefile.objs     |   1 +
 util/rbcache.c         | 253 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 include/qemu/rbcache.h
 create mode 100644 util/rbcache.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 228278c1ca..01f4afa1e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1472,6 +1472,12 @@ F: include/qemu/rbtree.h
 F: include/qemu/rbtree_augmented.h
 F: util/rbtree.c
 
+Range-Based Cache
+M: Denis V. Lunev <den@openvz.org>
+S: Supported
+F: include/qemu/rbcache.h
+F: util/rbcache.c
+
 UUID
 M: Fam Zheng <famz@redhat.com>
 S: Supported
diff --git a/include/qemu/rbcache.h b/include/qemu/rbcache.h
new file mode 100644
index 0000000000..24f7c1cb80
--- /dev/null
+++ b/include/qemu/rbcache.h
@@ -0,0 +1,128 @@
+/*
+ * QEMU Range-Based Cache core
+ *
+ * Copyright (C) 2015-2016 Parallels IP Holdings GmbH.
+ *
+ * Author: Pavel Butsykin <pbutsykin@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef RBCACHE_H
+#define RBCACHE_H
+
+#include "qemu/rbtree.h"
+#include "qemu/queue.h"
+
+typedef struct RBCacheNode {
+    struct RbNode rb_node;
+    uint64_t offset;
+    uint64_t bytes;
+    QTAILQ_ENTRY(RBCacheNode) entry;
+} RBCacheNode;
+
+typedef struct RBCache RBCache;
+
+/* These callbacks are used to extend the common structure RBCacheNode. The
+ * alloc callback should initialize only fields of the expanded node. Node
+ * common part is initialized in RBCache( see rbcache_node_alloc() ).
+ */
+typedef RBCacheNode *RBNodeAlloc(uint64_t offset, uint64_t bytes, void *opaque);
+typedef void RBNodeFree(RBCacheNode *node, void *opaque);
+
+
+enum eviction_type {
+    RBCACHE_FIFO,
+    RBCACHE_LRU,
+};
+
+/**
+ * rbcache_search:
+ * @rbcache: the cache object.
+ * @offset: the start of the range.
+ * @bytes: the size of the range.
+ *
+ * Returns the node corresponding to the range(offset, bytes), or NULL if
+ * the node was not found. In the case when the range covers multiple nodes,
+ * it returns the node with the lowest offset.
+ */
+void *rbcache_search(RBCache *rbcache, uint64_t offset, uint64_t bytes);
+
+/**
+ * rbcache_insert:
+ * @rbcache: the cache object.
+ * @node: a new node for the cache.
+ *
+ * Returns the new node, or old node if a node describing the same range
+ * already exists. In case of partial overlaps, the existing overlapping node
+ * with the lowest offset is returned.
+ */
+void *rbcache_insert(RBCache *rbcache, RBCacheNode *node);
+
+/**
+ * rbcache_search_and_insert:
+ * @rbcache: the cache object.
+ * @offset: the start of the range.
+ * @bytes: the size of the range.
+ *
+ * rbcache_search_and_insert() is like rbcache_insert(), except that a new node
+ * is allocated inside the function. Returns the new node, or old node if a node
+ * describing the same range. In case of partial overlaps, the existing
+ * overlapping node with the lowest offset is returned.
+ */
+void *rbcache_search_and_insert(RBCache *rbcache, uint64_t offset,
+                                uint64_t byte);
+
+/**
+ * rbcache_remove:
+ * @rbcache: the cache object.
+ * @node: a node to remove.
+ *
+ * Removes the cached range owned by the node, it also frees the node.
+ */
+void rbcache_remove(RBCache *rbcache, RBCacheNode *node);
+
+/**
+ * rbcache_node_alloc:
+ * @rbcache: the cache object.
+ * @offset: the start of the range.
+ * @bytes: the size of the range.
+ *
+ * Returns an allocated and initialized node.
+ */
+RBCacheNode *rbcache_node_alloc(RBCache *rbcache, uint64_t offset,
+                                uint64_t bytes);
+
+/**
+ * rbcache_node_free:
+ * @rbcache: the cache object.
+ * @node: a node to free.
+ *
+ * Frees the node.
+ */
+void rbcache_node_free(RBCache *rbcache, RBCacheNode *node);
+
+/**
+ * rbcache_create:
+ * @alloc: callback to allocation node, allows to upgrade allocate and expand
+ *         the capabilities of the node.
+ * @free: callback to release node, must be used together with alloc callback.
+ * @limit_size: maximum cache size in bytes.
+ * @eviction_type: method of memory limitation
+ * @opaque: the opaque pointer to pass to the callback.
+ *
+ * Returns the cache object.
+ */
+RBCache *rbcache_create(RBNodeAlloc *alloc, RBNodeFree *free,
+                        uint64_t limit_size, int eviction_type, void *opaque);
+
+/**
+ * rbcache_destroy:
+ * @rbcache: the cache object.
+ *
+ * Cleanup the cache object created with rbcache_create().
+ */
+void rbcache_destroy(RBCache *rbcache);
+
+#endif /* RBCACHE_H */
diff --git a/util/Makefile.objs b/util/Makefile.objs
index a5607cb88f..e9f545ddbf 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -37,3 +37,4 @@ util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += rbtree.o
+util-obj-y += rbcache.o
diff --git a/util/rbcache.c b/util/rbcache.c
new file mode 100644
index 0000000000..2f1f860f76
--- /dev/null
+++ b/util/rbcache.c
@@ -0,0 +1,253 @@
+/*
+ * QEMU Range-Based Cache core
+ *
+ * Copyright (C) 2015-2016 Parallels IP Holdings GmbH.
+ *
+ * Author: Pavel Butsykin <pbutsykin@virtuozzo.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/rbcache.h"
+
+/* RBCache provides functionality to cache the data from block devices
+ * (basically). The range here is used as the main key for searching and storing
+ * data. The cache is based on red-black trees, so basic operations search,
+ * insert, delete are performed for O(log n).
+ *
+ * It is important to note that QEMU usually does not require a data cache, but
+ * in reality, there are already some cases where a cache of small amounts can
+ * increase performance, so as the data structure was selected red-black trees,
+ * this is a quite simple data structure and show high efficiency on a small
+ * number of elements. Therefore, when the minimum range is 512 bytes, the
+ * recommended size of the cache memory no more than 8-16mb. Also note that this
+ * cache implementation allows to store ranges of different lengths without
+ * alignment.
+ */
+
+struct RBCache {
+    struct RbRoot root;
+    RBNodeAlloc *alloc;
+    RBNodeFree  *free;
+    uint64_t limit_size;
+    uint64_t cur_size;
+    enum eviction_type eviction_type;
+    void *opaque;
+
+    QTAILQ_HEAD(RBCacheNodeHead, RBCacheNode) queue;
+};
+
+static int node_key_cmp(const RBCacheNode *node1, const RBCacheNode *node2)
+{
+    assert(node1 != NULL);
+    assert(node2 != NULL);
+
+    if (node1->offset >= node2->offset + node2->bytes) {
+        return 1;
+    }
+    if (node1->offset + node1->bytes <= node2->offset) {
+        return -1;
+    }
+
+    return 0;
+}
+
+/* Find leftmost node that intersects given target_offset. */
+static RBCacheNode *node_previous(RBCacheNode *node, uint64_t target_offset)
+{
+    while (node) {
+        struct RbNode *prev_rb_node = rb_prev(&node->rb_node);
+        RBCacheNode *prev_node;
+        if (prev_rb_node == NULL) {
+            break;
+        }
+        prev_node = container_of(prev_rb_node, RBCacheNode, rb_node);
+        if (prev_node->offset + prev_node->bytes <= target_offset) {
+            break;
+        }
+        node = prev_node;
+    }
+
+    assert(node != NULL);
+
+    return node;
+}
+
+RBCacheNode *rbcache_node_alloc(RBCache *rbcache, uint64_t offset,
+                                uint64_t bytes)
+{
+    RBCacheNode *node;
+
+    if (rbcache->alloc) {
+        node = rbcache->alloc(offset, bytes, rbcache->opaque);
+    } else {
+        node = g_new(RBCacheNode, 1);
+    }
+
+    node->offset = offset;
+    node->bytes  = bytes;
+
+    return node;
+}
+
+void rbcache_node_free(RBCache *rbcache, RBCacheNode *node)
+{
+    if (rbcache->free) {
+        rbcache->free(node, rbcache->opaque);
+    } else {
+        g_free(node);
+    }
+}
+
+static void rbcache_try_shrink(RBCache *rbcache)
+{
+    while (rbcache->cur_size > rbcache->limit_size) {
+        RBCacheNode *node;
+        assert(!QTAILQ_EMPTY(&rbcache->queue));
+
+        node = QTAILQ_LAST(&rbcache->queue, RBCacheNodeHead);
+
+        rbcache_remove(rbcache, node);
+    }
+}
+
+static inline void node_move_in_queue(RBCache *rbcache, RBCacheNode *node)
+{
+    if (rbcache->eviction_type == RBCACHE_LRU) {
+        QTAILQ_REMOVE(&rbcache->queue, node, entry);
+        QTAILQ_INSERT_HEAD(&rbcache->queue, node, entry);
+    }
+}
+
+/*
+ * Adds a new node to the tree if the range of the node doesn't overlap with
+ * existing nodes, and returns the new node. If the new node overlaps with
+ * another existing node, the tree is not changed and the function returns a
+ * pointer to the existing node. If the new node covers multiple nodes, then
+ * returns the leftmost node in the tree.
+ */
+static RBCacheNode *node_insert(RBCache *rbcache, RBCacheNode *node, bool alloc)
+{
+    struct RbNode **new, *parent = NULL;
+
+    assert(rbcache != NULL);
+    assert(node->bytes != 0);
+
+    /* Figure out where to put new node */
+    new = &(rbcache->root.rb_node);
+    while (*new) {
+        RBCacheNode *this = container_of(*new, RBCacheNode, rb_node);
+        int result = node_key_cmp(node, this);
+        if (result == 0) {
+            this = node_previous(this, node->offset);
+            node_move_in_queue(rbcache, this);
+            return this;
+        }
+        parent = *new;
+        new = result < 0 ? &((*new)->rb_left) : &((*new)->rb_right);
+    }
+
+    if (alloc) {
+        node = rbcache_node_alloc(rbcache, node->offset, node->bytes);
+    }
+    /* Add new node and rebalance tree. */
+    rb_link_node(&node->rb_node, parent, new);
+    rb_insert_color(&node->rb_node, &rbcache->root);
+
+    rbcache->cur_size += node->bytes;
+
+    rbcache_try_shrink(rbcache);
+
+    QTAILQ_INSERT_HEAD(&rbcache->queue, node, entry);
+
+    return node;
+}
+
+void *rbcache_search(RBCache *rbcache, uint64_t offset, uint64_t bytes)
+{
+    struct RbNode *rb_node;
+    RBCacheNode node = {
+        .offset = offset,
+        .bytes  = bytes,
+    };
+
+    assert(rbcache != NULL);
+
+    rb_node = rbcache->root.rb_node;
+    while (rb_node) {
+        RBCacheNode *this = container_of(rb_node, RBCacheNode, rb_node);
+        int32_t result = node_key_cmp(&node, this);
+        if (result == 0) {
+            this = node_previous(this, offset);
+            node_move_in_queue(rbcache, this);
+            return this;
+        }
+        rb_node = result < 0 ? rb_node->rb_left : rb_node->rb_right;
+    }
+    return NULL;
+}
+
+void *rbcache_insert(RBCache *rbcache, RBCacheNode *node)
+{
+    return node_insert(rbcache, node, false);
+}
+
+void *rbcache_search_and_insert(RBCache *rbcache, uint64_t offset,
+                                uint64_t bytes)
+{
+    RBCacheNode node = {
+        .offset = offset,
+        .bytes  = bytes,
+    };
+
+    return node_insert(rbcache, &node, true);
+}
+
+void rbcache_remove(RBCache *rbcache, RBCacheNode *node)
+{
+    assert(rbcache->cur_size >= node->bytes);
+
+    rbcache->cur_size -= node->bytes;
+    rb_erase(&node->rb_node, &rbcache->root);
+
+    QTAILQ_REMOVE(&rbcache->queue, node, entry);
+
+    rbcache_node_free(rbcache, node);
+}
+
+RBCache *rbcache_create(RBNodeAlloc *alloc, RBNodeFree *free,
+                        uint64_t limit_size, int eviction_type, void *opaque)
+{
+    RBCache *rbcache = g_new(RBCache, 1);
+
+    /* We can't use only one callback, or both or neither */
+    assert(!(!alloc ^ !free));
+
+    *rbcache = (RBCache) {
+        .root          = RB_ROOT,
+        .alloc         = alloc,
+        .free          = free,
+        .limit_size    = limit_size,
+        .eviction_type = eviction_type,
+        .opaque        = opaque,
+        .queue         = QTAILQ_HEAD_INITIALIZER(rbcache->queue),
+    };
+
+    return rbcache;
+}
+
+void rbcache_destroy(RBCache *rbcache)
+{
+    RBCacheNode *node, *next;
+
+    assert(rbcache != NULL);
+
+    QTAILQ_FOREACH_SAFE(node, &rbcache->queue, entry, next) {
+        QTAILQ_REMOVE(&rbcache->queue, node, entry);
+        rbcache_node_free(rbcache, node);
+    }
+
+    g_free(rbcache);
+}
-- 
2.11.0
