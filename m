Received: from eggs.gnu.org ([2001:4830:134:3::10]:43316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28t-0000Yc-DF
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28p-0003lT-Mx
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28p-0003ji-CY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33F50C049581
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:40 +0100
Message-Id: <20181217231700.24482-16-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/35] block/iscsi: cancel libiscsi task when
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
index abb872d3d9..a7e8c1ffaf 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -295,8 +295,12 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int=
 status, void *command_data,
 {
     IscsiAIOCB *acb =3D private_data;
=20
-    acb->status =3D -ECANCELED;
-    iscsi_schedule_bh(acb);
+    /* If the command callback hasn't been called yet, drop the task */
+    if (!acb->bh) {
+        /* Call iscsi_aio_ioctl_cb() with SCSI_STATUS_CANCELLED */
+        iscsi_scsi_cancel_task(iscsi, acb->task);
+    }
+
     qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
 }
=20
@@ -947,6 +951,14 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int =
status,
 {
     IscsiAIOCB *acb =3D opaque;
=20
+    if (status =3D=3D SCSI_STATUS_CANCELLED) {
+        if (!acb->bh) {
+            acb->status =3D -ECANCELED;
+            iscsi_schedule_bh(acb);
+        }
+        return;
+    }
+
     acb->status =3D 0;
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
--=20
2.20.1
