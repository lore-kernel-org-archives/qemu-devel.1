Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d9hcF-0003OD-10
	for qemu-devel@nongnu.org; Sat, 13 May 2017 20:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d9hc4-0004t7-9z
	for qemu-devel@nongnu.org; Sat, 13 May 2017 20:42:31 -0400
Received: from nm3-vm1.bullet.mail.ir2.yahoo.com ([212.82.96.90]:55436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <flypie@rocketmail.com>) id 1d9hc3-0004rO-Ee
	for qemu-devel@nongnu.org; Sat, 13 May 2017 20:42:20 -0400
Date: Sun, 14 May 2017 00:42:07 +0000 (UTC)
From: John Bradley <flypie@rocketmail.com>
Reply-To: John Bradley <flypie1@yahoo.com>
Message-ID: <757990479.60759.1494722527715@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <757990479.60759.1494722527715.ref@mail.yahoo.com>
Subject: [Qemu-devel] Changes to Broadcom(BCM) files and Raspberry Pi files.
 Addition of PanelEmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

>From 7f74f048f135d9c9c230a9e90f72451c841c6d35 Mon Sep 17 00:00:00 2001
From: John Bradley <flypie@rocketmail.com>
Date: Sat, 13 May 2017 23:07:47 +0100
Subject: [PATCH] Changes to Broadcom(BCM) files and Raspberry Pi files.
Addition of PanelEmu

The files add the ability to attach, via TCP, a panel emulator
The include a unification of several PD Raspberry PI additions
A modification to dev-network to all circle SDK WWW client to work
The DummyPanel is not included but available at
https://github.com/flypie/GDummyPanel.git

Signed-off-by: John Bradley <flypie@rocketmail.com>
---
.gitignore                           |   54 ++
hw/arm/Makefile.objs                 |    2 +-
hw/arm/bcm2835.c                     |  114 ++++
hw/arm/bcm2835_peripherals.c         |  104 ++++
hw/arm/bcm2836.c                     |    3 +-
hw/arm/raspi.c                       |   77 ++-
hw/gpio/bcm2835_gpio.c               |  333 ++++++-----
hw/misc/Makefile.objs                |    2 +
hw/misc/bcm2835_mphi.c               |  163 ++++++
hw/misc/bcm2835_power.c              |  106 ++++
hw/timer/Makefile.objs               |    2 +
hw/timer/bcm2835_st.c                |  202 +++++++
hw/timer/bcm2835_timer.c             |  224 +++++++
hw/usb/Makefile.objs                 |    4 +-
hw/usb/bcm2835_usb.c                 |  604 +++++++++++++++++++
hw/usb/bcm2835_usb_regs.h            | 1061 ++++++++++++++++++++++++++++++++++
hw/usb/dev-network.c                 |    2 +-
include/hw/arm/bcm2835.h             |   37 ++
include/hw/arm/bcm2835_peripherals.h |   10 +
include/hw/gpio/bcm2835_gpio.h       |    5 +
include/hw/intc/bcm2835_control.h    |   53 ++
include/hw/intc/bcm2836_control.h    |    2 +
include/hw/misc/bcm2835_mphi.h       |   28 +
include/hw/misc/bcm2835_power.h      |   22 +
include/hw/timer/bcm2835_st.h        |   25 +
include/hw/timer/bcm2835_timer.h     |   32 +
include/hw/usb/bcm2835_usb.h         |   78 +++
include/qemu/PanelEmu.h              |   53 ++
util/Makefile.objs                   |    1 +
util/PanelEmu.c                      |  293 ++++++++++
30 files changed, 3547 insertions(+), 149 deletions(-)
create mode 100644 hw/arm/bcm2835.c
create mode 100644 hw/misc/bcm2835_mphi.c
create mode 100644 hw/misc/bcm2835_power.c
create mode 100644 hw/timer/bcm2835_st.c
create mode 100644 hw/timer/bcm2835_timer.c
create mode 100644 hw/usb/bcm2835_usb.c
create mode 100644 hw/usb/bcm2835_usb_regs.h
create mode 100644 include/hw/arm/bcm2835.h
create mode 100644 include/hw/intc/bcm2835_control.h
create mode 100644 include/hw/misc/bcm2835_mphi.h
create mode 100644 include/hw/misc/bcm2835_power.h
create mode 100644 include/hw/timer/bcm2835_st.h
create mode 100644 include/hw/timer/bcm2835_timer.h
create mode 100644 include/hw/usb/bcm2835_usb.h
create mode 100644 include/qemu/PanelEmu.h
create mode 100644 util/PanelEmu.c

diff --git a/.gitignore b/.gitignore
index 55a001e3b8..08e0ac978f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+/bin
/config-devices.*
/config-all-devices.*
/config-all-disas.*
@@ -131,3 +132,56 @@ trace-dtrace-root.h
trace-dtrace-root.dtrace
trace-ust-all.h
trace-ust-all.c
+
+bin/debug/x86_64-w64-mingw64/Makefile
+
+bin/debug/x86_64-w64-mingw64/arm-softmmu/Makefile
+
+bin/debug/x86_64-w64-mingw64/arm-softmmu/config-devices.mak
+
+# Compiled source #
+###################
+*.com
+*.class
+*.dll
+*.exe
+*.o
+*.so
+
+# Packages #
+############
+# it's better to unpack these files and commit the raw source
+# git has its own built in compression methods
+*.7z
+*.dmg
+*.gz
+*.iso
+*.jar
+*.rar
+*.tar
+*.zip
+
+# Logs and databases #
+######################
+*.log
+*.sql
+*.sqlite
+
+# OS generated files #
+######################
+.DS_Store
+.DS_Store?
+._*
+.Spotlight-V100
+.Trashes
+ehthumbs.db
+Thumbs.db
+.cproject
+.project
+### NetBeans ###
+nbproject/private/
+build/
+nbbuild/
+dist/
+nbdist/
+.nb-gradle/
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 4c5c4ee76c..35b2da24f5 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -11,7 +11,7 @@ obj-y += armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
obj-$(CONFIG_DIGIC) += digic.o
obj-y += omap1.o omap2.o strongarm.o
obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
-obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
+obj-$(CONFIG_RASPI) += bcm2835.o bcm2835_peripherals.o bcm2836.o raspi.o
obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-ep108.o
obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
diff --git a/hw/arm/bcm2835.c b/hw/arm/bcm2835.c
new file mode 100644
index 0000000000..e5744c1620
--- /dev/null
+++ b/hw/arm/bcm2835.c
@@ -0,0 +1,114 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
+ *
+ * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/arm/bcm2835.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/sysbus.h"
+#include "exec/address-spaces.h"
+
+
+/* Peripheral base address seen by the CPU */
+#define BCM2835_PERI_BASE       0x20000000
+
+static void bcm2835_init(Object *obj)
+{
+    BCM2835State *s = BCM2835(obj);
+
+    object_initialize(&s->cpus[0], sizeof(s->cpus[0]), "arm1176-" TYPE_ARM_CPU);
+    object_property_add_child(obj, "cpu", OBJECT(&s->cpus[0]), &error_abort);
+
+    object_initialize(&s->peripherals, sizeof(s->peripherals),
+                      TYPE_BCM2835_PERIPHERALS);
+    object_property_add_child(obj, "peripherals", OBJECT(&s->peripherals),
+                              &error_abort);
+    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
+                              "board-rev", &error_abort);
+    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
+                              "vcram-size", &error_abort);
+    qdev_set_parent_bus(DEVICE(&s->peripherals), sysbus_get_default());
+}
+
+static void bcm2835_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835State *s = BCM2835(dev);
+    Object *obj;
+    Error *err = NULL;
+
+    /* common peripherals from bcm2835 */
+    obj = object_property_get_link(OBJECT(dev), "ram", &err);
+    if (obj == NULL) {
+        error_setg(errp, "%s: required ram link not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
+                              "sd-bus", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
+                            BCM2835_PERI_BASE, 1);
+
+    object_property_set_bool(OBJECT(&s->cpus[0]), true, "realized", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpus[0]), ARM_CPU_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+                       qdev_get_gpio_in(DEVICE(&s->cpus[0]), ARM_CPU_FIQ));
+}
+
+static Property bcm2835_props[] = {
+    DEFINE_PROP_UINT32("enabled-cpus", BCM2835State, enabled_cpus, BCM2835_NCPUS),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void bcm2835_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->props = bcm2835_props;
+    dc->realize = bcm2835_realize;
+}
+
+static const TypeInfo bcm2835_type_info = {
+    .name = TYPE_BCM2835,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835State),
+    .instance_init = bcm2835_init,
+    .class_init = bcm2835_class_init,
+};
+
+static void bcm2835_register_types(void)
+{
+    type_register_static(&bcm2835_type_info);
+}
+
+type_init(bcm2835_register_types)
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 369ef1e3bd..e0e8525eab 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -56,6 +56,29 @@ static void bcm2835_peripherals_init(Object *obj)
object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());

+    /* System timer */
+    object_initialize(&s->st, sizeof(s->st), TYPE_BCM2835_ST);
+    object_property_add_child(obj, "systimer", OBJECT(&s->st), NULL);
+    qdev_set_parent_bus(DEVICE(&s->st), sysbus_get_default());
+
+    /* ARM timer */
+    object_initialize(&s->timer, sizeof(s->timer), TYPE_BCM2835_TIMER);
+    object_property_add_child(obj, "armtimer", OBJECT(&s->timer), NULL);
+    qdev_set_parent_bus(DEVICE(&s->timer), sysbus_get_default());
+
+    /* USB controller */
+    object_initialize(&s->usb, sizeof(s->usb), TYPE_BCM2835_USB);
+    object_property_add_child(obj, "usb", OBJECT(&s->usb), NULL);
+    qdev_set_parent_bus(DEVICE(&s->usb), sysbus_get_default());
+
+    object_property_add_const_link(OBJECT(&s->usb), "dma_mr",
+                                   OBJECT(&s->gpu_bus_mr), &error_abort);
+
+    /* MPHI - Message-based Parallel Host Interface */
+    object_initialize(&s->mphi, sizeof(s->mphi), TYPE_BCM2835_MPHI);
+    object_property_add_child(obj, "mphi", OBJECT(&s->mphi), NULL);
+    qdev_set_parent_bus(DEVICE(&s->mphi), sysbus_get_default());
+
/* Mailboxes */
object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX);
object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
@@ -64,6 +87,11 @@ static void bcm2835_peripherals_init(Object *obj)
object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
OBJECT(&s->mbox_mr), &error_abort);

+    /* Power management */
+    object_initialize(&s->power, sizeof(s->power), TYPE_BCM2835_POWER);
+    object_property_add_child(obj, "power", OBJECT(&s->power), NULL);
+    qdev_set_parent_bus(DEVICE(&s->power), sysbus_get_default());
+
/* Framebuffer */
object_initialize(&s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
object_property_add_child(obj, "fb", OBJECT(&s->fb), NULL);
@@ -179,6 +207,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
sysbus_connect_irq(s->uart0, 0,
qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
INTERRUPT_UART));
+
/* AUX / UART1 */
qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hds[1]);

@@ -194,6 +223,67 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
INTERRUPT_AUX));

+    /* System timer */
+    object_property_set_bool(OBJECT(&s->st), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->st), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->st), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->st), 1,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->st), 2,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER2));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->st), 3,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER3));
+
+    /* ARM timer */
+    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, ARMCTRL_TIMER0_1_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
+                               INTERRUPT_ARM_TIMER));
+
+    /* USB controller */
+    object_property_set_bool(OBJECT(&s->usb), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, USB_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->usb), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_USB));
+
+    /* MPHI - Message-based Parallel Host Interface */
+    object_property_set_bool(OBJECT(&s->mphi), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, MPHI_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mphi), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mphi), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_HOSTPORT));
+
/* Mailboxes */
object_property_set_bool(OBJECT(&s->mboxes), true, "realized", &err);
if (err) {
@@ -207,6 +297,18 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
INTERRUPT_ARM_MAILBOX));

+    /* Power management */
+    object_property_set_bool(OBJECT(&s->power), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->mbox_mr, MBOX_CHAN_POWER << MBOX_AS_CHAN_SHIFT,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->power), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->power), 0,
+                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_POWER));
+
/* Framebuffer */
vcram_size = (uint32_t)object_property_get_int(OBJECT(s), "vcram-size",
&err);
@@ -338,6 +440,8 @@ static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
DeviceClass *dc = DEVICE_CLASS(oc);

dc->realize = bcm2835_peripherals_realize;
+    /* Reason: realize() method uses qemu_char_get_next_serial() */
+    dc->cannot_instantiate_with_device_add_yet = true;
}

static const TypeInfo bcm2835_peripherals_type_info = {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8c43291112..5f1bd15b24 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -27,7 +27,7 @@ static void bcm2836_init(Object *obj)
{
BCM2836State *s = BCM2836(obj);
int n;
-
+ 
for (n = 0; n < BCM2836_NCPUS; n++) {
object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
"cortex-a15-" TYPE_ARM_CPU);
@@ -106,6 +106,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
/* Mirror bcm2836, which has clusterid set to 0xf
* TODO: this should be converted to a property of ARM_CPU
*/
+
s->cpus[n].mp_affinity = 0xF00 | n;

/* set periphbase/CBAR value for CPU-local registers */
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2b295f14c4..8ed2d9785d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -4,6 +4,8 @@
*
* Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
* Written by Andrew Baumann
+ * 
+ * Merge into QEMU root fork John Bradley April 2017
*
* This code is licensed under the GNU GPLv2 and later.
*/
@@ -12,6 +14,7 @@
#include "qapi/error.h"
#include "qemu-common.h"
#include "cpu.h"
+#include "hw/arm/bcm2835.h"
#include "hw/arm/bcm2836.h"
#include "qemu/error-report.h"
#include "hw/boards.h"
@@ -27,10 +30,20 @@
/* Table of Linux board IDs for different Pi versions */
static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43};

-typedef struct RasPiState {
+/* Table of board revisions
+ * https://github.com/AndrewFromMelbourne/raspberry_pi_revision/blob/master/README.md
+ */
+static const uint32_t raspi_boardrev[] = {[1] = 0x10, [2] = 0xa21041};
+
+typedef struct RasPi1State {
+    BCM2835State soc;
+    MemoryRegion ram;
+} RasPi1State;
+
+typedef struct RasPi2State {
BCM2836State soc;
MemoryRegion ram;
-} RasPiState;
+} RasPi2State;

static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
{
@@ -113,9 +126,53 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
arm_load_kernel(ARM_CPU(first_cpu), &binfo);
}

+static void raspi1_init(MachineState *machine)
+{
+    RasPi1State *s = g_new0(RasPi1State, 1);
+    uint32_t vcram_size;
+    DriveInfo *di;
+    BlockBackend *blk;
+    BusState *bus;
+    DeviceState *carddev;
+
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2835);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+                              &error_abort);
+
+    /* Allocate and map RAM */
+    memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
+                                         machine->ram_size);
+    /* FIXME: Remove when we have custom CPU address space support */
+    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram, 0);
+
+    /* Setup the SOC */
+    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
+                                   &error_abort);
+//   object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
+//                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
+                            &error_abort);
+    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
+
+    /* Create and plug in the SD cards */
+    di = drive_get_next(IF_SD);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
+    if (bus == NULL) {
+        error_report("No SD bus found in SOC object");
+        exit(1);
+    }
+    carddev = qdev_create(bus, TYPE_SD_CARD);
+    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
+    object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
+
+    vcram_size = object_property_get_int(OBJECT(&s->soc), "vcram-size",
+                                         &error_abort);
+    setup_boot(machine, 1, machine->ram_size - vcram_size);
+}
static void raspi2_init(MachineState *machine)
{
-    RasPiState *s = g_new0(RasPiState, 1);
+    RasPi2State *s = g_new0(RasPi2State, 1);
uint32_t vcram_size;
DriveInfo *di;
BlockBackend *blk;
@@ -158,6 +215,20 @@ static void raspi2_init(MachineState *machine)
setup_boot(machine, 2, machine->ram_size - vcram_size);
}

+
+static void raspi1_machine_init(MachineClass *mc)
+{
+    mc->desc = "Raspberry Pi 1";
+    mc->init = raspi1_init;
+    mc->block_default_type = IF_SD;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->max_cpus = BCM2835_NCPUS;
+    mc->default_ram_size = 512 * 1024 * 1024;
+};
+DEFINE_MACHINE("raspi1", raspi1_machine_init)
+
static void raspi2_machine_init(MachineClass *mc)
{
mc->desc = "Raspberry Pi 2";
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index acc2e3cf9e..37be668d2a 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -19,6 +19,8 @@
#include "hw/sd/sd.h"
#include "hw/gpio/bcm2835_gpio.h"

+
+
#define GPFSEL0   0x00
#define GPFSEL1   0x04
#define GPFSEL2   0x08
@@ -53,9 +55,9 @@ static uint32_t gpfsel_get(BCM2835GpioState *s, uint8_t reg)
{
int i;
uint32_t value = 0;
-    for (i = 0; i < 10; i++) {
+    for (i = 0; i < 10; i ++) {
uint32_t index = 10 * reg + i;
-        if (index < sizeof(s->fsel)) {
+        if (index < sizeof (s->fsel)) {
value |= (s->fsel[index] & 0x7) << (3 * i);
}
}
@@ -65,9 +67,9 @@ static uint32_t gpfsel_get(BCM2835GpioState *s, uint8_t reg)
static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)
{
int i;
-    for (i = 0; i < 10; i++) {
+    for (i = 0; i < 10; i ++) {
uint32_t index = 10 * reg + i;
-        if (index < sizeof(s->fsel)) {
+        if (index < sizeof (s->fsel)) {
int fsel = (value >> (3 * i)) & 0x7;
s->fsel[index] = fsel;
}
@@ -75,24 +77,24 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)

/* SD controller selection (48-53) */
if (s->sd_fsel != 0
-            && (s->fsel[48] == 0) /* SD_CLK_R */
-            && (s->fsel[49] == 0) /* SD_CMD_R */
-            && (s->fsel[50] == 0) /* SD_DATA0_R */
-            && (s->fsel[51] == 0) /* SD_DATA1_R */
-            && (s->fsel[52] == 0) /* SD_DATA2_R */
-            && (s->fsel[53] == 0) /* SD_DATA3_R */
-            ) {
+        && (s->fsel[48] == 0) /* SD_CLK_R */
+        && (s->fsel[49] == 0) /* SD_CMD_R */
+        && (s->fsel[50] == 0) /* SD_DATA0_R */
+        && (s->fsel[51] == 0) /* SD_DATA1_R */
+        && (s->fsel[52] == 0) /* SD_DATA2_R */
+        && (s->fsel[53] == 0) /* SD_DATA3_R */
+        ) {
/* SDHCI controller selected */
sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
s->sd_fsel = 0;
} else if (s->sd_fsel != 4
-            && (s->fsel[48] == 4) /* SD_CLK_R */
-            && (s->fsel[49] == 4) /* SD_CMD_R */
-            && (s->fsel[50] == 4) /* SD_DATA0_R */
-            && (s->fsel[51] == 4) /* SD_DATA1_R */
-            && (s->fsel[52] == 4) /* SD_DATA2_R */
-            && (s->fsel[53] == 4) /* SD_DATA3_R */
-            ) {
+               && (s->fsel[48] == 4) /* SD_CLK_R */
+               && (s->fsel[49] == 4) /* SD_CMD_R */
+               && (s->fsel[50] == 4) /* SD_DATA0_R */
+               && (s->fsel[51] == 4) /* SD_DATA1_R */
+               && (s->fsel[52] == 4) /* SD_DATA2_R */
+               && (s->fsel[53] == 4) /* SD_DATA3_R */
+               ) {
/* SDHost controller selected */
sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
s->sd_fsel = 4;
@@ -108,13 +110,13 @@ static int gpfsel_is_out(BCM2835GpioState *s, int index)
}

static void gpset(BCM2835GpioState *s,
-        uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
+                  uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
{
-    uint32_t changes = val & ~*lev;
+    uint32_t changes = val & ~ *lev;
uint32_t cur = 1;

int i;
-    for (i = 0; i < count; i++) {
+    for (i = 0; i < count; i ++) {
if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
qemu_set_irq(s->out[start + i], 1);
}
@@ -125,132 +127,165 @@ static void gpset(BCM2835GpioState *s,
}

static void gpclr(BCM2835GpioState *s,
-        uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
+                  uint32_t val, uint8_t start, uint8_t count, uint32_t *lev)
{
uint32_t changes = val & *lev;
uint32_t cur = 1;

int i;
-    for (i = 0; i < count; i++) {
+    for (i = 0; i < count; i ++) {
if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
qemu_set_irq(s->out[start + i], 0);
}
cur <<= 1;
}

-    *lev &= ~val;
+    *lev &= ~ val;
}

-static uint64_t bcm2835_gpio_read(void *opaque, hwaddr offset,
-        unsigned size)
+static uint64_t bcm2835_gpio_read(void *opaque, hwaddr offset, unsigned size)
{
-    BCM2835GpioState *s = (BCM2835GpioState *)opaque;
+    BCM2835GpioState *s = (BCM2835GpioState *) opaque;
+
+    uint64_t Data;

switch (offset) {
-    case GPFSEL0:
-    case GPFSEL1:
-    case GPFSEL2:
-    case GPFSEL3:
-    case GPFSEL4:
-    case GPFSEL5:
-        return gpfsel_get(s, offset / 4);
-    case GPSET0:
-    case GPSET1:
-        /* Write Only */
-        return 0;
-    case GPCLR0:
-    case GPCLR1:
-        /* Write Only */
-        return 0;
-    case GPLEV0:
-        return s->lev0;
-    case GPLEV1:
-        return s->lev1;
-    case GPEDS0:
-    case GPEDS1:
-    case GPREN0:
-    case GPREN1:
-    case GPFEN0:
-    case GPFEN1:
-    case GPHEN0:
-    case GPHEN1:
-    case GPLEN0:
-    case GPLEN1:
-    case GPAREN0:
-    case GPAREN1:
-    case GPAFEN0:
-    case GPAFEN1:
-    case GPPUD:
-    case GPPUDCLK0:
-    case GPPUDCLK1:
-        /* Not implemented */
-        return 0;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-                __func__, offset);
-        break;
+        case GPFSEL0:
+        case GPFSEL1:
+        case GPFSEL2:
+        case GPFSEL3:
+        case GPFSEL4:
+        case GPFSEL5:
+            return gpfsel_get(s, offset / 4);
+        case GPSET0:
+        case GPSET1:
+            /* Write Only */
+            return 0;
+        case GPCLR0:
+        case GPCLR1:
+            /* Write Only */
+            return 0;
+        case GPLEV0:
+            if (s->panel.socket != - 1) {
+                if (panel_read(&s->panel, &Data)) {
+                    s->lev0 = (uint32_t) Data;
+                    s->lev1 = (uint32_t) (Data >> 32);
+                }
+            }
+            return s->lev0;
+        case GPLEV1:
+            if (s->panel.socket != - 1) {
+                if (panel_read(&s->panel, &Data)) {
+                    s->lev0 = (uint32_t) Data;
+                    s->lev1 = (uint32_t) (Data >> 32);
+                }
+            }
+            return s->lev1;
+        case GPEDS0:
+        case GPEDS1:
+        case GPREN0:
+        case GPREN1:
+        case GPFEN0:
+        case GPFEN1:
+        case GPHEN0:
+        case GPHEN1:
+        case GPLEN0:
+        case GPLEN1:
+        case GPAREN0:
+        case GPAREN1:
+        case GPAFEN0:
+        case GPAFEN1:
+        case GPPUD:
+        case GPPUDCLK0:
+        case GPPUDCLK1:
+            /* Not implemented */
+            return 0;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+                          __func__, offset);
+            break;
}

return 0;
}

static void bcm2835_gpio_write(void *opaque, hwaddr offset,
-        uint64_t value, unsigned size)
+                               uint64_t value, unsigned size)
{
-    BCM2835GpioState *s = (BCM2835GpioState *)opaque;
+    BCM2835GpioState *s = (BCM2835GpioState *) opaque;
+    uint64_t Data;
+

switch (offset) {
-    case GPFSEL0:
-    case GPFSEL1:
-    case GPFSEL2:
-    case GPFSEL3:
-    case GPFSEL4:
-    case GPFSEL5:
-        gpfsel_set(s, offset / 4, value);
-        break;
-    case GPSET0:
-        gpset(s, value, 0, 32, &s->lev0);
-        break;
-    case GPSET1:
-        gpset(s, value, 32, 22, &s->lev1);
-        break;
-    case GPCLR0:
-        gpclr(s, value, 0, 32, &s->lev0);
-        break;
-    case GPCLR1:
-        gpclr(s, value, 32, 22, &s->lev1);
-        break;
-    case GPLEV0:
-    case GPLEV1:
-        /* Read Only */
-        break;
-    case GPEDS0:
-    case GPEDS1:
-    case GPREN0:
-    case GPREN1:
-    case GPFEN0:
-    case GPFEN1:
-    case GPHEN0:
-    case GPHEN1:
-    case GPLEN0:
-    case GPLEN1:
-    case GPAREN0:
-    case GPAREN1:
-    case GPAFEN0:
-    case GPAFEN1:
-    case GPPUD:
-    case GPPUDCLK0:
-    case GPPUDCLK1:
-        /* Not implemented */
-        break;
-    default:
-        goto err_out;
+        case GPFSEL0:
+        case GPFSEL1:
+        case GPFSEL2:
+        case GPFSEL3:
+        case GPFSEL4:
+        case GPFSEL5:
+            gpfsel_set(s, offset / 4, value);
+            break;
+        case GPSET0:
+            gpset(s, value, 0, 32, &s->lev0);
+            if (s->panel.socket != - 1) {
+                Data = value;
+                senddatatopanel(&s->panel, Data, true); //John Bradley dummy GPIO Panel
+            }
+            break;
+        case GPSET1:
+            gpset(s, value, 32, 22, &s->lev1);
+            if (s->panel.socket != - 1) {
+                Data = value;
+                Data <<= 32;
+                senddatatopanel(&s->panel, Data, true); //John Bradley dummy GPIO Panel
+            }
+            break;
+        case GPCLR0:
+            gpclr(s, value, 0, 32, &s->lev0);
+            if (s->panel.socket != - 1) {
+                Data = value;
+                senddatatopanel(&s->panel, Data, false); //John Bradley dummy GPIO Panel
+            }
+            break;
+        case GPCLR1:
+            gpclr(s, value, 32, 22, &s->lev1);
+            if (s->panel.socket != - 1) {
+                Data = value;
+                Data <<= 32;
+                senddatatopanel(&s->panel, Data, false); //John Bradley dummy GPIO Panel
+            }
+            break;
+        case GPLEV0:
+        case GPLEV1:
+            /* Read Only */
+            break;
+        case GPEDS0:
+        case GPEDS1:
+        case GPREN0:
+        case GPREN1:
+        case GPFEN0:
+        case GPFEN1:
+        case GPHEN0:
+        case GPHEN1:
+        case GPLEN0:
+        case GPLEN1:
+        case GPAREN0:
+        case GPAREN1:
+        case GPAFEN0:
+        case GPAFEN1:
+        case GPPUD:
+        case GPPUDCLK0:
+        case GPPUDCLK1:
+            /* Not implemented */
+            break;
+        default:
+            goto err_out;
}
return;

err_out:
qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-            __func__, offset);
+                  __func__, offset);
}

static void bcm2835_gpio_reset(DeviceState *dev)
@@ -258,7 +293,7 @@ static void bcm2835_gpio_reset(DeviceState *dev)
BCM2835GpioState *s = BCM2835_GPIO(dev);

int i;
-    for (i = 0; i < 6; i++) {
+    for (i = 0; i < 6; i ++) {
gpfsel_set(s, i, 0);
}

@@ -272,21 +307,22 @@ static void bcm2835_gpio_reset(DeviceState *dev)
}

static const MemoryRegionOps bcm2835_gpio_ops = {
-    .read = bcm2835_gpio_read,
-    .write = bcm2835_gpio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+                                                 .read = bcm2835_gpio_read,
+                                                 .write = bcm2835_gpio_write,
+                                                 .endianness = DEVICE_NATIVE_ENDIAN,
};

static const VMStateDescription vmstate_bcm2835_gpio = {
-    .name = "bcm2835_gpio",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(fsel, BCM2835GpioState, 54),
-        VMSTATE_UINT32(lev0, BCM2835GpioState),
-        VMSTATE_UINT32(lev1, BCM2835GpioState),
-        VMSTATE_UINT8(sd_fsel, BCM2835GpioState),
-        VMSTATE_END_OF_LIST()
+                                                        .name = "bcm2835_gpio",
+                                                        .version_id = 1,
+                                                        .minimum_version_id = 1,
+                                                        .fields = (VMStateField[])
+    {
+     VMSTATE_UINT8_ARRAY(fsel, BCM2835GpioState, 54),
+     VMSTATE_UINT32(lev0, BCM2835GpioState),
+     VMSTATE_UINT32(lev1, BCM2835GpioState),
+     VMSTATE_UINT8(sd_fsel, BCM2835GpioState),
+     VMSTATE_END_OF_LIST()
}
};

@@ -296,13 +332,26 @@ static void bcm2835_gpio_init(Object *obj)
DeviceState *dev = DEVICE(obj);
SysBusDevice *sbd = SYS_BUS_DEVICE(obj);

-    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
+    qbus_create_inplace(&s->sdbus, sizeof (s->sdbus),
TYPE_SD_BUS, DEVICE(s), "sd-bus");

memory_region_init_io(&s->iomem, obj,
-            &bcm2835_gpio_ops, s, "bcm2835_gpio", 0x1000);
+                          &bcm2835_gpio_ops, s, "bcm2835_gpio", 0x1000);
sysbus_init_mmio(sbd, &s->iomem);
qdev_init_gpio_out(dev, s->out, 54);
+
+    int err;
+
+    /* Get access to the GPIO panel, program will quit on fail */
+    err = panel_open(&s->panel);
+    if (err) {
+        printf("Couldn't connect to a GPIO panel\n"); //John Bradley dummy GPIO Panel
+    } else {
+        sendpincount(&s->panel, 54); //PI Has 54 Pins
+        sendenabledmap(&s->panel, 0x003FFFFFFFFFFFFC); //Pins 0 & 1 are I2C so disable
+        sendinputmap(&s->panel, 0x0000000000000000); //There are no dedicated input pins I know off
+        sendoutputmap(&s->panel, 0x0000800000000000); //Pin 53 is dedicated output LED
+    }
}

static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
@@ -314,7 +363,7 @@ static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &err);
if (obj == NULL) {
error_setg(errp, "%s: required sdhci link not found: %s",
-                __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(err));
return;
}
s->sdbus_sdhci = SD_BUS(obj);
@@ -322,7 +371,7 @@ static void bcm2835_gpio_realize(DeviceState *dev, Error **errp)
obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &err);
if (obj == NULL) {
error_setg(errp, "%s: required sdhost link not found: %s",
-                __func__, error_get_pretty(err));
+                   __func__, error_get_pretty(err));
return;
}
s->sdbus_sdhost = SD_BUS(obj);
@@ -332,17 +381,17 @@ static void bcm2835_gpio_class_init(ObjectClass *klass, void *data)
{
DeviceClass *dc = DEVICE_CLASS(klass);

-    dc->vmsd = &vmstate_bcm2835_gpio;
-    dc->realize = &bcm2835_gpio_realize;
-    dc->reset = &bcm2835_gpio_reset;
+    dc->vmsd = & vmstate_bcm2835_gpio;
+    dc->realize = & bcm2835_gpio_realize;
+    dc->reset = & bcm2835_gpio_reset;
}

static const TypeInfo bcm2835_gpio_info = {
-    .name          = TYPE_BCM2835_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(BCM2835GpioState),
-    .instance_init = bcm2835_gpio_init,
-    .class_init    = bcm2835_gpio_class_init,
+                                           .name = TYPE_BCM2835_GPIO,
+                                           .parent = TYPE_SYS_BUS_DEVICE,
+                                           .instance_size = sizeof (BCM2835GpioState),
+                                           .instance_init = bcm2835_gpio_init,
+                                           .class_init = bcm2835_gpio_class_init,
};

static void bcm2835_gpio_register_types(void)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c8b489390f..fd0cc922ee 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -41,6 +41,8 @@ obj-$(CONFIG_OMAP) += omap_l4.o
obj-$(CONFIG_OMAP) += omap_sdrc.o
obj-$(CONFIG_OMAP) += omap_tap.o
obj-$(CONFIG_RASPI) += bcm2835_mbox.o
+obj-$(CONFIG_RASPI) += bcm2835_mphi.o
+obj-$(CONFIG_RASPI) += bcm2835_power.o
obj-$(CONFIG_RASPI) += bcm2835_property.o
obj-$(CONFIG_RASPI) += bcm2835_rng.o
obj-$(CONFIG_SLAVIO) += slavio_misc.o
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
new file mode 100644
index 0000000000..7681e00684
--- /dev/null
+++ b/hw/misc/bcm2835_mphi.c
@@ -0,0 +1,163 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/bcm2835_mphi.h"
+
+#include "qemu/log.h"
+#include "qapi/error.h"
+
+static void bcm2835_mphi_update_irq(BCM2835MphiState *s)
+{
+    if (s->mphi_intstat) {
+        qemu_set_irq(s->irq, 1);
+    } else {
+        qemu_set_irq(s->irq, 0);
+    }
+}
+
+static uint64_t bcm2835_mphi_read(void *opaque, hwaddr offset,
+    unsigned size)
+{
+    BCM2835MphiState *s = (BCM2835MphiState *)opaque;
+    uint32_t res = 0;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x00:    /* mphi_base */
+        res = s->mphi_base;
+        break;
+    case 0x28:    /* mphi_outdda */
+        res = s->mphi_outdda;
+        break;
+    case 0x2c:    /* mphi_outddb */
+        res = s->mphi_outddb;
+        break;
+    case 0x4c:    /* mphi_ctrl */
+        res = s->mphi_ctrl;
+        break;
+    case 0x50:    /* mphi_intstat */
+        res = s->mphi_intstat;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_mphi_read: Bad offset %x\n", (int)offset);
+        res = 0;
+        break;
+    }
+
+    return res;
+}
+
+static void bcm2835_mphi_write(void *opaque, hwaddr offset,
+    uint64_t value, unsigned size)
+{
+    BCM2835MphiState *s = (BCM2835MphiState *)opaque;
+    int set_irq = 0;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x00:    /* mphi_base */
+        s->mphi_base = value;
+        break;
+    case 0x28:    /* mphi_outdda */
+        s->mphi_outdda = value;
+        break;
+    case 0x2c:    /* mphi_outddb */
+        s->mphi_outddb = value;
+        if (value & (1 << 29)) {
+            /* Enable MPHI interrupt */
+            s->mphi_intstat |= (1 << 16);
+            set_irq = 1;
+        }
+        break;
+    case 0x4c:    /* mphi_ctrl */
+        s->mphi_ctrl &= ~(1 << 31);
+        s->mphi_ctrl |= value & (1 << 31);
+
+        s->mphi_ctrl &= ~(3 << 16);
+        if (value & (1 << 16)) {
+            s->mphi_ctrl |= (3 << 16);
+        }
+
+        break;
+    case 0x50:    /* mphi_intstat */
+        s->mphi_intstat &= ~value;
+        set_irq = 1;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_mphi_write: Bad offset %x\n", (int)offset);
+        break;
+    }
+
+    if (set_irq) {
+        bcm2835_mphi_update_irq(s);
+    }
+}
+
+static const MemoryRegionOps bcm2835_mphi_ops = {
+    .read = bcm2835_mphi_read,
+    .write = bcm2835_mphi_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_bcm2835_mphi = {
+    .name = TYPE_BCM2835_MPHI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_mphi_init(Object *obj)
+{
+    BCM2835MphiState *s = BCM2835_MPHI(obj);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_mphi_ops, s,
+                          TYPE_BCM2835_MPHI, 0x1000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+}
+
+static void bcm2835_mphi_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835MphiState *s = BCM2835_MPHI(dev);
+
+    s->mphi_base = 0;
+    s->mphi_ctrl = 0;
+    s->mphi_outdda = 0;
+    s->mphi_outddb = 0;
+    s->mphi_intstat = 0;
+}
+
+static void bcm2835_mphi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_mphi_realize;
+    dc->vmsd = &vmstate_bcm2835_mphi;
+}
+
+static TypeInfo bcm2835_mphi_info = {
+    .name          = TYPE_BCM2835_MPHI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835MphiState),
+    .class_init    = bcm2835_mphi_class_init,
+    .instance_init = bcm2835_mphi_init,
+};
+
+static void bcm2835_mphi_register_types(void)
+{
+    type_register_static(&bcm2835_mphi_info);
+}
+
+type_init(bcm2835_mphi_register_types)
diff --git a/hw/misc/bcm2835_power.c b/hw/misc/bcm2835_power.c
new file mode 100644
index 0000000000..3bdb2b03da
--- /dev/null
+++ b/hw/misc/bcm2835_power.c
@@ -0,0 +1,106 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/bcm2835_power.h"
+#include "hw/misc/bcm2835_mbox_defs.h"
+
+#include "qemu/log.h"
+#include "qapi/error.h"
+
+static uint64_t bcm2835_power_read(void *opaque, hwaddr offset, unsigned size)
+{
+    BCM2835PowerState *s = (BCM2835PowerState *)opaque;
+    uint32_t res = 0;
+
+    switch (offset) {
+    case 0:
+        res = MBOX_CHAN_POWER;
+        s->pending = 0;
+        qemu_set_irq(s->mbox_irq, 0);
+        break;
+    case 4:
+        res = s->pending;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_power_read: Bad offset %x\n", (int)offset);
+        return 0;
+    }
+    return res;
+}
+
+static void bcm2835_power_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned size)
+{
+    BCM2835PowerState *s = (BCM2835PowerState *)opaque;
+    switch (offset) {
+    case 0:
+        s->pending = 1;
+        qemu_set_irq(s->mbox_irq, 1);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_power_write: Bad offset %x\n", (int)offset);
+        return;
+    }
+
+}
+
+static const MemoryRegionOps bcm2835_power_ops = {
+    .read = bcm2835_power_read,
+    .write = bcm2835_power_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_bcm2835_power = {
+    .name = TYPE_BCM2835_POWER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_power_init(Object *obj)
+{
+    BCM2835PowerState *s = BCM2835_POWER(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->mbox_irq);
+    memory_region_init_io(&s->iomem, obj, &bcm2835_power_ops, s,
+                          TYPE_BCM2835_POWER, 0x10);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void bcm2835_power_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835PowerState *s = BCM2835_POWER(dev);
+
+    s->pending = 0;
+}
+
+static void bcm2835_power_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_power_realize;
+    dc->vmsd = &vmstate_bcm2835_power;
+}
+
+static TypeInfo bcm2835_power_info = {
+    .name          = TYPE_BCM2835_POWER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835PowerState),
+    .class_init    = bcm2835_power_class_init,
+    .instance_init = bcm2835_power_init,
+};
+
+static void bcm2835_power_register_types(void)
+{
+    type_register_static(&bcm2835_power_info);
+}
+
+type_init(bcm2835_power_register_types)
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index dd6f27e2a3..7beccc8747 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -29,6 +29,8 @@ obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
obj-$(CONFIG_OMAP) += omap_gptimer.o
obj-$(CONFIG_OMAP) += omap_synctimer.o
obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
+obj-$(CONFIG_RASPI) += bcm2835_st.o
+obj-$(CONFIG_RASPI) += bcm2835_timer.o
obj-$(CONFIG_SH4) += sh_timer.o
obj-$(CONFIG_DIGIC) += digic-timer.o
obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
diff --git a/hw/timer/bcm2835_st.c b/hw/timer/bcm2835_st.c
new file mode 100644
index 0000000000..fb5cf5e573
--- /dev/null
+++ b/hw/timer/bcm2835_st.c
@@ -0,0 +1,202 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+/* Based on several timers code found in various QEMU source files. */
+
+#include "qemu/osdep.h"
+#include "hw/timer/bcm2835_st.h"
+#include "qemu/log.h"
+
+static void bcm2835_st_update(BCM2835StState *s)
+{
+    int64_t now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+    uint32_t clo = (uint32_t)now;
+    uint32_t delta;
+    bool set = false;
+    int i;
+
+    /* Calculate new "next" value and reschedule */
+    for (i = 0; i < 4; i++) {
+        if (!(s->match & (1 << i))) {
+            if (!set || s->compare[i] - clo < delta) {
+                set = true;
+                s->next = s->compare[i];
+                delta = s->next - clo;
+            }
+        }
+    }
+
+    if (set) {
+        timer_mod(s->timer, now + delta);
+    } else {
+        timer_del(s->timer);
+    }
+}
+
+static void bcm2835_st_tick(void *opaque)
+{
+    BCM2835StState *s = (BCM2835StState *)opaque;
+    int i;
+
+    /* Trigger irqs for current "next" value */
+    for (i = 0; i < 4; i++) {
+        if (!(s->match & (1 << i)) && (s->next == s->compare[i])) {
+            s->match |= (1 << i);
+            qemu_set_irq(s->irq[i], 1);
+        }
+    }
+
+    bcm2835_st_update(s);
+}
+
+static uint64_t bcm2835_st_read(void *opaque, hwaddr offset,
+                           unsigned size)
+{
+    BCM2835StState *s = (BCM2835StState *)opaque;
+    uint32_t res = 0;
+    uint64_t now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x00:
+        res = s->match;
+        break;
+    case 0x04:
+        res = (uint32_t)now;
+        /* Ugly temporary hack to get Plan9 to boot... */
+        /* see http://plan9.bell-labs.com/sources/contrib/ \
+         * miller/rpi/sys/src/9/bcm/clock.c */
+        /* res = (now / 10000) * 10000; */
+        break;
+    case 0x08:
+        res = (now >> 32);
+        break;
+    case 0x0c:
+        res = s->compare[0];
+        break;
+    case 0x10:
+        res = s->compare[1];
+        break;
+    case 0x14:
+        res = s->compare[2];
+        break;
+    case 0x18:
+        res = s->compare[3];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_st_read: Bad offset %x\n", (int)offset);
+        return 0;
+    }
+
+    return res;
+}
+
+static void bcm2835_st_write(void *opaque, hwaddr offset,
+                        uint64_t value, unsigned size)
+{
+    BCM2835StState *s = (BCM2835StState *)opaque;
+    int i;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x00:
+        s->match &= ~value & 0x0f;
+        for (i = 0; i < 4; i++) {
+            if (value & (1 << i)) {
+                qemu_set_irq(s->irq[i], 0);
+            }
+        }
+        break;
+    case 0x0c:
+        s->compare[0] = value;
+        break;
+    case 0x10:
+        s->compare[1] = value;
+        break;
+    case 0x14:
+        s->compare[2] = value;
+        break;
+    case 0x18:
+        s->compare[3] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_st_write: Bad offset %x\n", (int)offset);
+        return;
+    }
+    bcm2835_st_update(s);
+}
+
+static const MemoryRegionOps bcm2835_st_ops = {
+    .read = bcm2835_st_read,
+    .write = bcm2835_st_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_bcm2835_st = {
+    .name = TYPE_BCM2835_ST,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(compare, BCM2835StState, 4),
+        VMSTATE_UINT32(match, BCM2835StState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_st_init(Object *obj)
+{
+    BCM2835StState *s = BCM2835_ST(obj);
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq[i]);
+    }
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_st_ops, s,
+                          TYPE_BCM2835_ST, 0x20);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void bcm2835_st_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835StState *s = BCM2835_ST(dev);
+    int i;
+
+    for (i = 0; i < 4; i++) {
+        s->compare[i] = 0;
+    }
+    s->match = 0;
+    s->timer = timer_new_us(QEMU_CLOCK_VIRTUAL, bcm2835_st_tick, s);
+
+    bcm2835_st_update(s);
+}
+
+static void bcm2835_st_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_st_realize;
+    dc->vmsd = &vmstate_bcm2835_st;
+}
+
+static TypeInfo bcm2835_st_info = {
+    .name          = TYPE_BCM2835_ST,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835StState),
+    .class_init    = bcm2835_st_class_init,
+    .instance_init = bcm2835_st_init,
+};
+
+static void bcm2835_st_register_types(void)
+{
+    type_register_static(&bcm2835_st_info);
+}
+
+type_init(bcm2835_st_register_types)
diff --git a/hw/timer/bcm2835_timer.c b/hw/timer/bcm2835_timer.c
new file mode 100644
index 0000000000..87f14f8561
--- /dev/null
+++ b/hw/timer/bcm2835_timer.c
@@ -0,0 +1,224 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/timer/bcm2835_timer.h"
+#include "qemu/main-loop.h"
+#include "qemu/log.h"
+
+#define SYSCLOCK_FREQ (252000000)
+#define APBCLOCK_FREQ (126000000)
+
+#define CTRL_FRC_EN (1 << 9)
+#define CTRL_TIMER_EN (1 << 7)
+#define CTRL_IRQ_EN (1 << 5)
+#define CTRL_PS_MASK (3 << 2)
+#define CTRL_PS_SHIFT 2
+#define CTRL_CNT_32 (1 << 1)
+#define CTRL_FRC_PS_MASK (0xff << 16)
+#define CTRL_FRC_PS_SHIFT 16
+
+static void timer_tick(void *opaque)
+{
+    BCM2835TimerState *s = (BCM2835TimerState *)opaque;
+    s->raw_irq = 1;
+    if (s->control & CTRL_IRQ_EN) {
+        qemu_set_irq(s->irq, 1);
+    }
+}
+static void frc_timer_tick(void *opaque)
+{
+    BCM2835TimerState *s = (BCM2835TimerState *)opaque;
+    s->frc_value++;
+}
+
+static uint64_t bcm2835_timer_read(void *opaque, hwaddr offset,
+    unsigned size)
+{
+    BCM2835TimerState *s = (BCM2835TimerState *)opaque;
+    uint32_t res = 0;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x0:
+        res = s->load;
+        break;
+    case 0x4:
+        res = ptimer_get_count(s->timer);
+        break;
+    case 0x8:
+        res = s->control;
+        break;
+    case 0xc:
+        res = 0x544d5241;
+        break;
+    case 0x10:
+        res = s->raw_irq;
+        break;
+    case 0x14:
+        if (s->control & CTRL_IRQ_EN) {
+            res = s->raw_irq;
+        }
+        break;
+    case 0x18:
+        res = s->load;
+        break;
+    case 0x1c:
+        res = s->prediv;
+        break;
+    case 0x20:
+        res = s->frc_value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_timer_read: Bad offset %x\n", (int)offset);
+        return 0;
+    }
+
+    return res;
+}
+
+static void bcm2835_timer_write(void *opaque, hwaddr offset,
+    uint64_t value, unsigned size)
+{
+    BCM2835TimerState *s = (BCM2835TimerState *)opaque;
+    uint32_t freq;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x0:
+        s->load = value;
+        ptimer_set_limit(s->timer, s->load, 1);
+        break;
+    case 0x4:
+        break;
+    case 0x8:
+        if (s->control & CTRL_FRC_EN) {
+            ptimer_stop(s->frc_timer);
+        }
+        if (s->control & CTRL_TIMER_EN) {
+            ptimer_stop(s->timer);
+        }
+        s->control = value & 0x00ff03ae;
+
+        freq = SYSCLOCK_FREQ;
+        ptimer_set_freq(s->frc_timer, freq);
+        ptimer_set_limit(s->frc_timer,
+            ((s->control & CTRL_FRC_PS_MASK) >> CTRL_FRC_PS_SHIFT) + 1,
+            s->control & CTRL_FRC_EN);
+
+        freq = APBCLOCK_FREQ;
+        freq /= s->prediv + 1;
+        switch ((s->control & CTRL_PS_MASK) >> CTRL_PS_SHIFT) {
+        case 1:
+            freq >>= 4;
+            break;
+        case 2:
+            freq >>= 8;
+            break;
+        default:
+            break;
+        }
+        ptimer_set_freq(s->timer, freq);
+        ptimer_set_limit(s->timer, s->load, s->control & CTRL_TIMER_EN);
+
+        if (s->control & CTRL_TIMER_EN) {
+            ptimer_run(s->timer, 0);
+        }
+        if (s->control & CTRL_FRC_EN) {
+            s->frc_value++;
+            ptimer_run(s->frc_timer, 0);
+        }
+        break;
+    case 0xc:
+        s->raw_irq = 0;
+        qemu_set_irq(s->irq, 0);
+        break;
+    case 0x10:
+    case 0x14:
+        break;
+    case 0x18:
+        s->load = value;
+        ptimer_set_limit(s->timer, s->load, 0);
+        break;
+    case 0x1c:
+        s->prediv = value & 0x3ff;
+        break;
+    case 0x20:
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "bcm2835_timer_write: Bad offset %x\n", (int)offset);
+        return;
+    }
+}
+
+static const MemoryRegionOps bcm2835_timer_ops = {
+    .read = bcm2835_timer_read,
+    .write = bcm2835_timer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_bcm2835_timer = {
+    .name = TYPE_BCM2835_TIMER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_timer_init(Object *obj)
+{
+    BCM2835TimerState *s = BCM2835_TIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_timer_ops, s,
+                          TYPE_BCM2835_TIMER, 0x100);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+}
+
+static void bcm2835_timer_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835TimerState *s = BCM2835_TIMER(dev);
+    QEMUBH *bh;
+
+    s->load = 0;
+    s->control = 0x3e << 16;
+    s->raw_irq = 0;
+    s->prediv = 0x7d;
+
+    bh = qemu_bh_new(timer_tick, s);
+    s->timer = ptimer_init(bh,PTIMER_POLICY_DEFAULT);
+
+    bh = qemu_bh_new(frc_timer_tick, s);
+    s->frc_timer = ptimer_init(bh,PTIMER_POLICY_DEFAULT);
+}
+
+static void bcm2835_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_timer_realize;
+    dc->vmsd = &vmstate_bcm2835_timer;
+}
+
+static TypeInfo bcm2835_timer_info = {
+    .name          = TYPE_BCM2835_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835TimerState),
+    .class_init    = bcm2835_timer_class_init,
+    .instance_init = bcm2835_timer_init,
+};
+
+static void bcm2835_timer_register_types(void)
+{
+    type_register_static(&bcm2835_timer_info);
+}
+
+type_init(bcm2835_timer_register_types)
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 5958be8ce3..9ac7cb4c41 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -40,5 +40,7 @@ common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))

ifeq ($(CONFIG_USB_LIBUSB),y)
-common-obj-$(CONFIG_XEN) += xen-usb.o
+common-obj-$(CONFIG_XEN_BACKEND) += xen-usb.o
endif
+
+obj-$(CONFIG_RASPI) += bcm2835_usb.o
diff --git a/hw/usb/bcm2835_usb.c b/hw/usb/bcm2835_usb.c
new file mode 100644
index 0000000000..ed745e5591
--- /dev/null
+++ b/hw/usb/bcm2835_usb.c
@@ -0,0 +1,604 @@
+/*
+ * Raspberry Pi emulation (c) 2012-2013 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+/* This is wrong at so many levels, but well, I'm releasing it anyway */
+
+#include "qemu/osdep.h"
+#include "hw/usb/bcm2835_usb.h"
+
+#include "qemu/log.h"
+#include "qapi/error.h"
+
+#include "sysemu/dma.h"
+
+#include "bcm2835_usb_regs.h"
+
+/* You may have to change these parameters to get an almost-usable mouse
+ * support.
+ * The problem is that frame scheduling is all done by software, so a LOT of
+ * interrupts are generated, which doesn't help... */
+#define SOF_INCR 1
+#define SOF_DELAY 5000
+
+static void bcm2835_usb_update_irq(BCM2835UsbState *s)
+{
+    int n;
+
+    s->haint = 0;
+    for (n = 0; n < BCM2835_USB_HCHANS; n++) {
+        if (s->hchan[n].hcint & s->hchan[n].hcintmsk) {
+            s->haint |= (1 << n);
+        }
+    }
+    s->gintsts &= ~gintsts_hcintr;
+    if (s->haint & s->haintmsk) {
+        s->gintsts |= gintsts_hcintr;
+    }
+
+    if ((s->hprt0 & hprt0_prtconndet)
+        || (s->hprt0 & hprt0_prtenchng)) {
+        s->gintsts |= gintsts_portintr;
+    } else {
+        s->gintsts &= ~gintsts_portintr;
+    }
+
+    s->gintsts |= gintsts_nptxfempty | gintsts_ptxfempty;
+
+    if (!(s->gahbcfg & gahbcfg_glblintrmsk)) {
+        qemu_set_irq(s->irq, 0);
+    } else {
+        if (s->gintsts & s->gintmsk) {
+            qemu_set_irq(s->irq, 1);
+        } else {
+            qemu_set_irq(s->irq, 0);
+        }
+    }
+}
+
+
+static void bcm2835_usb_sof_tick(void *opaque)
+{
+    BCM2835UsbState *s = (BCM2835UsbState *)opaque;
+    int64_t now;
+
+    uint32_t num = (s->hfnum & 0x3fff) + SOF_INCR;
+    s->hfnum = (num & 0x3fff) | (0x3210 << 16);
+    s->gintsts |= gintsts_sofintr;
+
+    bcm2835_usb_update_irq(s);
+
+    now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+    timer_mod(s->sof_timer, now + SOF_DELAY);
+}
+
+static void channel_enable(BCM2835UsbHcState *c)
+{
+    USBEndpoint *ep;
+    USBDevice *dev;
+
+    uint32_t epnum = (c->hcchar >> hcchar_epnum_shift) & hcchar_epnum_mask;
+    uint32_t devaddr = (c->hcchar >> hcchar_devaddr_shift)
+                       & hcchar_devaddr_mask;
+    uint32_t xfersize = (c->hctsiz >> hctsiz_xfersize_shift)
+                        & hctsiz_xfersize_mask;
+    uint32_t pid = (c->hctsiz >> hctsiz_pid_shift) & hctsiz_pid_mask;
+    uint32_t dma_addr = c->hcdma; /* ??? */
+    int actual_length;
+    int qpid;
+
+    if (!c->parent->reset_done) {
+        return;
+    }
+
+    if (c->hcchar & hcchar_epdir) {
+        /* IN */
+        qpid = USB_TOKEN_IN;
+    } else {
+        /* OUT/SETUP */
+        if (pid == DWC_HCTSIZ_SETUP) {
+            qpid = USB_TOKEN_SETUP;
+        } else {
+            qpid = USB_TOKEN_OUT;
+        }
+    }
+
+    dev = usb_find_device(&c->parent->port, devaddr);
+    assert(dev != NULL);
+
+    ep = usb_ep_get(dev, qpid, epnum);
+    usb_packet_setup(&c->packet, qpid, ep, 0, devaddr, 0, 0);
+
+    if (xfersize > 0) {
+        dma_memory_read(&c->parent->dma_as, dma_addr, c->buffer, xfersize);
+
+        usb_packet_addbuf(&c->packet, c->buffer, xfersize);
+    }
+    usb_handle_packet(dev, &c->packet);
+
+    if (c->packet.status == USB_RET_SUCCESS) {
+        if (qpid == USB_TOKEN_IN) {
+            actual_length = c->packet.actual_length;
+
+            xfersize -= actual_length;
+            c->hctsiz &= ~(hctsiz_xfersize_mask << hctsiz_xfersize_shift);
+            c->hctsiz |= xfersize << hctsiz_xfersize_shift;
+
+            dma_memory_write(&c->parent->dma_as, dma_addr, c->buffer,
+                             actual_length);
+        }
+
+        c->hcint |= hcint_xfercomp | hcint_chhltd;
+        bcm2835_usb_update_irq(c->parent);
+    } else if (c->packet.status == USB_RET_NAK) {
+        c->hcint |= hcint_chhltd | hcint_nak;
+        bcm2835_usb_update_irq(c->parent);
+    } else {
+        /* assert(0); */
+        c->hcint |= hcint_chhltd | hcint_stall;
+        bcm2835_usb_update_irq(c->parent);
+    }
+
+}
+
+static uint32_t bcm2835_usb_hchan_read(BCM2835UsbState *s, int ch,
+    int offset)
+{
+    BCM2835UsbHcState *c = &s->hchan[ch];
+    uint32_t res;
+
+    switch (offset) {
+    case 0x0:
+        res = c->hcchar;
+        break;
+    case 0x4:
+        res = c->hcsplt;
+        break;
+    case 0x8:
+        res = c->hcint;
+        break;
+    case 0xc:
+        res = c->hcintmsk;
+        break;
+    case 0x10:
+        res = c->hctsiz;
+        break;
+    case 0x14:
+        res = c->hcdma;
+        break;
+    case 0x1c:
+        res = c->hcdmab;
+        break;
+    default:
+        res = 0;
+        break;
+    }
+    return res;
+}
+static void bcm2835_usb_hchan_write(BCM2835UsbState *s, int ch,
+    int offset, uint32_t value, int *pset_irq)
+{
+    BCM2835UsbHcState *c = &s->hchan[ch];
+
+    switch (offset) {
+    case 0x0:
+        c->hcchar = value;
+        if (value & hcchar_chdis) {
+            c->hcchar &= ~(hcchar_chdis | hcchar_chen);
+            /* TODO irq */
+        }
+        if (value & hcchar_chen) {
+            channel_enable(c);
+        }
+        break;
+    case 0x4:
+        c->hcsplt = value;
+        break;
+    case 0x8:
+        /* Looks like a standard interrupt register */
+        c->hcint &= ~value;
+        *pset_irq = 1;
+        break;
+    case 0xc:
+        c->hcintmsk = value;
+        break;
+    case 0x10:
+        c->hctsiz = value;
+        break;
+    case 0x14:
+        c->hcdma = value;
+        break;
+    case 0x1c:
+        c->hcdmab = value;
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t bcm2835_usb_read(void *opaque, hwaddr offset,
+    unsigned size)
+{
+    BCM2835UsbState *s = (BCM2835UsbState *)opaque;
+    uint32_t res = 0;
+    int i;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x0:
+        res = s->gotgctl;
+        break;
+    case 0x4:
+        res = s->gotgint;
+        break;
+    case 0x8:
+        res = s->gahbcfg;
+        break;
+    case 0xc:
+        res = s->gusbcfg;
+        break;
+    case 0x10:
+        res = s->grstctl;
+        break;
+    case 0x14:
+        res = s->gintsts;
+        /* Enforce Host mode */
+        res |= gintsts_curmode;
+        break;
+    case 0x18:
+        res = s->gintmsk;
+        break;
+    case 0x24:
+        res = s->grxfsiz;
+        break;
+    case 0x28:
+        res = s->gnptxfsiz;
+        break;
+    case 0x2c:
+        res = s->gnptxsts;
+        break;
+    case 0x3c:
+        res = s->guid;
+        break;
+    case 0x40:
+        res = 0x4f54280a;
+        break;
+    case 0x44:
+        res = 0;
+        break;
+    case 0x48:
+        res = 0x228ddd50;
+        break;
+    case 0x4c:
+        res = 0x0ff000e8;
+        break;
+    case 0x50:
+        res = 0x1ff00020;
+        break;
+    case 0x5c:
+        res = s->gdfifocfg;
+        break;
+    case 0x100:
+        res = s->hptxfsiz;
+        break;
+    case 0x400:
+        res = s->hcfg;
+        break;
+    case 0x408:
+        res = s->hfnum;
+        break;
+    case 0x410:
+        res = s->hptxsts;
+        break;
+    case 0x414:
+        res = s->haint;
+        break;
+    case 0x418:
+        res = s->haintmsk;
+        break;
+    case 0x440:
+        res = s->hprt0;
+        res &= ~hprt0_prtconnsts;
+        if (s->attached) {
+            res |= hprt0_prtconnsts;
+        }
+        break;
+    case 0x800:
+        res = s->dcfg;
+        break;
+
+    case 0xe00:
+    case 0x54:
+    case 0x58:
+        res = 0;
+        break;
+
+    default:
+        if ((offset >= 0x104) && (offset < 0x104 + (15 << 2))) {
+            res = s->dtxfsiz[(offset - 0x104) >> 2];
+        } else if ((offset >= 0x500) && (offset < 0x500 + 0x20*BCM2835_USB_HCHANS)) {
+            i = (offset - 0x500) >> 5;
+            res = bcm2835_usb_hchan_read(s, i, offset & 0x1f);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "bcm2835_usb_read: Bad offset %x\n", (int)offset);
+            res = 0;
+        }
+        break;
+    }
+    return res;
+}
+
+static void bcm2835_usb_write(void *opaque, hwaddr offset,
+    uint64_t value, unsigned size)
+{
+    BCM2835UsbState *s = (BCM2835UsbState *)opaque;
+
+    int i;
+    int set_irq = 0;
+
+    assert(size == 4);
+
+    switch (offset) {
+    case 0x0:
+        s->gotgctl = value;
+        break;
+    case 0x4:
+        /* Looks like a standard interrupt register */
+        s->gotgint &= ~value;
+        break;
+    case 0x8:
+        s->gahbcfg = value;
+        set_irq = 1;
+        break;
+    case 0xc:
+        s->gusbcfg = value;
+        break;
+    case 0x10:
+        s->grstctl &= ~0x7c0;
+        s->grstctl |= value & 0x7c0;
+        break;
+    case 0x14:
+        s->gintsts &= ~value;
+        /* Enforce Host mode */
+        s->gintsts |= gintsts_curmode;
+        set_irq = 1;
+        break;
+    case 0x18:
+        s->gintmsk = value;
+        break;
+    case 0x24:
+        s->grxfsiz = value;
+        break;
+    case 0x28:
+        s->gnptxfsiz = value;
+        break;
+    case 0x3c:
+        s->guid = value;
+        break;
+    case 0x5c:
+        s->gdfifocfg = value;
+        break;
+    case 0x100:
+        s->hptxfsiz = value;
+        break;
+    case 0x400:
+        s->hcfg = value;
+        break;
+    case 0x408:
+        /* Probably RO */
+        break;
+    case 0x410:
+        /* Probably RO */
+        break;
+    case 0x414:
+        /* Probably RO */
+        break;
+    case 0x418:
+        s->haintmsk = value & ((1 << BCM2835_USB_HCHANS) - 1);
+        set_irq = 1;
+        break;
+    case 0x440:
+        if (!(s->hprt0 & hprt0_prtpwr) && (value & hprt0_prtpwr)) {
+            /* Trigger the port status change interrupt on power on */
+            if (s->attached) {
+                s->hprt0 |= hprt0_prtconndet;
+                set_irq = 1;
+                /* Reset the device (that's probably not the right place) */
+                usb_device_reset(s->port.dev);
+                s->reset_done = 1;
+                timer_mod(s->sof_timer, 0);
+            }
+        }
+        s->hprt0 &= ~hprt0_prtpwr;
+        s->hprt0 |= value & hprt0_prtpwr;
+
+        if ((s->hprt0 & hprt0_prtres) ^ (value & hprt0_prtres)) {
+            s->hprt0 |= hprt0_prtenchng;
+            set_irq = 1;
+        }
+        s->hprt0 &= ~(hprt0_prtena | hprt0_prtres);
+        if (value & hprt0_prtres) {
+            s->hprt0 |= hprt0_prtres;
+        } else {
+            s->hprt0 |= hprt0_prtena;
+        }
+
+        /* Interrupt clears */
+        if (value & hprt0_prtconndet) {
+            s->hprt0 &= ~hprt0_prtconndet;
+            set_irq = 1;
+        }
+        if (value & hprt0_prtenchng) {
+            s->hprt0 &= ~hprt0_prtenchng;
+            set_irq = 1;
+        }
+
+        break;
+
+    case 0xe00:
+    case 0x54:
+    case 0x58:
+        break;
+
+    default:
+        if ((offset >= 0x104) && (offset < 0x104 + (15 << 2))) {
+            s->dtxfsiz[(offset - 0x104) >> 2] = value;
+        } else if ((offset >= 0x500) && (offset < 0x500 + 0x20*BCM2835_USB_HCHANS)) {
+            i = (offset - 0x500) >> 5;
+            bcm2835_usb_hchan_write(s, i, offset & 0x1f, value, &set_irq);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "bcm2835_usb_write: Bad offset %x\n", (int)offset);
+        }
+        break;
+    }
+
+    if (set_irq) {
+        bcm2835_usb_update_irq(s);
+    }
+}
+
+static void bcm2835_usb_attach(USBPort *port1)
+{
+    BCM2835UsbState *s = port1->opaque;
+    s->attached = 1;
+}
+static void bcm2835_usb_detach(USBPort *port1)
+{
+}
+static void bcm2835_usb_child_detach(USBPort *port1, USBDevice *child)
+{
+}
+static void bcm2835_usb_wakeup(USBPort *port1)
+{
+}
+static void bcm2835_usb_async_complete(USBPort *port, USBPacket *packet)
+{
+}
+
+
+static const MemoryRegionOps bcm2835_usb_ops = {
+    .read = bcm2835_usb_read,
+    .write = bcm2835_usb_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_bcm2835_usb = {
+    .name = TYPE_BCM2835_USB,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static USBPortOps bcm2835_usb_port_ops = {
+    .attach = bcm2835_usb_attach,
+    .detach = bcm2835_usb_detach,
+    .child_detach = bcm2835_usb_child_detach,
+    .wakeup = bcm2835_usb_wakeup,
+    .complete = bcm2835_usb_async_complete,
+};
+
+static USBBusOps bcm2835_usb_bus_ops = {
+};
+
+static void bcm2835_usb_init(Object *obj)
+{
+    BCM2835UsbState *s = BCM2835_USB(obj);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_usb_ops, s,
+                          TYPE_BCM2835_USB, 0x20000);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+}
+
+static void bcm2835_usb_realize(DeviceState *dev, Error **errp)
+{
+    int n;
+    BCM2835UsbState *s = BCM2835_USB(dev);
+    Error *err = NULL;
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "dma_mr", &err);
+    if (err || obj == NULL) {
+        error_setg(errp, "bcm2835_usb: required dma_mr property not found");
+        return;
+    }
+
+    s->dma_mr = MEMORY_REGION(obj);
+    address_space_init(&s->dma_as, s->dma_mr, NULL);
+
+    s->gusbcfg = 0x20402700;
+    s->hptxfsiz = 0x02002000;
+    s->hcfg = 0x00000001;
+    s->dcfg = 0x00000000;
+    s->grxfsiz = 0x00001000;
+    s->gnptxfsiz = 0x01001000;
+    for (n = 0; n < 15; n++) {
+        s->dtxfsiz[n] = 0x02002000;
+    }
+    s->gahbcfg = 0x0000000e;
+    s->grstctl = 0x80000000;
+    s->gotgctl = 0x001c0000;
+    s->gotgint = 0;
+    s->gintsts = 0;
+    s->gintmsk = 0;
+    s->gdfifocfg = 0x00000000;
+    s->hprt0 = DWC_HPRT0_PRTSPD_FULL_SPEED << hprt0_prtspd_shift;
+    s->gnptxsts = 0x080100;
+    s->hfnum = 0;
+    s->hptxsts = 0x080200;
+    s->guid = 0x2708A000;
+
+    for (n = 0; n < BCM2835_USB_HCHANS; n++) {
+        s->hchan[n].parent = s;
+        s->hchan[n].index = n;
+
+        s->hchan[n].hcchar = 0;
+        s->hchan[n].hcsplt = 0;
+        s->hchan[n].hcint = 0;
+        s->hchan[n].hcintmsk = 0;
+        s->hchan[n].hctsiz = 0;
+        s->hchan[n].hcdma = 0;
+        s->hchan[n].hcdmab = 0;
+
+        usb_packet_init(&s->hchan[n].packet);
+    }
+
+    s->attached = 0;
+    s->reset_done = 0;
+
+    s->sof_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, bcm2835_usb_sof_tick, s);
+
+    usb_bus_new(&s->bus, sizeof(s->bus), &bcm2835_usb_bus_ops, DEVICE(s));
+    usb_register_port(&s->bus, &s->port, s, 0, &bcm2835_usb_port_ops,
+        USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
+}
+
+static void bcm2835_usb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_usb_realize;
+    dc->vmsd = &vmstate_bcm2835_usb;
+}
+
+static TypeInfo bcm2835_usb_info = {
+    .name          = TYPE_BCM2835_USB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835UsbState),
+    .class_init    = bcm2835_usb_class_init,
+    .instance_init = bcm2835_usb_init,
+};
+
+static void bcm2835_usb_register_types(void)
+{
+    type_register_static(&bcm2835_usb_info);
+}
+
+type_init(bcm2835_usb_register_types)
diff --git a/hw/usb/bcm2835_usb_regs.h b/hw/usb/bcm2835_usb_regs.h
new file mode 100644
index 0000000000..76f3219b54
--- /dev/null
+++ b/hw/usb/bcm2835_usb_regs.h
@@ -0,0 +1,1061 @@
+#ifndef BCM2835_USB_REGS_H
+#define BCM2835_USB_REGS_H
+
+#define __DWC_OTG_REGS_H__
+#define DWC_GLBINTRMASK        0x0001
+#define DWC_DMAENABLE        0x0020
+#define DWC_NPTXEMPTYLVL_EMPTY    0x0080
+#define DWC_NPTXEMPTYLVL_HALFEMPTY    0x0000
+#define DWC_PTXEMPTYLVL_EMPTY    0x0100
+#define DWC_PTXEMPTYLVL_HALFEMPTY    0x0000
+#define DWC_SLAVE_ONLY_ARCH 0
+#define DWC_EXT_DMA_ARCH 1
+#define DWC_INT_DMA_ARCH 2
+#define DWC_MODE_HNP_SRP_CAPABLE    0
+#define DWC_MODE_SRP_ONLY_CAPABLE    1
+#define DWC_MODE_NO_HNP_SRP_CAPABLE        2
+#define DWC_MODE_SRP_CAPABLE_DEVICE        3
+#define DWC_MODE_NO_SRP_CAPABLE_DEVICE    4
+#define DWC_MODE_SRP_CAPABLE_HOST    5
+#define DWC_MODE_NO_SRP_CAPABLE_HOST    6
+
+/* union gotgctl_data */
+#define gotgctl_sesreqscs (1 << 0)
+#define gotgctl_sesreq (1 << 1)
+#define gotgctl_vbvalidoven (1 << 2)
+#define gotgctl_vbvalidovval (1 << 3)
+#define gotgctl_avalidoven (1 << 4)
+#define gotgctl_avalidovval (1 << 5)
+#define gotgctl_bvalidoven (1 << 6)
+#define gotgctl_bvalidovval (1 << 7)
+#define gotgctl_hstnegscs (1 << 8)
+#define gotgctl_hnpreq (1 << 9)
+#define gotgctl_hstsethnpen (1 << 10)
+#define gotgctl_devhnpen (1 << 11)
+#define gotgctl_reserved12_15_shift (12)
+#define gotgctl_reserved12_15_mask (0xf)
+#define gotgctl_conidsts (1 << 16)
+#define gotgctl_dbnctime (1 << 17)
+#define gotgctl_asesvld (1 << 18)
+#define gotgctl_bsesvld (1 << 19)
+#define gotgctl_otgver (1 << 20)
+#define gotgctl_reserved1 (1 << 21)
+#define gotgctl_multvalidbc_shift (22)
+#define gotgctl_multvalidbc_mask (0x1f)
+#define gotgctl_chirpen (1 << 27)
+#define gotgctl_reserved28_31_shift (28)
+#define gotgctl_reserved28_31_mask (0xf)
+
+/* union gotgint_data */
+#define gotgint_reserved0_1_shift (0)
+#define gotgint_reserved0_1_mask (0x3)
+#define gotgint_sesenddet (1 << 2)
+#define gotgint_reserved3_7_shift (3)
+#define gotgint_reserved3_7_mask (0x1f)
+#define gotgint_sesreqsucstschng (1 << 8)
+#define gotgint_hstnegsucstschng (1 << 9)
+#define gotgint_reserved10_16_shift (10)
+#define gotgint_reserved10_16_mask (0x7f)
+#define gotgint_hstnegdet (1 << 17)
+#define gotgint_adevtoutchng (1 << 18)
+#define gotgint_debdone (1 << 19)
+#define gotgint_mvic (1 << 20)
+#define gotgint_reserved31_21_shift (21)
+#define gotgint_reserved31_21_mask (0x7ff)
+
+/* union gahbcfg_data */
+#define gahbcfg_glblintrmsk (1 << 0)
+#define DWC_GAHBCFG_GLBINT_ENABLE        1
+#define gahbcfg_hburstlen_shift (1)
+#define gahbcfg_hburstlen_mask (0xf)
+#define DWC_GAHBCFG_INT_DMA_BURST_SINGLE    0
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR        1
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR4        3
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR8        5
+#define DWC_GAHBCFG_INT_DMA_BURST_INCR16    7
+#define gahbcfg_dmaenable (1 << 5)
+#define DWC_GAHBCFG_DMAENABLE            1
+#define gahbcfg_reserved (1 << 6)
+#define gahbcfg_nptxfemplvl_txfemplvl (1 << 7)
+#define gahbcfg_ptxfemplvl (1 << 8)
+#define DWC_GAHBCFG_TXFEMPTYLVL_EMPTY        1
+#define DWC_GAHBCFG_TXFEMPTYLVL_HALFEMPTY    0
+#define gahbcfg_reserved9_20_shift (9)
+#define gahbcfg_reserved9_20_mask (0xfff)
+#define gahbcfg_remmemsupp (1 << 21)
+#define gahbcfg_notialldmawrit (1 << 22)
+#define gahbcfg_ahbsingle (1 << 23)
+#define gahbcfg_reserved24_31_shift (24)
+#define gahbcfg_reserved24_31_mask (0xff)
+
+/* union gusbcfg_data */
+#define gusbcfg_toutcal_shift (0)
+#define gusbcfg_toutcal_mask (0x7)
+#define gusbcfg_phyif (1 << 3)
+#define gusbcfg_ulpi_utmi_sel (1 << 4)
+#define gusbcfg_fsintf (1 << 5)
+#define gusbcfg_physel (1 << 6)
+#define gusbcfg_ddrsel (1 << 7)
+#define gusbcfg_srpcap (1 << 8)
+#define gusbcfg_hnpcap (1 << 9)
+#define gusbcfg_usbtrdtim_shift (10)
+#define gusbcfg_usbtrdtim_mask (0xf)
+#define gusbcfg_reserved1 (1 << 14)
+#define gusbcfg_phylpwrclksel (1 << 15)
+#define gusbcfg_otgutmifssel (1 << 16)
+#define gusbcfg_ulpi_fsls (1 << 17)
+#define gusbcfg_ulpi_auto_res (1 << 18)
+#define gusbcfg_ulpi_clk_sus_m (1 << 19)
+#define gusbcfg_ulpi_ext_vbus_drv (1 << 20)
+#define gusbcfg_ulpi_int_vbus_indicator (1 << 21)
+#define gusbcfg_term_sel_dl_pulse (1 << 22)
+#define gusbcfg_indicator_complement (1 << 23)
+#define gusbcfg_indicator_pass_through (1 << 24)
+#define gusbcfg_ulpi_int_prot_dis (1 << 25)
+#define gusbcfg_ic_usb_cap (1 << 26)
+#define gusbcfg_ic_traffic_pull_remove (1 << 27)
+#define gusbcfg_tx_end_delay (1 << 28)
+#define gusbcfg_force_host_mode (1 << 29)
+#define gusbcfg_force_dev_mode (1 << 30)
+#define gusbcfg_reserved31 (1 << 31)
+
+/* union grstctl_data */
+#define grstctl_csftrst (1 << 0)
+#define grstctl_hsftrst (1 << 1)
+#define grstctl_hstfrm (1 << 2)
+#define grstctl_intknqflsh (1 << 3)
+#define grstctl_rxfflsh (1 << 4)
+#define grstctl_txfflsh (1 << 5)
+#define grstctl_txfnum_shift (6)
+#define grstctl_txfnum_mask (0x1f)
+#define grstctl_reserved11_29_shift (11)
+#define grstctl_reserved11_29_mask (0x7ffff)
+#define grstctl_dmareq (1 << 30)
+#define grstctl_ahbidle (1 << 31)
+
+/* union gintmsk_data */
+#define gintmsk_reserved0 (1 << 0)
+#define gintmsk_modemismatch (1 << 1)
+#define gintmsk_otgintr (1 << 2)
+#define gintmsk_sofintr (1 << 3)
+#define gintmsk_rxstsqlvl (1 << 4)
+#define gintmsk_nptxfempty (1 << 5)
+#define gintmsk_ginnakeff (1 << 6)
+#define gintmsk_goutnakeff (1 << 7)
+#define gintmsk_ulpickint (1 << 8)
+#define gintmsk_i2cintr (1 << 9)
+#define gintmsk_erlysuspend (1 << 10)
+#define gintmsk_usbsuspend (1 << 11)
+#define gintmsk_usbreset (1 << 12)
+#define gintmsk_enumdone (1 << 13)
+#define gintmsk_isooutdrop (1 << 14)
+#define gintmsk_eopframe (1 << 15)
+#define gintmsk_restoredone (1 << 16)
+#define gintmsk_epmismatch (1 << 17)
+#define gintmsk_inepintr (1 << 18)
+#define gintmsk_outepintr (1 << 19)
+#define gintmsk_incomplisoin (1 << 20)
+#define gintmsk_incomplisoout (1 << 21)
+#define gintmsk_fetsusp (1 << 22)
+#define gintmsk_resetdet (1 << 23)
+#define gintmsk_portintr (1 << 24)
+#define gintmsk_hcintr (1 << 25)
+#define gintmsk_ptxfempty (1 << 26)
+#define gintmsk_lpmtranrcvd (1 << 27)
+#define gintmsk_conidstschng (1 << 28)
+#define gintmsk_disconnect (1 << 29)
+#define gintmsk_sessreqintr (1 << 30)
+#define gintmsk_wkupintr (1 << 31)
+
+/* union gintsts_data */
+#define DWC_SOF_INTR_MASK 0x0008
+#define DWC_HOST_MODE 1
+#define gintsts_curmode (1 << 0)
+#define gintsts_modemismatch (1 << 1)
+#define gintsts_otgintr (1 << 2)
+#define gintsts_sofintr (1 << 3)
+#define gintsts_rxstsqlvl (1 << 4)
+#define gintsts_nptxfempty (1 << 5)
+#define gintsts_ginnakeff (1 << 6)
+#define gintsts_goutnakeff (1 << 7)
+#define gintsts_ulpickint (1 << 8)
+#define gintsts_i2cintr (1 << 9)
+#define gintsts_erlysuspend (1 << 10)
+#define gintsts_usbsuspend (1 << 11)
+#define gintsts_usbreset (1 << 12)
+#define gintsts_enumdone (1 << 13)
+#define gintsts_isooutdrop (1 << 14)
+#define gintsts_eopframe (1 << 15)
+#define gintsts_restoredone (1 << 16)
+#define gintsts_epmismatch (1 << 17)
+#define gintsts_inepint (1 << 18)
+#define gintsts_outepintr (1 << 19)
+#define gintsts_incomplisoin (1 << 20)
+#define gintsts_incomplisoout (1 << 21)
+#define gintsts_fetsusp (1 << 22)
+#define gintsts_resetdet (1 << 23)
+#define gintsts_portintr (1 << 24)
+#define gintsts_hcintr (1 << 25)
+#define gintsts_ptxfempty (1 << 26)
+#define gintsts_lpmtranrcvd (1 << 27)
+#define gintsts_conidstschng (1 << 28)
+#define gintsts_disconnect (1 << 29)
+#define gintsts_sessreqintr (1 << 30)
+#define gintsts_wkupintr (1 << 31)
+
+/* union device_grxsts_data */
+#define device_grxsts_epnum_shift (0)
+#define device_grxsts_epnum_mask (0xf)
+#define device_grxsts_bcnt_shift (4)
+#define device_grxsts_bcnt_mask (0x7ff)
+#define device_grxsts_dpid_shift (15)
+#define device_grxsts_dpid_mask (0x3)
+#define DWC_STS_DATA_UPDT        0x2    /* OUT Data Packet */
+#define DWC_STS_XFER_COMP        0x3    /* OUT Data Transfer Complete */
+#define DWC_DSTS_GOUT_NAK        0x1    /* Global OUT NAK */
+#define DWC_DSTS_SETUP_COMP        0x4    /* Setup Phase Complete */
+#define DWC_DSTS_SETUP_UPDT 0x6    /* SETUP Packet */
+#define device_grxsts_pktsts_shift (17)
+#define device_grxsts_pktsts_mask (0xf)
+#define device_grxsts_fn_shift (21)
+#define device_grxsts_fn_mask (0xf)
+#define device_grxsts_reserved25_31_shift (25)
+#define device_grxsts_reserved25_31_mask (0x7f)
+
+/* union host_grxsts_data */
+#define host_grxsts_chnum_shift (0)
+#define host_grxsts_chnum_mask (0xf)
+#define host_grxsts_bcnt_shift (4)
+#define host_grxsts_bcnt_mask (0x7ff)
+#define host_grxsts_dpid_shift (15)
+#define host_grxsts_dpid_mask (0x3)
+#define host_grxsts_pktsts_shift (17)
+#define host_grxsts_pktsts_mask (0xf)
+#define DWC_GRXSTS_PKTSTS_IN              0x2
+#define DWC_GRXSTS_PKTSTS_IN_XFER_COMP      0x3
+#define DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR 0x5
+#define DWC_GRXSTS_PKTSTS_CH_HALTED          0x7
+#define host_grxsts_reserved21_31_shift (21)
+#define host_grxsts_reserved21_31_mask (0x7ff)
+
+/* union fifosize_data */
+#define fifosize_startaddr_shift (0)
+#define fifosize_startaddr_mask (0xffff)
+#define fifosize_depth_shift (16)
+#define fifosize_depth_mask (0xffff)
+
+/* union gnptxsts_data */
+#define gnptxsts_nptxfspcavail_shift (0)
+#define gnptxsts_nptxfspcavail_mask (0xffff)
+#define gnptxsts_nptxqspcavail_shift (16)
+#define gnptxsts_nptxqspcavail_mask (0xff)
+#define gnptxsts_nptxqtop_terminate (1 << 24)
+#define gnptxsts_nptxqtop_token_shift (25)
+#define gnptxsts_nptxqtop_token_mask (0x3)
+#define gnptxsts_nptxqtop_chnep_shift (27)
+#define gnptxsts_nptxqtop_chnep_mask (0xf)
+#define gnptxsts_reserved (1 << 31)
+
+/* union dtxfsts_data */
+#define dtxfsts_txfspcavail_shift (0)
+#define dtxfsts_txfspcavail_mask (0xffff)
+#define dtxfsts_reserved_shift (16)
+#define dtxfsts_reserved_mask (0xffff)
+
+/* union gi2cctl_data */
+#define gi2cctl_rwdata_shift (0)
+#define gi2cctl_rwdata_mask (0xff)
+#define gi2cctl_regaddr_shift (8)
+#define gi2cctl_regaddr_mask (0xff)
+#define gi2cctl_addr_shift (16)
+#define gi2cctl_addr_mask (0x7f)
+#define gi2cctl_i2cen (1 << 23)
+#define gi2cctl_ack (1 << 24)
+#define gi2cctl_i2csuspctl (1 << 25)
+#define gi2cctl_i2cdevaddr_shift (26)
+#define gi2cctl_i2cdevaddr_mask (0x3)
+#define gi2cctl_i2cdatse0 (1 << 28)
+#define gi2cctl_reserved (1 << 29)
+#define gi2cctl_rw (1 << 30)
+#define gi2cctl_bsydne (1 << 31)
+
+/* union gpvndctl_data */
+#define gpvndctl_regdata_shift (0)
+#define gpvndctl_regdata_mask (0xff)
+#define gpvndctl_vctrl_shift (8)
+#define gpvndctl_vctrl_mask (0xff)
+#define gpvndctl_regaddr16_21_shift (16)
+#define gpvndctl_regaddr16_21_mask (0x3f)
+#define gpvndctl_regwr (1 << 22)
+#define gpvndctl_reserved23_24_shift (23)
+#define gpvndctl_reserved23_24_mask (0x3)
+#define gpvndctl_newregreq (1 << 25)
+#define gpvndctl_vstsbsy (1 << 26)
+#define gpvndctl_vstsdone (1 << 27)
+#define gpvndctl_reserved28_30_shift (28)
+#define gpvndctl_reserved28_30_mask (0x7)
+#define gpvndctl_disulpidrvr (1 << 31)
+
+/* union ggpio_data */
+#define ggpio_gpi_shift (0)
+#define ggpio_gpi_mask (0xffff)
+#define ggpio_gpo_shift (16)
+#define ggpio_gpo_mask (0xffff)
+
+/* union guid_data */
+#define guid_rwdata_shift (0)
+#define guid_rwdata_mask (0xffffffff)
+
+/* union gsnpsid_data */
+#define gsnpsid_rwdata_shift (0)
+#define gsnpsid_rwdata_mask (0xffffffff)
+
+/* union hwcfg1_data */
+#define hwcfg1_ep_dir0_shift (0)
+#define hwcfg1_ep_dir0_mask (0x3)
+#define hwcfg1_ep_dir1_shift (2)
+#define hwcfg1_ep_dir1_mask (0x3)
+#define hwcfg1_ep_dir2_shift (4)
+#define hwcfg1_ep_dir2_mask (0x3)
+#define hwcfg1_ep_dir3_shift (6)
+#define hwcfg1_ep_dir3_mask (0x3)
+#define hwcfg1_ep_dir4_shift (8)
+#define hwcfg1_ep_dir4_mask (0x3)
+#define hwcfg1_ep_dir5_shift (10)
+#define hwcfg1_ep_dir5_mask (0x3)
+#define hwcfg1_ep_dir6_shift (12)
+#define hwcfg1_ep_dir6_mask (0x3)
+#define hwcfg1_ep_dir7_shift (14)
+#define hwcfg1_ep_dir7_mask (0x3)
+#define hwcfg1_ep_dir8_shift (16)
+#define hwcfg1_ep_dir8_mask (0x3)
+#define hwcfg1_ep_dir9_shift (18)
+#define hwcfg1_ep_dir9_mask (0x3)
+#define hwcfg1_ep_dir10_shift (20)
+#define hwcfg1_ep_dir10_mask (0x3)
+#define hwcfg1_ep_dir11_shift (22)
+#define hwcfg1_ep_dir11_mask (0x3)
+#define hwcfg1_ep_dir12_shift (24)
+#define hwcfg1_ep_dir12_mask (0x3)
+#define hwcfg1_ep_dir13_shift (26)
+#define hwcfg1_ep_dir13_mask (0x3)
+#define hwcfg1_ep_dir14_shift (28)
+#define hwcfg1_ep_dir14_mask (0x3)
+#define hwcfg1_ep_dir15_shift (30)
+#define hwcfg1_ep_dir15_mask (0x3)
+
+/* union hwcfg2_data */
+#define hwcfg2_op_mode_shift (0)
+#define hwcfg2_op_mode_mask (0x7)
+#define DWC_HWCFG2_OP_MODE_HNP_SRP_CAPABLE_OTG 0
+#define DWC_HWCFG2_OP_MODE_SRP_ONLY_CAPABLE_OTG 1
+#define DWC_HWCFG2_OP_MODE_NO_HNP_SRP_CAPABLE_OTG 2
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE 3
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE 4
+#define DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST 5
+#define DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST 6
+#define hwcfg2_architecture_shift (3)
+#define hwcfg2_architecture_mask (0x3)
+#define hwcfg2_point2point (1 << 5)
+#define hwcfg2_hs_phy_type_shift (6)
+#define hwcfg2_hs_phy_type_mask (0x3)
+#define DWC_HWCFG2_HS_PHY_TYPE_NOT_SUPPORTED 0
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI 1
+#define DWC_HWCFG2_HS_PHY_TYPE_ULPI 2
+#define DWC_HWCFG2_HS_PHY_TYPE_UTMI_ULPI 3
+#define hwcfg2_fs_phy_type_shift (8)
+#define hwcfg2_fs_phy_type_mask (0x3)
+#define hwcfg2_num_dev_ep_shift (10)
+#define hwcfg2_num_dev_ep_mask (0xf)
+#define hwcfg2_num_host_chan_shift (14)
+#define hwcfg2_num_host_chan_mask (0xf)
+#define hwcfg2_perio_ep_supported (1 << 18)
+#define hwcfg2_dynamic_fifo (1 << 19)
+#define hwcfg2_multi_proc_int (1 << 20)
+#define hwcfg2_reserved21 (1 << 21)
+#define hwcfg2_nonperio_tx_q_depth_shift (22)
+#define hwcfg2_nonperio_tx_q_depth_mask (0x3)
+#define hwcfg2_host_perio_tx_q_depth_shift (24)
+#define hwcfg2_host_perio_tx_q_depth_mask (0x3)
+#define hwcfg2_dev_token_q_depth_shift (26)
+#define hwcfg2_dev_token_q_depth_mask (0x1f)
+#define hwcfg2_otg_enable_ic_usb (1 << 31)
+
+/* union hwcfg3_data */
+#define hwcfg3_xfer_size_cntr_width_shift (0)
+#define hwcfg3_xfer_size_cntr_width_mask (0xf)
+#define hwcfg3_packet_size_cntr_width_shift (4)
+#define hwcfg3_packet_size_cntr_width_mask (0x7)
+#define hwcfg3_otg_func (1 << 7)
+#define hwcfg3_i2c (1 << 8)
+#define hwcfg3_vendor_ctrl_if (1 << 9)
+#define hwcfg3_optional_features (1 << 10)
+#define hwcfg3_synch_reset_type (1 << 11)
+#define hwcfg3_adp_supp (1 << 12)
+#define hwcfg3_otg_enable_hsic (1 << 13)
+#define hwcfg3_bc_support (1 << 14)
+#define hwcfg3_otg_lpm_en (1 << 15)
+#define hwcfg3_dfifo_depth_shift (16)
+#define hwcfg3_dfifo_depth_mask (0xffff)
+
+/* union hwcfg4_data */
+#define hwcfg4_num_dev_perio_in_ep_shift (0)
+#define hwcfg4_num_dev_perio_in_ep_mask (0xf)
+#define hwcfg4_power_optimiz (1 << 4)
+#define hwcfg4_min_ahb_freq (1 << 5)
+#define hwcfg4_hiber (1 << 6)
+#define hwcfg4_xhiber (1 << 7)
+#define hwcfg4_reserved_shift (8)
+#define hwcfg4_reserved_mask (0x3f)
+#define hwcfg4_utmi_phy_data_width_shift (14)
+#define hwcfg4_utmi_phy_data_width_mask (0x3)
+#define hwcfg4_num_dev_mode_ctrl_ep_shift (16)
+#define hwcfg4_num_dev_mode_ctrl_ep_mask (0xf)
+#define hwcfg4_iddig_filt_en (1 << 20)
+#define hwcfg4_vbus_valid_filt_en (1 << 21)
+#define hwcfg4_a_valid_filt_en (1 << 22)
+#define hwcfg4_b_valid_filt_en (1 << 23)
+#define hwcfg4_session_end_filt_en (1 << 24)
+#define hwcfg4_ded_fifo_en (1 << 25)
+#define hwcfg4_num_in_eps_shift (26)
+#define hwcfg4_num_in_eps_mask (0xf)
+#define hwcfg4_desc_dma (1 << 30)
+#define hwcfg4_desc_dma_dyn (1 << 31)
+
+/* union glpmctl_data */
+#define glpmctl_lpm_cap_en (1 << 0)
+#define glpmctl_appl_resp (1 << 1)
+#define glpmctl_hird_shift (2)
+#define glpmctl_hird_mask (0xf)
+#define glpmctl_rem_wkup_en (1 << 6)
+#define glpmctl_en_utmi_sleep (1 << 7)
+#define glpmctl_hird_thres_shift (8)
+#define glpmctl_hird_thres_mask (0x1f)
+#define glpmctl_lpm_resp_shift (13)
+#define glpmctl_lpm_resp_mask (0x3)
+#define glpmctl_prt_sleep_sts (1 << 15)
+#define glpmctl_sleep_state_resumeok (1 << 16)
+#define glpmctl_lpm_chan_index_shift (17)
+#define glpmctl_lpm_chan_index_mask (0xf)
+#define glpmctl_retry_count_shift (21)
+#define glpmctl_retry_count_mask (0x7)
+#define glpmctl_send_lpm (1 << 24)
+#define glpmctl_retry_count_sts_shift (25)
+#define glpmctl_retry_count_sts_mask (0x7)
+#define glpmctl_reserved28_29_shift (28)
+#define glpmctl_reserved28_29_mask (0x3)
+#define glpmctl_hsic_connect (1 << 30)
+#define glpmctl_inv_sel_hsic (1 << 31)
+
+/* union adpctl_data */
+#define adpctl_prb_dschg_shift (0)
+#define adpctl_prb_dschg_mask (0x3)
+#define adpctl_prb_delta_shift (2)
+#define adpctl_prb_delta_mask (0x3)
+#define adpctl_prb_per_shift (4)
+#define adpctl_prb_per_mask (0x3)
+#define adpctl_rtim_shift (6)
+#define adpctl_rtim_mask (0x7ff)
+#define adpctl_enaprb (1 << 17)
+#define adpctl_enasns (1 << 18)
+#define adpctl_adpres (1 << 19)
+#define adpctl_adpen (1 << 20)
+#define adpctl_adp_prb_int (1 << 21)
+#define adpctl_adp_sns_int (1 << 22)
+#define adpctl_adp_tmout_int (1 << 23)
+#define adpctl_adp_prb_int_msk (1 << 24)
+#define adpctl_adp_sns_int_msk (1 << 25)
+#define adpctl_adp_tmout_int_msk (1 << 26)
+#define adpctl_ar_shift (27)
+#define adpctl_ar_mask (0x3)
+#define adpctl_reserved29_31_shift (29)
+#define adpctl_reserved29_31_mask (0x7)
+
+/* union dcfg_data */
+#define dcfg_devspd_shift (0)
+#define dcfg_devspd_mask (0x3)
+#define dcfg_nzstsouthshk (1 << 2)
+#define DWC_DCFG_SEND_STALL 1
+#define dcfg_ena32khzs (1 << 3)
+#define dcfg_devaddr_shift (4)
+#define dcfg_devaddr_mask (0x7f)
+#define dcfg_perfrint_shift (11)
+#define dcfg_perfrint_mask (0x3)
+#define DWC_DCFG_FRAME_INTERVAL_80 0
+#define DWC_DCFG_FRAME_INTERVAL_85 1
+#define DWC_DCFG_FRAME_INTERVAL_90 2
+#define DWC_DCFG_FRAME_INTERVAL_95 3
+#define dcfg_endevoutnak (1 << 13)
+#define dcfg_reserved14_17_shift (14)
+#define dcfg_reserved14_17_mask (0xf)
+#define dcfg_epmscnt_shift (18)
+#define dcfg_epmscnt_mask (0x1f)
+#define dcfg_descdma (1 << 23)
+#define dcfg_perschintvl_shift (24)
+#define dcfg_perschintvl_mask (0x3)
+#define dcfg_resvalid_shift (26)
+#define dcfg_resvalid_mask (0x3f)
+
+/* union dctl_data */
+#define dctl_rmtwkupsig (1 << 0)
+#define dctl_sftdiscon (1 << 1)
+#define dctl_gnpinnaksts (1 << 2)
+#define dctl_goutnaksts (1 << 3)
+#define dctl_tstctl_shift (4)
+#define dctl_tstctl_mask (0x7)
+#define dctl_sgnpinnak (1 << 7)
+#define dctl_cgnpinnak (1 << 8)
+#define dctl_sgoutnak (1 << 9)
+#define dctl_cgoutnak (1 << 10)
+#define dctl_pwronprgdone (1 << 11)
+#define dctl_reserved (1 << 12)
+#define dctl_gmc_shift (13)
+#define dctl_gmc_mask (0x3)
+#define dctl_ifrmnum (1 << 15)
+#define dctl_nakonbble (1 << 16)
+#define dctl_encontonbna (1 << 17)
+#define dctl_reserved18_31_shift (18)
+#define dctl_reserved18_31_mask (0x3fff)
+
+/* union dsts_data */
+#define dsts_suspsts (1 << 0)
+#define dsts_enumspd_shift (1)
+#define dsts_enumspd_mask (0x3)
+#define DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ 0
+#define DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ 1
+#define DWC_DSTS_ENUMSPD_LS_PHY_6MHZ           2
+#define DWC_DSTS_ENUMSPD_FS_PHY_48MHZ           3
+#define dsts_errticerr (1 << 3)
+#define dsts_reserved4_7_shift (4)
+#define dsts_reserved4_7_mask (0xf)
+#define dsts_soffn_shift (8)
+#define dsts_soffn_mask (0x3fff)
+#define dsts_reserved22_31_shift (22)
+#define dsts_reserved22_31_mask (0x3ff)
+
+/* union diepint_data */
+#define diepint_xfercompl (1 << 0)
+#define diepint_epdisabled (1 << 1)
+#define diepint_ahberr (1 << 2)
+#define diepint_timeout (1 << 3)
+#define diepint_intktxfemp (1 << 4)
+#define diepint_intknepmis (1 << 5)
+#define diepint_inepnakeff (1 << 6)
+#define diepint_emptyintr (1 << 7)
+#define diepint_txfifoundrn (1 << 8)
+#define diepint_bna (1 << 9)
+#define diepint_reserved10_12_shift (10)
+#define diepint_reserved10_12_mask (0x7)
+#define diepint_nak (1 << 13)
+#define diepint_reserved14_31_shift (14)
+#define diepint_reserved14_31_mask (0x3ffff)
+
+/* union doepint_data */
+#define doepint_xfercompl (1 << 0)
+#define doepint_epdisabled (1 << 1)
+#define doepint_ahberr (1 << 2)
+#define doepint_setup (1 << 3)
+#define doepint_outtknepdis (1 << 4)
+#define doepint_stsphsercvd (1 << 5)
+#define doepint_back2backsetup (1 << 6)
+#define doepint_reserved7 (1 << 7)
+#define doepint_outpkterr (1 << 8)
+#define doepint_bna (1 << 9)
+#define doepint_reserved10 (1 << 10)
+#define doepint_pktdrpsts (1 << 11)
+#define doepint_babble (1 << 12)
+#define doepint_nak (1 << 13)
+#define doepint_nyet (1 << 14)
+#define doepint_sr (1 << 15)
+#define doepint_reserved16_31_shift (16)
+#define doepint_reserved16_31_mask (0xffff)
+
+/* union daint_data */
+#define daint_in_shift (0)
+#define daint_in_mask (0xffff)
+#define daint_out_shift (16)
+#define daint_out_mask (0xffff)
+#define daint_b_inep0 (1 << 0)
+#define daint_b_inep1 (1 << 1)
+#define daint_b_inep2 (1 << 2)
+#define daint_b_inep3 (1 << 3)
+#define daint_b_inep4 (1 << 4)
+#define daint_b_inep5 (1 << 5)
+#define daint_b_inep6 (1 << 6)
+#define daint_b_inep7 (1 << 7)
+#define daint_b_inep8 (1 << 8)
+#define daint_b_inep9 (1 << 9)
+#define daint_b_inep10 (1 << 10)
+#define daint_b_inep11 (1 << 11)
+#define daint_b_inep12 (1 << 12)
+#define daint_b_inep13 (1 << 13)
+#define daint_b_inep14 (1 << 14)
+#define daint_b_inep15 (1 << 15)
+#define daint_b_outep0 (1 << 16)
+#define daint_b_outep1 (1 << 17)
+#define daint_b_outep2 (1 << 18)
+#define daint_b_outep3 (1 << 19)
+#define daint_b_outep4 (1 << 20)
+#define daint_b_outep5 (1 << 21)
+#define daint_b_outep6 (1 << 22)
+#define daint_b_outep7 (1 << 23)
+#define daint_b_outep8 (1 << 24)
+#define daint_b_outep9 (1 << 25)
+#define daint_b_outep10 (1 << 26)
+#define daint_b_outep11 (1 << 27)
+#define daint_b_outep12 (1 << 28)
+#define daint_b_outep13 (1 << 29)
+#define daint_b_outep14 (1 << 30)
+#define daint_b_outep15 (1 << 31)
+
+/* union dtknq1_data */
+#define dtknq1_intknwptr_shift (0)
+#define dtknq1_intknwptr_mask (0x1f)
+#define dtknq1_reserved05_06_shift (5)
+#define dtknq1_reserved05_06_mask (0x3)
+#define dtknq1_wrap_bit (1 << 7)
+#define dtknq1_epnums0_5_shift (8)
+#define dtknq1_epnums0_5_mask (0xffffff)
+
+/* union dthrctl_data */
+#define dthrctl_non_iso_thr_en (1 << 0)
+#define dthrctl_iso_thr_en (1 << 1)
+#define dthrctl_tx_thr_len_shift (2)
+#define dthrctl_tx_thr_len_mask (0x1ff)
+#define dthrctl_ahb_thr_ratio_shift (11)
+#define dthrctl_ahb_thr_ratio_mask (0x3)
+#define dthrctl_reserved13_15_shift (13)
+#define dthrctl_reserved13_15_mask (0x7)
+#define dthrctl_rx_thr_en (1 << 16)
+#define dthrctl_rx_thr_len_shift (17)
+#define dthrctl_rx_thr_len_mask (0x1ff)
+#define dthrctl_reserved26 (1 << 26)
+#define dthrctl_arbprken (1 << 27)
+#define dthrctl_reserved28_31_shift (28)
+#define dthrctl_reserved28_31_mask (0xf)
+
+/* union depctl_data */
+#define depctl_mps_shift (0)
+#define depctl_mps_mask (0x7ff)
+#define DWC_DEP0CTL_MPS_64     0
+#define DWC_DEP0CTL_MPS_32     1
+#define DWC_DEP0CTL_MPS_16     2
+#define DWC_DEP0CTL_MPS_8     3
+#define depctl_nextep_shift (11)
+#define depctl_nextep_mask (0xf)
+#define depctl_usbactep (1 << 15)
+#define depctl_dpid (1 << 16)
+#define depctl_naksts (1 << 17)
+#define depctl_eptype_shift (18)
+#define depctl_eptype_mask (0x3)
+#define depctl_snp (1 << 20)
+#define depctl_stall (1 << 21)
+#define depctl_txfnum_shift (22)
+#define depctl_txfnum_mask (0xf)
+#define depctl_cnak (1 << 26)
+#define depctl_snak (1 << 27)
+#define depctl_setd0pid (1 << 28)
+#define depctl_setd1pid (1 << 29)
+#define depctl_epdis (1 << 30)
+#define depctl_epena (1 << 31)
+
+/* union deptsiz_data */
+#define deptsiz_xfersize_shift (0)
+#define deptsiz_xfersize_mask (0x7ffff)
+#define MAX_PKT_CNT 1023
+#define deptsiz_pktcnt_shift (19)
+#define deptsiz_pktcnt_mask (0x3ff)
+#define deptsiz_mc_shift (29)
+#define deptsiz_mc_mask (0x3)
+#define deptsiz_reserved (1 << 31)
+
+/* union deptsiz0_data */
+#define deptsiz0_xfersize_shift (0)
+#define deptsiz0_xfersize_mask (0x7f)
+#define deptsiz0_reserved7_18_shift (7)
+#define deptsiz0_reserved7_18_mask (0xfff)
+#define deptsiz0_pktcnt_shift (19)
+#define deptsiz0_pktcnt_mask (0x3)
+#define deptsiz0_reserved21_28_shift (21)
+#define deptsiz0_reserved21_28_mask (0xff)
+#define deptsiz0_supcnt_shift (29)
+#define deptsiz0_supcnt_mask (0x3)
+#define deptsiz0_reserved31 (1 << 31)
+#define BS_HOST_READY    0x0
+#define BS_DMA_BUSY        0x1
+#define BS_DMA_DONE        0x2
+#define BS_HOST_BUSY    0x3
+#define RTS_SUCCESS        0x0
+#define RTS_BUFFLUSH    0x1
+#define RTS_RESERVED    0x2
+#define RTS_BUFERR        0x3
+
+/* union dev_dma_desc_sts */
+#define dev_dma_desc_sts_bytes_shift (0)
+#define dev_dma_desc_sts_bytes_mask (0xffff)
+#define dev_dma_desc_sts_nak (1 << 16)
+#define dev_dma_desc_sts_reserved17_22_shift (17)
+#define dev_dma_desc_sts_reserved17_22_mask (0x3f)
+#define dev_dma_desc_sts_mtrf (1 << 23)
+#define dev_dma_desc_sts_sr (1 << 24)
+#define dev_dma_desc_sts_ioc (1 << 25)
+#define dev_dma_desc_sts_sp (1 << 26)
+#define dev_dma_desc_sts_l (1 << 27)
+#define dev_dma_desc_sts_sts_shift (28)
+#define dev_dma_desc_sts_sts_mask (0x3)
+#define dev_dma_desc_sts_bs_shift (30)
+#define dev_dma_desc_sts_bs_mask (0x3)
+#define dev_dma_desc_sts_b_rxbytes_shift (0)
+#define dev_dma_desc_sts_b_rxbytes_mask (0x7ff)
+#define dev_dma_desc_sts_b_reserved11 (1 << 11)
+#define dev_dma_desc_sts_b_framenum_shift (12)
+#define dev_dma_desc_sts_b_framenum_mask (0x7ff)
+#define dev_dma_desc_sts_b_pid_shift (23)
+#define dev_dma_desc_sts_b_pid_mask (0x3)
+#define dev_dma_desc_sts_b_ioc (1 << 25)
+#define dev_dma_desc_sts_b_sp (1 << 26)
+#define dev_dma_desc_sts_b_l (1 << 27)
+#define dev_dma_desc_sts_b_rxsts_shift (28)
+#define dev_dma_desc_sts_b_rxsts_mask (0x3)
+#define dev_dma_desc_sts_b_bs_shift (30)
+#define dev_dma_desc_sts_b_bs_mask (0x3)
+#define dev_dma_desc_sts_b_b_txbytes_shift (0)
+#define dev_dma_desc_sts_b_b_txbytes_mask (0xfff)
+#define dev_dma_desc_sts_b_b_framenum_shift (12)
+#define dev_dma_desc_sts_b_b_framenum_mask (0x7ff)
+#define dev_dma_desc_sts_b_b_pid_shift (23)
+#define dev_dma_desc_sts_b_b_pid_mask (0x3)
+#define dev_dma_desc_sts_b_b_ioc (1 << 25)
+#define dev_dma_desc_sts_b_b_sp (1 << 26)
+#define dev_dma_desc_sts_b_b_l (1 << 27)
+#define dev_dma_desc_sts_b_b_txsts_shift (28)
+#define dev_dma_desc_sts_b_b_txsts_mask (0x3)
+#define dev_dma_desc_sts_b_b_bs_shift (30)
+#define dev_dma_desc_sts_b_b_bs_mask (0x3)
+#define DWC_DEV_GLOBAL_REG_OFFSET 0x800
+#define DWC_DEV_IN_EP_REG_OFFSET 0x900
+#define DWC_EP_REG_OFFSET 0x20
+#define DWC_DEV_OUT_EP_REG_OFFSET 0xB00
+
+/* union hcfg_data */
+#define hcfg_fslspclksel_shift (0)
+#define hcfg_fslspclksel_mask (0x3)
+#define DWC_HCFG_30_60_MHZ 0
+#define DWC_HCFG_48_MHZ       1
+#define DWC_HCFG_6_MHZ       2
+#define hcfg_fslssupp (1 << 2)
+#define hcfg_reserved3_6_shift (3)
+#define hcfg_reserved3_6_mask (0xf)
+#define hcfg_ena32khzs (1 << 7)
+#define hcfg_resvalid_shift (8)
+#define hcfg_resvalid_mask (0xff)
+#define hcfg_reserved16_22_shift (16)
+#define hcfg_reserved16_22_mask (0x7f)
+#define hcfg_descdma (1 << 23)
+#define hcfg_frlisten_shift (24)
+#define hcfg_frlisten_mask (0x3)
+#define hcfg_perschedena (1 << 26)
+#define hcfg_reserved27_30_shift (27)
+#define hcfg_reserved27_30_mask (0xf)
+#define hcfg_modechtimen (1 << 31)
+
+/* union hfir_data */
+#define hfir_frint_shift (0)
+#define hfir_frint_mask (0xffff)
+#define hfir_hfirrldctrl (1 << 16)
+#define hfir_reserved_shift (17)
+#define hfir_reserved_mask (0x7fff)
+
+/* union hfnum_data */
+#define hfnum_frnum_shift (0)
+#define hfnum_frnum_mask (0xffff)
+#define DWC_HFNUM_MAX_FRNUM 0x3FFF
+#define hfnum_frrem_shift (16)
+#define hfnum_frrem_mask (0xffff)
+
+/* union hptxsts_data */
+#define hptxsts_ptxfspcavail_shift (0)
+#define hptxsts_ptxfspcavail_mask (0xffff)
+#define hptxsts_ptxqspcavail_shift (16)
+#define hptxsts_ptxqspcavail_mask (0xff)
+#define hptxsts_ptxqtop_terminate (1 << 24)
+#define hptxsts_ptxqtop_token_shift (25)
+#define hptxsts_ptxqtop_token_mask (0x3)
+#define hptxsts_ptxqtop_chnum_shift (27)
+#define hptxsts_ptxqtop_chnum_mask (0xf)
+#define hptxsts_ptxqtop_odd (1 << 31)
+
+/* union hprt0_data */
+#define hprt0_prtconnsts (1 << 0)
+#define hprt0_prtconndet (1 << 1)
+#define hprt0_prtena (1 << 2)
+#define hprt0_prtenchng (1 << 3)
+#define hprt0_prtovrcurract (1 << 4)
+#define hprt0_prtovrcurrchng (1 << 5)
+#define hprt0_prtres (1 << 6)
+#define hprt0_prtsusp (1 << 7)
+#define hprt0_prtrst (1 << 8)
+#define hprt0_reserved9 (1 << 9)
+#define hprt0_prtlnsts_shift (10)
+#define hprt0_prtlnsts_mask (0x3)
+#define hprt0_prtpwr (1 << 12)
+#define hprt0_prttstctl_shift (13)
+#define hprt0_prttstctl_mask (0xf)
+#define hprt0_prtspd_shift (17)
+#define hprt0_prtspd_mask (0x3)
+#define DWC_HPRT0_PRTSPD_HIGH_SPEED 0
+#define DWC_HPRT0_PRTSPD_FULL_SPEED 1
+#define DWC_HPRT0_PRTSPD_LOW_SPEED    2
+#define hprt0_reserved19_31_shift (19)
+#define hprt0_reserved19_31_mask (0x1fff)
+
+/* union haint_data */
+#define haint_ch0 (1 << 0)
+#define haint_ch1 (1 << 1)
+#define haint_ch2 (1 << 2)
+#define haint_ch3 (1 << 3)
+#define haint_ch4 (1 << 4)
+#define haint_ch5 (1 << 5)
+#define haint_ch6 (1 << 6)
+#define haint_ch7 (1 << 7)
+#define haint_ch8 (1 << 8)
+#define haint_ch9 (1 << 9)
+#define haint_ch10 (1 << 10)
+#define haint_ch11 (1 << 11)
+#define haint_ch12 (1 << 12)
+#define haint_ch13 (1 << 13)
+#define haint_ch14 (1 << 14)
+#define haint_ch15 (1 << 15)
+#define haint_reserved_shift (16)
+#define haint_reserved_mask (0xffff)
+#define haint_b_chint_shift (0)
+#define haint_b_chint_mask (0xffff)
+#define haint_b_reserved_shift (16)
+#define haint_b_reserved_mask (0xffff)
+
+/* union haintmsk_data */
+#define haintmsk_ch0 (1 << 0)
+#define haintmsk_ch1 (1 << 1)
+#define haintmsk_ch2 (1 << 2)
+#define haintmsk_ch3 (1 << 3)
+#define haintmsk_ch4 (1 << 4)
+#define haintmsk_ch5 (1 << 5)
+#define haintmsk_ch6 (1 << 6)
+#define haintmsk_ch7 (1 << 7)
+#define haintmsk_ch8 (1 << 8)
+#define haintmsk_ch9 (1 << 9)
+#define haintmsk_ch10 (1 << 10)
+#define haintmsk_ch11 (1 << 11)
+#define haintmsk_ch12 (1 << 12)
+#define haintmsk_ch13 (1 << 13)
+#define haintmsk_ch14 (1 << 14)
+#define haintmsk_ch15 (1 << 15)
+#define haintmsk_reserved_shift (16)
+#define haintmsk_reserved_mask (0xffff)
+#define haintmsk_b_chint_shift (0)
+#define haintmsk_b_chint_mask (0xffff)
+#define haintmsk_b_reserved_shift (16)
+#define haintmsk_b_reserved_mask (0xffff)
+
+/* union hcchar_data */
+#define hcchar_mps_shift (0)
+#define hcchar_mps_mask (0x7ff)
+#define hcchar_epnum_shift (11)
+#define hcchar_epnum_mask (0xf)
+#define hcchar_epdir (1 << 15)
+#define hcchar_reserved (1 << 16)
+#define hcchar_lspddev (1 << 17)
+#define hcchar_eptype_shift (18)
+#define hcchar_eptype_mask (0x3)
+#define hcchar_multicnt_shift (20)
+#define hcchar_multicnt_mask (0x3)
+#define hcchar_devaddr_shift (22)
+#define hcchar_devaddr_mask (0x7f)
+#define hcchar_oddfrm (1 << 29)
+#define hcchar_chdis (1 << 30)
+#define hcchar_chen (1 << 31)
+
+/* union hcsplt_data */
+#define hcsplt_prtaddr_shift (0)
+#define hcsplt_prtaddr_mask (0x7f)
+#define hcsplt_hubaddr_shift (7)
+#define hcsplt_hubaddr_mask (0x7f)
+#define hcsplt_xactpos_shift (14)
+#define hcsplt_xactpos_mask (0x3)
+#define DWC_HCSPLIT_XACTPOS_MID 0
+#define DWC_HCSPLIT_XACTPOS_END 1
+#define DWC_HCSPLIT_XACTPOS_BEGIN 2
+#define DWC_HCSPLIT_XACTPOS_ALL 3
+#define hcsplt_compsplt (1 << 16)
+#define hcsplt_reserved_shift (17)
+#define hcsplt_reserved_mask (0x3fff)
+#define hcsplt_spltena (1 << 31)
+
+/* union hcint_data */
+#define hcint_xfercomp (1 << 0)
+#define hcint_chhltd (1 << 1)
+#define hcint_ahberr (1 << 2)
+#define hcint_stall (1 << 3)
+#define hcint_nak (1 << 4)
+#define hcint_ack (1 << 5)
+#define hcint_nyet (1 << 6)
+#define hcint_xacterr (1 << 7)
+#define hcint_bblerr (1 << 8)
+#define hcint_frmovrun (1 << 9)
+#define hcint_datatglerr (1 << 10)
+#define hcint_bna (1 << 11)
+#define hcint_xcs_xact (1 << 12)
+#define hcint_frm_list_roll (1 << 13)
+#define hcint_reserved14_31_shift (14)
+#define hcint_reserved14_31_mask (0x3ffff)
+
+/* union hcintmsk_data */
+#define hcintmsk_xfercompl (1 << 0)
+#define hcintmsk_chhltd (1 << 1)
+#define hcintmsk_ahberr (1 << 2)
+#define hcintmsk_stall (1 << 3)
+#define hcintmsk_nak (1 << 4)
+#define hcintmsk_ack (1 << 5)
+#define hcintmsk_nyet (1 << 6)
+#define hcintmsk_xacterr (1 << 7)
+#define hcintmsk_bblerr (1 << 8)
+#define hcintmsk_frmovrun (1 << 9)
+#define hcintmsk_datatglerr (1 << 10)
+#define hcintmsk_bna (1 << 11)
+#define hcintmsk_xcs_xact (1 << 12)
+#define hcintmsk_frm_list_roll (1 << 13)
+#define hcintmsk_reserved14_31_shift (14)
+#define hcintmsk_reserved14_31_mask (0x3ffff)
+
+/* union hctsiz_data */
+#define hctsiz_xfersize_shift (0)
+#define hctsiz_xfersize_mask (0x7ffff)
+#define hctsiz_pktcnt_shift (19)
+#define hctsiz_pktcnt_mask (0x3ff)
+#define hctsiz_pid_shift (29)
+#define hctsiz_pid_mask (0x3)
+#define DWC_HCTSIZ_DATA0 0
+#define DWC_HCTSIZ_DATA1 2
+#define DWC_HCTSIZ_DATA2 1
+#define DWC_HCTSIZ_MDATA 3
+#define DWC_HCTSIZ_SETUP 3
+#define hctsiz_dopng (1 << 31)
+#define hctsiz_b_schinfo_shift (0)
+#define hctsiz_b_schinfo_mask (0xff)
+#define hctsiz_b_ntd_shift (8)
+#define hctsiz_b_ntd_mask (0xff)
+#define hctsiz_b_reserved16_28_shift (16)
+#define hctsiz_b_reserved16_28_mask (0x1fff)
+#define hctsiz_b_pid_shift (29)
+#define hctsiz_b_pid_mask (0x3)
+#define hctsiz_b_dopng (1 << 31)
+
+/* union hcdma_data */
+#define hcdma_reserved0_2_shift (0)
+#define hcdma_reserved0_2_mask (0x7)
+#define hcdma_ctd_shift (3)
+#define hcdma_ctd_mask (0xff)
+#define hcdma_dma_addr_shift (11)
+#define hcdma_dma_addr_mask (0x1fffff)
+
+/* union host_dma_desc_sts */
+#define host_dma_desc_sts_n_bytes_shift (0)
+#define host_dma_desc_sts_n_bytes_mask (0x1ffff)
+#define host_dma_desc_sts_qtd_offset_shift (17)
+#define host_dma_desc_sts_qtd_offset_mask (0x3f)
+#define host_dma_desc_sts_a_qtd (1 << 23)
+#define host_dma_desc_sts_sup (1 << 24)
+#define host_dma_desc_sts_ioc (1 << 25)
+#define host_dma_desc_sts_eol (1 << 26)
+#define host_dma_desc_sts_reserved27 (1 << 27)
+#define host_dma_desc_sts_sts_shift (28)
+#define host_dma_desc_sts_sts_mask (0x3)
+#define DMA_DESC_STS_PKTERR    1
+#define host_dma_desc_sts_reserved30 (1 << 30)
+#define host_dma_desc_sts_a (1 << 31)
+#define host_dma_desc_sts_b_n_bytes_shift (0)
+#define host_dma_desc_sts_b_n_bytes_mask (0xfff)
+#define host_dma_desc_sts_b_reserved12_24_shift (12)
+#define host_dma_desc_sts_b_reserved12_24_mask (0x1fff)
+#define host_dma_desc_sts_b_ioc (1 << 25)
+#define host_dma_desc_sts_b_reserved26_27_shift (26)
+#define host_dma_desc_sts_b_reserved26_27_mask (0x3)
+#define host_dma_desc_sts_b_sts_shift (28)
+#define host_dma_desc_sts_b_sts_mask (0x3)
+#define host_dma_desc_sts_b_reserved30 (1 << 30)
+#define host_dma_desc_sts_b_a (1 << 31)
+#define    MAX_DMA_DESC_SIZE        131071
+#define MAX_DMA_DESC_NUM_GENERIC    64
+#define MAX_DMA_DESC_NUM_HS_ISOC    256
+#define MAX_FRLIST_EN_NUM        64
+#define DWC_OTG_HOST_GLOBAL_REG_OFFSET 0x400
+#define DWC_OTG_HOST_PORT_REGS_OFFSET 0x440
+#define DWC_OTG_HOST_CHAN_REGS_OFFSET 0x500
+#define DWC_OTG_CHAN_REGS_OFFSET 0x20
+
+/* union pcgcctl_data */
+#define pcgcctl_stoppclk (1 << 0)
+#define pcgcctl_gatehclk (1 << 1)
+#define pcgcctl_pwrclmp (1 << 2)
+#define pcgcctl_rstpdwnmodule (1 << 3)
+#define pcgcctl_reserved (1 << 4)
+#define pcgcctl_enbl_sleep_gating (1 << 5)
+#define pcgcctl_phy_in_sleep (1 << 6)
+#define pcgcctl_deep_sleep (1 << 7)
+#define pcgcctl_resetaftsusp (1 << 8)
+#define pcgcctl_restoremode (1 << 9)
+#define pcgcctl_enbl_extnd_hiber (1 << 10)
+#define pcgcctl_extnd_hiber_pwrclmp (1 << 11)
+#define pcgcctl_extnd_hiber_switch (1 << 12)
+#define pcgcctl_ess_reg_restored (1 << 13)
+#define pcgcctl_prt_clk_sel_shift (14)
+#define pcgcctl_prt_clk_sel_mask (0x3)
+#define pcgcctl_port_power (1 << 16)
+#define pcgcctl_max_xcvrselect_shift (17)
+#define pcgcctl_max_xcvrselect_mask (0x3)
+#define pcgcctl_max_termsel (1 << 19)
+#define pcgcctl_mac_dev_addr_shift (20)
+#define pcgcctl_mac_dev_addr_mask (0x7f)
+#define pcgcctl_p2hd_dev_enum_spd_shift (27)
+#define pcgcctl_p2hd_dev_enum_spd_mask (0x3)
+#define pcgcctl_p2hd_prt_spd_shift (29)
+#define pcgcctl_p2hd_prt_spd_mask (0x3)
+#define pcgcctl_if_dev_mode (1 << 31)
+
+/* union gdfifocfg_data */
+#define gdfifocfg_gdfifocfg_shift (0)
+#define gdfifocfg_gdfifocfg_mask (0xffff)
+#define gdfifocfg_epinfobase_shift (16)
+#define gdfifocfg_epinfobase_mask (0xffff)
+
+/* union gpwrdn_data */
+#define gpwrdn_pmuintsel (1 << 0)
+#define gpwrdn_pmuactv (1 << 1)
+#define gpwrdn_restore (1 << 2)
+#define gpwrdn_pwrdnclmp (1 << 3)
+#define gpwrdn_pwrdnrstn (1 << 4)
+#define gpwrdn_pwrdnswtch (1 << 5)
+#define gpwrdn_dis_vbus (1 << 6)
+#define gpwrdn_lnstschng (1 << 7)
+#define gpwrdn_lnstchng_msk (1 << 8)
+#define gpwrdn_rst_det (1 << 9)
+#define gpwrdn_rst_det_msk (1 << 10)
+#define gpwrdn_disconn_det (1 << 11)
+#define gpwrdn_disconn_det_msk (1 << 12)
+#define gpwrdn_connect_det (1 << 13)
+#define gpwrdn_connect_det_msk (1 << 14)
+#define gpwrdn_srp_det (1 << 15)
+#define gpwrdn_srp_det_msk (1 << 16)
+#define gpwrdn_sts_chngint (1 << 17)
+#define gpwrdn_sts_chngint_msk (1 << 18)
+#define gpwrdn_linestate_shift (19)
+#define gpwrdn_linestate_mask (0x3)
+#define gpwrdn_idsts (1 << 21)
+#define gpwrdn_bsessvld (1 << 22)
+#define gpwrdn_adp_int (1 << 23)
+#define gpwrdn_mult_val_id_bc_shift (24)
+#define gpwrdn_mult_val_id_bc_mask (0x1f)
+#define gpwrdn_reserved29_31_shift (29)
+#define gpwrdn_reserved29_31_mask (0x7)
+
+#endif /* BCM2835_USB_REGS_H */
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 85fc81bf43..3d97b5d489 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1201,7 +1201,7 @@ static void usb_net_handle_dataout(USBNetState *s, USBPacket *p)
s->out_ptr += sz;

if (!is_rndis(s)) {
-        if (p->iov.size < 64) {
+        /*if (p->iov.size < 64)*/ {
qemu_send_packet(qemu_get_queue(s->nic), s->out_buf, s->out_ptr);
s->out_ptr = 0;
}
diff --git a/include/hw/arm/bcm2835.h b/include/hw/arm/bcm2835.h
new file mode 100644
index 0000000000..9ea8ddd572
--- /dev/null
+++ b/include/hw/arm/bcm2835.h
@@ -0,0 +1,37 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
+ *
+ * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ *
+ * Moved to Qemu root from Old Rasp
+ * John Bradley April 2017
+ * 
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_H
+#define BCM2835_H
+
+#include "hw/arm/arm.h"
+#include "hw/arm/bcm2835_peripherals.h"
+#include "hw/intc/bcm2835_control.h"
+
+#define TYPE_BCM2835 "bcm2835"
+#define BCM2835(obj) OBJECT_CHECK(BCM2835State, (obj), TYPE_BCM2835)
+
+#define BCM2835_NCPUS 1
+
+typedef struct BCM2835State {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    uint32_t enabled_cpus;
+    ARMCPU cpus[BCM2835_NCPUS];
+ 
+    BCM2835PeripheralState peripherals;
+} BCM2835State;
+
+#endif /* BCM2835_H */
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 122b286de7..ef28b51066 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -18,12 +18,17 @@
#include "hw/display/bcm2835_fb.h"
#include "hw/dma/bcm2835_dma.h"
#include "hw/intc/bcm2835_ic.h"
+#include "hw/misc/bcm2835_mphi.h"
+#include "hw/misc/bcm2835_power.h"
#include "hw/misc/bcm2835_property.h"
#include "hw/misc/bcm2835_rng.h"
#include "hw/misc/bcm2835_mbox.h"
#include "hw/sd/sdhci.h"
#include "hw/sd/bcm2835_sdhost.h"
#include "hw/gpio/bcm2835_gpio.h"
+#include "hw/timer/bcm2835_st.h"
+#include "hw/timer/bcm2835_timer.h"
+#include "hw/usb/bcm2835_usb.h"

#define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
#define BCM2835_PERIPHERALS(obj) \
@@ -43,10 +48,15 @@ typedef struct BCM2835PeripheralState {
BCM2835FBState fb;
BCM2835DMAState dma;
BCM2835ICState ic;
+    BCM2835MphiState mphi;
+    BCM2835PowerState power;
BCM2835PropertyState property;
BCM2835RngState rng;
BCM2835MboxState mboxes;
SDHCIState sdhci;
+    BCM2835StState st;
+    BCM2835TimerState timer;
+    BCM2835UsbState usb;
BCM2835SDHostState sdhost;
BCM2835GpioState gpio;
} BCM2835PeripheralState;
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpio.h
index 9f8e0c720c..73cfda6a6b 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -16,6 +16,8 @@

#include "hw/sd/sd.h"

+#include "qemu/PanelEmu.h"
+
typedef struct BCM2835GpioState {
SysBusDevice parent_obj;

@@ -30,6 +32,9 @@ typedef struct BCM2835GpioState {
uint32_t lev0, lev1;
uint8_t sd_fsel;
qemu_irq out[54];
+
+    panel_connection_t panel;
+
} BCM2835GpioState;

#define TYPE_BCM2835_GPIO "bcm2835_gpio"
diff --git a/include/hw/intc/bcm2835_control.h b/include/hw/intc/bcm2835_control.h
new file mode 100644
index 0000000000..6d09b03077
--- /dev/null
+++ b/include/hw/intc/bcm2835_control.h
@@ -0,0 +1,53 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
+ *
+ * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ * 
+ * Merge into QEMU root fork John Bradley April 2017
+ * 
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_CONTROL_H
+#define BCM2835_CONTROL_H
+
+#include "hw/sysbus.h"
+
+/* 4 mailboxes per core, for 16 total */
+#define BCM2835_NCORES 1
+#define BCM2835_MBPERCORE 4
+
+#define TYPE_BCM2835_CONTROL "bcm2836-control"
+#define BCM2835_CONTROL(obj) \
+    OBJECT_CHECK(BCM2835ControlState, (obj), TYPE_BCM2835_CONTROL)
+
+typedef struct BCM2835ControlState {
+    /*< private >*/
+    SysBusDevice busdev;
+    /*< public >*/
+    MemoryRegion iomem;
+
+    /* mailbox state */
+    uint32_t mailboxes[BCM2835_NCORES * BCM2835_MBPERCORE];
+
+    /* interrupt routing/control registers */
+    uint8_t route_gpu_irq, route_gpu_fiq;
+    uint32_t timercontrol[BCM2835_NCORES];
+    uint32_t mailboxcontrol[BCM2835_NCORES];
+
+    /* interrupt status regs (derived from input pins; not visible to user) */
+    bool gpu_irq, gpu_fiq;
+    uint8_t timerirqs[BCM2835_NCORES];
+
+    /* interrupt source registers, post-routing (also input-derived; visible) */
+    uint32_t irqsrc[BCM2835_NCORES];
+    uint32_t fiqsrc[BCM2835_NCORES];
+
+    /* outputs to CPU cores */
+    qemu_irq irq[BCM2835_NCORES];
+    qemu_irq fiq[BCM2835_NCORES];
+} BCM2835ControlState;
+
+#endif
diff --git a/include/hw/intc/bcm2836_control.h b/include/hw/intc/bcm2836_control.h
index 613f3c4186..768b4d4930 100644
--- a/include/hw/intc/bcm2836_control.h
+++ b/include/hw/intc/bcm2836_control.h
@@ -5,6 +5,8 @@
* Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
* Written by Andrew Baumann
*
+ * Merge into QEMU root fork John Bradley April 2017
+ *
* This code is licensed under the GNU GPLv2 and later.
*/

diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
new file mode 100644
index 0000000000..72824a9ff5
--- /dev/null
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -0,0 +1,28 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_MPHI_H
+#define BCM2835_MPHI_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_MPHI "bcm2835-mphi"
+#define BCM2835_MPHI(obj) \
+        OBJECT_CHECK(BCM2835MphiState, (obj), TYPE_BCM2835_MPHI)
+
+typedef struct {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+
+    uint32_t mphi_base;
+    uint32_t mphi_ctrl;
+    uint32_t mphi_outdda;
+    uint32_t mphi_outddb;
+    uint32_t mphi_intstat;
+
+    qemu_irq irq;
+} BCM2835MphiState;
+
+#endif
diff --git a/include/hw/misc/bcm2835_power.h b/include/hw/misc/bcm2835_power.h
new file mode 100644
index 0000000000..a19e7f4930
--- /dev/null
+++ b/include/hw/misc/bcm2835_power.h
@@ -0,0 +1,22 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_POWER_H
+#define BCM2835_POWER_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2835_POWER "bcm2835-power"
+#define BCM2835_POWER(obj) \
+        OBJECT_CHECK(BCM2835PowerState, (obj), TYPE_BCM2835_POWER)
+
+typedef struct {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+    int pending;
+    qemu_irq mbox_irq;
+} BCM2835PowerState;
+
+#endif
diff --git a/include/hw/timer/bcm2835_st.h b/include/hw/timer/bcm2835_st.h
new file mode 100644
index 0000000000..11dc312711
--- /dev/null
+++ b/include/hw/timer/bcm2835_st.h
@@ -0,0 +1,25 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_ST_H
+#define BCM2835_ST_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+
+#define TYPE_BCM2835_ST "bcm2835_st"
+#define BCM2835_ST(obj) OBJECT_CHECK(BCM2835StState, (obj), TYPE_BCM2835_ST)
+
+typedef struct BCM2835StState {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    uint32_t compare[4];
+    uint32_t match;
+    uint32_t next;
+    qemu_irq irq[4];
+} BCM2835StState;
+
+#endif
diff --git a/include/hw/timer/bcm2835_timer.h b/include/hw/timer/bcm2835_timer.h
new file mode 100644
index 0000000000..e2a0a76f01
--- /dev/null
+++ b/include/hw/timer/bcm2835_timer.h
@@ -0,0 +1,32 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_TIMER_H
+#define BCM2835_TIMER_H
+
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+
+#define TYPE_BCM2835_TIMER "bcm2835_timer"
+#define BCM2835_TIMER(obj) \
+        OBJECT_CHECK(BCM2835TimerState, (obj), TYPE_BCM2835_TIMER)
+
+typedef struct {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+
+    qemu_irq irq;
+
+    uint32_t load;
+    uint32_t control;
+    uint32_t raw_irq;
+    uint32_t prediv;
+    uint32_t frc_value;
+
+    ptimer_state *timer;
+    ptimer_state *frc_timer;
+} BCM2835TimerState;
+
+#endif
diff --git a/include/hw/usb/bcm2835_usb.h b/include/hw/usb/bcm2835_usb.h
new file mode 100644
index 0000000000..246123123b
--- /dev/null
+++ b/include/hw/usb/bcm2835_usb.h
@@ -0,0 +1,78 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_USB_H
+#define BCM2835_USB_H
+
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+
+#include "hw/usb.h"
+
+#define BCM2835_USB_HCHANS 8
+
+#define TYPE_BCM2835_USB "bcm2835_usb"
+#define BCM2835_USB(obj) \
+        OBJECT_CHECK(BCM2835UsbState, (obj), TYPE_BCM2835_USB)
+
+//typedef struct BCM2835UsbState BCM2835UsbState;
+
+typedef struct {
+    struct BCM2835UsbState_ *parent;
+    int index;
+
+    uint32_t hcchar;
+    uint32_t hcsplt;
+    uint32_t hcint;
+    uint32_t hcintmsk;
+    uint32_t hctsiz;
+    uint32_t hcdma;
+    uint32_t reserved;
+    uint32_t hcdmab;
+
+    USBPacket packet;
+    uint8_t buffer[8192];
+} BCM2835UsbHcState;
+
+typedef struct BCM2835UsbState_ {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
+
+    USBBus bus;
+    USBPort port;
+    int attached;
+    int reset_done;
+    QEMUTimer *sof_timer;
+
+    uint32_t gusbcfg;
+    uint32_t hptxfsiz;
+    uint32_t hcfg;
+    uint32_t dcfg;
+    uint32_t grxfsiz;
+    uint32_t gnptxfsiz;
+    uint32_t dtxfsiz[15];
+    uint32_t gahbcfg;
+    uint32_t grstctl;
+    uint32_t gotgctl;
+    uint32_t gotgint;
+    uint32_t gintsts;
+    uint32_t gintmsk;
+    uint32_t gdfifocfg;
+    uint32_t hprt0;
+    uint32_t haint;
+    uint32_t haintmsk;
+    uint32_t gnptxsts;
+    uint32_t hfnum;
+    uint32_t hptxsts;
+    uint32_t guid;
+
+    BCM2835UsbHcState hchan[BCM2835_USB_HCHANS];
+
+    qemu_irq irq;
+} BCM2835UsbState;
+
+#endif
diff --git a/include/qemu/PanelEmu.h b/include/qemu/PanelEmu.h
new file mode 100644
index 0000000000..b7a15e64e7
--- /dev/null
+++ b/include/qemu/PanelEmu.h
@@ -0,0 +1,53 @@
+/*
+ * To change this license header, choose License Headers in Project Properties.
+ * To change this template file, choose Tools | Templates
+ * and open the template in the editor.
+ */
+
+/*
+ * File:   PanelEmu.h
+ * Author: John Bradley
+ *
+ * Created on 22 April 2017, 22:26
+ */
+
+#ifndef PANELEMU_H
+#define PANELEMU_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+
+#define DRIVER_NAME "RDC-GPIO: "
+#define PANEL_NAME "GPIO panel: "
+
+
+#define DEFAULT_PORT 0xb1ff       //45567
+
+#define PANEL_PINS 54
+
+    typedef struct panel_connection {
+        int socket; /* socket we'll connect to the panel with */
+        fd_set fds; /* list of descriptors (only the above socket */
+        char last[PANEL_PINS / 8]; /* we don't want to send updates to the panel
+	                       unless something changed */
+    } panel_connection_t;
+
+    int panel_open(panel_connection_t* h);
+
+    bool panel_read(panel_connection_t* h, uint64_t *pinS);
+    void senddatatopanel(panel_connection_t* h, uint64_t pinS, bool Value);
+    void panel_send_read_command(panel_connection_t* h);
+    void sendpincount(panel_connection_t* h, int Num);
+    void sendenabledmap(panel_connection_t* h, uint64_t pins);
+    void sendinputmap(panel_connection_t* h, uint64_t pins);
+    void sendoutputmap(panel_connection_t* h, uint64_t pins);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* PANELEMU_H */
+
diff --git a/util/Makefile.objs b/util/Makefile.objs
index c6205ebf86..8316ed79ba 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -43,3 +43,4 @@ util-obj-y += qdist.o
util-obj-y += qht.o
util-obj-y += range.o
util-obj-y += systemd.o
+util-obj-y += PanelEmu.o
\ No newline at end of file
diff --git a/util/PanelEmu.c b/util/PanelEmu.c
new file mode 100644
index 0000000000..59c87d2747
--- /dev/null
+++ b/util/PanelEmu.c
@@ -0,0 +1,293 @@
+/*
+ * Emulation for Rasp PI GPIO via Server connected to via Socket
+ *
+ */
+#include "qemu/osdep.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <memory.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#ifdef __MINGW32__
+#include <winsock2.h>
+#else
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#endif
+
+
+#include "qemu/PanelEmu.h"
+
+typedef enum
+{
+    MACHINEDESC = 0,
+    PINSTOPANEL = 1,
+    READREQ = 2,
+    PINCOUNT = 3,
+    ENABLEMAP = 4,
+    INPUTMAP = 5,
+    OUTPUTMAP = 6,
+    PINSTOQEMU = 7
+} PacketType;
+
+#define MAXPACKET   255
+
+#define PACKETLEN   0  //Includes Packet Length
+#define PACKETTYPE  1
+
+typedef struct
+{
+    unsigned short int Data[MAXPACKET];
+} CommandPacket;
+
+/*
+ * Hub connections
+ *
+ */
+
+int panel_open(panel_connection_t* h)
+{
+    int rv;
+#ifdef __MINGW32__ 
+    struct sockaddr_in remote;
+#else
+    struct sockaddr_in remote; 
+#endif
+ 
+    int returnval = - 1;
+
+#ifdef __MINGW32__ 
+     printf("__MINGW32__\n");
+#else
+     printf("NOT __MINGW32__\n"); 
+#endif 
+ 
+#ifdef __MINGW32__
+    WSADATA wsadata;
+    if (WSAStartup(MAKEWORD(1, 1), &wsadata) == SOCKET_ERROR) {
+        printf("Error creating socket.\n");
+    }
+    else
+#endif
+    {
+        if ((h->socket = socket(AF_INET, SOCK_STREAM, 0)) != - 1) {
+#ifdef __MINGW32__
+            memset((char *)&remote, 0, sizeof(remote));
+            remote.sin_family = AF_INET;
+            remote.sin_port = htons(DEFAULT_PORT);
+            remote.sin_addr.s_addr = inet_addr("127.0.0.1"); 
+#else
+            bzero((char *)&remote, sizeof(remote));
+            remote.sin_family = AF_INET;
+            remote.sin_port = htons(DEFAULT_PORT);
+            remote.sin_addr.s_addr = inet_addr("127.0.0.1");
+#endif
+            if ((rv=connect(h->socket, (struct sockaddr *) &remote, sizeof (remote))) != - 1) {
+#ifdef __MINGW32__
+                char value = 1;
+                setsockopt(h->socket, IPPROTO_TCP, TCP_NODELAY, &value, sizeof ( value));
+
+#endif
+                FD_ZERO(&h->fds);
+
+                /* Set our connected socket */
+                FD_SET(h->socket, &h->fds);
+
+                printf(PANEL_NAME "Connected OK %d\n",rv);
+                returnval = 0;
+            } else {
+                printf(PANEL_NAME "connection Failes %d\n",rv);
+#ifdef __MINGW32__
+                closesocket(h->socket);
+#else
+                close(h->socket);
+#endif
+                h->socket = - 1;
+            }
+        }
+    }
+    return returnval;
+}
+
+static void panel_command(panel_connection_t *h, CommandPacket *Pkt)
+{
+    if (send(h->socket, (char *) Pkt, Pkt->Data[PACKETLEN], 0) == - 1) {
+        perror(PANEL_NAME "send");
+#ifdef __MINGW32__
+        closesocket(h->socket);
+#else
+        close(h->socket);
+#endif
+        h->socket = - 1; /* act like we never connected */
+    }
+}
+
+/* Wait for values to be read back from panel */
+bool panel_read(panel_connection_t* h, uint64_t* Data)
+{
+    fd_set rfds, efds;
+    int LengthInBuffer;
+    int select_res = 0;
+
+    CommandPacket *PktPtr = (CommandPacket *) malloc(sizeof (CommandPacket));
+    CommandPacket *Pkt;
+    bool NoError = true;
+    bool NewData = false;
+    bool NoData = false;
+    struct timeval timeout;
+
+    int ReadStart = 0;
+
+    timeout.tv_sec = 0;
+    timeout.tv_usec = 0;
+
+    if (h->socket != - 1) {
+        rfds = h->fds;
+        efds = h->fds;
+
+//        printf(PANEL_NAME "panel_read\n");
+
+        Pkt = PktPtr;
+        while (NoError&&! NoData) {
+            select_res = select(h->socket + 1, &rfds, NULL, &efds, &timeout);
+            if (select_res > 0) {
+                if (FD_ISSET(h->socket, &rfds)) {
+                    /* receive more data */
+                    if ((LengthInBuffer = recv(h->socket, (char *) &Pkt[ReadStart], sizeof (*Pkt) - ReadStart, 0)) > 0) {
+                        LengthInBuffer += ReadStart;
+                        for (int i = 0; LengthInBuffer > 0; i ++) {
+                            if (LengthInBuffer >= Pkt->Data[i + PACKETLEN]) {
+                                if (Pkt->Data[i + PACKETTYPE] == PINSTOQEMU) {
+                                    *Data = (uint64_t) Pkt->Data[i + 2];
+                                    *Data |= ((uint64_t) Pkt->Data[i + 3]) << 16;
+                                    *Data |= ((uint64_t) Pkt->Data[i + 4]) << 32;
+                                    *Data |= ((uint64_t) Pkt->Data[i + 5]) << 48;
+
+                                    NewData = true;
+                                } else {
+                                    printf(PANEL_NAME "Invalid data received\n");
+                                }
+                                LengthInBuffer -= Pkt->Data[PACKETLEN];
+                                i += Pkt->Data[PACKETLEN]; //								Pkt=(CommandPacket *)&(Pkt->Data[Pkt->Data[PACKETLEN]]);
+                            } else {
+                                ReadStart = LengthInBuffer;
+                                for (int j = 0; j < LengthInBuffer; j ++) {
+                                    Pkt->Data[j] = Pkt->Data[i + j];
+                                }
+                                printf(PANEL_NAME "Partial Packet Read");
+                            }
+                        }
+                    } else {
+                        if (LengthInBuffer < 0) {
+                            if (errno != EINTR) {
+                                printf(PANEL_NAME "recv");
+                                NoError = FALSE;
+                            }
+                        } else {
+                            printf(PANEL_NAME "closed connection\n");
+                            NoError = FALSE;
+                        }
+                    }
+                }
+            } else if (select_res == 0) {
+                NoData = true;
+            } else if (errno != EINTR) {
+#ifdef __MINGW32__
+                closesocket(h->socket);
+#else
+                close(h->socket);
+#endif
+                h->socket = - 1; /* act like we never connected */
+                perror(PANEL_NAME "select error");
+                NoError = FALSE;
+            }
+        }
+    }
+
+    free(PktPtr);
+
+    return NewData;
+}
+
+void panel_send_read_command(panel_connection_t* h)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = 4;
+    Pkt.Data[PACKETTYPE] = READREQ;
+
+    panel_command(h, &Pkt);
+}
+
+/* Set a pin to a specified value */
+void senddatatopanel(panel_connection_t* h, uint64_t pin, bool val)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *) &Pkt.Data[6 + 1]-(char *) &Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = PINSTOPANEL;
+    Pkt.Data[2] = (unsigned short int) (pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int) ((pin >> 16)&0xFFFF);
+    Pkt.Data[4] = (unsigned short int) (pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int) ((pin >> 48)&0xFFFF);
+    Pkt.Data[6] = val;
+
+    panel_command(h, &Pkt);
+}
+
+void sendpincount(panel_connection_t* h, int val)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *) &Pkt.Data[2 + 1]-(char *) &Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = PINCOUNT;
+    Pkt.Data[2] = val;
+
+    panel_command(h, &Pkt);
+}
+
+void sendenabledmap(panel_connection_t* h, uint64_t pin)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *) &Pkt.Data[5 + 1]-(char *) &Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = ENABLEMAP;
+    Pkt.Data[2] = (unsigned short int) (pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int) ((pin >> 16)&0xFFFF);
+    Pkt.Data[4] = (unsigned short int) (pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int) ((pin >> 48)&0xFFFF);
+
+    panel_command(h, &Pkt);
+}
+
+void sendinputmap(panel_connection_t* h, uint64_t pin)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *) &Pkt.Data[5 + 1]-(char *) &Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = INPUTMAP;
+    Pkt.Data[2] = (unsigned short int) (pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int) ((pin >> 16)&0xFFFF);
+    Pkt.Data[4] = (unsigned short int) (pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int) ((pin >> 48)&0xFFFF);
+
+    panel_command(h, &Pkt);
+}
+
+void sendoutputmap(panel_connection_t* h, uint64_t pin)
+{
+    CommandPacket Pkt;
+
+    Pkt.Data[PACKETLEN] = (char *) &Pkt.Data[5 + 1]-(char *) &Pkt.Data[0];
+    Pkt.Data[PACKETTYPE] = OUTPUTMAP;
+    Pkt.Data[2] = (unsigned short int) (pin & 0xFFFF);
+    Pkt.Data[3] = (unsigned short int) ((pin >> 16)&0xFFFF);
+    Pkt.Data[4] = (unsigned short int) (pin >> 32 & 0xFFFF);
+    Pkt.Data[5] = (unsigned short int) ((pin >> 48)&0xFFFF);
+
+    panel_command(h, &Pkt);
+}
+
-- 
2.13.0.windows.1
