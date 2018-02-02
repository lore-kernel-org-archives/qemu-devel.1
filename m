Received: from eggs.gnu.org ([2001:4830:134:3::10]:54266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehiho-0004Ke-OB
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehihn-0000dK-Jg
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 16:17:08 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  2 Feb 2018 22:16:28 +0100
Message-Id: <20180202211628.3661-4-stefanha@redhat.com>
In-Reply-To: <20180202211628.3661-1-stefanha@redhat.com>
References: <20180202211628.3661-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] block/iscsi: fix ioctl cancel
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The ioctl request cancellation code assumes that requests do not
complete once TASK ABORT has been sent to the iSCSI target.  The request
completion callback is unconditionally invoked when TASK ABORT finishes.
Therefore the request completion callback is invoked twice if the
request does happen to complete before TASK ABORT.

Futhermore, iscsi_aio_cancel() does not increment the request's
reference count, causing a use-after-free when TASK ABORT finishes after
the request has already completed.

The iscsilun->mutex protection is also missing in iscsi_aio_cancel().

This patch rewrites iscsi_aio_cancel() and iscsi_abort_task_cb() to
avoid double completion, use-after-free, and to take iscsilun->mutex
when needed.

Reported-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 1cfe1c647c..4566902d43 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -282,14 +282,19 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
     };
 }
 
+/* Called (via iscsi_service) with QemuMutex held. */
 static void
 iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *command_data,
                     void *private_data)
 {
     IscsiAIOCB *acb = private_data;
 
-    acb->status = -ECANCELED;
-    iscsi_schedule_bh(acb);
+    /* Skip if the request already completed */
+    if (acb->status == -ECANCELED) {
+        iscsi_schedule_bh(acb);
+    }
+
+    qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
 }
 
 static void
@@ -298,14 +303,26 @@ iscsi_aio_cancel(BlockAIOCB *blockacb)
     IscsiAIOCB *acb = (IscsiAIOCB *)blockacb;
     IscsiLun *iscsilun = acb->iscsilun;
 
+    qemu_mutex_lock(&iscsilun->mutex);
+
+    /* If it was cancelled or completed already, our work is done here */
     if (acb->status != -EINPROGRESS) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return;
     }
 
+    /* This can still be overwritten if the request completes */
+    acb->status = -ECANCELED;
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
-- 
2.14.3
