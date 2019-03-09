Received: from eggs.gnu.org ([209.51.188.92]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wih-0003tB-5y
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0000Wo-DT
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wig-0000R1-3Y
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:34 -0500
Received: by mail-wr1-x442.google.com with SMTP id g12so23639139wrm.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:02 +0100
Message-Id: <1552117698-12355-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/25] virtio-scsi: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

Build fails with gcc 9:

  CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
hw/scsi/virtio-scsi.c: In function â€˜virtio_scsi_do_tmfâ€™:
hw/scsi/virtio-scsi.c:265:39: error: taking address of packed member of â€˜struct virtio_scsi_ctrl_tmf_reqâ€™ may result in an unaligned pointer value [-Werror=address-of-packed-member]
  265 |     virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
      |                                       ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

All the fields in struct virtio_scsi_ctrl_tmf_req are naturally aligned,
so we could in theory drop QEMU_PACKED. Unfortunately, the header file
is imported from linux which already has the packed attribute. Trying to
fix that in the update-linux-headers.sh script is likely to produce
ugliness. Turn the call to virtio_tswap32s() into an assignment instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155137678223.44753.5438092367451176318.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ce99d28..839f120 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -262,7 +262,13 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
     /* Here VIRTIO_SCSI_S_OK means "FUNCTION COMPLETE".  */
     req->resp.tmf.response = VIRTIO_SCSI_S_OK;
 
-    virtio_tswap32s(VIRTIO_DEVICE(s), &req->req.tmf.subtype);
+    /*
+     * req->req.tmf has the QEMU_PACKED attribute. Don't use virtio_tswap32s()
+     * to avoid compiler errors.
+     */
+    req->req.tmf.subtype =
+        virtio_tswap32(VIRTIO_DEVICE(s), req->req.tmf.subtype);
+
     switch (req->req.tmf.subtype) {
     case VIRTIO_SCSI_T_TMF_ABORT_TASK:
     case VIRTIO_SCSI_T_TMF_QUERY_TASK:
-- 
1.8.3.1
