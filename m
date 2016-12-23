Received: from eggs.gnu.org ([2001:4830:134:3::10]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKW4G-0001dk-9p
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKW4F-0008Ks-Ho
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 15:03:52 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:56 +0300
Message-ID: <1482503344-6424-14-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 13/21] coroutine: add qemu_coroutine_add_next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

Simple add coroutine to self->co_queue_wakeup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/coroutine.h | 2 ++
 util/qemu-coroutine.c    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e6a60d5..6e87c87 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -226,4 +226,6 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
  */
 void coroutine_fn yield_until_fd_readable(int fd);
 
+void qemu_coroutine_add_next(Coroutine *next);
+
 #endif /* QEMU_COROUTINE_H */
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 737bffa..300b96d 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -151,3 +151,10 @@ bool qemu_coroutine_entered(Coroutine *co)
 {
     return co->caller;
 }
+
+void qemu_coroutine_add_next(Coroutine *next)
+{
+    Coroutine *self = qemu_coroutine_self();
+    QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, next, co_queue_next);
+    trace_qemu_co_queue_next(next);
+}
-- 
1.8.3.1
