Received: from eggs.gnu.org ([2001:4830:134:3::10]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6O-0005V0-E7
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6K-00026t-Hk
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:20 +0100
Message-Id: <20171222151846.28110-10-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 09/35] block: Don't acquire AioContext in
 hmp_qemu_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Commit 15afd94a047 added code to acquire and release the AioContext in
qemuio_command(). This means that the lock is taken twice now in the
call path from hmp_qemu_io(). This causes BDRV_POLL_WHILE() to hang for
any requests issued to nodes in a non-mainloop AioContext.

Dropping the first locking from hmp_qemu_io() fixes the problem.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hmp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index 35a7041824..2d72f94193 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2318,7 +2318,6 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
 {
     BlockBackend *blk;
     BlockBackend *local_blk = NULL;
-    AioContext *aio_context;
     const char* device = qdict_get_str(qdict, "device");
     const char* command = qdict_get_str(qdict, "command");
     Error *err = NULL;
@@ -2338,9 +2337,6 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
         }
     }
 
-    aio_context = blk_get_aio_context(blk);
-    aio_context_acquire(aio_context);
-
     /*
      * Notably absent: Proper permission management. This is sad, but it seems
      * almost impossible to achieve without changing the semantics and thereby
@@ -2368,8 +2364,6 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
      */
     qemuio_command(blk, command);
 
-    aio_context_release(aio_context);
-
 fail:
     blk_unref(local_blk);
     hmp_handle_error(mon, &err);
-- 
2.13.6
