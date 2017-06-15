Received: from eggs.gnu.org ([2001:4830:134:3::10]:40738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOv-0008Az-6L
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOu-0007VL-Ca
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:21 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOu-0007V4-6I
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id y25so545332wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:20 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:28 +0200
Message-Id: <1497523981-38449-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/41] megasas: do not read sense length more
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

Avoid TOC-TOU bugs depending on how the compiler behaves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 804122a..1888118 100644
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
1.8.3.1
