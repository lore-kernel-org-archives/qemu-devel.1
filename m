Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MR-0000hE-3l
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-00006n-F1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:42 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MK-0008VB-O6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id g67so6365305wmd.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:35 +0100
Message-Id: <1544628195-37728-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/54] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

iscsi_aio_cancel() does not increment the request's reference count,
causing a use-after-free when ABORT TASK finishes after the request has
already completed.

There are some additional issues with iscsi_aio_cancel():
1. Several ABORT TASKs may be sent for the same task if
   iscsi_aio_cancel() is invoked multiple times.  It's better to avoid
   this just in case the command identifier is reused.
2. The iscsilun->mutex protection is missing in iscsi_aio_cancel().

Reported-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180203061621.7033-4-stefanha@redhat.com>
Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
Tested-by: Sreejith Mohanan <sreejit.mohanan@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 1924a2b..abb872d 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -124,6 +124,7 @@ typedef struct IscsiAIOCB {
 #ifdef __linux__
     sg_io_hdr_t *ioh;
 #endif
+    bool cancelled;
 } IscsiAIOCB;
 
 /* libiscsi uses time_t so its enough to process events every second */
@@ -287,6 +288,7 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
     };
 }
 
+/* Called (via iscsi_service) with QemuMutex held. */
 static void
 iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
                     void *private_data)
@@ -295,6 +297,7 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
 
     acb->status = -ECANCELED;
     iscsi_schedule_bh(acb);
+    qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
 }
 
 static void
@@ -303,14 +306,25 @@ iscsi_aio_cancel(BlockAIOCB *blockacb)
     IscsiAIOCB *acb = (IscsiAIOCB *)blockacb;
     IscsiLun *iscsilun = acb->iscsilun;
 
-    if (acb->status != -EINPROGRESS) {
+    qemu_mutex_lock(&iscsilun->mutex);
+
+    /* If it was cancelled or completed already, our work is done here */
+    if (acb->cancelled || acb->status != -EINPROGRESS) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return;
     }
 
+    acb->cancelled = true;
+
+    qemu_aio_ref(acb); /* released in iscsi_abort_task_cb() */
+
     /* send a task mgmt call to the target to cancel the task on the target */
-    iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
-                                     iscsi_abort_task_cb, acb);
+    if (iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
+                                         iscsi_abort_task_cb, acb) < 0) {
+        qemu_aio_unref(acb); /* since iscsi_abort_task_cb() won't be called */
+    }
 
+    qemu_mutex_unlock(&iscsilun->mutex);
 }
 
 static const AIOCBInfo iscsi_aiocb_info = {
@@ -1008,6 +1022,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb->bh          = NULL;
     acb->status      = -EINPROGRESS;
     acb->ioh         = buf;
+    acb->cancelled   = false;
 
     if (req != SG_IO) {
         iscsi_ioctl_handle_emulated(acb, req, buf);
-- 
1.8.3.1
