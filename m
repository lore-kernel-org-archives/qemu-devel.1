Received: from eggs.gnu.org ([2001:4830:134:3::10]:49697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcB-00023m-Fd
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFcA-00040e-JS
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:11 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFcA-0003xp-DV
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc9-0007f3-N8
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:09 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:08:02 +0000
Message-Id: <1486750082-12324-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/12] aspeed/smc: use a modulo to check segment
 limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The size of a segment is not necessarily a power of 2.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1486648058-520-5-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 7017707..cb51573 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -475,15 +475,15 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
     AspeedSegments seg;
 
     aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
-    if ((addr & (seg.size - 1)) != addr) {
+    if ((addr % seg.size) != addr) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: invalid address 0x%08x for CS%d segment : "
                       "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
                       s->ctrl->name, addr, fl->id, seg.addr,
                       seg.addr + seg.size);
+        addr %= seg.size;
     }
 
-    addr &= seg.size - 1;
     return addr;
 }
 
-- 
2.7.4
