Received: from eggs.gnu.org ([2001:4830:134:3::10]:56926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xw-00078s-3K
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xv-0002x5-2I
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:56 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:09 -0600
Message-Id: <f02979282eb1d31811f0f87c0bb5d774a959746c.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 11/17] e500: derive baud from CCB clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

The CCB (Complex Core Bus) clock is the reference for the DUARTs
with an extra divide by 16.

>From the mpc8540, mpc8544, and P2010 ref manuals.
CCB=333MHz, with divider=0x87a gives ~9600 baud.
333e6 Hz/(16*0x87a) = 9591 Hz.
This is verified with a real mpc8540.

The existing value for the mpc8544ds boards is replaced.
Previously the uart "clock-frequency" device tree node
was left as zero, and at some point either u-boot or Linux
picks a value inconsistent with the frequency
given to serial_mm_init().
The FIFO timeout calculated from this was incorrect.

Now use an arbitrary (valid) CCB frequency of 333MHz
in the device tree and for the UART.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c      |  9 ++++++++-
 hw/ppc/e500_ccsr.c | 16 ++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 2d87d91582..cfd5ed0152 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -49,6 +49,12 @@
 
 #define RAM_SIZES_ALIGN            (64UL << 20)
 
+/* Somewhat arbitrarily choosen Complex Core Bus frequency
+ * for our simulation (real freq of mpc8544ds board unknown)
+ * Used in baud rate calculations.
+ */
+#define CCB_FREQ (333333333)
+
 /* TODO: parameterize
  * Some CCSR offsets duplicated in e500_ccsr.c
  */
@@ -113,7 +119,7 @@ static void dt_serial_create(void *fdt, unsigned long long offset,
     qemu_fdt_setprop_string(fdt, ser, "compatible", "ns16550");
     qemu_fdt_setprop_cells(fdt, ser, "reg", offset, 0x100);
     qemu_fdt_setprop_cell(fdt, ser, "cell-index", idx);
-    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", 0);
+    qemu_fdt_setprop_cell(fdt, ser, "clock-frequency", CCB_FREQ);
     qemu_fdt_setprop_cells(fdt, ser, "interrupts", 42, 2);
     qemu_fdt_setprop_phandle(fdt, ser, "interrupt-parent", mpic);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, ser);
@@ -759,6 +765,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     dev = qdev_create(NULL, "e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
                               OBJECT(dev), NULL);
+    qdev_prop_set_uint32(dev, "ccb-freq", CCB_FREQ);
     qdev_prop_set_uint32(dev, "mpic-model", params->mpic_version);
     qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
     qdev_prop_set_uint32(dev, "ram-size", ram_size);
diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
index f1adba4e54..c479ed91ee 100644
--- a/hw/ppc/e500_ccsr.c
+++ b/hw/ppc/e500_ccsr.c
@@ -69,6 +69,7 @@ typedef struct {
     uint32_t merrd;
 
     uint32_t porpllsr;
+    uint32_t ccb_freq;
 
     DeviceState *pic;
 } CCSRState;
@@ -272,15 +273,21 @@ static void e500_ccsr_realize(DeviceState *dev, Error **errp)
     /* Note: MPIC internal interrupts are offset by 16 */
 
     /* DUARTS */
+    /* for mpc8540, mpc8544, and P2010 (unmodeled), the DUART reference clock
+     * is the CCB clock divided by 16.
+     * So baud rate is CCB/(16*divider)
+     */
     if (serial_hds[0]) {
-        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(0),
-                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
+        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(0), 0,
+                       qdev_get_gpio_in(ccsr->pic, 16 + 26),
+                       ccsr->ccb_freq / 16u,
                        serial_hds[0], DEVICE_BIG_ENDIAN);
     }
 
     if (serial_hds[1]) {
-        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(1),
-                       0, qdev_get_gpio_in(ccsr->pic, 16 + 26), 399193,
+        serial_mm_init(&ccsr->iomem, E500_DUART_OFFSET(1), 0,
+                       qdev_get_gpio_in(ccsr->pic, 16 + 26),
+                       ccsr->ccb_freq / 16u,
                        serial_hds[1], DEVICE_BIG_ENDIAN);
     }
 
@@ -290,6 +297,7 @@ static Property e500_ccsr_props[] = {
     DEFINE_PROP_UINT32("base", CCSRState, defbase, 0xff700000),
     DEFINE_PROP_UINT32("ram-size", CCSRState, ram_size, 0),
     DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
+    DEFINE_PROP_UINT32("ccb-freq", CCSRState, ccb_freq, 333333333u),
     /* "mpic-model" aliased from MPIC */
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.11.0
