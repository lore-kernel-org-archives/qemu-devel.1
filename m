Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28r-0000Wr-Pu
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28p-0003lN-MH
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28p-0003jI-8U
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:39 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:39 +0100
Message-Id: <20181217231700.24482-15-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/35] block/iscsi: fix ioctl cancel
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Sreejith Mohanan <sreejit.mohanan@nutanix.com>

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
index 1924a2b58e..abb872d3d9 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -124,6 +124,7 @@ typedef struct IscsiAIOCB {
 #ifdef __linux__
     sg_io_hdr_t *ioh;
 #endif
+    bool cancelled;
 } IscsiAIOCB;
=20
 /* libiscsi uses time_t so its enough to process events every second */
@@ -287,6 +288,7 @@ static void iscsi_co_init_iscsitask(IscsiLun *iscsilu=
n, struct IscsiTask *iTask)
     };
 }
=20
+/* Called (via iscsi_service) with QemuMutex held. */
 static void
 iscsi_abort_task_cb(struct iscsi_context *iscsi, int status, void *comma=
nd_data,
                     void *private_data)
@@ -295,6 +297,7 @@ iscsi_abort_task_cb(struct iscsi_context *iscsi, int =
status, void *command_data,
=20
     acb->status =3D -ECANCELED;
     iscsi_schedule_bh(acb);
+    qemu_aio_unref(acb); /* acquired in iscsi_aio_cancel() */
 }
=20
 static void
@@ -303,14 +306,25 @@ iscsi_aio_cancel(BlockAIOCB *blockacb)
     IscsiAIOCB *acb =3D (IscsiAIOCB *)blockacb;
     IscsiLun *iscsilun =3D acb->iscsilun;
=20
-    if (acb->status !=3D -EINPROGRESS) {
+    qemu_mutex_lock(&iscsilun->mutex);
+
+    /* If it was cancelled or completed already, our work is done here *=
/
+    if (acb->cancelled || acb->status !=3D -EINPROGRESS) {
+        qemu_mutex_unlock(&iscsilun->mutex);
         return;
     }
=20
+    acb->cancelled =3D true;
+
+    qemu_aio_ref(acb); /* released in iscsi_abort_task_cb() */
+
     /* send a task mgmt call to the target to cancel the task on the tar=
get */
-    iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
-                                     iscsi_abort_task_cb, acb);
+    if (iscsi_task_mgmt_abort_task_async(iscsilun->iscsi, acb->task,
+                                         iscsi_abort_task_cb, acb) < 0) =
{
+        qemu_aio_unref(acb); /* since iscsi_abort_task_cb() won't be cal=
led */
+    }
=20
+    qemu_mutex_unlock(&iscsilun->mutex);
 }
=20
 static const AIOCBInfo iscsi_aiocb_info =3D {
@@ -1008,6 +1022,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState=
 *bs,
     acb->bh          =3D NULL;
     acb->status      =3D -EINPROGRESS;
     acb->ioh         =3D buf;
+    acb->cancelled   =3D false;
=20
     if (req !=3D SG_IO) {
         iscsi_ioctl_handle_emulated(acb, req, buf);
--=20
2.20.1
