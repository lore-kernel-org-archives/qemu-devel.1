Received: from eggs.gnu.org ([2001:4830:134:3::10]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfX-0001ef-4I
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0006Ex-E3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfU-00065w-Jf
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfI-0003ar-8q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:40 +0100
Message-Id: <20180615142521.19143-3-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/43] hw/arm/mps2-tz: Put ethernet controller
 behind PPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The ethernet controller in the AN505 MPC FPGA image is behind
the same AHB Peripheral Protection Controller that handles
the graphics and GPIOs. (In the documentation this is clear
in the block diagram but the ethernet controller was omitted
from the table listing devices connected to the PPC.)
The ethernet sits behind AHB PPCEXP0 interface 5. We had
incorrectly claimed that this was a "gpio4", but there are
only 4 GPIOs in this image.

Correct the QEMU model to match the hardware.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180515171446.10834-1-peter.maydell@linaro.org
---
 hw/arm/mps2-tz.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8dc8bfd4ab2..c5ef95e4cc0 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -74,12 +74,13 @@ typedef struct {
     UnimplementedDeviceState spi[5];
     UnimplementedDeviceState i2c[4];
     UnimplementedDeviceState i2s_audio;
-    UnimplementedDeviceState gpio[5];
+    UnimplementedDeviceState gpio[4];
     UnimplementedDeviceState dma[4];
     UnimplementedDeviceState gfx;
     CMSDKAPBUART uart[5];
     SplitIRQ sec_resp_splitter;
     qemu_or_irq uart_irq_orgate;
+    DeviceState *lan9118;
 } MPS2TZMachineState;
 
 #define TYPE_MPS2TZ_MACHINE "mps2tz"
@@ -224,6 +225,26 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *mms, void *opaque,
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
 }
 
+static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
+                                  const char *name, hwaddr size)
+{
+    SysBusDevice *s;
+    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
+    NICInfo *nd = &nd_table[0];
+
+    /* In hardware this is a LAN9220; the LAN9118 is software compatible
+     * except that it doesn't support the checksum-offload feature.
+     */
+    qemu_check_nic_model(nd, "lan9118");
+    mms->lan9118 = qdev_create(NULL, "lan9118");
+    qdev_set_nic_properties(mms->lan9118, nd);
+    qdev_init_nofail(mms->lan9118);
+
+    s = SYS_BUS_DEVICE(mms->lan9118);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 16));
+    return sysbus_mmio_get_region(s, 0);
+}
+
 static void mps2tz_common_init(MachineState *machine)
 {
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
@@ -363,7 +384,7 @@ static void mps2tz_common_init(MachineState *machine)
                 { "gpio1", make_unimp_dev, &mms->gpio[1], 0x40101000, 0x1000 },
                 { "gpio2", make_unimp_dev, &mms->gpio[2], 0x40102000, 0x1000 },
                 { "gpio3", make_unimp_dev, &mms->gpio[3], 0x40103000, 0x1000 },
-                { "gpio4", make_unimp_dev, &mms->gpio[4], 0x40104000, 0x1000 },
+                { "eth", make_eth_dev, NULL, 0x42000000, 0x100000 },
             },
         }, {
             .name = "ahb_ppcexp1",
@@ -447,13 +468,6 @@ static void mps2tz_common_init(MachineState *machine)
                                                      "cfg_sec_resp", 0));
     }
 
-    /* In hardware this is a LAN9220; the LAN9118 is software compatible
-     * except that it doesn't support the checksum-offload feature.
-     * The ethernet controller is not behind a PPC.
-     */
-    lan9118_init(&nd_table[0], 0x42000000,
-                 qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 16));
-
     create_unimplemented_device("FPGA NS PC", 0x48007000, 0x1000);
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400000);
-- 
2.17.1
