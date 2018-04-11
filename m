Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6In4-0002YO-MR
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6In3-0004QI-Mt
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Apr 2018 18:39:26 +0200
Message-Id: <20180411163940.2523-6-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
References: <20180411163940.2523-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 05/19] tests/test-bdrv-drain: bdrv_drain_all()
 works in coroutines now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Since we use bdrv_do_drained_begin/end() for bdrv_drain_all_begin/end(),
coroutine context is automatically left with a BH, preventing the
deadlocks that made bdrv_drain_all*() unsafe in coroutine context. We
can consider it compatible now the latest, after having removed the old
polling code as dead code.

Enable the coroutine test cases for bdrv_drain_all().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-bdrv-drain.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index cd870609c5..6de525b509 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -233,6 +233,11 @@ static void test_drv_cb_drain_subtree(void)
     test_drv_cb_common(BDRV_SUBTREE_DRAIN, true);
 }
 
+static void test_drv_cb_co_drain_all(void)
+{
+    call_in_coroutine(test_drv_cb_drain_all);
+}
+
 static void test_drv_cb_co_drain(void)
 {
     call_in_coroutine(test_drv_cb_drain);
@@ -289,6 +294,11 @@ static void test_quiesce_drain_subtree(void)
     test_quiesce_common(BDRV_SUBTREE_DRAIN, true);
 }
 
+static void test_quiesce_co_drain_all(void)
+{
+    call_in_coroutine(test_quiesce_drain_all);
+}
+
 static void test_quiesce_co_drain(void)
 {
     call_in_coroutine(test_quiesce_drain);
@@ -795,7 +805,8 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/driver-cb/drain_subtree",
                     test_drv_cb_drain_subtree);
 
-    // XXX bdrv_drain_all() doesn't work in coroutine context
+    g_test_add_func("/bdrv-drain/driver-cb/co/drain_all",
+                    test_drv_cb_co_drain_all);
     g_test_add_func("/bdrv-drain/driver-cb/co/drain", test_drv_cb_co_drain);
     g_test_add_func("/bdrv-drain/driver-cb/co/drain_subtree",
                     test_drv_cb_co_drain_subtree);
@@ -806,7 +817,8 @@ int main(int argc, char **argv)
     g_test_add_func("/bdrv-drain/quiesce/drain_subtree",
                     test_quiesce_drain_subtree);
 
-    // XXX bdrv_drain_all() doesn't work in coroutine context
+    g_test_add_func("/bdrv-drain/quiesce/co/drain_all",
+                    test_quiesce_co_drain_all);
     g_test_add_func("/bdrv-drain/quiesce/co/drain", test_quiesce_co_drain);
     g_test_add_func("/bdrv-drain/quiesce/co/drain_subtree",
                     test_quiesce_co_drain_subtree);
-- 
2.13.6
