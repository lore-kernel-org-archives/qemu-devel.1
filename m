Received: from eggs.gnu.org ([2001:4830:134:3::10]:59583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ehMR9-00078X-Nl
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 16:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ehMQ5-0003kx-Ed
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 16:30:27 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Feb 2018 16:29:13 -0500
Message-Id: <20180201212917.18131-2-pbonzini@redhat.com>
In-Reply-To: <20180201212917.18131-1-pbonzini@redhat.com>
References: <20180201212917.18131-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] test-coroutine: add simple CoMutex test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

In preparation for adding a similar test using QemuLockable, add a very
simple testcase that has two interleaved calls to lock and unlock.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-coroutine.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index 76c646107e..010cb95ad6 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -175,7 +175,7 @@ static void coroutine_fn c1_fn(void *opaque)
     qemu_coroutine_enter(c2);
 }
 
-static void test_co_queue(void)
+static void test_no_dangling_access(void)
 {
     Coroutine *c1;
     Coroutine *c2;
@@ -195,6 +195,51 @@ static void test_co_queue(void)
     *c1 = tmp;
 }
 
+static bool locked = false;
+static int done;
+
+static void coroutine_fn mutex_fn(void *opaque)
+{
+    CoMutex *m = opaque;
+    qemu_co_mutex_lock(m);
+    assert(!locked);
+    locked = true;
+    qemu_coroutine_yield();
+    locked = false;
+    qemu_co_mutex_unlock(m);
+    done++;
+}
+
+static void do_test_co_mutex(CoroutineEntry *entry, void *opaque)
+{
+    Coroutine *c1 = qemu_coroutine_create(entry, opaque);
+    Coroutine *c2 = qemu_coroutine_create(entry, opaque);
+
+    done = 0;
+    qemu_coroutine_enter(c1);
+    g_assert(locked);
+    qemu_coroutine_enter(c2);
+
+    /* Unlock queues c2.  It is then started automatically when c1 yields or
+     * terminates.
+     */
+    qemu_coroutine_enter(c1);
+    g_assert_cmpint(done, ==, 1);
+    g_assert(locked);
+
+    qemu_coroutine_enter(c2);
+    g_assert_cmpint(done, ==, 2);
+    g_assert(!locked);
+}
+
+static void test_co_mutex(void)
+{
+    CoMutex m;
+
+    qemu_co_mutex_init(&m);
+    do_test_co_mutex(mutex_fn, &m);
+}
+
 /*
  * Check that creation, enter, and return work
  */
@@ -422,7 +467,7 @@ int main(int argc, char **argv)
      * crash, so skip it.
      */
     if (CONFIG_COROUTINE_POOL) {
-        g_test_add_func("/basic/co_queue", test_co_queue);
+        g_test_add_func("/basic/no-dangling-access", test_no_dangling_access);
     }
 
     g_test_add_func("/basic/lifecycle", test_lifecycle);
@@ -432,6 +477,7 @@ int main(int argc, char **argv)
     g_test_add_func("/basic/entered", test_entered);
     g_test_add_func("/basic/in_coroutine", test_in_coroutine);
     g_test_add_func("/basic/order", test_order);
+    g_test_add_func("/locking/co-mutex", test_co_mutex);
     if (g_test_perf()) {
         g_test_add_func("/perf/lifecycle", perf_lifecycle);
         g_test_add_func("/perf/nesting", perf_nesting);
-- 
2.14.3
