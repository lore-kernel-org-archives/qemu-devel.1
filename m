Received: from eggs.gnu.org ([2001:4830:134:3::10]:56941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQu-0001tR-Ia
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQq-0005FT-J8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIDQq-0005EY-DL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:17:56 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 14:17:42 +0200
Message-Id: <20170606121747.25356-3-pbonzini@redhat.com>
In-Reply-To: <20170606121747.25356-1-pbonzini@redhat.com>
References: <20170606121747.25356-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] megasas: do not read sense length more
 than once from frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zyy4013@stu.ouc.edu.cn, ppandit@redhat.com, hare@suse.de

Avoid TOC-TOU bugs depending on how the compiler behaves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 804122ab05..1888118e5f 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -309,9 +309,11 @@ static int megasas_build_sense(MegasasCmd *cmd, uint8_t *sense_ptr,
     PCIDevice *pcid = PCI_DEVICE(cmd->state);
     uint32_t pa_hi = 0, pa_lo;
     hwaddr pa;
+    int frame_sense_len;
 
-    if (sense_len > cmd->frame->header.sense_len) {
-        sense_len = cmd->frame->header.sense_len;
+    frame_sense_len = cmd->frame->header.sense_len;
+    if (sense_len > frame_sense_len) {
+        sense_len = frame_sense_len;
     }
     if (sense_len) {
         pa_lo = le32_to_cpu(cmd->frame->pass.sense_addr_lo);
-- 
2.13.0
