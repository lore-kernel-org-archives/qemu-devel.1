Received: from eggs.gnu.org ([2001:4830:134:3::10]:35282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tb-000732-D2
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Ta-0002oq-JF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Ta-0002fG-AP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:54 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8TZ-0006N8-BC
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:33:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:32:56 +0100
Message-Id: <20180824093343.11346-6-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/52] hw/intc/arm_gic: Make per-cpu GICH memory
 regions 0x200 bytes large
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reduce the size of the per-cpu GICH memory regions from 0x1000
to 0x200. The registers only cover 0x200 bytes, and the Cortex-A15
wants to map them at a spacing of 0x200 bytes apart. Having the
region be too large interferes with mapping them like that, so
reduce it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180821132811.17675-3-peter.maydell@linaro.org
---
 hw/intc/arm_gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index c1b35fc1ee2..542b4b93eab 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2084,7 +2084,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         for (i = 0; i < s->num_cpu; i++) {
             memory_region_init_io(&s->vifaceiomem[i + 1], OBJECT(s),
                                   &gic_viface_ops, &s->backref[i],
-                                  "gic_viface", 0x1000);
+                                  "gic_viface", 0x200);
             sysbus_init_mmio(sbd, &s->vifaceiomem[i + 1]);
         }
     }
-- 
2.18.0
