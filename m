Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eelob-0000Ak-Oj
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeloa-0004OA-7M
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eeloa-0004Ni-1O
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F7F485543
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 17:59:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2018 18:59:45 +0100
Message-Id: <20180125175949.7780-2-pbonzini@redhat.com>
In-Reply-To: <20180125175949.7780-1-pbonzini@redhat.com>
References: <20180125175949.7780-1-pbonzini@redhat.com>
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
Cc: famz@redhat.com

In preparation for adding a similar test using QemuLockable, add a very
simple testcase that has two interleaved calls to lock and unlock.

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
