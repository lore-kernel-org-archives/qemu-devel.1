Received: from eggs.gnu.org ([2001:4830:134:3::10]:44140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq6-00052w-M9
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq4-0002Ay-QJ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:37 +1000
Message-Id: <20180709074350.27086-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/16] sm501: Implement i2c part for reading
 monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Emulate the i2c part of SM501 which is used to access the EDID info
from a monitor.

The vmstate structure is changed and its version is increased but
SM501 is only used on SH and PPC sam460ex machines that don't support
cross-version migration.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak    |   1 +
 default-configs/ppcemb-softmmu.mak |   1 +
 default-configs/sh4-softmmu.mak    |   2 +
 default-configs/sh4eb-softmmu.mak  |   2 +
 hw/display/sm501.c                 | 147 ++++++++++++++++++++++++++++-
 5 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index 6f12bf84f0..3181bbf163 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -25,6 +25,7 @@ CONFIG_ETSEC=3Dy
 CONFIG_SAM460EX=3Dy
 CONFIG_USB_EHCI_SYSBUS=3Dy
 CONFIG_SM501=3Dy
+CONFIG_DDC=3Dy
 CONFIG_IDE_SII3112=3Dy
 CONFIG_I2C=3Dy
 CONFIG_BITBANG_I2C=3Dy
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-=
softmmu.mak
index 37af1930b3..ac44f150c6 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -17,6 +17,7 @@ CONFIG_XILINX=3Dy
 CONFIG_XILINX_ETHLITE=3Dy
 CONFIG_USB_EHCI_SYSBUS=3Dy
 CONFIG_SM501=3Dy
+CONFIG_DDC=3Dy
 CONFIG_IDE_SII3112=3Dy
 CONFIG_I2C=3Dy
 CONFIG_BITBANG_I2C=3Dy
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmm=
u.mak
index 546d855088..caeccd55be 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -9,6 +9,8 @@ CONFIG_PFLASH_CFI02=3Dy
 CONFIG_SH4=3Dy
 CONFIG_IDE_MMIO=3Dy
 CONFIG_SM501=3Dy
+CONFIG_I2C=3Dy
+CONFIG_DDC=3Dy
 CONFIG_ISA_TESTDEV=3Dy
 CONFIG_I82378=3Dy
 CONFIG_I8259=3Dy
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-so=
ftmmu.mak
index 2d3fd49663..53b9cd7b5a 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -9,6 +9,8 @@ CONFIG_PFLASH_CFI02=3Dy
 CONFIG_SH4=3Dy
 CONFIG_IDE_MMIO=3Dy
 CONFIG_SM501=3Dy
+CONFIG_I2C=3Dy
+CONFIG_DDC=3Dy
 CONFIG_ISA_TESTDEV=3Dy
 CONFIG_I82378=3Dy
 CONFIG_I8259=3Dy
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9dec0d3218..05c964bea1 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -34,6 +35,8 @@
 #include "hw/devices.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/i2c-ddc.h"
 #include "qemu/range.h"
 #include "ui/pixel_ops.h"
=20
@@ -216,6 +219,14 @@
 #define SM501_I2C_SLAVE_ADDRESS         (0x03)
 #define SM501_I2C_DATA                  (0x04)
=20
+#define SM501_I2C_CONTROL_START         (1 << 2)
+#define SM501_I2C_CONTROL_ENABLE        (1 << 0)
+
+#define SM501_I2C_STATUS_COMPLETE       (1 << 3)
+#define SM501_I2C_STATUS_ERROR          (1 << 2)
+
+#define SM501_I2C_RESET_ERROR           (1 << 2)
+
 /* SSP base */
 #define SM501_SSP                       (0x020000)
=20
@@ -471,10 +482,12 @@ typedef struct SM501State {
     MemoryRegion local_mem_region;
     MemoryRegion mmio_region;
     MemoryRegion system_config_region;
+    MemoryRegion i2c_region;
     MemoryRegion disp_ctrl_region;
     MemoryRegion twoD_engine_region;
     uint32_t last_width;
     uint32_t last_height;
+    I2CBus *i2c_bus;
=20
     /* mmio registers */
     uint32_t system_control;
@@ -487,6 +500,11 @@ typedef struct SM501State {
     uint32_t misc_timing;
     uint32_t power_mode_control;
=20
+    uint8_t i2c_byte_count;
+    uint8_t i2c_status;
+    uint8_t i2c_addr;
+    uint8_t i2c_data[16];
+
     uint32_t uart0_ier;
     uint32_t uart0_lcr;
     uint32_t uart0_mcr;
@@ -897,6 +915,109 @@ static const MemoryRegionOps sm501_system_config_op=
s =3D {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
+static uint64_t sm501_i2c_read(void *opaque, hwaddr addr, unsigned size)
+{
+    SM501State *s =3D (SM501State *)opaque;
+    uint8_t ret =3D 0;
+
+    switch (addr) {
+    case SM501_I2C_BYTE_COUNT:
+        ret =3D s->i2c_byte_count;
+        break;
+    case SM501_I2C_STATUS:
+        ret =3D s->i2c_status;
+        break;
+    case SM501_I2C_SLAVE_ADDRESS:
+        ret =3D s->i2c_addr;
+        break;
+    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
+        ret =3D s->i2c_data[addr - SM501_I2C_DATA];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register r=
ead."
+                      " addr=3D0x%" HWADDR_PRIx "\n", addr);
+    }
+
+    SM501_DPRINTF("sm501 i2c regs : read addr=3D%" HWADDR_PRIx " val=3D%=
x\n",
+                  addr, ret);
+    return ret;
+}
+
+static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
+                            unsigned size)
+{
+    SM501State *s =3D (SM501State *)opaque;
+    SM501_DPRINTF("sm501 i2c regs : write addr=3D%" HWADDR_PRIx
+                  " val=3D%" PRIx64 "\n", addr, value);
+
+    switch (addr) {
+    case SM501_I2C_BYTE_COUNT:
+        s->i2c_byte_count =3D value & 0xf;
+        break;
+    case SM501_I2C_CONTROL:
+        if (value & SM501_I2C_CONTROL_ENABLE) {
+            if (value & SM501_I2C_CONTROL_START) {
+                int res =3D i2c_start_transfer(s->i2c_bus,
+                                             s->i2c_addr >> 1,
+                                             s->i2c_addr & 1);
+                s->i2c_status |=3D (res ? SM501_I2C_STATUS_ERROR : 0);
+                if (!res) {
+                    int i;
+                    SM501_DPRINTF("sm501 i2c : transferring %d bytes to =
0x%x\n",
+                                  s->i2c_byte_count + 1, s->i2c_addr >> =
1);
+                    for (i =3D 0; i <=3D s->i2c_byte_count; i++) {
+                        res =3D i2c_send_recv(s->i2c_bus, &s->i2c_data[i=
],
+                                            !(s->i2c_addr & 1));
+                        if (res) {
+                            SM501_DPRINTF("sm501 i2c : transfer failed"
+                                          " i=3D%d, res=3D%d\n", i, res)=
;
+                            s->i2c_status |=3D (res ? SM501_I2C_STATUS_E=
RROR : 0);
+                            return;
+                        }
+                    }
+                    if (i) {
+                        SM501_DPRINTF("sm501 i2c : transferred %d bytes\=
n", i);
+                        s->i2c_status =3D SM501_I2C_STATUS_COMPLETE;
+                    }
+                }
+            } else {
+                SM501_DPRINTF("sm501 i2c : end transfer\n");
+                i2c_end_transfer(s->i2c_bus);
+                s->i2c_status &=3D ~SM501_I2C_STATUS_ERROR;
+            }
+        }
+        break;
+    case SM501_I2C_RESET:
+        if ((value & SM501_I2C_RESET_ERROR) =3D=3D 0) {
+            s->i2c_status &=3D ~SM501_I2C_STATUS_ERROR;
+        }
+        break;
+    case SM501_I2C_SLAVE_ADDRESS:
+        s->i2c_addr =3D value & 0xff;
+        break;
+    case SM501_I2C_DATA ... SM501_I2C_DATA + 15:
+        s->i2c_data[addr - SM501_I2C_DATA] =3D value & 0xff;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "sm501 i2c : not implemented register w=
rite. "
+                      "addr=3D0x%" HWADDR_PRIx " val=3D%" PRIx64 "\n", a=
ddr, value);
+    }
+}
+
+static const MemoryRegionOps sm501_i2c_ops =3D {
+    .read =3D sm501_i2c_read,
+    .write =3D sm501_i2c_write,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 1,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 1,
+    },
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
 static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
 {
     SM501State *s =3D (SM501State *)opaque;
@@ -1577,6 +1698,10 @@ static void sm501_reset(SM501State *s)
     s->irq_mask =3D 0;
     s->misc_timing =3D 0;
     s->power_mode_control =3D 0;
+    s->i2c_byte_count =3D 0;
+    s->i2c_status =3D 0;
+    s->i2c_addr =3D 0;
+    memset(s->i2c_data, 0, 16);
     s->dc_panel_control =3D 0x00010000; /* FIFO level 3 */
     s->dc_video_control =3D 0;
     s->dc_crt_control =3D 0x00010000;
@@ -1615,6 +1740,12 @@ static void sm501_init(SM501State *s, DeviceState =
*dev,
     memory_region_set_log(&s->local_mem_region, true, DIRTY_MEMORY_VGA);
     s->local_mem =3D memory_region_get_ram_ptr(&s->local_mem_region);
=20
+    /* i2c */
+    s->i2c_bus =3D i2c_init_bus(dev, "sm501.i2c");
+    /* ddc */
+    I2CDDCState *ddc =3D I2CDDC(qdev_create(BUS(s->i2c_bus), TYPE_I2CDDC=
));
+    i2c_set_slave_address(I2C_SLAVE(ddc), 0x50);
+
     /* mmio */
     memory_region_init(&s->mmio_region, OBJECT(dev), "sm501.mmio", MMIO_=
SIZE);
     memory_region_init_io(&s->system_config_region, OBJECT(dev),
@@ -1622,6 +1753,9 @@ static void sm501_init(SM501State *s, DeviceState *=
dev,
                           "sm501-system-config", 0x6c);
     memory_region_add_subregion(&s->mmio_region, SM501_SYS_CONFIG,
                                 &s->system_config_region);
+    memory_region_init_io(&s->i2c_region, OBJECT(dev), &sm501_i2c_ops, s=
,
+                          "sm501-i2c", 0x14);
+    memory_region_add_subregion(&s->mmio_region, SM501_I2C, &s->i2c_regi=
on);
     memory_region_init_io(&s->disp_ctrl_region, OBJECT(dev),
                           &sm501_disp_ctrl_ops, s,
                           "sm501-disp-ctrl", 0x1000);
@@ -1705,6 +1839,11 @@ static const VMStateDescription vmstate_sm501_stat=
e =3D {
         VMSTATE_UINT32(twoD_destination_base, SM501State),
         VMSTATE_UINT32(twoD_alpha, SM501State),
         VMSTATE_UINT32(twoD_wrap, SM501State),
+        /* Added in version 2 */
+        VMSTATE_UINT8(i2c_byte_count, SM501State),
+        VMSTATE_UINT8(i2c_status, SM501State),
+        VMSTATE_UINT8(i2c_addr, SM501State),
+        VMSTATE_UINT8_ARRAY(i2c_data, SM501State, 16),
         VMSTATE_END_OF_LIST()
      }
 };
@@ -1770,8 +1909,8 @@ static void sm501_reset_sysbus(DeviceState *dev)
=20
 static const VMStateDescription vmstate_sm501_sysbus =3D {
     .name =3D TYPE_SYSBUS_SM501,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_STRUCT(state, SM501SysBusState, 1,
                        vmstate_sm501_state, SM501State),
@@ -1843,8 +1982,8 @@ static void sm501_reset_pci(DeviceState *dev)
=20
 static const VMStateDescription vmstate_sm501_pci =3D {
     .name =3D TYPE_PCI_SM501,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
         VMSTATE_STRUCT(state, SM501PCIState, 1,
--=20
2.17.1
