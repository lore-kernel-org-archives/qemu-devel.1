Received: from eggs.gnu.org ([2001:4830:134:3::10]:42575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lC-000365-IM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1lB-000272-GK
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:46 +0100
Message-Id: <20171221142251.18366-15-kwolf@redhat.com>
In-Reply-To: <20171221142251.18366-1-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/19] test-bdrv-drain: Test behaviour in
 coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

If bdrv_do_drained_begin/end() are called in coroutine context, they
first use a BH to get out of the coroutine context. Call some existing
tests again from a coroutine to cover this code path.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index c00d96bb2f..16ff3483e3 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -82,6 +82,34 @@ static void aio_ret_cb(void *opaque, int ret)
     *aio_ret = ret;
 }
 
+typedef struct CallInCoroutineData {
+    void (*entry)(void);
+    bool done;
+} CallInCoroutineData;
+
+static coroutine_fn void call_in_coroutine_entry(void *opaque)
+{
+    CallInCoroutineData *data = opaque;
+
+    data->entry();
+    data->done = true;
+}
+
+static void call_in_coroutine(void (*entry)(void))
+{
+    Coroutine *co;
+    CallInCoroutineData data = {
+        .entry  = entry,
+        .done   = false,
+    };
+
+    co = qemu_coroutine_create(call_in_coroutine_entry, &data);
+    qemu_coroutine_enter(co);
+    while (!data.done) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+}
+
 enum drain_type {
     BDRV_DRAIN_ALL,
     BDRV_DRAIN,
@@ -188,6 +216,16 @@ static void test_drv_cb_drain_subtree(void)
     test_drv_cb_common(BDRV_SUBTREE_DRAIN, true);
 }
 
+static void test_drv_cb_co_drain(void)
+{
+    call_in_coroutine(test_drv_cb_drain);
+}
+
+static void test_drv_cb_co_drain_subtree(void)
+{
+    call_in_coroutine(test_drv_cb_drain_subtree);
+}
+
 static void test_quiesce_common(enum drain_type drain_type, bool recursive)
 {
     BlockBackend *blk;
@@ -235,6 +273,16 @@ static void test_quiesce_drain_subtree(void)
     test_quiesce_common(BDRV_SUBTREE_DRAIN, true);
 }
 
+static void test_quiesce_co_drain(void)
+{
+    call_in_coroutine(test_quiesce_drain);
+}
+
+static void test_quiesce_co_drain_subtree(void)
+{
+    call_in_coroutine(test_quiesce_drain_subtree);
+}
+
 static void test_nested(void)
 {
     BlockBackend *blk;
@@ -422,11 +470,22 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/driver-cb/drain_subtree",
                     test_drv_cb_drain_subtree);
 
+    // XXX bdrv_drain_all() doesn't work in coroutine context
+    g_test_add_func("/bdrv-drain/driver-cb/co/drain", test_drv_cb_co_drain);
+    g_test_add_func("/bdrv-drain/driver-cb/co/drain_subtree",
+                    test_drv_cb_co_drain_subtree);
+
+
     g_test_add_func("/bdrv-drain/quiesce/drain_all", test_quiesce_drain_all);
     g_test_add_func("/bdrv-drain/quiesce/drain", test_quiesce_drain);
     g_test_add_func("/bdrv-drain/quiesce/drain_subtree",
                     test_quiesce_drain_subtree);
 
+    // XXX bdrv_drain_all() doesn't work in coroutine context
+    g_test_add_func("/bdrv-drain/quiesce/co/drain", test_quiesce_co_drain);
+    g_test_add_func("/bdrv-drain/quiesce/co/drain_subtree",
+                    test_quiesce_co_drain_subtree);
+
     g_test_add_func("/bdrv-drain/nested", test_nested);
 
     g_test_add_func("/bdrv-drain/blockjob/drain_all", test_blockjob_drain_all);
-- 
2.13.6
