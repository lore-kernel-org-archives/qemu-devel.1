Received: from eggs.gnu.org ([2001:4830:134:3::10]:41002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCVuF-0007nJ-G5
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCVuE-0001DM-Ht
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:20:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eCVuE-0001DD-BX
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:20:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  8 Nov 2017 19:20:43 +0000
Message-Id: <20171108192043.10682-3-stefanha@redhat.com>
In-Reply-To: <20171108192043.10682-1-stefanha@redhat.com>
References: <20171108192043.10682-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc1 v2 2/2] util/async: use
 atomic_mb_set in qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Sergio Lopez <slp@redhat.com>

Commit b7a745d added a qemu_bh_cancel call to the completion function
as an optimization to prevent it from unnecessarily rescheduling itself.

This completion function is scheduled from worker_thread, after setting
the state of a ThreadPoolElement to THREAD_DONE.

This was considered to be safe, as the completion function restarts the
loop just after the call to qemu_bh_cancel. But, as this loop lacks a HW
memory barrier, the read of req->state may actually happen _before_ the
call, seeing it still as THREAD_QUEUED, and ending the completion
function without having processed a pending TPE linked at pool->head:

         worker thread             |            I/O thread
------------------------------------------------------------------------
                                   | speculatively read req->state
req->state = THREAD_DONE;          |
qemu_bh_schedule(p->completion_bh) |
  bh->scheduled = 1;               |
                                   | qemu_bh_cancel(p->completion_bh)
                                   |   bh->scheduled = 0;
                                   | if (req->state == THREAD_DONE)
                                   |   // sees THREAD_QUEUED

The source of the misunderstanding was that qemu_bh_cancel is now being
used by the _consumer_ rather than the producer, and therefore now needs
to have acquire semantics just like e.g. aio_bh_poll.

In some situations, if there are no other independent requests in the
same aio context that could eventually trigger the scheduling of the
completion function, the omitted TPE and all operations pending on it
will get stuck forever.

[Added Sergio's updated wording about the HW memory barrier.
--Stefan]

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-id: 20171108063447.2842-1-slp@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 355af73ee7..0e1bd8780a 100644
--- a/util/async.c
+++ b/util/async.c
@@ -174,7 +174,7 @@ void qemu_bh_schedule(QEMUBH *bh)
  */
 void qemu_bh_cancel(QEMUBH *bh)
 {
-    bh->scheduled = 0;
+    atomic_mb_set(&bh->scheduled, 0);
 }
 
 /* This func is async.The bottom half will do the delete action at the finial
-- 
2.13.6
