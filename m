Received: from eggs.gnu.org ([2001:4830:134:3::10]:33297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d2jC0-0003Mf-Ca
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d2jBu-0005ZW-CO
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d2jBu-0005YP-3D
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:58:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C60B0C04B94E
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:58:28 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 24 Apr 2017 20:58:17 +0200
Message-Id: <20170424185817.41002-1-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] pc/fwcfg: unbreak migration from qemu-2.5 and
 qemu-2.6 during firmware boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, dgilbert@redhat.com, lersek@redhat.com

Since 2.7 commit (b2a575a Add optionrom compatible with fw_cfg DMA version)
regressed migration during firmware exection time by
abusing fwcfg.dma_enabled property to decide loading
dma version of option rom AND by mistake disabling DMA
for 2.6 and earlier globally instead of only for option rom.

so 2.6 machine type guest is broken when it already runs
firmware in DMA mode but migrated to qemu-2.7(pc-2.6)
at that time;

a) qemu-2.6:pc2.6 (fwcfg.dma=on,firmware=dma,oprom=mmio)
b) qemu-2.7:pc2.6 (fwcfg.dma=off,firmware=mmio,oprom=mmio)

  to:   a     b
from
a       OK   FAIL
b       OK   OK

So we currently have broken forward migration from
qemu-2.6 to qemu-2.[789] that however could be fixed
for 2.10 by re-enabling DMA for 2.[56] machine types
and allowing dma capable option rom only since 2.7.
As result qemu should end up with:

c) qemu-2.10:pc2.6 (fwcfg.dma=on,firmware=dma,oprom=mmio)

   to:  a     b    c
from
a      OK   FAIL  OK
b      OK   OK    OK
c      OK   FAIL  OK

where forward migration from qemu-2.6 to qemu-2.10 should
work again leaving only qemu-2.[789]:pc-2.6 broken.

Patch should also help downstream to maintain migration
the way it used to be since dma cable option rom
is managed by new

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c         | 2 +-
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_q35.c     | 1 +
 include/hw/i386/pc.h | 6 ++----
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f3b372a18f..3f2d96da64 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1047,7 +1047,7 @@ static void load_linux(PCMachineState *pcms,
     fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
 
-    if (fw_cfg_dma_enabled(fw_cfg)) {
+    if (!pcmc->linuxboot_dma_disabled && fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
         option_rom[nb_option_roms].bootindex = 0;
     } else {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa388..dd3a2bb02a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -474,6 +474,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
+    pcmc->linuxboot_dma_disabled = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8547..9988ecc578 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -335,6 +335,7 @@ static void pc_q35_2_6_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
+    pcmc->linuxboot_dma_disabled = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f278b3ae89..ff6f13b61b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -151,6 +151,8 @@ struct PCMachineClass {
     bool save_tsc_khz;
     /* generate legacy CPU hotplug AML */
     bool legacy_cpu_hotplug;
+
+    bool linuxboot_dma_disabled;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
@@ -432,10 +434,6 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 #define PC_COMPAT_2_6 \
     HW_COMPAT_2_6 \
     {\
-        .driver   = "fw_cfg_io",\
-        .property = "dma_enabled",\
-        .value    = "off",\
-    },{\
         .driver   = TYPE_X86_CPU,\
         .property = "cpuid-0xb",\
         .value    = "off",\
-- 
2.11.0 (Apple Git-81)
