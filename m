Received: from eggs.gnu.org ([209.51.188.92]:56389)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1hLROD-0002E3-NA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1hLRKz-0002Hv-MJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:54:19 -0400
Received: from mx01.kamp.de ([82.141.2.16]:36460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1hLRKz-0002GI-Cj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:54:17 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:54:09 +0200
From: Peter Lieven <pl@kamp.de>
Date: Tue, 30 Apr 2019 13:54:04 +0200
Message-Id: <20190430115404.18483-1-pl@kamp.de>
Subject: [Qemu-devel] [PATCH RESEND] megasas: fix mapped frame size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, hare@suse.com, pbonzini@redhat.com, fam@euphon.net, Peter Lieven <pl@kamp.de>

the current value of 1024 bytes (16 * MFI_FRAME_SIZE) we map is not enough to hold
the maximum number of scatter gather elements we advertise. We actually need a
maximum of 2048 bytes. This is 128 max sg elements * 16 bytes (sizeof (union mfi_sgl)).

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/megasas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index a56317e026..5ad762de23 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -477,7 +477,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
 {
     PCIDevice *pcid = PCI_DEVICE(s);
     MegasasCmd *cmd = NULL;
-    int frame_size = MFI_FRAME_SIZE * 16;
+    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl);
     hwaddr frame_size_p = frame_size;
     unsigned long index;
 
-- 
2.17.1
