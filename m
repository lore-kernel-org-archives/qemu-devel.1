Received: from eggs.gnu.org ([209.51.188.92]:42695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzPyL-0001yL-Va
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzPyJ-0001ZK-FI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:59:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzPyJ-0001Xx-3S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:59:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SHsZY4097815
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:59:49 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxk3uc9kh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:59:48 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 28 Feb 2019 17:59:46 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 28 Feb 2019 18:59:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <155137678223.44753.5438092367451176318.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-scsi: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Build fails with gcc 9:

  CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
hw/scsi/virtio-scsi.c: In function =E2=80=98virtio_scsi_do_tmf=E2=80=99:
hw/scsi/virtio-scsi.c:265:39: error: taking address of packed member of =E2=
=80=98struct virtio_scsi_ctrl_tmf_req=E2=80=99 may result in an unaligned=
 pointer value [-Werror=3Daddress-of-packed-member]
  265 |     virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
      |                                       ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

All the fields in struct virtio_scsi_ctrl_tmf_req are naturally aligned,
so we could in theory drop QEMU_PACKED. Unfortunately, the header file
is imported from linux which already has the packed attribute. Trying to
fix that in the update-linux-headers.sh script is likely to produce
ugliness. Turn the call to virtio_tswap32s() into an assignment instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/scsi/virtio-scsi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ce99d288b035..839f1202567d 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -262,7 +262,13 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOS=
CSIReq *req)
     /* Here VIRTIO_SCSI_S_OK means "FUNCTION COMPLETE".  */
     req->resp.tmf.response =3D VIRTIO_SCSI_S_OK;
=20
-    virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
+    /*
+     * req->req.tmf has the QEMU_PACKED attribute. Don't use virtio_tswa=
p32s()
+     * to avoid compiler errors.
+     */
+    req->req.tmf.subtype =3D
+        virtio_tswap32(VIRTIO_DEVICE(s), req->req.tmf.subtype);
+
     switch (req->req.tmf.subtype) {
     case VIRTIO_SCSI_T_TMF_ABORT_TASK:
     case VIRTIO_SCSI_T_TMF_QUERY_TASK:
