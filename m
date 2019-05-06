Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6479C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE1D205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE1D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZ9m-0006e7-Qi
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:39:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5X-0002xU-58
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hNZ5T-0007Os-GX
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:60084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hNZ5R-0007M1-Bf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 May 2019 01:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; d="scan'208";a="155407123"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by FMSMGA003.fm.intel.com with ESMTP; 06 May 2019 01:34:58 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 16:33:15 +0800
Message-Id: <1557131596-25403-10-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH v2 09/10] cpu/topology: add hw/arm support for
 smp machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the replace rules, the global smp variables in arm
are replaced with smp machine properties. The init_cpus() and
xlnx_zynqmp_create_rpu() are refactored to pass MachineState.
No semantic changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
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
 hw/arm/vexpress.c      | 12 ++++++++----
 hw/arm/virt.c          |  8 +++++++-
 hw/arm/xlnx-zynqmp.c   | 16 ++++++++++------
 target/arm/cpu.c       |  8 +++++++-
 13 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7b7b97f..ed772d5 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
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
index 4b56bfa..74b8ecb 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/misc/unimp.h"
+#include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 
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
index 7663ad6..71cc414 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -23,6 +23,7 @@
 #include "qemu-common.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/misc/unimp.h"
+#include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 
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
index 96ccf18..f3b1712 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -240,6 +240,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     SysBusDevice *busdev;
     qemu_irq pic[128];
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
     qemu_irq cpu_irq[4];
     qemu_irq cpu_fiq[4];
     qemu_irq cpu_virq[4];
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index fb2b015..47c44dd 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -43,7 +43,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
         .kernel_filename = machine->kernel_filename,
         .kernel_cmdline = machine->kernel_cmdline,
         .initrd_filename = machine->initrd_filename,
-        .nb_cpus = smp_cpus,
+        .nb_cpus = machine->smp.cpus,
     };
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc,  sizeof(s->soc),
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 9c5f0e7..a8df0cc 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -46,7 +46,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .kernel_filename = machine->kernel_filename,
         .kernel_cmdline = machine->kernel_cmdline,
         .initrd_filename = machine->initrd_filename,
-        .nb_cpus = smp_cpus,
+        .nb_cpus = machine->smp.cpus,
     };
 
     object_initialize(&s->soc, sizeof(s->soc), TYPE_FSL_IMX7);
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 66899c2..3862976 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -116,7 +116,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
 
     binfo.board_id = raspi_boardid[version];
     binfo.ram_size = ram_size;
-    binfo.nb_cpus = smp_cpus;
+    binfo.nb_cpus = machine->smp.cpus;
 
     if (version <= 2) {
         /* The rpi1 and 2 require some custom setup code to run in Secure
@@ -189,7 +189,7 @@ static void raspi_init(MachineState *machine, int version)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
+    object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled-cpus",
                             &error_abort);
     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 05a244d..f470f21 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -70,6 +70,7 @@ static void realview_init(MachineState *machine,
     NICInfo *nd;
     I2CBus *i2c;
     int n;
+    unsigned int smp_cpus = machine->smp.cpus;
     int done_nic = 0;
     qemu_irq cpu_irq[4];
     int is_mpcore = 0;
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index ee140e5..f9e7dc5 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -107,7 +107,7 @@ static void sabrelite_init(MachineState *machine)
     sabrelite_binfo.kernel_filename = machine->kernel_filename;
     sabrelite_binfo.kernel_cmdline = machine->kernel_cmdline;
     sabrelite_binfo.initrd_filename = machine->initrd_filename;
-    sabrelite_binfo.nb_cpus = smp_cpus;
+    sabrelite_binfo.nb_cpus = machine->smp.cpus;
     sabrelite_binfo.secure_boot = true;
     sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 19273a2..6d93d9f 100644
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
index 1b02ba4..002c083 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -555,11 +555,13 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
 
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
@@ -984,13 +986,14 @@ static void create_flash(const VirtMachineState *vms,
 
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
@@ -1423,6 +1426,8 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
     bool aarch64 = true;
+    unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int max_cpus = machine->smp.max_cpus;
 
     /*
      * In accelerated mode, the memory map is computed earlier in kvm_type()
@@ -1786,6 +1791,7 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
     VirtMachineState *vms = VIRT_MACHINE(ms);
 
     if (ms->possible_cpus) {
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 4f8bc41..fc8e1a9 100644
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
index a181fa8..d33e3f1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -29,6 +29,7 @@
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
+#include "hw/boards.h"
 #endif
 #include "hw/arm/arm.h"
 #include "sysemu/sysemu.h"
@@ -1194,6 +1195,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     init_cpreg_list(cpu);
 
 #ifndef CONFIG_USER_ONLY
+    MachineState *ms = MACHINE(qdev_get_machine());
+    unsigned int smp_cpus = ms->smp.cpus;
+
     if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         cs->num_ases = 2;
 
@@ -1732,10 +1736,12 @@ static void cortex_a9_initfn(Object *obj)
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
1.8.3.1


