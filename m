Received: from eggs.gnu.org ([2001:4830:134:3::10]:47583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPt-00011E-Mw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPr-0005E7-Lk
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPr-00051T-DO
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPb-00036O-QE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:59 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:27 +0000
Message-Id: <1484834995-26826-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/36] aspeed/smc: remove call to
 aspeed_smc_update_cs() in reset function
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

Instead, we can simply set the irq level when unselecting the slave
devices. This change prepares ground for a subsequent cleanup of the
aspeed_smc_update_cs() routine which uselessly loops on all slaves to
update their status.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1483979087-32663-3-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 8a7217d..205c0ab 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -424,6 +424,7 @@ static void aspeed_smc_reset(DeviceState *d)
     /* Unselect all slaves */
     for (i = 0; i < s->num_cs; ++i) {
         s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;
+        qemu_set_irq(s->cs_lines[i], true);
     }
 
     /* setup default segment register values for all */
@@ -431,8 +432,6 @@ static void aspeed_smc_reset(DeviceState *d)
         s->regs[R_SEG_ADDR0 + i] =
             aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
     }
-
-    aspeed_smc_update_cs(s);
 }
 
 static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
-- 
2.7.4
