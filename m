Received: from eggs.gnu.org ([2001:4830:134:3::10]:35348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tf-00074O-5c
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Te-00038y-Dz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Te-0002yz-68
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:58 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Td-0006PI-6b
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:33:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:00 +0100
Message-Id: <20180824093343.11346-10-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/52] hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Connect the VIRQ and VFIQ lines from the GIC to the CPU;
these exist always for both CPU and GIC whether the
virtualization extensions are enabled or not, so we
can just unconditionally connect them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180821132811.17675-7-peter.maydell@linaro.org
---
 hw/arm/fsl-imx7.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index d5e26855a55..7663ad68610 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -209,6 +209,10 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(sbd, i, irq);
         irq = qdev_get_gpio_in(d, ARM_CPU_FIQ);
         sysbus_connect_irq(sbd, i + smp_cpus, irq);
+        irq = qdev_get_gpio_in(d, ARM_CPU_VIRQ);
+        sysbus_connect_irq(sbd, i + 2 * smp_cpus, irq);
+        irq = qdev_get_gpio_in(d, ARM_CPU_VFIQ);
+        sysbus_connect_irq(sbd, i + 3 * smp_cpus, irq);
     }
 
     /*
-- 
2.18.0
