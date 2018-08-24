Received: from eggs.gnu.org ([2001:4830:134:3::10]:35302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tc-000733-Fl
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tb-0002to-IT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Tb-0002p9-BS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:33:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Ta-0006Ng-Bz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:33:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:32:57 +0100
Message-Id: <20180824093343.11346-7-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/52] hw/arm/vexpress: Connect VIRQ and VFIQ
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
Message-id: 20180821132811.17675-4-peter.maydell@linaro.org
---
 hw/arm/vexpress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5bfe2e43487..dc47ed84c20 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -251,6 +251,10 @@ static void init_cpus(const char *cpu_type, const char *privdev,
         sysbus_connect_irq(busdev, n, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         sysbus_connect_irq(busdev, n + smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(busdev, n + 2 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(busdev, n + 3 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 }
 
-- 
2.18.0
