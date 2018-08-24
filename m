Received: from eggs.gnu.org ([2001:4830:134:3::10]:35666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8U4-0007T1-23
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8U3-0004L6-2D
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8U2-0004FY-Mb
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8U1-0006Z7-D6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:22 +0100
Message-Id: <20180824093343.11346-32-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/52] hw/arm/iotkit: Wire up the lines for MSCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The IoTKit doesn't have any MSCs itself but it does need
some wiring to connect the external signals from MSCs
in the outer board model up to the registers and the
NVIC IRQ line.

We also need to expose a MemoryRegion corresponding to
the AHB bus, so that MSCs in the outer board model can
use that as their downstream port. (In the FPGA this is
the "AHB Slave Expansion" ports shown in the block
diagram in the AN505 documentation.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180820141116.9118-14-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/arm/iotkit.h |  8 ++++++++
 hw/arm/iotkit.c         | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
index 426dc326a0d..3a8ee639085 100644
--- a/include/hw/arm/iotkit.h
+++ b/include/hw/arm/iotkit.h
@@ -28,6 +28,9 @@
  *  + QOM property "EXP_NUMIRQ" sets the number of expansion interrupts
  *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts, which
  *    are wired to the NVIC lines 32 .. n+32
+ *  + sysbus MMIO region 0 is the "AHB Slave Expansion" which allows
+ *    bus master devices in the board model to make transactions into
+ *    all the devices and memory areas in the IoTKit
  * Controlling up to 4 AHB expansion PPBs which a system using the IoTKit
  * might provide:
  *  + named GPIO outputs apb_ppcexp{0,1,2,3}_nonsec[0..15]
@@ -45,6 +48,11 @@
  * Controlling each of the 16 expansion MPCs which a system using the IoTKit
  * might provide:
  *  + named GPIO inputs mpcexp_status[0..15]
+ * Controlling each of the 16 expansion MSCs which a system using the IoTKit
+ * might provide:
+ *  + named GPIO inputs mscexp_status[0..15]
+ *  + named GPIO outputs mscexp_clear[0..15]
+ *  + named GPIO outputs mscexp_ns[0..15]
  */
 
 #ifndef IOTKIT_H
diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index f8276b5425c..8742200fb42 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -667,6 +667,21 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
 
     iotkit_forward_sec_resp_cfg(s);
 
+    /* Forward the MSC related signals */
+    qdev_pass_gpios(dev_secctl, dev, "mscexp_status");
+    qdev_pass_gpios(dev_secctl, dev, "mscexp_clear");
+    qdev_pass_gpios(dev_secctl, dev, "mscexp_ns");
+    qdev_connect_gpio_out_named(dev_secctl, "msc_irq", 0,
+                                qdev_get_gpio_in(DEVICE(&s->armv7m), 11));
+
+    /*
+     * Expose our container region to the board model; this corresponds
+     * to the AHB Slave Expansion ports which allow bus master devices
+     * (eg DMA controllers) in the board model to make transactions into
+     * devices in the IoTKit.
+     */
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->container);
+
     system_clock_scale = NANOSECONDS_PER_SECOND / s->mainclk_frq;
 }
 
-- 
2.18.0
