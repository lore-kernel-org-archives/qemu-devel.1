Received: from eggs.gnu.org ([2001:4830:134:3::10]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1ft9kD-0007PC-Af
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <saipava@xilinx.com>) id 1ft9k9-00020f-Ie
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:55:09 -0400
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Date: Fri, 24 Aug 2018 16:25:32 +0530
Message-ID: <1535108133-3722-8-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1535108133-3722-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1535108133-3722-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [QEMU][PATCH 7/8] sdhci: Add i.MX specific subtype of
 SDHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edgari@xilinx.com, figlesia@xilinx.com
Cc: qemu-dev@xilinx.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, yurovsky@gmail.com

From: Andrey Smirnov <andrew.smirnov@gmail.com>

IP block found on several generations of i.MX family does not use
vanilla SDHCI implementation and it comes with a number of quirks.

Introduce i.MX SDHCI subtype of SDHCI block to add code necessary to
support unmodified Linux guest driver.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[PMM: define and use ESDHC_UNDOCUMENTED_REG27]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h |  22 +++++
 hw/sd/sdhci.c          | 230 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
 include/hw/sd/sdhci.h  |  13 +++
 3 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index fa69331..756ef3f 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -89,6 +89,7 @@ FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
=20
 /* R/W Host control Register 0x0 */
 #define SDHC_HOSTCTL                   0x28
+#define SDHC_CTRL_LED                  0x01
 #define SDHC_CTRL_DATATRANSFERWIDTH    0x02 /* SD mode only */
 #define SDHC_CTRL_HIGH_SPEED           0x04
 #define SDHC_CTRL_DMA_CHECK_MASK       0x18
@@ -97,6 +98,10 @@ FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
 #define SDHC_CTRL_ADMA2_32             0x10
 #define SDHC_CTRL_ADMA2_64             0x18
 #define SDHC_DMA_TYPE(x)               ((x) & SDHC_CTRL_DMA_CHECK_MASK)
+#define SDHC_CTRL_4BITBUS              0x02
+#define SDHC_CTRL_8BITBUS              0x20
+#define SDHC_CTRL_CDTEST_INS           0x40
+#define SDHC_CTRL_CDTEST_EN            0x80
=20
 /* R/W Power Control Register 0x0 */
 #define SDHC_PWRCON                    0x29
@@ -280,4 +285,21 @@ enum {
     sdhc_gap_write  =3D 2   /* SDHC stopped at block gap during write op=
eration */
 };
=20
+extern const VMStateDescription sdhci_vmstate;
+
+
+#define ESDHC_MIX_CTRL                  0x48
+#define ESDHC_VENDOR_SPEC               0xc0
+#define ESDHC_DLL_CTRL                  0x60
+
+#define ESDHC_TUNING_CTRL               0xcc
+#define ESDHC_TUNE_CTRL_STATUS          0x68
+#define ESDHC_WTMK_LVL                  0x44
+
+/* Undocumented register used by guests working around erratum ERR004536=
 */
+#define ESDHC_UNDOCUMENTED_REG27        0x6c
+
+#define ESDHC_CTRL_4BITBUS              (0x1 << 1)
+#define ESDHC_CTRL_8BITBUS              (0x2 << 1)
+
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8910470..3017e5a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -365,7 +365,8 @@ static void sdhci_send_command(SDHCIState *s)
             }
         }
=20
-        if ((s->norintstsen & SDHC_NISEN_TRSCMP) &&
+        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+            (s->norintstsen & SDHC_NISEN_TRSCMP) &&
             (s->cmdreg & SDHC_CMD_RESPONSE) =3D=3D SDHC_CMD_RSP_WITH_BUS=
Y) {
             s->norintsts |=3D SDHC_NIS_TRSCMP;
         }
@@ -1348,6 +1349,8 @@ static void sdhci_initfn(SDHCIState *s)
=20
     s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_ins=
ertion_irq, s);
     s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_tr=
ansfer, s);
+
+    s->io_ops =3D &sdhci_mmio_ops;
 }
=20
 static void sdhci_uninitfn(SDHCIState *s)
@@ -1566,6 +1569,10 @@ static void sdhci_sysbus_realize(DeviceState *dev,=
 Error ** errp)
     }
=20
     sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
+            SDHC_REGISTERS_MAP_SIZE);
+
     sysbus_init_mmio(sbd, &s->iomem);
 }
=20
@@ -1617,11 +1624,232 @@ static const TypeInfo sdhci_bus_info =3D {
     .class_init =3D sdhci_bus_class_init,
 };
=20
+static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
+    uint32_t ret;
+    uint16_t hostctl1;
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
+        hostctl1 =3D SDHC_DMA_TYPE(s->hostctl1) << (8 - 3);
+
+        if (s->hostctl1 & SDHC_CTRL_8BITBUS) {
+            hostctl1 |=3D ESDHC_CTRL_8BITBUS;
+        }
+
+        if (s->hostctl1 & SDHC_CTRL_4BITBUS) {
+            hostctl1 |=3D ESDHC_CTRL_4BITBUS;
+        }
+
+        ret  =3D hostctl1;
+        ret |=3D (uint32_t)s->blkgap << 16;
+        ret |=3D (uint32_t)s->wakcon << 24;
+
+        break;
+
+    case ESDHC_DLL_CTRL:
+    case ESDHC_TUNE_CTRL_STATUS:
+    case ESDHC_UNDOCUMENTED_REG27:
+    case ESDHC_TUNING_CTRL:
+    case ESDHC_VENDOR_SPEC:
+    case ESDHC_MIX_CTRL:
+    case ESDHC_WTMK_LVL:
+        ret =3D 0;
+        break;
+    }
+
+    return ret;
+}
+
+static void
+usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+{
+    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
+    uint8_t hostctl1;
+    uint32_t value =3D (uint32_t)val;
+
+    switch (offset) {
+    case ESDHC_DLL_CTRL:
+    case ESDHC_TUNE_CTRL_STATUS:
+    case ESDHC_UNDOCUMENTED_REG27:
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
+         * |-----------+--------+--------+-----------+----------+-------=
--|
+         * | Card      | Card   | Endian | DATA3     | Data     | Led   =
  |
+         * | Detect    | Detect | Mode   | as Card   | Transfer | Contro=
l |
+         * | Signal    | Test   |        | Detection | Width    |       =
  |
+         * | Selection | Level  |        | Pin       |          |       =
  |
+         * |-----------+--------+--------+-----------+----------+-------=
--|
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
+         * |--------+--------+----------+------+--------+----------+----=
-----|
+         * | Card   | Card   | Extended | DMA  | High   | Data     | LED=
     |
+         * | Detect | Detect | Data     | Sel. | Speed  | Transfer | Con=
trol |
+         * | Signal | Test   | Transfer |      | Enable | Width    |    =
     |
+         * | Sel.   | Level  | Width    |      |        |          |    =
     |
+         * |--------+--------+----------+------+--------+----------+----=
-----|
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
+        hostctl1 =3D value & (SDHC_CTRL_LED |
+                            SDHC_CTRL_CDTEST_INS |
+                            SDHC_CTRL_CDTEST_EN);
+        /*
+         * Second, split "Data Transfer Width" from bits 2 and 1 in to
+         * bits 5 and 1
+         */
+        if (value & ESDHC_CTRL_8BITBUS) {
+            hostctl1 |=3D SDHC_CTRL_8BITBUS;
+        }
+
+        if (value & ESDHC_CTRL_4BITBUS) {
+            hostctl1 |=3D ESDHC_CTRL_4BITBUS;
+        }
+
+        /*
+         * Third, move DMA select from bits 9 and 8 to bits 4 and 3
+         */
+        hostctl1 |=3D SDHC_DMA_TYPE(value >> (8 - 3));
+
+        /*
+         * Now place the corrected value into low 16-bit of the value
+         * we are going to give standard SDHCI write function
+         *
+         * NOTE: This transformation should be the inverse of what can
+         * be found in drivers/mmc/host/sdhci-esdhc-imx.c in Linux
+         * kernel
+         */
+        value &=3D ~UINT16_MAX;
+        value |=3D hostctl1;
+        value |=3D (uint16_t)s->pwrcon << 8;
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
+        s->trnmod =3D value & UINT16_MAX;
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
+        val |=3D 0x7 << 12;
+        /* FALLTHROUGH */
+    default:
+        sdhci_write(opaque, offset, val, size);
+        break;
+    }
+}
+
+
+static const MemoryRegionOps usdhc_mmio_ops =3D {
+    .read =3D usdhc_read,
+    .write =3D usdhc_write,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+        .unaligned =3D false
+    },
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+static void imx_usdhc_init(Object *obj)
+{
+    SDHCIState *s =3D SYSBUS_SDHCI(obj);
+
+    s->io_ops =3D &usdhc_mmio_ops;
+    s->quirks =3D SDHCI_QUIRK_NO_BUSY_IRQ;
+}
+
+static const TypeInfo imx_usdhc_info =3D {
+    .name =3D TYPE_IMX_USDHC,
+    .parent =3D TYPE_SYSBUS_SDHCI,
+    .instance_init =3D imx_usdhc_init,
+};
+
 static void sdhci_register_types(void)
 {
     type_register_static(&sdhci_pci_info);
     type_register_static(&sdhci_sysbus_info);
     type_register_static(&sdhci_bus_info);
+    type_register_static(&imx_usdhc_info);
 }
=20
 type_init(sdhci_register_types)
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 129d212..f321767 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -44,6 +44,7 @@ typedef struct SDHCIState {
     AddressSpace sysbus_dma_as;
     AddressSpace *dma_as;
     MemoryRegion *dma_mr;
+    const MemoryRegionOps *io_ops;
=20
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
@@ -93,10 +94,20 @@ typedef struct SDHCIState {
=20
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int=
 */
+    uint32_t quirks;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
 } SDHCIState;
=20
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
=20
@@ -104,4 +115,6 @@ typedef struct SDHCIState {
 #define SYSBUS_SDHCI(obj)                               \
      OBJECT_CHECK(SDHCIState, (obj), TYPE_SYSBUS_SDHCI)
=20
+#define TYPE_IMX_USDHC "imx-usdhc"
+
 #endif /* SDHCI_H */
--=20
2.7.4
