Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFC-0002GI-JO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFB-0006cy-Hb
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFB-0006cg-Aw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:49 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:23 +0200
Message-Id: <20170505101337.4650-8-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/21] scsi: avoid an off-by-one error in
 megasas_mmio_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading magic sequence(MFI_SEQ) in megasas_mmio_write,
an off-by-one error could occur as 's->adp_reset' index is not
reset after reading the last sequence.

Reported-by: YY Z <bigbird475958471@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20170424120634.12268-1-ppandit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 84b8caf901..804122ab05 100644
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
2.12.2
