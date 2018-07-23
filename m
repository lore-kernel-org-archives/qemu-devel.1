Received: from eggs.gnu.org ([2001:4830:134:3::10]:41322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIx-00028I-9Y
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIv-0003c6-Hi
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:39 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:41 -0500
Message-Id: <20180723201748.25573-33-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 32/99] util: implement simple iova tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

Introduce a simplest iova tree implementation based on GTree.

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit eecf5eedbdc0fc04f39abcf3afeedfbf21b25ca4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 MAINTAINERS              |   6 ++
 include/qemu/iova-tree.h | 134 +++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs       |   1 +
 util/iova-tree.c         | 114 +++++++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 include/qemu/iova-tree.h
 create mode 100644 util/iova-tree.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 24b70169bc..ada7c33485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1781,6 +1781,12 @@ F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
 
+IOVA Tree
+M: Peter Xu <peterx@redhat.com>
+S: Maintained
+F: include/qemu/iova-tree.h
+F: util/iova-tree.c
+
 Usermode Emulation
 ------------------
 Overall
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
new file mode 100644
index 0000000000..b061932097
--- /dev/null
+++ b/include/qemu/iova-tree.h
@@ -0,0 +1,134 @@
+/*
+ * An very simplified iova tree implementation based on GTree.
+ *
+ * Copyright 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *  Peter Xu <peterx@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ */
+#ifndef IOVA_TREE_H
+#define IOVA_TREE_H
+
+/*
+ * Currently the iova tree will only allow to keep ranges
+ * information, and no extra user data is allowed for each element.  A
+ * benefit is that we can merge adjacent ranges internally within the
+ * tree.  It can save a lot of memory when the ranges are splitted but
+ * mostly continuous.
+ *
+ * Note that current implementation does not provide any thread
+ * protections.  Callers of the iova tree should be responsible
+ * for the thread safety issue.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+#include "exec/hwaddr.h"
+
+#define  IOVA_OK           (0)
+#define  IOVA_ERR_INVALID  (-1) /* Invalid parameters */
+#define  IOVA_ERR_OVERLAP  (-2) /* IOVA range overlapped */
+
+typedef struct IOVATree IOVATree;
+typedef struct DMAMap {
+    hwaddr iova;
+    hwaddr translated_addr;
+    hwaddr size;                /* Inclusive */
+    IOMMUAccessFlags perm;
+} QEMU_PACKED DMAMap;
+typedef gboolean (*iova_tree_iterator)(DMAMap *map);
+
+/**
+ * iova_tree_new:
+ *
+ * Create a new iova tree.
+ *
+ * Returns: the tree pointer when succeeded, or NULL if error.
+ */
+IOVATree *iova_tree_new(void);
+
+/**
+ * iova_tree_insert:
+ *
+ * @tree: the iova tree to insert
+ * @map: the mapping to insert
+ *
+ * Insert an iova range to the tree.  If there is overlapped
+ * ranges, IOVA_ERR_OVERLAP will be returned.
+ *
+ * Return: 0 if succeeded, or <0 if error.
+ */
+int iova_tree_insert(IOVATree *tree, DMAMap *map);
+
+/**
+ * iova_tree_remove:
+ *
+ * @tree: the iova tree to remove range from
+ * @map: the map range to remove
+ *
+ * Remove mappings from the tree that are covered by the map range
+ * provided.  The range does not need to be exactly what has inserted,
+ * all the mappings that are included in the provided range will be
+ * removed from the tree.  Here map->translated_addr is meaningless.
+ *
+ * Return: 0 if succeeded, or <0 if error.
+ */
+int iova_tree_remove(IOVATree *tree, DMAMap *map);
+
+/**
+ * iova_tree_find:
+ *
+ * @tree: the iova tree to search from
+ * @map: the mapping to search
+ *
+ * Search for a mapping in the iova tree that overlaps with the
+ * mapping range specified.  Only the first found mapping will be
+ * returned.
+ *
+ * Return: DMAMap pointer if found, or NULL if not found.  Note that
+ * the returned DMAMap pointer is maintained internally.  User should
+ * only read the content but never modify or free the content.  Also,
+ * user is responsible to make sure the pointer is valid (say, no
+ * concurrent deletion in progress).
+ */
+DMAMap *iova_tree_find(IOVATree *tree, DMAMap *map);
+
+/**
+ * iova_tree_find_address:
+ *
+ * @tree: the iova tree to search from
+ * @iova: the iova address to find
+ *
+ * Similar to iova_tree_find(), but it tries to find mapping with
+ * range iova=iova & size=0.
+ *
+ * Return: same as iova_tree_find().
+ */
+DMAMap *iova_tree_find_address(IOVATree *tree, hwaddr iova);
+
+/**
+ * iova_tree_foreach:
+ *
+ * @tree: the iova tree to iterate on
+ * @iterator: the interator for the mappings, return true to stop
+ *
+ * Iterate over the iova tree.
+ *
+ * Return: 1 if found any overlap, 0 if not, <0 if error.
+ */
+void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator);
+
+/**
+ * iova_tree_destroy:
+ *
+ * @tree: the iova tree to destroy
+ *
+ * Destroy an existing iova tree.
+ *
+ * Return: None.
+ */
+void iova_tree_destroy(IOVATree *tree);
+
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 728c3541db..e1c3fed4dc 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -47,4 +47,5 @@ util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
+util-obj-y += iova-tree.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
diff --git a/util/iova-tree.c b/util/iova-tree.c
new file mode 100644
index 0000000000..2d9cebfc89
--- /dev/null
+++ b/util/iova-tree.c
@@ -0,0 +1,114 @@
+/*
+ * IOVA tree implementation based on GTree.
+ *
+ * Copyright 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *  Peter Xu <peterx@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ */
+
+#include <glib.h>
+#include "qemu/iova-tree.h"
+
+struct IOVATree {
+    GTree *tree;
+};
+
+static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
+{
+    const DMAMap *m1 = a, *m2 = b;
+
+    if (m1->iova > m2->iova + m2->size) {
+        return 1;
+    }
+
+    if (m1->iova + m1->size < m2->iova) {
+        return -1;
+    }
+
+    /* Overlapped */
+    return 0;
+}
+
+IOVATree *iova_tree_new(void)
+{
+    IOVATree *iova_tree = g_new0(IOVATree, 1);
+
+    /* We don't have values actually, no need to free */
+    iova_tree->tree = g_tree_new_full(iova_tree_compare, NULL, g_free, NULL);
+
+    return iova_tree;
+}
+
+DMAMap *iova_tree_find(IOVATree *tree, DMAMap *map)
+{
+    return g_tree_lookup(tree->tree, map);
+}
+
+DMAMap *iova_tree_find_address(IOVATree *tree, hwaddr iova)
+{
+    DMAMap map = { .iova = iova, .size = 0 };
+
+    return iova_tree_find(tree, &map);
+}
+
+static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
+{
+    /* Key and value are sharing the same range data */
+    g_tree_insert(gtree, range, range);
+}
+
+int iova_tree_insert(IOVATree *tree, DMAMap *map)
+{
+    DMAMap *new;
+
+    if (map->iova + map->size < map->iova || map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    /* We don't allow to insert range that overlaps with existings */
+    if (iova_tree_find(tree, map)) {
+        return IOVA_ERR_OVERLAP;
+    }
+
+    new = g_new0(DMAMap, 1);
+    memcpy(new, map, sizeof(*new));
+    iova_tree_insert_internal(tree->tree, new);
+
+    return IOVA_OK;
+}
+
+static gboolean iova_tree_traverse(gpointer key, gpointer value,
+                                gpointer data)
+{
+    iova_tree_iterator iterator = data;
+    DMAMap *map = key;
+
+    g_assert(key == value);
+
+    return iterator(map);
+}
+
+void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator)
+{
+    g_tree_foreach(tree->tree, iova_tree_traverse, iterator);
+}
+
+int iova_tree_remove(IOVATree *tree, DMAMap *map)
+{
+    DMAMap *overlap;
+
+    while ((overlap = iova_tree_find(tree, map))) {
+        g_tree_remove(tree->tree, overlap);
+    }
+
+    return IOVA_OK;
+}
+
+void iova_tree_destroy(IOVATree *tree)
+{
+    g_tree_destroy(tree->tree);
+    g_free(tree);
+}
-- 
2.17.1
