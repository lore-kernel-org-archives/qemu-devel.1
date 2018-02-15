Received: from eggs.gnu.org ([2001:4830:134:3::10]:35002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emHVz-0006iT-K7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emHVv-0002up-GH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:15:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emHVv-0002uX-C6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:15:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 15 Feb 2018 11:15:26 +0000
Message-Id: <20180215111526.2464-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] block/iscsi: cancel libiscsi task when ABORT
 TASK TMF completes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
---
 block/iscsi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 41e67cb371..4cb188ac2b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -292,8 +292,12 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
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
 
@@ -941,6 +945,14 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
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
2.14.3
