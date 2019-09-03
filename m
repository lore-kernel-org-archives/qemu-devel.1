Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD24620882
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD24620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GRf-0007Zh-2G
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwU-0004Hc-VY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwQ-0001Fy-8c
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwP-00018l-Gb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C68CC18005F6;
 Tue,  3 Sep 2019 21:02:07 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBDB7194B2;
 Tue,  3 Sep 2019 21:02:06 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:50 -0300
Message-Id: <20190903210201.14627-3-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 21:02:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 02/13] hw/arm: simplify arm_load_dtb
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

In struct arm_boot_info, kernel_filename, initrd_filename and
kernel_cmdline are copied from from MachineState. This patch add
MachineState as a parameter into arm_load_dtb() and move the copy chunk
of kernel_filename, initrd_filename and kernel_cmdline into
arm_load_kernel().

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20190809065731.9097-2-tao3.xu@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: C=C3=A9dric Le Goater <clg@kaod.org>
[ehabkost: include hw/boards.h again to fix build failures]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/boot.h     |  4 ++--
 hw/arm/aspeed.c           |  5 +----
 hw/arm/boot.c             | 15 +++++++++------
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
 30 files changed, 44 insertions(+), 147 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 5714dea1a2..7f4d0ca7cd 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -131,7 +131,7 @@ struct arm_boot_info {
  * before sysbus-fdt arm_register_platform_bus_fdt_creator. Indeed the
  * machine init done notifiers are called in registration reverse order.
  */
-void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info);
+void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info=
 *info);
=20
 AddressSpace *arm_boot_address_space(ARMCPU *cpu,
                                      const struct arm_boot_info *info);
@@ -158,7 +158,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * Note: Must not be called unless have_dtb(binfo) is true.
  */
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as);
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms);
=20
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 7a2e885e0b..13e208c78c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -242,9 +242,6 @@ static void aspeed_board_init(MachineState *machine,
         write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
     }
=20
-    aspeed_board_binfo.kernel_filename =3D machine->kernel_filename;
-    aspeed_board_binfo.initrd_filename =3D machine->initrd_filename;
-    aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
     aspeed_board_binfo.ram_size =3D ram_size;
     aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM];
     aspeed_board_binfo.nb_cpus =3D bmc->soc.num_cpus;
@@ -253,7 +250,7 @@ static void aspeed_board_init(MachineState *machine,
         cfg->i2c_init(bmc);
     }
=20
-    arm_load_kernel(ARM_CPU(first_cpu), &aspeed_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
 }
=20
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index eff89ab80e..b46eaefa2d 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "hw/boards.h"
 #include "sysemu/reset.h"
 #include "hw/loader.h"
 #include "elf.h"
@@ -523,7 +524,7 @@ static void fdt_add_psci_node(void *fdt)
 }
=20
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as)
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms)
 {
     void *fdt =3D NULL;
     int size, rc, n =3D 0;
@@ -626,9 +627,9 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
         qemu_fdt_add_subnode(fdt, "/chosen");
     }
=20
-    if (binfo->kernel_cmdline && *binfo->kernel_cmdline) {
+    if (ms->kernel_cmdline && *ms->kernel_cmdline) {
         rc =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                                     binfo->kernel_cmdline);
+                                     ms->kernel_cmdline);
         if (rc < 0) {
             fprintf(stderr, "couldn't set /chosen/bootargs\n");
             goto fail;
@@ -1260,7 +1261,7 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, st=
ruct arm_boot_info *info)
      */
 }
=20
-void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
+void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info=
 *info)
 {
     CPUState *cs;
     AddressSpace *as =3D arm_boot_address_space(cpu, info);
@@ -1281,7 +1282,9 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_i=
nfo *info)
      * doesn't support secure.
      */
     assert(!(info->secure_board_setup && kvm_enabled()));
-
+    info->kernel_filename =3D ms->kernel_filename;
+    info->kernel_cmdline =3D ms->kernel_cmdline;
+    info->initrd_filename =3D ms->initrd_filename;
     info->dtb_filename =3D qemu_opt_get(qemu_get_machine_opts(), "dtb");
     info->dtb_limit =3D 0;
=20
@@ -1293,7 +1296,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_i=
nfo *info)
     }
=20
     if (!info->skip_dtb_autoload && have_dtb(info)) {
-        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0=
) {
+        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms)=
 < 0) {
             exit(1);
         }
     }
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 219643c633..b1288ccea8 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -25,9 +25,6 @@ static struct arm_boot_info collie_binfo =3D {
=20
 static void collie_init(MachineState *machine)
 {
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     StrongARMState *s;
     DriveInfo *dinfo;
     MemoryRegion *sysmem =3D get_system_memory();
@@ -46,11 +43,8 @@ static void collie_init(MachineState *machine)
=20
     sysbus_create_simple("scoop", 0x40800000, NULL);
=20
-    collie_binfo.kernel_filename =3D kernel_filename;
-    collie_binfo.kernel_cmdline =3D kernel_cmdline;
-    collie_binfo.initrd_filename =3D initrd_filename;
     collie_binfo.board_id =3D 0x208;
-    arm_load_kernel(s->cpu, &collie_binfo);
+    arm_load_kernel(s->cpu, machine, &collie_binfo);
 }
=20
 static void collie_machine_init(MachineClass *mc)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 38e0ca0f53..1bef3cb9af 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -73,10 +73,7 @@ static void cubieboard_init(MachineState *machine)
     /* TODO create and connect IDE devices for ide_drive_get() */
=20
     cubieboard_binfo.ram_size =3D machine->ram_size;
-    cubieboard_binfo.kernel_filename =3D machine->kernel_filename;
-    cubieboard_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    cubieboard_binfo.initrd_filename =3D machine->initrd_filename;
-    arm_load_kernel(&s->a10->cpu, &cubieboard_binfo);
+    arm_load_kernel(&s->a10->cpu, machine, &cubieboard_binfo);
 }
=20
 static void cubieboard_machine_init(MachineClass *mc)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index f69358a5ba..be21f50387 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -122,9 +122,6 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_board_binfo.board_id =3D exynos4_board_id[board_type];
     exynos4_board_binfo.smp_bootreg_addr =3D
             exynos4_board_smp_bootreg_addr[board_type];
-    exynos4_board_binfo.kernel_filename =3D machine->kernel_filename;
-    exynos4_board_binfo.initrd_filename =3D machine->initrd_filename;
-    exynos4_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
     exynos4_board_binfo.gic_cpu_if_addr =3D
             EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
=20
@@ -143,7 +140,7 @@ static void nuri_init(MachineState *machine)
 {
     exynos4_boards_init_common(machine, EXYNOS4_BOARD_NURI);
=20
-    arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &exynos4_board_binfo);
 }
=20
 static void smdkc210_init(MachineState *machine)
@@ -153,7 +150,7 @@ static void smdkc210_init(MachineState *machine)
=20
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)])=
);
-    arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &exynos4_board_binfo);
 }
=20
 static void nuri_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 362e5ba044..f1724d6929 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -236,9 +236,6 @@ enum cxmachines {
 static void calxeda_init(MachineState *machine, enum cxmachines machine_=
id)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     DeviceState *dev =3D NULL;
     SysBusDevice *busdev;
     qemu_irq pic[128];
@@ -390,9 +387,6 @@ static void calxeda_init(MachineState *machine, enum =
cxmachines machine_id)
     /* TODO create and connect IDE devices for ide_drive_get() */
=20
     highbank_binfo.ram_size =3D ram_size;
-    highbank_binfo.kernel_filename =3D kernel_filename;
-    highbank_binfo.kernel_cmdline =3D kernel_cmdline;
-    highbank_binfo.initrd_filename =3D initrd_filename;
     /* highbank requires a dtb in order to boot, and the dtb will overri=
de
      * the board ID. The following value is ignored, so set it to -1 to =
be
      * clear that the value is meaningless.
@@ -412,7 +406,7 @@ static void calxeda_init(MachineState *machine, enum =
cxmachines machine_id)
                     "may not boot.");
     }
=20
-    arm_load_kernel(ARM_CPU(first_cpu), &highbank_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &highbank_binfo);
 }
=20
 static void highbank_init(MachineState *machine)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 5d673e47bc..c76fc2bd94 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -116,9 +116,6 @@ static void imx25_pdk_init(MachineState *machine)
     }
=20
     imx25_pdk_binfo.ram_size =3D machine->ram_size;
-    imx25_pdk_binfo.kernel_filename =3D machine->kernel_filename;
-    imx25_pdk_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    imx25_pdk_binfo.initrd_filename =3D machine->initrd_filename;
     imx25_pdk_binfo.loader_start =3D FSL_IMX25_SDRAM0_ADDR;
     imx25_pdk_binfo.board_id =3D 1771,
     imx25_pdk_binfo.nb_cpus =3D 1;
@@ -129,7 +126,7 @@ static void imx25_pdk_init(MachineState *machine)
      * fail.
      */
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, &imx25_pdk_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &imx25_pdk_binfo);
     }
 }
=20
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 200568b42a..524970840d 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -582,9 +582,6 @@ static struct arm_boot_info integrator_binfo =3D {
 static void integratorcp_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem =3D get_system_memory();
@@ -654,10 +651,7 @@ static void integratorcp_init(MachineState *machine)
     sysbus_create_simple("pl110", 0xc0000000, pic[22]);
=20
     integrator_binfo.ram_size =3D ram_size;
-    integrator_binfo.kernel_filename =3D kernel_filename;
-    integrator_binfo.kernel_cmdline =3D kernel_cmdline;
-    integrator_binfo.initrd_filename =3D initrd_filename;
-    arm_load_kernel(cpu, &integrator_binfo);
+    arm_load_kernel(cpu, machine, &integrator_binfo);
 }
=20
 static void integratorcp_machine_init(MachineClass *mc)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 2f052e1f8c..1d5ef289d5 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -127,13 +127,10 @@ static void kzm_init(MachineState *machine)
     }
=20
     kzm_binfo.ram_size =3D machine->ram_size;
-    kzm_binfo.kernel_filename =3D machine->kernel_filename;
-    kzm_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    kzm_binfo.initrd_filename =3D machine->initrd_filename;
     kzm_binfo.nb_cpus =3D 1;
=20
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, &kzm_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &kzm_binfo);
     }
 }
=20
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 1bad1aea76..b01ce3ce08 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -176,11 +176,8 @@ static void mainstone_common_init(MemoryRegion *addr=
ess_space_mem,
     smc91c111_init(&nd_table[0], MST_ETH_PHYS,
                     qdev_get_gpio_in(mst_irq, ETHERNET_IRQ));
=20
-    mainstone_binfo.kernel_filename =3D machine->kernel_filename;
-    mainstone_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    mainstone_binfo.initrd_filename =3D machine->initrd_filename;
     mainstone_binfo.board_id =3D arm_id;
-    arm_load_kernel(mpu->cpu, &mainstone_binfo);
+    arm_load_kernel(mpu->cpu, machine, &mainstone_binfo);
 }
=20
 static void mainstone_init(MachineState *machine)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 0276875f02..e90b393a44 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -40,9 +40,6 @@ static void mcimx6ul_evk_init(MachineState *machine)
         .loader_start =3D FSL_IMX6UL_MMDC_ADDR,
         .board_id =3D -1,
         .ram_size =3D machine->ram_size,
-        .kernel_filename =3D machine->kernel_filename,
-        .kernel_cmdline =3D machine->kernel_cmdline,
-        .initrd_filename =3D machine->initrd_filename,
         .nb_cpus =3D machine->smp.cpus,
     };
=20
@@ -72,7 +69,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
=20
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, &boot_info);
+        arm_load_kernel(&s->soc.cpu, machine, &boot_info);
     }
 }
=20
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 97b8bb788a..2df2223611 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -43,9 +43,6 @@ static void mcimx7d_sabre_init(MachineState *machine)
         .loader_start =3D FSL_IMX7_MMDC_ADDR,
         .board_id =3D -1,
         .ram_size =3D machine->ram_size,
-        .kernel_filename =3D machine->kernel_filename,
-        .kernel_cmdline =3D machine->kernel_cmdline,
-        .initrd_filename =3D machine->initrd_filename,
         .nb_cpus =3D machine->smp.cpus,
     };
=20
@@ -75,7 +72,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
=20
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], &boot_info);
+        arm_load_kernel(&s->soc.cpu[0], machine, &boot_info);
     }
 }
=20
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 8ae4751d75..246cbb1336 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1573,9 +1573,6 @@ static struct arm_boot_info musicpal_binfo =3D {
=20
 static void musicpal_init(MachineState *machine)
 {
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     ARMCPU *cpu;
     qemu_irq pic[32];
     DeviceState *dev;
@@ -1704,10 +1701,7 @@ static void musicpal_init(MachineState *machine)
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
=20
     musicpal_binfo.ram_size =3D MP_RAM_DEFAULT_SIZE;
-    musicpal_binfo.kernel_filename =3D kernel_filename;
-    musicpal_binfo.kernel_cmdline =3D kernel_cmdline;
-    musicpal_binfo.initrd_filename =3D initrd_filename;
-    arm_load_kernel(cpu, &musicpal_binfo);
+    arm_load_kernel(cpu, machine, &musicpal_binfo);
 }
=20
 static void musicpal_machine_init(MachineClass *mc)
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index a6c4085337..a36971d39a 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1361,10 +1361,7 @@ static void n8x0_init(MachineState *machine,
=20
     if (machine->kernel_filename) {
         /* Or at the linux loader.  */
-        binfo->kernel_filename =3D machine->kernel_filename;
-        binfo->kernel_cmdline =3D machine->kernel_cmdline;
-        binfo->initrd_filename =3D machine->initrd_filename;
-        arm_load_kernel(s->mpu->cpu, binfo);
+        arm_load_kernel(s->mpu->cpu, machine, binfo);
=20
         qemu_register_reset(n8x0_boot_init, s);
     }
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 75a05c36b0..c071197be7 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -195,10 +195,7 @@ static void sx1_init(MachineState *machine, const in=
t version)
     }
=20
     /* Load the kernel.  */
-    sx1_binfo.kernel_filename =3D machine->kernel_filename;
-    sx1_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    sx1_binfo.initrd_filename =3D machine->initrd_filename;
-    arm_load_kernel(mpu->cpu, &sx1_binfo);
+    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
=20
     /* TODO: fix next line */
     //~ qemu_console_resize(ds, 640, 480);
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index bea47b917d..02a3a82b9b 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -187,9 +187,6 @@ static struct arm_boot_info palmte_binfo =3D {
=20
 static void palmte_init(MachineState *machine)
 {
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     MemoryRegion *address_space_mem =3D get_system_memory();
     struct omap_mpu_state_s *mpu;
     int flash_size =3D 0x00800000;
@@ -249,16 +246,13 @@ static void palmte_init(MachineState *machine)
         }
     }
=20
-    if (!rom_loaded && !kernel_filename && !qtest_enabled()) {
+    if (!rom_loaded && !machine->kernel_filename && !qtest_enabled()) {
         fprintf(stderr, "Kernel or ROM image must be specified\n");
         exit(1);
     }
=20
     /* Load the kernel.  */
-    palmte_binfo.kernel_filename =3D kernel_filename;
-    palmte_binfo.kernel_cmdline =3D kernel_cmdline;
-    palmte_binfo.initrd_filename =3D initrd_filename;
-    arm_load_kernel(mpu->cpu, &palmte_binfo);
+    arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
 }
=20
 static void palmte_machine_init(MachineClass *mc)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 5b2620acb4..74c062d05e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -157,13 +157,9 @@ static void setup_boot(MachineState *machine, int ve=
rsion, size_t ram_size)
=20
         binfo.entry =3D firmware_addr;
         binfo.firmware_loaded =3D true;
-    } else {
-        binfo.kernel_filename =3D machine->kernel_filename;
-        binfo.kernel_cmdline =3D machine->kernel_cmdline;
-        binfo.initrd_filename =3D machine->initrd_filename;
     }
=20
-    arm_load_kernel(ARM_CPU(first_cpu), &binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
 }
=20
 static void raspi_init(MachineState *machine, int version)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b108a9ab26..8fcdf75a2b 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -351,13 +351,10 @@ static void realview_init(MachineState *machine,
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
=20
     realview_binfo.ram_size =3D ram_size;
-    realview_binfo.kernel_filename =3D machine->kernel_filename;
-    realview_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    realview_binfo.initrd_filename =3D machine->initrd_filename;
     realview_binfo.nb_cpus =3D smp_cpus;
     realview_binfo.board_id =3D realview_board_id[board_type];
     realview_binfo.loader_start =3D (board_type =3D=3D BOARD_PB_A8 ? 0x7=
0000000 : 0);
-    arm_load_kernel(ARM_CPU(first_cpu), &realview_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &realview_binfo);
 }
=20
 static void realview_eb_init(MachineState *machine)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index a6185c169e..96cc455c5c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -103,16 +103,13 @@ static void sabrelite_init(MachineState *machine)
     }
=20
     sabrelite_binfo.ram_size =3D machine->ram_size;
-    sabrelite_binfo.kernel_filename =3D machine->kernel_filename;
-    sabrelite_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    sabrelite_binfo.initrd_filename =3D machine->initrd_filename;
     sabrelite_binfo.nb_cpus =3D machine->smp.cpus;
     sabrelite_binfo.secure_boot =3D true;
     sabrelite_binfo.write_secondary_boot =3D sabrelite_write_secondary;
     sabrelite_binfo.secondary_cpu_reset_hook =3D sabrelite_reset_seconda=
ry;
=20
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], &sabrelite_binfo);
+        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
     }
 }
=20
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e98e9a5170..1c1a2b662d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -711,13 +711,12 @@ static void sbsa_ref_init(MachineState *machine)
     create_pcie(sms, pic);
=20
     sms->bootinfo.ram_size =3D machine->ram_size;
-    sms->bootinfo.kernel_filename =3D machine->kernel_filename;
     sms->bootinfo.nb_cpus =3D smp_cpus;
     sms->bootinfo.board_id =3D -1;
     sms->bootinfo.loader_start =3D sbsa_ref_memmap[SBSA_MEM].base;
     sms->bootinfo.get_dtb =3D sbsa_ref_dtb;
     sms->bootinfo.firmware_loaded =3D firmware_loaded;
-    arm_load_kernel(ARM_CPU(first_cpu), &sms->bootinfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &sms->bootinfo);
 }
=20
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 59348123b5..25bd0f5d9d 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -954,11 +954,8 @@ static void spitz_common_init(MachineState *machine,
         /* A 4.0 GB microdrive is permanently sitting in CF slot 0.  */
         spitz_microdrive_attach(mpu, 0);
=20
-    spitz_binfo.kernel_filename =3D machine->kernel_filename;
-    spitz_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    spitz_binfo.initrd_filename =3D machine->initrd_filename;
     spitz_binfo.board_id =3D arm_id;
-    arm_load_kernel(mpu->cpu, &spitz_binfo);
+    arm_load_kernel(mpu->cpu, machine, &spitz_binfo);
     sl_bootparam_write(SL_PXA_PARAM_BASE);
 }
=20
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index e9627e356e..4d95a1f3e2 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -218,9 +218,6 @@ static struct arm_boot_info tosa_binfo =3D {
=20
 static void tosa_init(MachineState *machine)
 {
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
     PXA2xxState *mpu;
@@ -245,11 +242,8 @@ static void tosa_init(MachineState *machine)
=20
     tosa_tg_init(mpu);
=20
-    tosa_binfo.kernel_filename =3D kernel_filename;
-    tosa_binfo.kernel_cmdline =3D kernel_cmdline;
-    tosa_binfo.initrd_filename =3D initrd_filename;
     tosa_binfo.board_id =3D 0x208;
-    arm_load_kernel(mpu->cpu, &tosa_binfo);
+    arm_load_kernel(mpu->cpu, machine, &tosa_binfo);
     sl_bootparam_write(SL_PXA_PARAM_BASE);
 }
=20
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e25561705f..e86af01537 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -375,11 +375,8 @@ static void versatile_init(MachineState *machine, in=
t board_id)
     }
=20
     versatile_binfo.ram_size =3D machine->ram_size;
-    versatile_binfo.kernel_filename =3D machine->kernel_filename;
-    versatile_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    versatile_binfo.initrd_filename =3D machine->initrd_filename;
     versatile_binfo.board_id =3D board_id;
-    arm_load_kernel(cpu, &versatile_binfo);
+    arm_load_kernel(cpu, machine, &versatile_binfo);
 }
=20
 static void vpb_init(MachineState *machine)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5d932c27c0..4673a88a8d 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -707,9 +707,6 @@ static void vexpress_common_init(MachineState *machin=
e)
     }
=20
     daughterboard->bootinfo.ram_size =3D machine->ram_size;
-    daughterboard->bootinfo.kernel_filename =3D machine->kernel_filename=
;
-    daughterboard->bootinfo.kernel_cmdline =3D machine->kernel_cmdline;
-    daughterboard->bootinfo.initrd_filename =3D machine->initrd_filename=
;
     daughterboard->bootinfo.nb_cpus =3D machine->smp.cpus;
     daughterboard->bootinfo.board_id =3D VEXPRESS_BOARD_ID;
     daughterboard->bootinfo.loader_start =3D daughterboard->loader_start=
;
@@ -719,7 +716,7 @@ static void vexpress_common_init(MachineState *machin=
e)
     daughterboard->bootinfo.modify_dtb =3D vexpress_modify_dtb;
     /* When booting Linux we should be in secure state if the CPU has on=
e. */
     daughterboard->bootinfo.secure_boot =3D vms->secure;
-    arm_load_kernel(ARM_CPU(first_cpu), &daughterboard->bootinfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &daughterboard->bootinf=
o);
 }
=20
 static bool vexpress_get_secure(Object *obj, Error **errp)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d1629ccb3..3796aa70f8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1368,6 +1368,7 @@ void virt_machine_done(Notifier *notifier, void *da=
ta)
 {
     VirtMachineState *vms =3D container_of(notifier, VirtMachineState,
                                          machine_done);
+    MachineState *ms =3D MACHINE(vms);
     ARMCPU *cpu =3D ARM_CPU(first_cpu);
     struct arm_boot_info *info =3D &vms->bootinfo;
     AddressSpace *as =3D arm_boot_address_space(cpu, info);
@@ -1385,7 +1386,7 @@ void virt_machine_done(Notifier *notifier, void *da=
ta)
                                        vms->memmap[VIRT_PLATFORM_BUS].si=
ze,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
-    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
+    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0=
) {
         exit(1);
     }
=20
@@ -1711,16 +1712,13 @@ static void machvirt_init(MachineState *machine)
     create_platform_bus(vms, pic);
=20
     vms->bootinfo.ram_size =3D machine->ram_size;
-    vms->bootinfo.kernel_filename =3D machine->kernel_filename;
-    vms->bootinfo.kernel_cmdline =3D machine->kernel_cmdline;
-    vms->bootinfo.initrd_filename =3D machine->initrd_filename;
     vms->bootinfo.nb_cpus =3D smp_cpus;
     vms->bootinfo.board_id =3D -1;
     vms->bootinfo.loader_start =3D vms->memmap[VIRT_MEM].base;
     vms->bootinfo.get_dtb =3D machvirt_dtb;
     vms->bootinfo.skip_dtb_autoload =3D true;
     vms->bootinfo.firmware_loaded =3D firmware_loaded;
-    arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
=20
     vms->machine_done.notify =3D virt_machine_done;
     qemu_add_machine_init_done_notifier(&vms->machine_done);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 89da34808b..c14774e542 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -158,9 +158,6 @@ static inline void zynq_init_spi_flashes(uint32_t bas=
e_addr, qemu_irq irq,
 static void zynq_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     ARMCPU *cpu;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
@@ -303,16 +300,13 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(busdev, 0, 0xF8007000);
=20
     zynq_binfo.ram_size =3D ram_size;
-    zynq_binfo.kernel_filename =3D kernel_filename;
-    zynq_binfo.kernel_cmdline =3D kernel_cmdline;
-    zynq_binfo.initrd_filename =3D initrd_filename;
     zynq_binfo.nb_cpus =3D 1;
     zynq_binfo.board_id =3D 0xd32;
     zynq_binfo.loader_start =3D 0;
     zynq_binfo.board_setup_addr =3D BOARD_SETUP_ADDR;
     zynq_binfo.write_board_setup =3D zynq_write_board_setup;
=20
-    arm_load_kernel(ARM_CPU(first_cpu), &zynq_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &zynq_binfo);
 }
=20
 static void zynq_machine_init(MachineClass *mc)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index f95fde2309..462493c467 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -441,14 +441,11 @@ static void versal_virt_init(MachineState *machine)
                                         0, &s->soc.fpd.apu.mr, 0);
=20
     s->binfo.ram_size =3D machine->ram_size;
-    s->binfo.kernel_filename =3D machine->kernel_filename;
-    s->binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    s->binfo.initrd_filename =3D machine->initrd_filename;
     s->binfo.loader_start =3D 0x0;
     s->binfo.get_dtb =3D versal_virt_get_dtb;
     s->binfo.modify_dtb =3D versal_virt_modify_dtb;
     if (machine->kernel_filename) {
-        arm_load_kernel(s->soc.fpd.apu.cpu[0], &s->binfo);
+        arm_load_kernel(s->soc.fpd.apu.cpu[0], machine, &s->binfo);
     } else {
         AddressSpace *as =3D arm_boot_address_space(s->soc.fpd.apu.cpu[0=
],
                                                   &s->binfo);
@@ -457,7 +454,7 @@ static void versal_virt_init(MachineState *machine)
         s->binfo.loader_start =3D 0x1000;
         s->binfo.dtb_limit =3D 0x1000000;
         if (arm_load_dtb(s->binfo.loader_start,
-                         &s->binfo, s->binfo.dtb_limit, as) < 0) {
+                         &s->binfo, s->binfo.dtb_limit, as, machine) < 0=
) {
             exit(EXIT_FAILURE);
         }
     }
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 044d3394c0..53cfe7c1f1 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -171,11 +171,8 @@ static void xlnx_zcu102_init(MachineState *machine)
     /* TODO create and connect IDE devices for ide_drive_get() */
=20
     xlnx_zcu102_binfo.ram_size =3D ram_size;
-    xlnx_zcu102_binfo.kernel_filename =3D machine->kernel_filename;
-    xlnx_zcu102_binfo.kernel_cmdline =3D machine->kernel_cmdline;
-    xlnx_zcu102_binfo.initrd_filename =3D machine->initrd_filename;
     xlnx_zcu102_binfo.loader_start =3D 0;
-    arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
+    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &xlnx_zcu102_binfo);
 }
=20
 static void xlnx_zcu102_machine_instance_init(Object *obj)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 3923b87e4c..34794fe3ae 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -296,9 +296,6 @@ static const TypeInfo aer915_info =3D {
=20
 static void z2_init(MachineState *machine)
 {
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
     MemoryRegion *address_space_mem =3D get_system_memory();
     uint32_t sector_len =3D 0x10000;
     PXA2xxState *mpu;
@@ -352,11 +349,8 @@ static void z2_init(MachineState *machine)
     qdev_connect_gpio_out(mpu->gpio, Z2_GPIO_LCD_CS,
                           qemu_allocate_irq(z2_lcd_cs, z2_lcd, 0));
=20
-    z2_binfo.kernel_filename =3D kernel_filename;
-    z2_binfo.kernel_cmdline =3D kernel_cmdline;
-    z2_binfo.initrd_filename =3D initrd_filename;
     z2_binfo.board_id =3D 0x6dd;
-    arm_load_kernel(mpu->cpu, &z2_binfo);
+    arm_load_kernel(mpu->cpu, machine, &z2_binfo);
 }
=20
 static void z2_machine_init(MachineClass *mc)
--=20
2.21.0


