Received: from eggs.gnu.org ([2001:4830:134:3::10]:49292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBmfS-0001Ii-Pc
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eBmfO-0000BW-Sm
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eBmfO-0000Au-Mp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D2637F7A2
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:02:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  6 Nov 2017 19:02:33 +0000
Message-Id: <20171106190233.1175-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] tests-aio-multithread: fix
 /aio/multi/schedule race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

test_multi_co_schedule_entry() set to_schedule[id] in the final loop
iteration before terminating the coroutine.  There is a race condition
where the main thread attempts to enter the terminating or terminated
coroutine when signalling coroutines to stop:

  atomic_mb_set(&now_stopping, true);
  for (i = 0; i < NUM_CONTEXTS; i++) {
      ctx_run(i, finish_cb, NULL);  <--- enters dead coroutine!
      to_schedule[i] = NULL;
  }

Make sure only to set to_schedule[id] if this coroutine really needs to
be scheduled!

Reported-by: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
This patch is appropriate for the QEMU 2.11 release to eliminate
spurious test failures.

 tests/test-aio-multithread.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index 549d784915..d396185972 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -144,17 +144,16 @@ static void finish_cb(void *opaque)
 static coroutine_fn void test_multi_co_schedule_entry(void *opaque)
 {
     g_assert(to_schedule[id] == NULL);
-    atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
 
     while (!atomic_mb_read(&now_stopping)) {
         int n;
 
         n = g_test_rand_int_range(0, NUM_CONTEXTS);
         schedule_next(n);
+
+        atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
         qemu_coroutine_yield();
-
         g_assert(to_schedule[id] == NULL);
-        atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
     }
 }
 
-- 
2.13.6
