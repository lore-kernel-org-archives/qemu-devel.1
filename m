Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fFx3t-0003RF-8a
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fFx3q-000799-3b
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:29:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fFx3p-00078d-R1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:29:22 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue,  8 May 2018 15:29:07 +0800
Message-Id: <20180508072907.18959-1-peterx@redhat.com>
In-Reply-To: <20180504030811.28111-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/10] tests: add interval tree unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/test-interval-tree.c | 190 +++++++++++++++++++++++++++++++++++++
 tests/Makefile.include     |   2 +
 2 files changed, 192 insertions(+)
 create mode 100644 tests/test-interval-tree.c

diff --git a/tests/test-interval-tree.c b/tests/test-interval-tree.c
new file mode 100644
index 0000000000..a0e3decca0
--- /dev/null
+++ b/tests/test-interval-tree.c
@@ -0,0 +1,190 @@
+/*
+ * Interval tree tests
+ *
+ * Copyright Red Hat, Inc. 2018
+ *
+ * Authors:
+ *   Peter Xu <peterx@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/interval-tree.h"
+
+static ITRange ranges[2];
+static int range_i;
+
+static void ranges_reset(void)
+{
+    memset(&ranges, 0, sizeof(ranges));
+    range_i = 0;
+}
+
+static gboolean ranges_iterate(ITValue start, ITValue end)
+{
+    g_assert(range_i < ARRAY_SIZE(ranges));
+    ranges[range_i].start = start;
+    ranges[range_i].end = end;
+    range_i++;
+    return FALSE;
+}
+
+static void ranges_check(void)
+{
+    g_assert(range_i == 2);
+    g_assert(ranges[0].start == 10 && ranges[0].end == 19);
+    g_assert(ranges[1].start == 30 && ranges[1].end == 39);
+}
+
+static void test_interval_tree_common(void)
+{
+    int ret;
+    ITTree *tree = it_tree_new();
+    ITRange *range;
+
+    g_assert(tree);
+
+    /* Test insertion */
+    ret = it_tree_insert(tree, 10, 19);
+    g_assert(ret == 0);
+    ret = it_tree_insert(tree, 30, 39);
+    g_assert(ret == 0);
+    ret = it_tree_insert(tree, 15, 19);
+    g_assert(ret == IT_ERR_OVERLAP);
+    ret = it_tree_insert(tree, 0, 99);
+    g_assert(ret == IT_ERR_OVERLAP);
+
+    /* Test searching */
+    range = it_tree_find(tree, 0, 9);
+    g_assert(range == NULL);
+    range = it_tree_find(tree, 10, 19);
+    g_assert(range->start == 10 && range->end == 19);
+    range = it_tree_find_value(tree, 15);
+    g_assert(range->start == 10 && range->end == 19);
+    range = it_tree_find(tree, 15, 99);
+    g_assert(range->start == 10 && range->end == 19);
+    range = it_tree_find_value(tree, 35);
+    g_assert(range->start == 30 && range->end == 39);
+
+    /* Test iterations */
+    ranges_reset();
+    it_tree_foreach(tree, ranges_iterate);
+    ranges_check();
+
+    /* Remove one of them */
+    ret = it_tree_remove(tree, 10, 19);
+    g_assert(ret == 0);
+    g_assert(!it_tree_find(tree, 10, 19));
+    g_assert(it_tree_find(tree, 30, 39));
+
+    it_tree_destroy(tree);
+}
+
+static void test_interval_tree_merging(void)
+{
+    int ret;
+    ITTree *tree = it_tree_new();
+    ITRange *range;
+
+    g_assert(tree);
+
+    ret = it_tree_insert(tree, 10, 19);
+    g_assert(ret == 0);
+    ret = it_tree_insert(tree, 30, 39);
+    g_assert(ret == 0);
+
+    /* Test left side merging */
+    ret = it_tree_insert(tree, 40, 59);
+    g_assert(ret == 0);
+    range = it_tree_find(tree, 30, 39);
+    g_assert(range->start == 30 && range->end == 59);
+
+    /* Test right side merging */
+    ret = it_tree_insert(tree, 0, 9);
+    g_assert(ret == 0);
+    range = it_tree_find(tree, 10, 19);
+    g_assert(range->start == 0 && range->end == 19);
+
+    /* Test bidirectional merging */
+    ret = it_tree_insert(tree, 20, 29);
+    g_assert(ret == 0);
+    range = it_tree_find(tree, 20, 29);
+    g_assert(range->start == 0 && range->end == 59);
+    range = it_tree_find(tree, 0, 29);
+    g_assert(range->start == 0 && range->end == 59);
+    range = it_tree_find(tree, 40, 45);
+    g_assert(range->start == 0 && range->end == 59);
+
+    it_tree_destroy(tree);
+}
+
+static void test_interval_tree_removal(void)
+{
+    int ret;
+    ITTree *tree = it_tree_new();
+    ITRange *range;
+
+    g_assert(tree);
+
+    ret = it_tree_insert(tree, 10, 19);
+    g_assert(ret == 0);
+    ret = it_tree_insert(tree, 30, 39);
+    g_assert(ret == 0);
+
+    /*
+     * Remove some useless areas, which should not remove any existing
+     * ranges in the tree
+     */
+    ret = it_tree_remove(tree, 0, 9);
+    g_assert(ret == 0);
+    ret = it_tree_remove(tree, 50, 99);
+    g_assert(ret == 0);
+    ret = it_tree_remove(tree, 20, 29);
+    g_assert(ret == 0);
+    /* Make sure the elements are not removed */
+    g_assert(it_tree_find(tree, 10, 19));
+    g_assert(it_tree_find(tree, 30, 39));
+
+    /* Remove left subset of a range */
+    ret = it_tree_remove(tree, 0, 14);
+    g_assert(ret == 0);
+    range = it_tree_find(tree, 10, 19);
+    g_assert(range->start == 15 && range->end == 19);
+    it_tree_insert(tree, 10, 15);
+
+    /* Remove right subset of a range */
+    ret = it_tree_remove(tree, 35, 45);
+    g_assert(ret == 0);
+    range = it_tree_find(tree, 30, 39);
+    g_assert(range->start == 30 && range->end == 34);
+    it_tree_insert(tree, 35, 39);
+
+    /* Remove covers more than one range */
+    ret = it_tree_remove(tree, 0, 40);
+    g_assert(ret == 0);
+    g_assert(!it_tree_find(tree, 10, 19));
+    g_assert(!it_tree_find(tree, 30, 39));
+    it_tree_insert(tree, 10, 19);
+    it_tree_insert(tree, 30, 39);
+
+    /* Remove in the middle */
+    ret = it_tree_remove(tree, 12, 16);
+    g_assert(ret == 0);
+    range = it_tree_find_value(tree, 10);
+    g_assert(range->start == 10 && range->end == 11);
+    range = it_tree_find_value(tree, 17);
+    g_assert(range->start == 17 && range->end == 19);
+
+    it_tree_destroy(tree);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/interval-tree/common", test_interval_tree_common);
+    g_test_add_func("/interval-tree/merging", test_interval_tree_merging);
+    g_test_add_func("/interval-tree/removal", test_interval_tree_removal);
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b9a5e31a2..db1e6c93db 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -169,6 +169,7 @@ check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
+check-unit-y += tests/test-interval-tree$(EXESUF)
 
 check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
@@ -642,6 +643,7 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
 tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+tests/test-interval-tree$(EXESUF): tests/test-interval-tree.o $(test-util-obj-y)
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-- 
2.17.0
