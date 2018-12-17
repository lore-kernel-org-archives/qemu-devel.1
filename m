Received: from eggs.gnu.org ([2001:4830:134:3::10]:43281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28s-0000XT-B1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28p-0003lI-Lq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28p-0003gH-BL
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82A38C0495BF
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:37 +0100
Message-Id: <20181217231700.24482-13-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/35] block/iscsi: drop unused IscsiAIOCB->buf
 field
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

The IscsiAIOCB->buf field has not been used since commit
e49ab19fcaa617ad6cdfe1ac401327326b6a2552 ("block/iscsi: bump libiscsi
requirement to 1.9.0").  It used to be a linear buffer for old libiscsi
versions that didn't support scatter-gather.  The minimum libiscsi
version supports scatter-gather so we don't linearize buffers anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180203061621.7033-2-stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 727dee50bf..a4e3730a82 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -117,7 +117,6 @@ typedef struct IscsiAIOCB {
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
-    uint8_t *buf;
     int status;
     int64_t sector_num;
     int nb_sectors;
@@ -150,9 +149,6 @@ iscsi_bh_cb(void *p)
=20
     qemu_bh_delete(acb->bh);
=20
-    g_free(acb->buf);
-    acb->buf =3D NULL;
-
     acb->common.cb(acb->common.opaque, acb->status);
=20
     if (acb->task !=3D NULL) {
@@ -933,9 +929,6 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int s=
tatus,
 {
     IscsiAIOCB *acb =3D opaque;
=20
-    g_free(acb->buf);
-    acb->buf =3D NULL;
-
     acb->status =3D 0;
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
@@ -1010,7 +1003,6 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState=
 *bs,
     acb->iscsilun =3D iscsilun;
     acb->bh          =3D NULL;
     acb->status      =3D -EINPROGRESS;
-    acb->buf         =3D NULL;
     acb->ioh         =3D buf;
=20
     if (req !=3D SG_IO) {
--=20
2.20.1
