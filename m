Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC6CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6BE2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 11:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6BE2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLQ3M-00070y-1m
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 07:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iLPu8-0005s1-Lt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iLPu6-0001QH-N6
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iLPu4-0001Oe-MA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6207A2B87;
 Fri, 18 Oct 2019 10:54:39 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A24D61F21;
 Fri, 18 Oct 2019 10:54:35 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 09/15] hw/i386: make x86.c independent from PCMachineState
Date: Fri, 18 Oct 2019 12:53:09 +0200
Message-Id: <20191018105315.27511-10-slp@redhat.com>
In-Reply-To: <20191018105315.27511-1-slp@redhat.com>
References: <20191018105315.27511-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 18 Oct 2019 10:54:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>,
 mst@redhat.com, lersek@redhat.com, groug@kaod.org, marcandre.lureau@gmail.com,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a last step into splitting PCMachineState and deriving
X86MachineState from it, make the functions previously extracted from
pc.c to x86.c independent from PCMachineState, using X86MachineState
instead.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/x86.h | 13 +++++++----
 hw/i386/pc.c          | 14 ++++++++----
 hw/i386/pc_piix.c     |  2 +-
 hw/i386/pc_q35.c      |  2 +-
 hw/i386/x86.c         | 53 ++++++++++++++++++++-----------------------
 5 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d15713e92e..82d09fd7d0 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -75,10 +75,11 @@ typedef struct {
 #define X86_MACHINE_CLASS(class) \
     OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
=20
-uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
                                     unsigned int cpu_index);
-void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp);
-void x86_cpus_init(PCMachineState *pcms);
+
+void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp);
+void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
 CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
                                              unsigned cpu_index);
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
@@ -86,6 +87,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machine=
State *ms);
=20
 void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
=20
-void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
+void x86_load_linux(X86MachineState *x86ms,
+                    FWCfgState *fw_cfg,
+                    int acpi_data_size,
+                    bool pvh_enabled,
+                    bool linuxboot_dma_enabled);
=20
 #endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1457a45101..a4d3a284fb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -983,8 +983,8 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
=20
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
-    PCMachineState *pcms =3D PC_MACHINE(ms);
-    int64_t apic_id =3D x86_cpu_apic_id_from_index(pcms, id);
+    X86MachineState *x86ms =3D X86_MACHINE(ms);
+    int64_t apic_id =3D x86_cpu_apic_id_from_index(x86ms, id);
     Error *local_err =3D NULL;
=20
     if (id < 0) {
@@ -999,7 +999,8 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t i=
d, Error **errp)
         return;
     }
=20
-    x86_cpu_new(PC_MACHINE(ms), apic_id, &local_err);
+
+    x86_cpu_new(X86_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1100,6 +1101,7 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     assert(MACHINE(pcms)->kernel_filename !=3D NULL);
@@ -1108,7 +1110,8 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
=20
-    x86_load_linux(pcms, fw_cfg);
+    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
+                   pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled);
     for (i =3D 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -1244,7 +1247,8 @@ void pc_memory_init(PCMachineState *pcms,
     }
=20
     if (linux_boot) {
-        x86_load_linux(pcms, fw_cfg);
+        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
+                       pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled);
     }
=20
     for (i =3D 0; i < nb_option_roms; i++) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0afa8fe6ea..a86317cdff 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -154,7 +154,7 @@ static void pc_init1(MachineState *machine,
         }
     }
=20
-    x86_cpus_init(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
=20
     if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create();
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 374ac6c068..75c8caf7c2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -181,7 +181,7 @@ static void pc_q35_init(MachineState *machine)
         xen_hvm_init(pcms, &ram_memory);
     }
=20
-    x86_cpus_init(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
=20
     kvmclock_create();
=20
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index de4fed0164..fd84b23124 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -36,7 +36,6 @@
 #include "sysemu/sysemu.h"
=20
 #include "hw/i386/x86.h"
-#include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
@@ -61,11 +60,10 @@ static size_t pvh_start_addr;
  * no concept of "CPU index", and the NUMA tables on fw_cfg need the API=
C ID of
  * all CPUs up to max_cpus.
  */
-uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index)
 {
-    MachineState *ms =3D MACHINE(pcms);
-    X86MachineState *x86ms =3D X86_MACHINE(pcms);
+    MachineState *ms =3D MACHINE(x86ms);
     X86MachineClass *x86mc =3D X86_MACHINE_GET_CLASS(x86ms);
     uint32_t correct_id;
     static bool warned;
@@ -84,14 +82,14 @@ uint32_t x86_cpu_apic_id_from_index(PCMachineState *p=
cms,
     }
 }
=20
-void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
+
+void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
     Object *cpu =3D NULL;
     Error *local_err =3D NULL;
     CPUX86State *env =3D NULL;
-    X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
-    cpu =3D object_new(MACHINE(pcms)->cpu_type);
+    cpu =3D object_new(MACHINE(x86ms)->cpu_type);
=20
     env =3D &X86_CPU(cpu)->env;
     env->nr_dies =3D x86ms->smp_dies;
@@ -103,30 +101,28 @@ void x86_cpu_new(PCMachineState *pcms, int64_t apic=
_id, Error **errp)
     error_propagate(errp, local_err);
 }
=20
-void x86_cpus_init(PCMachineState *pcms)
+void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 {
     int i;
     const CPUArchIdList *possible_cpus;
-    MachineState *ms =3D MACHINE(pcms);
-    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
-    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
-    X86MachineState *x86ms =3D X86_MACHINE(pcms);
+    MachineState *ms =3D MACHINE(x86ms);
+    MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
=20
-    x86_cpu_set_default_version(pcmc->default_cpu_version);
+    x86_cpu_set_default_version(default_cpu_version);
=20
     /*
      * Calculates the limit to CPU APIC ID values
      *
      * Limit for the APIC ID value, so that all
-     * CPU APIC IDs are < pcms->apic_id_limit.
+     * CPU APIC IDs are < x86ms->apic_id_limit.
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_cre=
ate().
      */
-    x86ms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
+    x86ms->apic_id_limit =3D x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus -=
 1) + 1;
     possible_cpus =3D mc->possible_cpu_arch_ids(ms);
     for (i =3D 0; i < ms->smp.cpus; i++) {
-        x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
+        x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal)=
;
     }
 }
=20
@@ -154,7 +150,6 @@ int64_t x86_get_default_cpu_node_id(const MachineStat=
e *ms, int idx)
=20
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
-    PCMachineState *pcms =3D PC_MACHINE(ms);
     X86MachineState *x86ms =3D X86_MACHINE(ms);
     int i;
     unsigned int max_cpus =3D ms->smp.max_cpus;
@@ -177,7 +172,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machin=
eState *ms)
         ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count =3D 1;
         ms->possible_cpus->cpus[i].arch_id =3D
-            x86_cpu_apic_id_from_index(pcms, i);
+            x86_cpu_apic_id_from_index(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  x86ms->smp_dies, ms->smp.cores,
                                  ms->smp.threads, &topo);
@@ -335,8 +330,11 @@ static bool load_elfboot(const char *kernel_filename=
,
     return true;
 }
=20
-void x86_load_linux(PCMachineState *pcms,
-                    FWCfgState *fw_cfg)
+void x86_load_linux(X86MachineState *x86ms,
+                    FWCfgState *fw_cfg,
+                    int acpi_data_size,
+                    bool pvh_enabled,
+                    bool linuxboot_dma_enabled)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
@@ -346,9 +344,7 @@ void x86_load_linux(PCMachineState *pcms,
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
     FILE *f;
     char *vmode;
-    MachineState *machine =3D MACHINE(pcms);
-    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms =3D X86_MACHINE(pcms);
+    MachineState *machine =3D MACHINE(x86ms);
     struct setup_data *setup_data;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -395,7 +391,7 @@ void x86_load_linux(PCMachineState *pcms,
          * saving the PVH entry point used by the x86/HVM direct boot AB=
I.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (pcmc->pvh_enabled &&
+        if (pvh_enabled &&
             load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
@@ -425,8 +421,7 @@ void x86_load_linux(PCMachineState *pcms,
=20
                 initrd_data =3D g_mapped_file_get_contents(mapped_file);
                 initrd_size =3D g_mapped_file_get_length(mapped_file);
-                initrd_max =3D
-                    x86ms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+                initrd_max =3D x86ms->below_4g_mem_size - acpi_data_size=
 - 1;
                 if (initrd_size >=3D initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot s=
upport."
                             "(max: %"PRIu32", need %"PRId64")\n",
@@ -494,8 +489,8 @@ void x86_load_linux(PCMachineState *pcms,
         initrd_max =3D 0x37ffffff;
     }
=20
-    if (initrd_max >=3D x86ms->below_4g_mem_size - pcmc->acpi_data_size)=
 {
-        initrd_max =3D x86ms->below_4g_mem_size - pcmc->acpi_data_size -=
 1;
+    if (initrd_max >=3D x86ms->below_4g_mem_size - acpi_data_size) {
+        initrd_max =3D x86ms->below_4g_mem_size - acpi_data_size - 1;
     }
=20
     fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
@@ -652,7 +647,7 @@ void x86_load_linux(PCMachineState *pcms,
=20
     option_rom[nb_option_roms].bootindex =3D 0;
     option_rom[nb_option_roms].name =3D "linuxboot.bin";
-    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
     }
     nb_option_roms++;
--=20
2.21.0


