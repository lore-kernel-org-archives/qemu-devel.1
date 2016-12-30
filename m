Received: from eggs.gnu.org ([2001:4830:134:3::10]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN0bk-0007Kt-T8
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 12:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN0bh-0005CN-GU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 12:04:44 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:28 +0300
Message-ID: <20161230143142.18214-5-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 04/18] tests/test-rbcache: add test cases
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

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 tests/Makefile.include |   3 +
 tests/test-rbcache.c   | 431 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 434 insertions(+)
 create mode 100644 tests/test-rbcache.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4841d582a1..74bdcd2aac 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -55,6 +55,8 @@ check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
+gcov-files-test-rbcache-y = util/rbcache.c
+check-unit-y += tests/test-rbcache$(EXESUF)
 check-unit-y += tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 gcov-files-test-x86-cpuid-y =
@@ -498,6 +500,7 @@ tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y)
+tests/test-rbcache$(EXESUF): tests/test-rbcache.o $(test-util-obj-y)
 tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
 tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o page_cache.o $(test-util-obj-y)
 tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
diff --git a/tests/test-rbcache.c b/tests/test-rbcache.c
new file mode 100644
index 0000000000..40ccd6b225
--- /dev/null
+++ b/tests/test-rbcache.c
@@ -0,0 +1,431 @@
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
+typedef struct TestRBCacheData {
+    RBCache *cache;
+} TestRBCacheData;
+
+typedef struct TestRBCacheConfig {
+    uint64_t limit_size;
+    int eviction_type;
+    RBNodeAlloc *alloc;
+    RBNodeFree  *free;
+    void *opaque;
+} TestRBCacheConfig;
+
+#define KB(_n) ((_n) << 10)
+#define MB(_n) ((_n) << 20)
+
+#define OFFSET1 0
+#define SIZE1   KB(1)
+
+#define OFFSET2 KB(1)
+#define SIZE2   KB(2)
+
+#define OFFSET3 KB(18)
+#define SIZE3   KB(1)
+
+#define OFFSET4 KB(7)
+#define SIZE4   KB(7)
+
+#define OFFSET5 KB(1)
+#define SIZE5   KB(4)
+
+#define OFFSET6 KB(5)
+#define SIZE6   KB(5)
+
+#define OFFSET7 KB(15)
+#define SIZE7   KB(20)
+
+#define OFFSET8 KB(2)
+#define SIZE8   KB(20)
+
+
+static void test_rbcache_init(TestRBCacheData *data, const void *ctx)
+{
+    g_assert_nonnull(data->cache);
+}
+
+static void test_rbcache_insert(TestRBCacheData *data, const void *ctx)
+{
+    RBCacheNode *node1 = rbcache_node_alloc(data->cache, OFFSET1, SIZE1);
+    RBCacheNode *node2 = rbcache_node_alloc(data->cache, OFFSET2, SIZE2);
+    RBCacheNode *node3 = rbcache_node_alloc(data->cache, OFFSET3, SIZE3);
+    RBCacheNode *node4 = rbcache_node_alloc(data->cache, OFFSET4, SIZE4);
+    RBCacheNode *node5 = rbcache_node_alloc(data->cache, OFFSET5, SIZE5);
+    RBCacheNode *node6 = rbcache_node_alloc(data->cache, OFFSET6, SIZE6);
+    RBCacheNode *node7 = rbcache_node_alloc(data->cache, OFFSET7, SIZE7);
+    RBCacheNode *node8 = rbcache_node_alloc(data->cache, OFFSET8, SIZE8);
+    RBCacheNode *node;
+
+    node = rbcache_insert(data->cache, node2);
+    g_assert_true(node == node2);
+
+    node = rbcache_insert(data->cache, node1);
+    g_assert_true(node == node1);
+
+    node = rbcache_insert(data->cache, node3);
+    g_assert_true(node == node3);
+
+    node = rbcache_insert(data->cache, node4);
+    g_assert_true(node == node4);
+
+    node = rbcache_insert(data->cache, node5);
+    g_assert_true(node == node2);
+    rbcache_node_free(data->cache, node5);
+
+    node = rbcache_insert(data->cache, node6);
+    g_assert_true(node == node4);
+    rbcache_node_free(data->cache, node6);
+
+    node = rbcache_insert(data->cache, node7);
+    g_assert_true(node == node3);
+    rbcache_node_free(data->cache, node7);
+
+    node = rbcache_insert(data->cache, node8);
+    g_assert_true(node == node2);
+    rbcache_node_free(data->cache, node8);
+}
+
+static void test_rbcache_search(TestRBCacheData *data, const void *ctx)
+{
+    RBCacheNode *node;
+
+    test_rbcache_insert(data, ctx);
+
+    node = rbcache_search(data->cache, OFFSET1, SIZE1);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET1);
+    g_assert_cmpuint(node->bytes, ==, SIZE1);
+
+    node = rbcache_search(data->cache, OFFSET2 + KB(1), SIZE2);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET2);
+    g_assert_cmpuint(node->bytes, ==, SIZE2);
+
+    node = rbcache_search(data->cache, OFFSET8, SIZE8);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET2);
+    g_assert_cmpuint(node->bytes, ==, SIZE2);
+
+    node = rbcache_search(data->cache, OFFSET8 + KB(2), SIZE5);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET4);
+    g_assert_cmpuint(node->bytes, ==, OFFSET4);
+
+    node = rbcache_search(data->cache, OFFSET3 + SIZE3, SIZE3);
+    g_assert_null(node);
+}
+
+static void test_rbcache_search_and_insert(TestRBCacheData *data,
+                                           const void *ctx)
+{
+    RBCacheNode *node;
+
+    node = rbcache_search_and_insert(data->cache, OFFSET2, SIZE2);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET2);
+    g_assert_cmpuint(node->bytes, ==, SIZE2);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET1, SIZE1);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET1);
+    g_assert_cmpuint(node->bytes, ==, SIZE1);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET3, SIZE3);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET3);
+    g_assert_cmpuint(node->bytes, ==, SIZE3);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET4, SIZE4);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET4);
+    g_assert_cmpuint(node->bytes, ==, SIZE4);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET5, SIZE5);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET2);
+    g_assert_cmpuint(node->bytes, ==, SIZE2);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET6, SIZE6);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET4);
+    g_assert_cmpuint(node->bytes, ==, SIZE4);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET7, SIZE7);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET3);
+    g_assert_cmpuint(node->bytes, ==, SIZE3);
+
+    node = rbcache_search_and_insert(data->cache, OFFSET8, SIZE8);
+    g_assert_nonnull(node);
+    g_assert_cmpuint(node->offset, ==, OFFSET2);
+    g_assert_cmpuint(node->bytes, ==, SIZE2);
+}
+
+static void test_rbcache_remove(TestRBCacheData *data, const void *ctx)
+{
+    RBCacheNode *node;
+
+    test_rbcache_search_and_insert(data, ctx);
+
+    node = rbcache_search(data->cache, OFFSET1, SIZE1);
+    g_assert_nonnull(node);
+    rbcache_remove(data->cache, node);
+    node = rbcache_search(data->cache, OFFSET1, SIZE1);
+    g_assert_null(node);
+
+    node = rbcache_search(data->cache, OFFSET3, SIZE3);
+    g_assert_nonnull(node);
+    rbcache_remove(data->cache, node);
+    node = rbcache_search(data->cache, OFFSET3, SIZE3);
+    g_assert_null(node);
+
+    node = rbcache_search(data->cache, OFFSET4, SIZE4);
+    g_assert_nonnull(node);
+    rbcache_remove(data->cache, node);
+    node = rbcache_search(data->cache, OFFSET4, SIZE4);
+    g_assert_null(node);
+
+    node = rbcache_search(data->cache, OFFSET2, SIZE2);
+    g_assert_nonnull(node);
+    rbcache_remove(data->cache, node);
+    node = rbcache_search(data->cache, OFFSET2, SIZE2);
+    g_assert_null(node);
+}
+
+static void test_rbcache_shrink(TestRBCacheData *data, const void *ctx)
+{
+    RBCacheNode *node;
+
+    node = rbcache_search_and_insert(data->cache, 0, MB(2));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(2), MB(3));
+    g_assert_nonnull(node);
+
+    node = rbcache_search(data->cache, 0, MB(2));
+    g_assert_null(node);
+
+    node = rbcache_search(data->cache, MB(2), MB(3));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, 0, MB(2));
+    g_assert_nonnull(node);
+
+    node = rbcache_search(data->cache, 0, MB(2));
+    g_assert_nonnull(node);
+
+    node = rbcache_search(data->cache, MB(2), MB(3));
+    g_assert_null(node);
+}
+
+static void test_rbcache_shrink_fifo(TestRBCacheData *data, const void *ctx)
+{
+    RBCacheNode *node;
+
+    rbcache_search_and_insert(data->cache, 0, MB(1));
+    rbcache_search_and_insert(data->cache, MB(1), MB(1));
+    rbcache_search_and_insert(data->cache, MB(2), MB(1));
+    rbcache_search_and_insert(data->cache, MB(3), MB(1));
+
+    node = rbcache_search_and_insert(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(6), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(6), MB(1));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(7), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(6), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(7), MB(1));
+    g_assert_nonnull(node);
+}
+
+static void test_rbcache_shrink_lru(TestRBCacheData *data, const void *ctx)
+{
+    RBCacheNode *node;
+
+    rbcache_search_and_insert(data->cache, 0, MB(1));
+    rbcache_search_and_insert(data->cache, MB(1), MB(1));
+    rbcache_search_and_insert(data->cache, MB(2), MB(1));
+    rbcache_search_and_insert(data->cache, MB(3), MB(1));
+
+    node = rbcache_search_and_insert(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(6), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(6), MB(1));
+    g_assert_nonnull(node);
+
+    node = rbcache_search_and_insert(data->cache, MB(7), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, 0, MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(3), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(1), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(2), MB(1));
+    g_assert_null(node);
+    node = rbcache_search(data->cache, MB(4), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(5), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(6), MB(1));
+    g_assert_nonnull(node);
+    node = rbcache_search(data->cache, MB(7), MB(1));
+    g_assert_nonnull(node);
+}
+
+static void test_rbcache_setup(TestRBCacheData *data, const void *ctx)
+{
+    const TestRBCacheConfig *config = ctx;
+
+    data->cache =
+        rbcache_create(config->alloc, config->free, config->limit_size,
+                       config->eviction_type, config->opaque);
+}
+
+static void test_rbcache_teardown(TestRBCacheData *data, const void *ctx)
+{
+    rbcache_destroy(data->cache);
+}
+
+static void rbcache_test_add(const char *testpath,
+                             void (*test_func)(TestRBCacheData *data,
+                             const void *user_data), void *ctx)
+{
+    g_test_add(testpath, TestRBCacheData, ctx, test_rbcache_setup, test_func,
+               test_rbcache_teardown);
+}
+
+int main(int argc, char **argv)
+{
+    TestRBCacheConfig config = {
+        .limit_size = MB(4),
+        .eviction_type = RBCACHE_FIFO,
+    };
+    TestRBCacheConfig config_lru = {
+        .limit_size = MB(4),
+        .eviction_type = RBCACHE_LRU,
+    };
+
+    g_test_init(&argc, &argv, NULL);
+
+    rbcache_test_add("/rbcache/init", test_rbcache_init, &config);
+    rbcache_test_add("/rbcache/insert", test_rbcache_insert, &config);
+    rbcache_test_add("/rbcache/search", test_rbcache_search, &config);
+    rbcache_test_add("/rbcache/search_and_insert",
+                     test_rbcache_search_and_insert, &config);
+    rbcache_test_add("/rbcache/rbcache_remove", test_rbcache_remove, &config);
+    rbcache_test_add("/rbcache/shrink", test_rbcache_shrink, &config);
+    rbcache_test_add("/rbcache/shrink/fifo", test_rbcache_shrink_fifo, &config);
+    rbcache_test_add("/rbcache/shrink/lru", test_rbcache_shrink_lru,
+                     &config_lru);
+
+    g_test_run();
+
+    return 0;
+}
-- 
2.11.0
