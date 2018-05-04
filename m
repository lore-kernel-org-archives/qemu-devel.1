Received: from eggs.gnu.org ([2001:4830:134:3::10]:33394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER5r-0001xV-Jk
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER5n-0005nw-CT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fER5n-0005nf-6A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:07 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  4 May 2018 11:08:08 +0800
Message-Id: <20180504030811.28111-8-peterx@redhat.com>
In-Reply-To: <20180504030811.28111-1-peterx@redhat.com>
References: <20180504030811.28111-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/10] util: implement simple interval tree
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Introduce a simplest interval tree implementation based on GTree.
Current implementation is mostly tailored to maintain and trace device
mapped IOVA ranges, but still it might be useful to other modules in the
future.

It is naive in that it even does not allow user to pass in private
structs along with the ranges.  However it's good in that the tree can
do mergings of ranges when necessary when without such information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/interval-tree.h | 130 ++++++++++++++++++++++
 util/interval-tree.c         | 208 +++++++++++++++++++++++++++++++++++
 util/Makefile.objs           |   1 +
 3 files changed, 339 insertions(+)
 create mode 100644 include/qemu/interval-tree.h
 create mode 100644 util/interval-tree.c

diff --git a/include/qemu/interval-tree.h b/include/qemu/interval-tree.h
new file mode 100644
index 0000000000..14d364455b
--- /dev/null
+++ b/include/qemu/interval-tree.h
@@ -0,0 +1,130 @@
+/*
+ * An very simplified interval tree implementation based on GTree.
+ *
+ * Copyright 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *  Peter Xu <peterx@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ */
+#ifndef INTERVAL_TREE_H
+#define INTERVAL_TREE_H
+
+/*
+ * Currently the interval tree will only allow to keep ranges
+ * information, and no extra user data is allowed for each element.  A
+ * benefit is that we can merge adjacent ranges internally within the
+ * tree.  It can save a lot of memory when the ranges are splitted but
+ * mostly continuous.
+ *
+ * Note that current implementation does not provide any thread
+ * protections.  Callers of the interval tree should be responsible
+ * for the thread safety issue.
+ */
+
+#include <glib.h>
+
+#define  IT_OK           (0)
+#define  IT_ERR_OVERLAP  (-1)
+
+typedef unsigned long long ITValue;
+typedef struct ITTree ITTree;
+typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);
+
+struct ITRange {
+    ITValue start;
+    ITValue end;
+};
+typedef struct ITRange ITRange;
+
+/**
+ * it_tree_new:
+ *
+ * Create a new interval tree.
+ *
+ * Returns: the tree pointer when succeeded, or NULL if error.
+ */
+ITTree *it_tree_new(void);
+
+/**
+ * it_tree_insert:
+ *
+ * @tree: the interval tree to insert
+ * @start: the start of range, inclusive
+ * @end: the end of range, inclusive
+ *
+ * Insert an interval range to the tree.  If there is overlapped
+ * ranges, IT_ERR_OVERLAP will be returned.
+ *
+ * Return: 0 if succeeded, or <0 if error.
+ */
+int it_tree_insert(ITTree *tree, ITValue start, ITValue end);
+
+/**
+ * it_tree_remove:
+ *
+ * @tree: the interval tree to remove range from
+ * @start: the start of range, inclusive
+ * @end: the end of range, inclusive
+ *
+ * Remove an range from the tree.  The range does not need to be
+ * exactly what has inserted.  All the ranges that are included in the
+ * provided range will be removed from the tree.
+ *
+ * Return: 0 if succeeded, or <0 if error.
+ */
+int it_tree_remove(ITTree *tree, ITValue start, ITValue end);
+
+/**
+ * it_tree_find:
+ *
+ * @tree: the interval tree to search from
+ * @start: the start of range, inclusive
+ * @end: the end of range, inclusive
+ *
+ * Search for a range in the interval tree that overlaps with the
+ * range specified.  Only the first found range will be returned.
+ *
+ * Return: ITRange if found, or NULL if not found.  Note: the returned
+ * ITRange pointer is maintained internally.  User should only read
+ * the content but never modify or free the content.
+ */
+ITRange *it_tree_find(ITTree *tree, ITValue start, ITValue end);
+
+/**
+ * it_tree_find_value:
+ *
+ * @tree: the interval tree to search from
+ * @value: the value to find
+ *
+ * Similar to it_tree_find(), but it tries to find range (value, value).
+ *
+ * Return: same as it_tree_find().
+ */
+ITRange *it_tree_find_value(ITTree *tree, ITValue value);
+
+/**
+ * it_tree_foreach:
+ *
+ * @tree: the interval tree to iterate on
+ * @iterator: the interator for the ranges, return true to stop
+ *
+ * Search for a range in the interval tree.
+ *
+ * Return: 1 if found any overlap, 0 if not, <0 if error.
+ */
+void it_tree_foreach(ITTree *tree, it_tree_iterator iterator);
+
+/**
+ * it_tree_destroy:
+ *
+ * @tree: the interval tree to destroy
+ *
+ * Destroy an existing interval tree.
+ *
+ * Return: None.
+ */
+void it_tree_destroy(ITTree *tree);
+
+#endif
diff --git a/util/interval-tree.c b/util/interval-tree.c
new file mode 100644
index 0000000000..3d2bb951aa
--- /dev/null
+++ b/util/interval-tree.c
@@ -0,0 +1,208 @@
+/*
+ * An very simplified interval tree implementation based on GTree.
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
+#include "qemu/interval-tree.h"
+
+/*
+ * Each element of the internal tree is an ITRange.  It is shared
+ * between the key and value of the element, or we can see it a tree
+ * with keys only but no values.
+ */
+
+struct ITTree {
+    GTree *tree;
+};
+
+static int it_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
+{
+    const ITRange *r1 = a, *r2 = b;
+
+    if (r1->start > r2->end) {
+        return 1;
+    }
+
+    if (r1->end < r2->start) {
+        return -1;
+    }
+
+    /* Overlapped */
+    return 0;
+}
+
+/* Find out intersection of range A and B, put into OUT */
+static inline void it_range_and(ITRange *out, ITRange *a, ITRange *b)
+{
+    out->start = MAX(a->start, b->start);
+    out->end = MIN(a->end, b->end);
+}
+
+static inline gboolean it_range_equal(ITRange *a, ITRange *b)
+{
+    return a->start == b->start && a->end == b->end;
+}
+
+/* Whether ITRange A is superset of B? */
+static inline gboolean it_range_cover(ITRange *a, ITRange *b)
+{
+    return a->start <= b->start && a->end >= b->end;
+}
+
+ITTree *it_tree_new(void)
+{
+    ITTree *ittree = g_new0(ITTree, 1);
+
+    /* We don't have values actually, no need to free */
+    ittree->tree = g_tree_new_full(it_tree_compare, NULL, g_free, NULL);
+
+    return ittree;
+}
+
+ITRange *it_tree_find(ITTree *tree, ITValue start, ITValue end)
+{
+    ITRange range;
+
+    g_assert(tree);
+
+    range.start = start;
+    range.end = end;
+
+    return g_tree_lookup(tree->tree, &range);
+}
+
+ITRange *it_tree_find_value(ITTree *tree, ITValue value)
+{
+    return it_tree_find(tree, value, value);
+}
+
+static inline void it_tree_insert_internal(GTree *gtree, ITRange *range)
+{
+    /* Key and value are sharing the same range data */
+    g_tree_insert(gtree, range, range);
+}
+
+int it_tree_insert(ITTree *tree, ITValue start, ITValue end)
+{
+    ITRange range, *new, *overlap;
+    GTree *gtree;
+
+    g_assert(tree);
+    g_assert(start <= end);
+
+    gtree = tree->tree;
+
+    range.start = start;
+    range.end = end;
+
+    /* We don't allow to insert range that overlaps with existings */
+    if (g_tree_lookup(gtree, &range)) {
+        return IT_ERR_OVERLAP;
+    }
+
+    /* Merge left adjacent range */
+    overlap = it_tree_find_value(tree, start - 1);
+    if (overlap) {
+        range.start = overlap->start;
+        g_tree_remove(gtree, overlap);
+    }
+
+    /* Merge right adjacent range */
+    overlap = it_tree_find_value(tree, end + 1);
+    if (overlap) {
+        range.end = overlap->end;
+        g_tree_remove(gtree, overlap);
+    }
+
+    new = g_new0(ITRange, 1);
+    new->start = range.start;
+    new->end = range.end;
+    it_tree_insert_internal(gtree, new);
+
+    return IT_OK;
+}
+
+static gboolean it_tree_traverse(gpointer key, gpointer value,
+                                gpointer data)
+{
+    it_tree_iterator iterator = data;
+    ITRange *range = key;
+
+    g_assert(key == value);
+
+    return iterator(range->start, range->end);
+}
+
+void it_tree_foreach(ITTree *tree, it_tree_iterator iterator)
+{
+    g_assert(tree && iterator);
+    g_tree_foreach(tree->tree, it_tree_traverse, iterator);
+}
+
+/* Remove subset `range', which is part of `overlap'. */
+static void it_tree_remove_subset(GTree *gtree, const ITRange *overlap,
+                                  const ITRange *range)
+{
+    ITRange *range1, *range2;
+
+    if (overlap->start < range->start) {
+        range1 = g_new0(ITRange, 1);
+        range1->start = overlap->start;
+        range1->end = range->start - 1;
+    } else {
+        range1 = NULL;
+    }
+    if (range->end < overlap->end) {
+        range2 = g_new0(ITRange, 1);
+        range2->start = range->end + 1;
+        range2->end = overlap->end;
+    } else {
+        range2 = NULL;
+    }
+
+    g_tree_remove(gtree, overlap);
+
+    if (range1) {
+        it_tree_insert_internal(gtree, range1);
+    }
+    if (range2) {
+        it_tree_insert_internal(gtree, range2);
+    }
+}
+
+int it_tree_remove(ITTree *tree, ITValue start, ITValue end)
+{
+    ITRange range = { .start = start, .end = end }, *overlap, and;
+    GTree *gtree;
+
+    g_assert(tree);
+
+    gtree = tree->tree;
+    while ((overlap = g_tree_lookup(gtree, &range))) {
+        if (it_range_cover(overlap, &range)) {
+            /* Split existing range into two if needed; done */
+            it_tree_remove_subset(gtree, overlap, &range);
+            break;
+        } else {
+            /* Remove intersection and continue */
+            it_range_and(&and, overlap, &range);
+            g_assert(and.start <= and.end);
+            it_tree_remove_subset(gtree, overlap, &and);
+        }
+    }
+
+    return IT_OK;
+}
+
+void it_tree_destroy(ITTree *tree)
+{
+    g_tree_destroy(tree->tree);
+    g_free(tree);
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 728c3541db..4ac33910ed 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -47,4 +47,5 @@ util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
+util-obj-y += interval-tree.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
-- 
2.17.0
