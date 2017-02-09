Received: from eggs.gnu.org ([2001:4830:134:3::10]:33750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboLr-0008RR-LA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cboLn-00020s-Rj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cboLn-00020f-Mx
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Feb 2017 14:01:08 +0100
Message-Id: <1486645277-4724-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
References: <1486645277-4724-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] ui/vnc: Drop unused vnc_has_job() and
 vnc_jobs_clear()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

The functions vnc_has_job() and vnc_jobs_clear() are
never used; remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Message-id: 1486146260-8092-1-git-send-email-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-jobs.c | 23 -----------------------
 ui/vnc-jobs.h |  2 --
 2 files changed, 25 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 98ca978..f786777 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -128,29 +128,6 @@ static bool vnc_has_job_locked(VncState *vs)
     return false;
 }
 
-bool vnc_has_job(VncState *vs)
-{
-    bool ret;
-
-    vnc_lock_queue(queue);
-    ret = vnc_has_job_locked(vs);
-    vnc_unlock_queue(queue);
-    return ret;
-}
-
-void vnc_jobs_clear(VncState *vs)
-{
-    VncJob *job, *tmp;
-
-    vnc_lock_queue(queue);
-    QTAILQ_FOREACH_SAFE(job, &queue->jobs, next, tmp) {
-        if (job->vs == vs || !vs) {
-            QTAILQ_REMOVE(&queue->jobs, job, next);
-        }
-    }
-    vnc_unlock_queue(queue);
-}
-
 void vnc_jobs_join(VncState *vs)
 {
     vnc_lock_queue(queue);
diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
index 044bf9f..59f66bc 100644
--- a/ui/vnc-jobs.h
+++ b/ui/vnc-jobs.h
@@ -34,8 +34,6 @@
 VncJob *vnc_job_new(VncState *vs);
 int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h);
 void vnc_job_push(VncJob *job);
-bool vnc_has_job(VncState *vs);
-void vnc_jobs_clear(VncState *vs);
 void vnc_jobs_join(VncState *vs);
 
 void vnc_jobs_consume_buffer(VncState *vs);
-- 
1.8.3.1
