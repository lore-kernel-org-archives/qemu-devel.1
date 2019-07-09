Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A338C606D7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032A020449
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032A020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkPi-0008GR-8R
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hkkOD-0006b8-Gv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hkkOA-0007UV-Ai
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:58440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hkkO9-0007TZ-UK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jul 2019 00:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; d="scan'208";a="165681639"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2019 00:18:06 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Tue,  9 Jul 2019 15:15:07 +0800
Message-Id: <20190709071520.8745-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709071520.8745-1-tao3.xu@intel.com>
References: <20190709071520.8745-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [PATCH RESEND v6 01/14] hw/arm: simplify arm_load_dtb
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In struct arm_boot_info, kernel_filename, initrd_filename and
kernel_cmdline are copied from from MachineState. This patch add
MachineState as a parameter into arm_load_dtb() and move the copy chunk
of kernel_filename, initrd_filename and kernel_cmdline into
arm_load_kernel().

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v6:
    - rebase to upstream, move the copy chunk of kernel_filename
      arm_load_kernel() in arm/sbsa-ref
---
 hw/arm/aspeed.c           |  5 +----
 hw/arm/boot.c             | 14 ++++++++------
 hw/arm/collie.c           |  8 +-------
 hw/arm/cubieboard.c       |  5 +----
 hw/arm/exynos4_boards.c   |  7 ++-----
 hw/arm/highbank.c         |  8 +-------
 hw/arm/imx25_pdk.c        |  5 +----
 hw/arm/integratorcp.c     |  8 +-------
 hw/arm/kzm.c              |  5 +----
 hw/arm/mainstone.c        |  5 +----
 hw/arm/mcimx6ul-evk.c     |  5 +----
 hw/arm/mcimx7d-sabre.c    |  5 +----
 hw/arm/musicpal.c         |  8 +-------
 hw/arm/nseries.c          |  5 +----
 hw/arm/omap_sx1.c         |  5 +----
 hw/arm/palm.c             | 10 ++--------
 hw/arm/raspi.c            |  6 +-----
 hw/arm/realview.c         |  5 +----
 hw/arm/sabrelite.c        |  5 +----
 hw/arm/sbsa-ref.c         |  3 +--
 hw/arm/spitz.c            |  5 +----
 hw/arm/tosa.c             |  8 +-------
 hw/arm/versatilepb.c      |  5 +----
 hw/arm/vexpress.c         |  5 +----
 hw/arm/virt.c             |  8 +++-----
 hw/arm/xilinx_zynq.c      |  8 +-------
 hw/arm/xlnx-versal-virt.c |  7 ++-----
 hw/arm/xlnx-zcu102.c      |  5 +----
 hw/arm/z2.c               |  8 +-------
 include/hw/arm/boot.h     |  4 ++--
 30 files changed, 43 insertions(+), 147 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 843b708247..f8733b86b9 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -241,9 +241,6 @@ static void aspeed_board_init(MachineState *machine,
         write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
     }
 
-    aspeed_board_binfo.kernel_filename = machine->kernel_filename;
-    aspeed_board_binfo.initrd_filename = machine->initrd_filename;
-    aspeed_board_binfo.kernel_cmdline = machine->kernel_cmdline;
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->info->memmap[ASPEED_SDRAM];
     aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
@@ -252,7 +249,7 @@ static void aspeed_board_init(MachineState *machine,
         cfg->i2c_init(bmc);
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
 
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1fb24fbef2..a90151f465 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -524,7 +524,7 @@ static void fdt_add_psci_node(void *fdt)
 }
 
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as)
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms)
 {
     void *fdt = NULL;
     int size, rc, n = 0;
@@ -627,9 +627,9 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         qemu_fdt_add_subnode(fdt, "/chosen");
     }
 
-    if (binfo->kernel_cmdline && *binfo->kernel_cmdline) {
+    if (ms->kernel_cmdline && *ms->kernel_cmdline) {
         rc = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                                     binfo->kernel_cmdline);
+                                     ms->kernel_cmdline);
         if (rc < 0) {
             fprintf(stderr, "couldn't set /chosen/bootargs\n");
             goto fail;
@@ -1244,7 +1244,7 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
      */
 }
 
-void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
+void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 {
     CPUState *cs;
     AddressSpace *as = arm_boot_address_space(cpu, info);
@@ -1265,7 +1265,9 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
      * doesn't support secure.
      */
     assert(!(info->secure_board_setup && kvm_enabled()));
-
+    info->kernel_filename = ms->kernel_filename;
+    info->kernel_cmdline = ms->kernel_cmdline;
+    info->initrd_filename = ms->initrd_filename;
     info->dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
     info->dtb_limit = 0;
 
@@ -1277,7 +1279,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     }
 
     if (!info->skip_dtb_autoload && have_dtb(info)) {
-        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
+        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
             exit(1);
         }
     }
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 3db3c56004..72bc8f26e5 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -26,9 +26,6 @@ static struct arm_boot_info collie_binfo = {
 
 static void collie_init(MachineState *machine)
 {
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     StrongARMState *s;
     DriveInfo *dinfo;
     MemoryRegion *sysmem = get_system_memory();
@@ -47,11 +44,8 @@ static void collie_init(MachineState *machine)
 
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
-    collie_binfo.kernel_filename = kernel_filename;
-    collie_binfo.kernel_cmdline = kernel_cmdline;
-    collie_binfo.initrd_filename = initrd_filename;
     collie_binfo.board_id = 0x208;
-    arm_load_kernel(s->cpu, &collie_binfo);
+    arm_load_kernel(s->cpu, machine, &collie_binfo);
 }
 
 static void collie_machine_init(MachineClass *mc)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index f7c8a5985a..d992fa087a 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -72,10 +72,7 @@ static void cubieboard_init(MachineState *machine)
     /* TODO create and connect IDE devices for ide_drive_get() */
 
     cubieboard_binfo.ram_size = machine->ram_size;
-    cubieboard_binfo.kernel_filename = machine->kernel_filename;
-    cubieboard_binfo.kernel_cmdline = machine->kernel_cmdline;
-    cubieboard_binfo.initrd_filename = machine->initrd_filename;
-    arm_load_kernel(&s->a10->cpu, &cubieboard_binfo);
+    arm_load_kernel(&s->a10->cpu, machine, &cubieboard_binfo);
 }
 
 static void cubieboard_machine_init(MachineClass *mc)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index ac0b0dc2a9..da402d5216 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -120,9 +120,6 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_board_binfo.board_id = exynos4_board_id[board_type];
     exynos4_board_binfo.smp_bootreg_addr =
             exynos4_board_smp_bootreg_addr[board_type];
-    exynos4_board_binfo.kernel_filename = machine->kernel_filename;
-    exynos4_board_binfo.initrd_filename = machine->initrd_filename;
-    exynos4_board_binfo.kernel_cmdline = machine->kernel_cmdline;
     exynos4_board_binfo.gic_cpu_if_addr =
             EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
 
@@ -141,7 +138,7 @@ static void nuri_init(MachineState *machine)
 {
     exynos4_boards_init_common(machine, EXYNOS4_BOARD_NURI);
 
-    arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &exynos4_board_binfo);
 }
 
 static void smdkc210_init(MachineState *machine)
@@ -151,7 +148,7 @@ static void smdkc210_init(MachineState *machine)
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
-    arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &exynos4_board_binfo);
 }
 
 static void nuri_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index def0f1ce6a..1a35b6d82f 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -234,9 +234,6 @@ enum cxmachines {
 static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     DeviceState *dev = NULL;
     SysBusDevice *busdev;
     qemu_irq pic[128];
@@ -388,9 +385,6 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     /* TODO create and connect IDE devices for ide_drive_get() */
 
     highbank_binfo.ram_size = ram_size;
-    highbank_binfo.kernel_filename = kernel_filename;
-    highbank_binfo.kernel_cmdline = kernel_cmdline;
-    highbank_binfo.initrd_filename = initrd_filename;
     /* highbank requires a dtb in order to boot, and the dtb will override
      * the board ID. The following value is ignored, so set it to -1 to be
      * clear that the value is meaningless.
@@ -410,7 +404,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
                     "may not boot.");
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), &highbank_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &highbank_binfo);
 }
 
 static void highbank_init(MachineState *machine)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 5d673e47bc..c76fc2bd94 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -116,9 +116,6 @@ static void imx25_pdk_init(MachineState *machine)
     }
 
     imx25_pdk_binfo.ram_size = machine->ram_size;
-    imx25_pdk_binfo.kernel_filename = machine->kernel_filename;
-    imx25_pdk_binfo.kernel_cmdline = machine->kernel_cmdline;
-    imx25_pdk_binfo.initrd_filename = machine->initrd_filename;
     imx25_pdk_binfo.loader_start = FSL_IMX25_SDRAM0_ADDR;
     imx25_pdk_binfo.board_id = 1771,
     imx25_pdk_binfo.nb_cpus = 1;
@@ -129,7 +126,7 @@ static void imx25_pdk_init(MachineState *machine)
      * fail.
      */
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, &imx25_pdk_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &imx25_pdk_binfo);
     }
 }
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 200c0107f0..4d9e9c9e49 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -578,9 +578,6 @@ static struct arm_boot_info integrator_binfo = {
 static void integratorcp_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
@@ -650,10 +647,7 @@ static void integratorcp_init(MachineState *machine)
     sysbus_create_simple("pl110", 0xc0000000, pic[22]);
 
     integrator_binfo.ram_size = ram_size;
-    integrator_binfo.kernel_filename = kernel_filename;
-    integrator_binfo.kernel_cmdline = kernel_cmdline;
-    integrator_binfo.initrd_filename = initrd_filename;
-    arm_load_kernel(cpu, &integrator_binfo);
+    arm_load_kernel(cpu, machine, &integrator_binfo);
 }
 
 static void integratorcp_machine_init(MachineClass *mc)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 59d2102dc5..5ff419a555 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -126,13 +126,10 @@ static void kzm_init(MachineState *machine)
     }
 
     kzm_binfo.ram_size = machine->ram_size;
-    kzm_binfo.kernel_filename = machine->kernel_filename;
-    kzm_binfo.kernel_cmdline = machine->kernel_cmdline;
-    kzm_binfo.initrd_filename = machine->initrd_filename;
     kzm_binfo.nb_cpus = 1;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, &kzm_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &kzm_binfo);
     }
 }
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index cd1f904c6c..c76cfb5dd1 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -177,11 +177,8 @@ static void mainstone_common_init(MemoryRegion *address_space_mem,
     smc91c111_init(&nd_table[0], MST_ETH_PHYS,
                     qdev_get_gpio_in(mst_irq, ETHERNET_IRQ));
 
-    mainstone_binfo.kernel_filename = machine->kernel_filename;
-    mainstone_binfo.kernel_cmdline = machine->kernel_cmdline;
-    mainstone_binfo.initrd_filename = machine->initrd_filename;
     mainstone_binfo.board_id = arm_id;
-    arm_load_kernel(mpu->cpu, &mainstone_binfo);
+    arm_load_kernel(mpu->cpu, machine, &mainstone_binfo);
 }
 
 static void mainstone_init(MachineState *machine)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index bbffb11c2a..ff3e8ade8a 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -39,9 +39,6 @@ static void mcimx6ul_evk_init(MachineState *machine)
         .loader_start = FSL_IMX6UL_MMDC_ADDR,
         .board_id = -1,
         .ram_size = machine->ram_size,
-        .kernel_filename = machine->kernel_filename,
-        .kernel_cmdline = machine->kernel_cmdline,
-        .initrd_filename = machine->initrd_filename,
         .nb_cpus = machine->smp.cpus,
     };
 
@@ -71,7 +68,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], &boot_info);
+        arm_load_kernel(&s->soc.cpu[0], machine, &boot_info);
     }
 }
 
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 72eab03a0c..3123d8767f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -42,9 +42,6 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .loader_start = FSL_IMX7_MMDC_ADDR,
         .board_id = -1,
         .ram_size = machine->ram_size,
-        .kernel_filename = machine->kernel_filename,
-        .kernel_cmdline = machine->kernel_cmdline,
-        .initrd_filename = machine->initrd_filename,
         .nb_cpus = machine->smp.cpus,
     };
 
@@ -74,7 +71,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], &boot_info);
+        arm_load_kernel(&s->soc.cpu[0], machine, &boot_info);
     }
 }
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 95d56f3208..a53ee12737 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1568,9 +1568,6 @@ static struct arm_boot_info musicpal_binfo = {
 
 static void musicpal_init(MachineState *machine)
 {
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     ARMCPU *cpu;
     qemu_irq pic[32];
     DeviceState *dev;
@@ -1699,10 +1696,7 @@ static void musicpal_init(MachineState *machine)
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
 
     musicpal_binfo.ram_size = MP_RAM_DEFAULT_SIZE;
-    musicpal_binfo.kernel_filename = kernel_filename;
-    musicpal_binfo.kernel_cmdline = kernel_cmdline;
-    musicpal_binfo.initrd_filename = initrd_filename;
-    arm_load_kernel(cpu, &musicpal_binfo);
+    arm_load_kernel(cpu, machine, &musicpal_binfo);
 }
 
 static void musicpal_machine_init(MachineClass *mc)
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 4a79f5c88b..31dd2f1b51 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1358,10 +1358,7 @@ static void n8x0_init(MachineState *machine,
 
     if (machine->kernel_filename) {
         /* Or at the linux loader.  */
-        binfo->kernel_filename = machine->kernel_filename;
-        binfo->kernel_cmdline = machine->kernel_cmdline;
-        binfo->initrd_filename = machine->initrd_filename;
-        arm_load_kernel(s->mpu->cpu, binfo);
+        arm_load_kernel(s->mpu->cpu, machine, binfo);
 
         qemu_register_reset(n8x0_boot_init, s);
     }
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index cae78d0a36..3cc2817f06 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -196,10 +196,7 @@ static void sx1_init(MachineState *machine, const int version)
     }
 
     /* Load the kernel.  */
-    sx1_binfo.kernel_filename = machine->kernel_filename;
-    sx1_binfo.kernel_cmdline = machine->kernel_cmdline;
-    sx1_binfo.initrd_filename = machine->initrd_filename;
-    arm_load_kernel(mpu->cpu, &sx1_binfo);
+    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
 
     /* TODO: fix next line */
     //~ qemu_console_resize(ds, 640, 480);
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 9eb9612bce..67ab30b5bc 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -186,9 +186,6 @@ static struct arm_boot_info palmte_binfo = {
 
 static void palmte_init(MachineState *machine)
 {
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     MemoryRegion *address_space_mem = get_system_memory();
     struct omap_mpu_state_s *mpu;
     int flash_size = 0x00800000;
@@ -248,16 +245,13 @@ static void palmte_init(MachineState *machine)
         }
     }
 
-    if (!rom_loaded && !kernel_filename && !qtest_enabled()) {
+    if (!rom_loaded && !machine->kernel_filename && !qtest_enabled()) {
         fprintf(stderr, "Kernel or ROM image must be specified\n");
         exit(1);
     }
 
     /* Load the kernel.  */
-    palmte_binfo.kernel_filename = kernel_filename;
-    palmte_binfo.kernel_cmdline = kernel_cmdline;
-    palmte_binfo.initrd_filename = initrd_filename;
-    arm_load_kernel(mpu->cpu, &palmte_binfo);
+    arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
 }
 
 static void palmte_machine_init(MachineClass *mc)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 5b2620acb4..74c062d05e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -157,13 +157,9 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
 
         binfo.entry = firmware_addr;
         binfo.firmware_loaded = true;
-    } else {
-        binfo.kernel_filename = machine->kernel_filename;
-        binfo.kernel_cmdline = machine->kernel_cmdline;
-        binfo.initrd_filename = machine->initrd_filename;
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), &binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
 
 static void raspi_init(MachineState *machine, int version)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 7c56c8d2ed..5a3e65ddd6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -350,13 +350,10 @@ static void realview_init(MachineState *machine,
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
     realview_binfo.ram_size = ram_size;
-    realview_binfo.kernel_filename = machine->kernel_filename;
-    realview_binfo.kernel_cmdline = machine->kernel_cmdline;
-    realview_binfo.initrd_filename = machine->initrd_filename;
     realview_binfo.nb_cpus = smp_cpus;
     realview_binfo.board_id = realview_board_id[board_type];
     realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
-    arm_load_kernel(ARM_CPU(first_cpu), &realview_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &realview_binfo);
 }
 
 static void realview_eb_init(MachineState *machine)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 934f4c9261..8f4b68e14c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -102,16 +102,13 @@ static void sabrelite_init(MachineState *machine)
     }
 
     sabrelite_binfo.ram_size = machine->ram_size;
-    sabrelite_binfo.kernel_filename = machine->kernel_filename;
-    sabrelite_binfo.kernel_cmdline = machine->kernel_cmdline;
-    sabrelite_binfo.initrd_filename = machine->initrd_filename;
     sabrelite_binfo.nb_cpus = machine->smp.cpus;
     sabrelite_binfo.secure_boot = true;
     sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
     }
 }
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c67d5c6f9..2aba3c58c5 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -709,13 +709,12 @@ static void sbsa_ref_init(MachineState *machine)
     create_pcie(sms, pic);
 
     sms->bootinfo.ram_size = machine->ram_size;
-    sms->bootinfo.kernel_filename = machine->kernel_filename;
     sms->bootinfo.nb_cpus = smp_cpus;
     sms->bootinfo.board_id = -1;
     sms->bootinfo.loader_start = sbsa_ref_memmap[SBSA_MEM].base;
     sms->bootinfo.get_dtb = sbsa_ref_dtb;
     sms->bootinfo.firmware_loaded = firmware_loaded;
-    arm_load_kernel(ARM_CPU(first_cpu), &sms->bootinfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &sms->bootinfo);
 }
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 723cf5d592..42338696b3 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -951,11 +951,8 @@ static void spitz_common_init(MachineState *machine,
         /* A 4.0 GB microdrive is permanently sitting in CF slot 0.  */
         spitz_microdrive_attach(mpu, 0);
 
-    spitz_binfo.kernel_filename = machine->kernel_filename;
-    spitz_binfo.kernel_cmdline = machine->kernel_cmdline;
-    spitz_binfo.initrd_filename = machine->initrd_filename;
     spitz_binfo.board_id = arm_id;
-    arm_load_kernel(mpu->cpu, &spitz_binfo);
+    arm_load_kernel(mpu->cpu, machine, &spitz_binfo);
     sl_bootparam_write(SL_PXA_PARAM_BASE);
 }
 
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 7843d68d46..3a1de81278 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -218,9 +218,6 @@ static struct arm_boot_info tosa_binfo = {
 
 static void tosa_init(MachineState *machine)
 {
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *rom = g_new(MemoryRegion, 1);
     PXA2xxState *mpu;
@@ -245,11 +242,8 @@ static void tosa_init(MachineState *machine)
 
     tosa_tg_init(mpu);
 
-    tosa_binfo.kernel_filename = kernel_filename;
-    tosa_binfo.kernel_cmdline = kernel_cmdline;
-    tosa_binfo.initrd_filename = initrd_filename;
     tosa_binfo.board_id = 0x208;
-    arm_load_kernel(mpu->cpu, &tosa_binfo);
+    arm_load_kernel(mpu->cpu, machine, &tosa_binfo);
     sl_bootparam_write(SL_PXA_PARAM_BASE);
 }
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e5857117ac..d3c3c00f55 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -373,11 +373,8 @@ static void versatile_init(MachineState *machine, int board_id)
     }
 
     versatile_binfo.ram_size = machine->ram_size;
-    versatile_binfo.kernel_filename = machine->kernel_filename;
-    versatile_binfo.kernel_cmdline = machine->kernel_cmdline;
-    versatile_binfo.initrd_filename = machine->initrd_filename;
     versatile_binfo.board_id = board_id;
-    arm_load_kernel(cpu, &versatile_binfo);
+    arm_load_kernel(cpu, machine, &versatile_binfo);
 }
 
 static void vpb_init(MachineState *machine)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5d932c27c0..4673a88a8d 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -707,9 +707,6 @@ static void vexpress_common_init(MachineState *machine)
     }
 
     daughterboard->bootinfo.ram_size = machine->ram_size;
-    daughterboard->bootinfo.kernel_filename = machine->kernel_filename;
-    daughterboard->bootinfo.kernel_cmdline = machine->kernel_cmdline;
-    daughterboard->bootinfo.initrd_filename = machine->initrd_filename;
     daughterboard->bootinfo.nb_cpus = machine->smp.cpus;
     daughterboard->bootinfo.board_id = VEXPRESS_BOARD_ID;
     daughterboard->bootinfo.loader_start = daughterboard->loader_start;
@@ -719,7 +716,7 @@ static void vexpress_common_init(MachineState *machine)
     daughterboard->bootinfo.modify_dtb = vexpress_modify_dtb;
     /* When booting Linux we should be in secure state if the CPU has one. */
     daughterboard->bootinfo.secure_boot = vms->secure;
-    arm_load_kernel(ARM_CPU(first_cpu), &daughterboard->bootinfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &daughterboard->bootinfo);
 }
 
 static bool vexpress_get_secure(Object *obj, Error **errp)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b5138cb22..9b380504b6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1364,6 +1364,7 @@ void virt_machine_done(Notifier *notifier, void *data)
 {
     VirtMachineState *vms = container_of(notifier, VirtMachineState,
                                          machine_done);
+    MachineState *ms = MACHINE(vms);
     ARMCPU *cpu = ARM_CPU(first_cpu);
     struct arm_boot_info *info = &vms->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
@@ -1381,7 +1382,7 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
-    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
+    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
         exit(1);
     }
 
@@ -1707,16 +1708,13 @@ static void machvirt_init(MachineState *machine)
     create_platform_bus(vms, pic);
 
     vms->bootinfo.ram_size = machine->ram_size;
-    vms->bootinfo.kernel_filename = machine->kernel_filename;
-    vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
-    vms->bootinfo.initrd_filename = machine->initrd_filename;
     vms->bootinfo.nb_cpus = smp_cpus;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
     vms->bootinfo.get_dtb = machvirt_dtb;
     vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
-    arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&vms->machine_done);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 89da34808b..c14774e542 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -158,9 +158,6 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 static void zynq_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
@@ -303,16 +300,13 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
     zynq_binfo.ram_size = ram_size;
-    zynq_binfo.kernel_filename = kernel_filename;
-    zynq_binfo.kernel_cmdline = kernel_cmdline;
-    zynq_binfo.initrd_filename = initrd_filename;
     zynq_binfo.nb_cpus = 1;
     zynq_binfo.board_id = 0xd32;
     zynq_binfo.loader_start = 0;
     zynq_binfo.board_setup_addr = BOARD_SETUP_ADDR;
     zynq_binfo.write_board_setup = zynq_write_board_setup;
 
-    arm_load_kernel(ARM_CPU(first_cpu), &zynq_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &zynq_binfo);
 }
 
 static void zynq_machine_init(MachineClass *mc)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index f95fde2309..462493c467 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -441,14 +441,11 @@ static void versal_virt_init(MachineState *machine)
                                         0, &s->soc.fpd.apu.mr, 0);
 
     s->binfo.ram_size = machine->ram_size;
-    s->binfo.kernel_filename = machine->kernel_filename;
-    s->binfo.kernel_cmdline = machine->kernel_cmdline;
-    s->binfo.initrd_filename = machine->initrd_filename;
     s->binfo.loader_start = 0x0;
     s->binfo.get_dtb = versal_virt_get_dtb;
     s->binfo.modify_dtb = versal_virt_modify_dtb;
     if (machine->kernel_filename) {
-        arm_load_kernel(s->soc.fpd.apu.cpu[0], &s->binfo);
+        arm_load_kernel(s->soc.fpd.apu.cpu[0], machine, &s->binfo);
     } else {
         AddressSpace *as = arm_boot_address_space(s->soc.fpd.apu.cpu[0],
                                                   &s->binfo);
@@ -457,7 +454,7 @@ static void versal_virt_init(MachineState *machine)
         s->binfo.loader_start = 0x1000;
         s->binfo.dtb_limit = 0x1000000;
         if (arm_load_dtb(s->binfo.loader_start,
-                         &s->binfo, s->binfo.dtb_limit, as) < 0) {
+                         &s->binfo, s->binfo.dtb_limit, as, machine) < 0) {
             exit(EXIT_FAILURE);
         }
     }
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 044d3394c0..53cfe7c1f1 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -171,11 +171,8 @@ static void xlnx_zcu102_init(MachineState *machine)
     /* TODO create and connect IDE devices for ide_drive_get() */
 
     xlnx_zcu102_binfo.ram_size = ram_size;
-    xlnx_zcu102_binfo.kernel_filename = machine->kernel_filename;
-    xlnx_zcu102_binfo.kernel_cmdline = machine->kernel_cmdline;
-    xlnx_zcu102_binfo.initrd_filename = machine->initrd_filename;
     xlnx_zcu102_binfo.loader_start = 0;
-    arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
+    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &xlnx_zcu102_binfo);
 }
 
 static void xlnx_zcu102_machine_instance_init(Object *obj)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 44aa748d39..2f21421683 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -296,9 +296,6 @@ static const TypeInfo aer915_info = {
 
 static void z2_init(MachineState *machine)
 {
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     MemoryRegion *address_space_mem = get_system_memory();
     uint32_t sector_len = 0x10000;
     PXA2xxState *mpu;
@@ -352,11 +349,8 @@ static void z2_init(MachineState *machine)
     qdev_connect_gpio_out(mpu->gpio, Z2_GPIO_LCD_CS,
                           qemu_allocate_irq(z2_lcd_cs, z2_lcd, 0));
 
-    z2_binfo.kernel_filename = kernel_filename;
-    z2_binfo.kernel_cmdline = kernel_cmdline;
-    z2_binfo.initrd_filename = initrd_filename;
     z2_binfo.board_id = 0x6dd;
-    arm_load_kernel(mpu->cpu, &z2_binfo);
+    arm_load_kernel(mpu->cpu, machine, &z2_binfo);
 }
 
 static void z2_machine_init(MachineClass *mc)
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index c48cc4c2bc..2673abe81f 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -133,7 +133,7 @@ struct arm_boot_info {
  * before sysbus-fdt arm_register_platform_bus_fdt_creator. Indeed the
  * machine init done notifiers are called in registration reverse order.
  */
-void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info);
+void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info);
 
 AddressSpace *arm_boot_address_space(ARMCPU *cpu,
                                      const struct arm_boot_info *info);
@@ -160,7 +160,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * Note: Must not be called unless have_dtb(binfo) is true.
  */
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as);
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms);
 
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
-- 
2.20.1


