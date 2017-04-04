Received: from eggs.gnu.org ([2001:4830:134:3::10]:55017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYKw-0008Bt-FJ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYKr-0006Ld-G2
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:58:10 -0400
Received: from mail-bn3nam01on0042.outbound.protection.outlook.com
	([104.47.33.42]:55296
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cvYKr-0006Kr-5i
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:58:05 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 4 Apr 2017 16:40:09 -0700
Message-ID: <325f60be9b819f261848db3d69554da640294ca4.1491349058.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 3/5] cadence_gem: Only trigger interrupts if
 the status register is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Only trigger multi-queue GEM interrupts if the interrupt status register
is set. This logic was already used for non multi-queue interrupts but
it also applies to multi-queue interrupts.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 3e37665..b9eaed4 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -518,7 +518,7 @@ static void gem_update_int_status(CadenceGEMState *s)
     }
 
     for (i = 0; i < s->num_priority_queues; ++i) {
-        if (s->regs[GEM_INT_Q1_STATUS + i]) {
+        if (s->regs[GEM_INT_Q1_STATUS + i] && s->regs[GEM_ISR]) {
             DB_PRINT("asserting int. (q=%d)\n", i);
             qemu_set_irq(s->irq[i], 1);
         }
-- 
2.9.3
