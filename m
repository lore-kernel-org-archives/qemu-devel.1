Received: from eggs.gnu.org ([2001:4830:134:3::10]:52257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000py-6b
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000Ee-B6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MW-0008Vd-Vo
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id y139so6132645wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:36 +0100
Message-Id: <1544628195-37728-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/54] block/iscsi: cancel libiscsi task when
 ABORT TASK TMF completes
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

The libiscsi iscsi_task_mgmt_async() API documentation says:

  abort_task will also cancel the scsi task. The callback for the scsi
  task will be invoked with SCSI_STATUS_CANCELLED

The libiscsi implementation does not fulfil this promise.  The task's
callback is not invoked and its struct iscsi_pdu remains in the internal
list (effectively leaked).

This patch invokes the libiscsi iscsi_scsi_cancel_task() API to force
the task's callback to be invoked with SCSI_STATUS_CANCELLED when the
ABORT TASK TMF completes and the task's callback hasn't been invoked
yet.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180215111526.2464-1-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index abb872d..a7e8c1f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -295,8 +295,12 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
 {
     IscsiAIOCB *acb = private_data;
 
-    acb->status = -ECANCELED;
-    iscsi_schedule_bh(acb);
+    /* If the command callback hasn't been called yet, drop the task */
+    if (!acb->bh) {
+        /* Call iscsi_aio_ioctl_cb() with SCSI_STATUS_CANCELLED */
+        iscsi_scsi_cancel_task(iscsi, acb->task);
+    }
+
     qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
 }
 
@@ -947,6 +951,14 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
 {
     IscsiAIOCB *acb = opaque;
 
+    if (status == SCSI_STATUS_CANCELLED) {
+        if (!acb->bh) {
+            acb->status = -ECANCELED;
+            iscsi_schedule_bh(acb);
+        }
+        return;
+    }
+
     acb->status = 0;
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
-- 
1.8.3.1
