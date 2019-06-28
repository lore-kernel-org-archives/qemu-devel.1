Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F095C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1872064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1872064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggI3-0002NZ-8H
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgg7x-0000Pi-MW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgg7u-0007zp-TP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgg7u-0007xV-IF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6123308424E;
 Fri, 28 Jun 2019 01:56:33 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D543060BE0;
 Fri, 28 Jun 2019 01:56:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 27 Jun 2019 22:55:45 -0300
Message-Id: <20190628015606.32107-9-ehabkost@redhat.com>
In-Reply-To: <20190628015606.32107-1-ehabkost@redhat.com>
References: <20190628015606.32107-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 28 Jun 2019 01:56:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/29] hw/arm: Replace global smp variables with
 machine smp properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The global smp variables in arm are replaced with smp machine properties.
The init_cpus() and *_create_rpu() are refactored to pass MachineState.

A local variable of the same name would be introduced in the declaration
phase if it's used widely in the context OR replace it on the spot if it's
only used once. No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190518205428.90532-9-like.xu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/fsl-imx6.c      |  6 +++++-
 hw/arm/fsl-imx6ul.c    |  6 +++++-
 hw/arm/fsl-imx7.c      |  7 +++++--
 hw/arm/highbank.c      |  1 +
 hw/arm/mcimx6ul-evk.c  |  2 +-
 hw/arm/mcimx7d-sabre.c |  2 +-
 hw/arm/raspi.c         |  4 ++--
 hw/arm/realview.c      |  1 +
 hw/arm/sabrelite.c     |  2 +-
 hw/arm/vexpress.c      | 16 ++++++++++------
 hw/arm/virt.c          |  8 +++++++-
 hw/arm/xlnx-zynqmp.c   | 16 ++++++++++------
 target/arm/cpu.c       |  8 +++++++-
 13 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7129517378..de45833097 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
+#include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char.h"
 #include "qemu/error-report.h"
@@ -33,11 +34,12 @@
 
 static void fsl_imx6_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(obj);
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(smp_cpus, FSL_IMX6_NUM_CPUS); i++) {
+    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
         object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
                                 "cortex-a9-" TYPE_ARM_CPU, &error_abort, NULL);
@@ -93,9 +95,11 @@ static void fsl_imx6_init(Object *obj)
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
     Error *err = NULL;
+    unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 05505bac56..f860165438 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -20,6 +20,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/misc/unimp.h"
+#include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -28,11 +29,12 @@
 
 static void fsl_imx6ul_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(obj);
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
+    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6UL_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
         object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
                                 "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
@@ -156,10 +158,12 @@ static void fsl_imx6ul_init(Object *obj)
 
 static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(dev);
     int i;
     qemu_irq irq;
     char name[NAME_SIZE];
+    unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX6UL_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index b7e3526b4f..036a05176e 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/misc/unimp.h"
+#include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -30,12 +31,12 @@
 
 static void fsl_imx7_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(obj);
     char name[NAME_SIZE];
     int i;
 
-
-    for (i = 0; i < MIN(smp_cpus, FSL_IMX7_NUM_CPUS); i++) {
+    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX7_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
         object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
                                 ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort,
@@ -155,11 +156,13 @@ static void fsl_imx7_init(Object *obj)
 
 static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(dev);
     Object *o;
     int i;
     qemu_irq irq;
     char name[NAME_SIZE];
+    unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX7_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 72ca78108a..def0f1ce6a 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -241,6 +241,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     SysBusDevice *busdev;
     qemu_irq pic[128];
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
     qemu_irq cpu_irq[4];
     qemu_irq cpu_fiq[4];
     qemu_irq cpu_virq[4];
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 31511059e4..bbffb11c2a 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -42,7 +42,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
         .kernel_filename = machine->kernel_filename,
         .kernel_cmdline = machine->kernel_cmdline,
         .initrd_filename = machine->initrd_filename,
-        .nb_cpus = smp_cpus,
+        .nb_cpus = machine->smp.cpus,
     };
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc,  sizeof(s->soc),
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index d6b190d85d..72eab03a0c 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -45,7 +45,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .kernel_filename = machine->kernel_filename,
         .kernel_cmdline = machine->kernel_cmdline,
         .initrd_filename = machine->initrd_filename,
-        .nb_cpus = smp_cpus,
+        .nb_cpus = machine->smp.cpus,
     };
 
     object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX7);
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index cb23330940..5b2620acb4 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -116,7 +116,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
 
     binfo.board_id = raspi_boardid[version];
     binfo.ram_size = ram_size;
-    binfo.nb_cpus = smp_cpus;
+    binfo.nb_cpus = machine->smp.cpus;
 
     if (version <= 2) {
         /* The rpi1 and 2 require some custom setup code to run in Secure
@@ -194,7 +194,7 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
+    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled-cpus",
                             &error_abort);
     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 12d6e93a35..7c56c8d2ed 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -69,6 +69,7 @@ static void realview_init(MachineState *machine,
     NICInfo *nd;
     I2CBus *i2c;
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
     int done_nic = 0;
     qemu_irq cpu_irq[4];
     int is_mpcore = 0;
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 97230ac827..934f4c9261 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -105,7 +105,7 @@ static void sabrelite_init(MachineState *machine)
     sabrelite_binfo.kernel_filename = machine->kernel_filename;
     sabrelite_binfo.kernel_cmdline = machine->kernel_cmdline;
     sabrelite_binfo.initrd_filename = machine->initrd_filename;
-    sabrelite_binfo.nb_cpus = smp_cpus;
+    sabrelite_binfo.nb_cpus = machine->smp.cpus;
     sabrelite_binfo.secure_boot = true;
     sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 2b3b0c2334..5d932c27c0 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -203,12 +203,14 @@ struct VEDBoardInfo {
     DBoardInitFn *init;
 };
 
-static void init_cpus(const char *cpu_type, const char *privdev,
-                      hwaddr periphbase, qemu_irq *pic, bool secure, bool virt)
+static void init_cpus(MachineState *ms, const char *cpu_type,
+                      const char *privdev, hwaddr periphbase,
+                      qemu_irq *pic, bool secure, bool virt)
 {
     DeviceState *dev;
     SysBusDevice *busdev;
     int n;
+    unsigned int smp_cpus = ms->smp.cpus;
 
     /* Create the actual CPUs */
     for (n = 0; n < smp_cpus; n++) {
@@ -269,6 +271,7 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
                                   const char *cpu_type,
                                   qemu_irq *pic)
 {
+    MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *lowram = g_new(MemoryRegion, 1);
@@ -295,7 +298,7 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x60000000, ram);
 
     /* 0x1e000000 A9MPCore (SCU) private memory region */
-    init_cpus(cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
+    init_cpus(machine, cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
               vms->secure, vms->virt);
 
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
@@ -355,6 +358,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
                                    const char *cpu_type,
                                    qemu_irq *pic)
 {
+    MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
@@ -377,8 +381,8 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x80000000, ram);
 
     /* 0x2c000000 A15MPCore private memory region (GIC) */
-    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secure,
-              vms->virt);
+    init_cpus(machine, cpu_type, TYPE_A15MPCORE_PRIV,
+              0x2c000000, pic, vms->secure, vms->virt);
 
     /* A15 daughterboard peripherals: */
 
@@ -706,7 +710,7 @@ static void vexpress_common_init(MachineState *machine)
     daughterboard->bootinfo.kernel_filename = machine->kernel_filename;
     daughterboard->bootinfo.kernel_cmdline = machine->kernel_cmdline;
     daughterboard->bootinfo.initrd_filename = machine->initrd_filename;
-    daughterboard->bootinfo.nb_cpus = smp_cpus;
+    daughterboard->bootinfo.nb_cpus = machine->smp.cpus;
     daughterboard->bootinfo.board_id = VEXPRESS_BOARD_ID;
     daughterboard->bootinfo.loader_start = daughterboard->loader_start;
     daughterboard->bootinfo.smp_loader_start = map[VE_SRAM];
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4a0ac3baf0..026a5be18b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -558,11 +558,13 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
 
 static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 {
+    MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
     DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
     int type = vms->gic_version, i;
+    unsigned int smp_cpus = ms->smp.cpus;
     uint32_t nb_redist_regions = 0;
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
@@ -1038,13 +1040,14 @@ static bool virt_firmware_init(VirtMachineState *vms,
 
 static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
 {
+    MachineState *ms = MACHINE(vms);
     hwaddr base = vms->memmap[VIRT_FW_CFG].base;
     hwaddr size = vms->memmap[VIRT_FW_CFG].size;
     FWCfgState *fw_cfg;
     char *nodename;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
@@ -1477,6 +1480,8 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded;
     bool aarch64 = true;
+    unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int max_cpus = machine->smp.max_cpus;
 
     /*
      * In accelerated mode, the memory map is computed earlier in kvm_type()
@@ -1844,6 +1849,7 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
     VirtMachineState *vms = VIRT_MACHINE(ms);
 
     if (ms->possible_cpus) {
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index a1ca9b5adf..a60830d37a 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/intc/arm_gic_common.h"
+#include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
@@ -171,12 +172,13 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
     return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
-static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
-                                   Error **errp)
+static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
+                                   const char *boot_cpu, Error **errp)
 {
     Error *err = NULL;
     int i;
-    int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
+    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
 
     if (num_rpus <= 0) {
         /* Don't create rpu-cluster object if there's nothing to put in it */
@@ -221,9 +223,10 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
 
 static void xlnx_zynqmp_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
-    int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             sizeof(s->apu_cluster), TYPE_CPU_CLUSTER,
@@ -290,11 +293,12 @@ static void xlnx_zynqmp_init(Object *obj)
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     XlnxZynqMPState *s = XLNX_ZYNQMP(dev);
     MemoryRegion *system_memory = get_system_memory();
     uint8_t i;
     uint64_t ram_size;
-    int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
     qemu_irq gic_spi[GIC_NUM_SPI_INTR];
@@ -456,7 +460,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                     "RPUs just use -smp 6.");
     }
 
-    xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
+    xlnx_zynqmp_create_rpu(ms, s, boot_cpu, &err);
     if (err) {
         error_propagate(errp, err);
         return;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 376db154f0..73f7d9394d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
+#include "hw/boards.h"
 #endif
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
@@ -1361,6 +1362,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     init_cpreg_list(cpu);
 
 #ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
+
     if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         cs->num_ases = 2;
 
@@ -1901,10 +1905,12 @@ static void cortex_a9_initfn(Object *obj)
 #ifndef CONFIG_USER_ONLY
 static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+
     /* Linux wants the number of processors from here.
      * Might as well set the interrupt-controller bit too.
      */
-    return ((smp_cpus - 1) << 24) | (1 << 23);
+    return ((ms->smp.cpus - 1) << 24) | (1 << 23);
 }
 #endif
 
-- 
2.18.0.rc1.1.g3f1ff2140


