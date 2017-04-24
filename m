Received: from eggs.gnu.org ([2001:4830:134:3::10]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d2clS-0001KD-IG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d2clP-0003qP-EE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:06:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d2clP-0003p4-7t
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:06:43 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 24 Apr 2017 17:36:34 +0530
Message-Id: <20170424120634.12268-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: avoid an off-by-one error in
 megasas_mmio_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: YY Z <bigbird475958471@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading magic sequence(MFI_SEQ) in megasas_mmio_write,
an off-by-one error could occur as 's->adp_reset' index is not
reset after reading the last sequence.

Reported-by: YY Z <bigbird475958471@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/megasas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 84b8caf..804122a 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2138,15 +2138,15 @@ static void megasas_mmio_write(void *opaque, hwaddr addr,
     case MFI_SEQ:
         trace_megasas_mmio_writel("MFI_SEQ", val);
         /* Magic sequence to start ADP reset */
-        if (adp_reset_seq[s->adp_reset] == val) {
-            s->adp_reset++;
+        if (adp_reset_seq[s->adp_reset++] == val) {
+            if (s->adp_reset == 6) {
+                s->adp_reset = 0;
+                s->diag = MFI_DIAG_WRITE_ENABLE;
+            }
         } else {
             s->adp_reset = 0;
             s->diag = 0;
         }
-        if (s->adp_reset == 6) {
-            s->diag = MFI_DIAG_WRITE_ENABLE;
-        }
         break;
     case MFI_DIAG:
         trace_megasas_mmio_writel("MFI_DIAG", val);
-- 
2.9.3
