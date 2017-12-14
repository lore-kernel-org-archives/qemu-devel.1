Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUtL-0001eR-PN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUtJ-0000qu-W6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:43 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 06:52:52 -0800
Message-Id: <20171214145255.31545-13-andrew.smirnov@gmail.com>
In-Reply-To: <20171214145255.31545-1-andrew.smirnov@gmail.com>
References: <20171214145255.31545-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/15] sdhci: Add i.MX specific subtype of
 SDHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

IP block found on several generations of i.MX family does not use
vanilla SDHCI implementation and it comes with a number of quirks.

Introduce i.MX SDHCI subtype of SDHCI block to add code necessary to
support unmodified Linux guest driver.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/sd/sdhci-internal.h |  19 +++++
 hw/sd/sdhci.c          | 228 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/sd/sdhci.h  |  14 +++
 3 files changed, 259 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 161177cf39..b86ac0791b 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -85,12 +85,18 @@
 
 /* R/W Host control Register 0x0 */
 #define SDHC_HOSTCTL                   0x28
+#define SDHC_CTRL_LED                  0x01
 #define SDHC_CTRL_DMA_CHECK_MASK       0x18
 #define SDHC_CTRL_SDMA                 0x00
 #define SDHC_CTRL_ADMA1_32             0x08
 #define SDHC_CTRL_ADMA2_32             0x10
 #define SDHC_CTRL_ADMA2_64             0x18
 #define SDHC_DMA_TYPE(x)               ((x) & SDHC_CTRL_DMA_CHECK_MASK)
+#define SDHC_CTRL_4BITBUS              0x02
+#define SDHC_CTRL_8BITBUS              0x20
+#define SDHC_CTRL_CDTEST_INS           0x40
+#define SDHC_CTRL_CDTEST_EN            0x80
+
 
 /* R/W Power Control Register 0x0 */
 #define SDHC_PWRCON                    0x29
@@ -229,4 +235,17 @@ enum {
 
 extern const VMStateDescription sdhci_vmstate;
 
+
+#define ESDHC_MIX_CTRL                  0x48
+#define ESDHC_VENDOR_SPEC               0xc0
+#define ESDHC_DLL_CTRL                  0x60
+
+#define ESDHC_TUNING_CTRL               0xcc
+#define ESDHC_TUNE_CTRL_STATUS          0x68
+#define ESDHC_WTMK_LVL                  0x44
+
+#define ESDHC_CTRL_4BITBUS              (0x1 << 1)
+#define ESDHC_CTRL_8BITBUS              (0x2 << 1)
+
+
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6d6a791ee9..758af067f9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -265,7 +265,8 @@ static void sdhci_send_command(SDHCIState *s)
             }
         }
 
-        if ((s->norintstsen & SDHC_NISEN_TRSCMP) &&
+        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+            (s->norintstsen & SDHC_NISEN_TRSCMP) &&
             (s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY) {
             s->norintsts |= SDHC_NIS_TRSCMP;
         }
@@ -1191,6 +1192,8 @@ static void sdhci_initfn(SDHCIState *s)
 
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
+
+    s->io_ops = &sdhci_mmio_ops;
 }
 
 static void sdhci_uninitfn(SDHCIState *s)
@@ -1347,7 +1350,7 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
     sysbus_init_irq(sbd, &s->irq);
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
             SDHC_REGISTERS_MAP_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -1386,11 +1389,232 @@ static const TypeInfo sdhci_bus_info = {
     .class_init = sdhci_bus_class_init,
 };
 
+static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    SDHCIState *s = SYSBUS_SDHCI(opaque);
+    uint32_t ret;
+    uint16_t hostctl;
+
+    switch (offset) {
+    default:
+        return sdhci_read(opaque, offset, size);
+
+    case SDHC_HOSTCTL:
+        /*
+         * For a detailed explanation on the following bit
+         * manipulation code see comments in a similar part of
+         * usdhc_write()
+         */
+        hostctl = SDHC_DMA_TYPE(s->hostctl) << (8 - 3);
+
+        if (s->hostctl & SDHC_CTRL_8BITBUS) {
+            hostctl |= ESDHC_CTRL_8BITBUS;
+        }
+
+        if (s->hostctl & SDHC_CTRL_4BITBUS) {
+            hostctl |= ESDHC_CTRL_4BITBUS;
+        }
+
+        ret  = hostctl;
+        ret |= (uint32_t)s->blkgap << 16;
+        ret |= (uint32_t)s->wakcon << 24;
+
+        break;
+
+    case ESDHC_DLL_CTRL:
+    case ESDHC_TUNE_CTRL_STATUS:
+    case 0x6c:
+    case ESDHC_TUNING_CTRL:
+    case ESDHC_VENDOR_SPEC:
+    case ESDHC_MIX_CTRL:
+    case ESDHC_WTMK_LVL:
+        ret = 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void
+usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    SDHCIState *s = SYSBUS_SDHCI(opaque);
+    uint8_t hostctl;
+    uint32_t value = (uint32_t)val;
+
+    switch (offset) {
+    case ESDHC_DLL_CTRL:
+    case ESDHC_TUNE_CTRL_STATUS:
+    case 0x6c:
+    case ESDHC_TUNING_CTRL:
+    case ESDHC_WTMK_LVL:
+    case ESDHC_VENDOR_SPEC:
+        break;
+
+    case SDHC_HOSTCTL:
+        /*
+         * Here's What ESDHCI has at offset 0x28 (SDHC_HOSTCTL)
+         *
+         *       7         6     5      4      3      2        1      0
+         * |-----------+--------+--------+-----------+----------+---------|
+         * | Card      | Card   | Endian | DATA3     | Data     | Led     |
+         * | Detect    | Detect | Mode   | as Card   | Transfer | Control |
+         * | Signal    | Test   |        | Detection | Width    |         |
+         * | Selection | Level  |        | Pin       |          |         |
+         * |-----------+--------+--------+-----------+----------+---------|
+         *
+         * and 0x29
+         *
+         *  15      10 9    8
+         * |----------+------|
+         * | Reserved | DMA  |
+         * |          | Sel. |
+         * |          |      |
+         * |----------+------|
+         *
+         * and here's what SDCHI spec expects those offsets to be:
+         *
+         * 0x28 (Host Control Register)
+         *
+         *     7        6         5       4  3      2         1        0
+         * |--------+--------+----------+------+--------+----------+---------|
+         * | Card   | Card   | Extended | DMA  | High   | Data     | LED     |
+         * | Detect | Detect | Data     | Sel. | Speed  | Transfer | Control |
+         * | Signal | Test   | Transfer |      | Enable | Width    |         |
+         * | Sel.   | Level  | Width    |      |        |          |         |
+         * |--------+--------+----------+------+--------+----------+---------|
+         *
+         * and 0x29 (Power Control Register)
+         *
+         * |----------------------------------|
+         * | Power Control Register           |
+         * |                                  |
+         * | Description omitted,             |
+         * | since it has no analog in ESDHCI |
+         * |                                  |
+         * |----------------------------------|
+         *
+         * Since offsets 0x2A and 0x2B should be compatible between
+         * both IP specs we only need to reconcile least 16-bit of the
+         * word we've been given.
+         */
+
+        /*
+         * First, save bits 7 6 and 0 since they are identical
+         */
+        hostctl = value & (SDHC_CTRL_LED |
+                           SDHC_CTRL_CDTEST_INS |
+                           SDHC_CTRL_CDTEST_EN);
+        /*
+         * Second, split "Data Transfer Width" from bits 2 and 1 in to
+         * bits 5 and 1
+         */
+        if (value & ESDHC_CTRL_8BITBUS) {
+            hostctl |= SDHC_CTRL_8BITBUS;
+        }
+
+        if (value & ESDHC_CTRL_4BITBUS) {
+            hostctl |= ESDHC_CTRL_4BITBUS;
+        }
+
+        /*
+         * Third, move DMA select from bits 9 and 8 to bits 4 and 3
+         */
+        hostctl |= SDHC_DMA_TYPE(value >> (8 - 3));
+
+        /*
+         * Now place the corrected value into low 16-bit of the value
+         * we are going to give standard SDHCI write function
+         *
+         * NOTE: This transformation should be the inverse of what can
+         * be found in drivers/mmc/host/sdhci-esdhc-imx.c in Linux
+         * kernel
+         */
+        value &= ~UINT16_MAX;
+        value |= hostctl;
+        value |= (uint16_t)s->pwrcon << 8;
+
+        sdhci_write(opaque, offset, value, size);
+        break;
+
+    case ESDHC_MIX_CTRL:
+        /*
+         * So, when SD/MMC stack in Linux tries to write to "Transfer
+         * Mode Register", ESDHC i.MX quirk code will translate it
+         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
+         * order to get where we started
+         *
+         * Note that Auto CMD23 Enable bit is located in a wrong place
+         * on i.MX, but since it is not used by QEMU we do not care.
+         *
+         * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
+         * here becuase it will result in a call to
+         * sdhci_send_command(s) which we don't want.
+         *
+         */
+        s->trnmod = value & UINT16_MAX;
+        break;
+    case SDHC_TRNMOD:
+        /*
+         * Similar to above, but this time a write to "Command
+         * Register" will be translated into a 4-byte write to
+         * "Transfer Mode register" where lower 16-bit of value would
+         * be set to zero. So what we do is fill those bits with
+         * cached value from s->trnmod and let the SDHCI
+         * infrastructure handle the rest
+         */
+        sdhci_write(opaque, offset, val | s->trnmod, size);
+        break;
+    case SDHC_BLKSIZE:
+        /*
+         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
+         * Linux driver will try to zero this field out which will
+         * break the rest of SDHCI emulation.
+         *
+         * Linux defaults to maximum possible setting (512K boundary)
+         * and it seems to be the only option that i.MX IP implements,
+         * so we artificially set it to that value.
+         */
+        val |= 0x7 << 12;
+        /* FALLTHROUGH */
+    default:
+        sdhci_write(opaque, offset, val, size);
+        break;
+    }
+}
+
+
+static const MemoryRegionOps usdhc_mmio_ops = {
+    .read = usdhc_read,
+    .write = usdhc_write,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void imx_usdhc_init(Object *obj)
+{
+    SDHCIState *s = SYSBUS_SDHCI(obj);
+
+    s->io_ops = &usdhc_mmio_ops;
+    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+}
+
+static const TypeInfo imx_usdhc_info = {
+    .name = TYPE_IMX_USDHC,
+    .parent = TYPE_SYSBUS_SDHCI,
+    .instance_init = imx_usdhc_init,
+};
+
 static void sdhci_register_types(void)
 {
     type_register_static(&sdhci_pci_info);
     type_register_static(&sdhci_sysbus_info);
     type_register_static(&sdhci_bus_info);
+    type_register_static(&imx_usdhc_info);
 }
 
 type_init(sdhci_register_types)
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 0f0c3f1e64..b56836a2fc 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -39,6 +39,7 @@ typedef struct SDHCIState {
     };
     SDBus sdbus;
     MemoryRegion iomem;
+    const MemoryRegionOps *io_ops;
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
@@ -83,8 +84,19 @@ typedef struct SDHCIState {
     /* Force Event Auto CMD12 Error Interrupt Reg - write only */
     /* Force Event Error Interrupt Register- write only */
     /* RO Host Controller Version Register always reads as 0x2401 */
+
+    uint32_t quirks;
 } SDHCIState;
 
+/*
+ * Controller does not provide transfer-complete interrupt when not
+ * busy.
+ *
+ * NOTE: This definition is taken out of Linux kernel and so the
+ * original bit number is preserved
+ */
+#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
+
 #define TYPE_PCI_SDHCI "sdhci-pci"
 #define PCI_SDHCI(obj) OBJECT_CHECK(SDHCIState, (obj), TYPE_PCI_SDHCI)
 
@@ -92,4 +104,6 @@ typedef struct SDHCIState {
 #define SYSBUS_SDHCI(obj)                               \
      OBJECT_CHECK(SDHCIState, (obj), TYPE_SYSBUS_SDHCI)
 
+#define TYPE_IMX_USDHC "imx-usdhc"
+
 #endif /* SDHCI_H */
-- 
2.14.3
