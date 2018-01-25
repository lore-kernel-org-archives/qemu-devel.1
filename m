Received: from eggs.gnu.org ([2001:4830:134:3::10]:33805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoo-0003M8-73
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoi-0003Ay-DY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:54 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoi-0003AO-5g
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehog-0006x9-PI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:25 +0000
Message-Id: <1516887809-6265-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/21] hw/intc/arm_gic: Fix the NS view of C_BPR
 when C_CTRL.CBPR is 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc MICHEL <luc.michel@git.antfield.fr>

When C_CTRL.CBPR is 1, the Non-Secure view of C_BPR is altered:
  - A Non-Secure read of C_BPR should return the BPR value plus 1,
  saturated to 7,
  - A Non-Secure write should be ignored.

Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
Message-id: 20180119145756.7629-6-luc.michel@greensocs.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed comment typo]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b7989d2..724bc9f 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1212,8 +1212,13 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
         break;
     case 0x08: /* Binary Point */
         if (s->security_extn && !attrs.secure) {
-            /* BPR is banked. Non-secure copy stored in ABPR. */
-            *data = s->abpr[cpu];
+            if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
+                /* NS view of BPR when CBPR is 1 */
+                *data = MIN(s->bpr[cpu] + 1, 7);
+            } else {
+                /* BPR is banked. Non-secure copy stored in ABPR. */
+                *data = s->abpr[cpu];
+            }
         } else {
             *data = s->bpr[cpu];
         }
@@ -1286,7 +1291,12 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
         break;
     case 0x08: /* Binary Point */
         if (s->security_extn && !attrs.secure) {
-            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+            if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
+                /* WI when CBPR is 1 */
+                return MEMTX_OK;
+            } else {
+                s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+            }
         } else {
             s->bpr[cpu] = MAX(value & 0x7, GIC_MIN_BPR);
         }
-- 
2.7.4
