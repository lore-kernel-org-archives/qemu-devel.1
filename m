Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A5C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C18C21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C18C21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFczl-0002MY-1a
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFcrc-0001S6-An
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFcra-0000Nl-J7
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFcra-0000MO-BY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:32:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BA6F3084032;
 Wed,  2 Oct 2019 11:32:08 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1CE760619;
 Wed,  2 Oct 2019 11:31:56 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/10] hw/i386: make x86.c independent from PCMachineState
Date: Wed,  2 Oct 2019 13:30:58 +0200
Message-Id: <20191002113103.45023-6-slp@redhat.com>
In-Reply-To: <20191002113103.45023-1-slp@redhat.com>
References: <20191002113103.45023-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 02 Oct 2019 11:32:08 +0000 (UTC)
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a last step into splitting PCMachineState and deriving
X86MachineState from it, make the functions previously extracted from
pc.c to x86.c independent from PCMachineState, using X86MachineState
instead.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/pc.c          | 13 +++++++-----
 hw/i386/pc_piix.c     |  2 +-
 hw/i386/pc_q35.c      |  2 +-
 hw/i386/x86.c         | 48 ++++++++++++++++++++-----------------------
 include/hw/i386/x86.h | 12 +++++++----
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d579a2f1c2..5098293e73 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -982,8 +982,8 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
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
@@ -998,7 +998,7 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t i=
d, Error **errp)
         return;
     }
=20
-    x86_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
+    x86_new_cpu(X86_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1099,6 +1099,7 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms =3D X86_MACHINE(pcms);
=20
     assert(MACHINE(pcms)->kernel_filename !=3D NULL);
@@ -1107,7 +1108,8 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
=20
-    x86_load_linux(pcms, fw_cfg);
+    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
+                   pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled);
     for (i =3D 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -1243,7 +1245,8 @@ void pc_memory_init(PCMachineState *pcms,
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
index 0290b4c127..7f7b607c07 100644
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
index cc0ab0c4e4..9f9c7d6aba 100644
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
index 35b8239303..02d22c3664 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -60,11 +60,10 @@ static size_t pvh_start_addr;
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
@@ -83,14 +82,13 @@ uint32_t x86_cpu_apic_id_from_index(PCMachineState *p=
cms,
     }
 }
=20
-void x86_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
+void x86_new_cpu(X86MachineState *x86ms, int64_t apic_id, Error **errp)
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
@@ -102,16 +100,14 @@ void x86_new_cpu(PCMachineState *pcms, int64_t apic=
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
     /* Calculates the limit to CPU APIC ID values
      *
@@ -120,11 +116,11 @@ void x86_cpus_init(PCMachineState *pcms)
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
-        x86_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
+        x86_new_cpu(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal)=
;
     }
 }
=20
@@ -152,7 +148,6 @@ int64_t x86_get_default_cpu_node_id(const MachineStat=
e *ms, int idx)
=20
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
-    PCMachineState *pcms =3D PC_MACHINE(ms);
     X86MachineState *x86ms =3D X86_MACHINE(ms);
     int i;
     unsigned int max_cpus =3D ms->smp.max_cpus;
@@ -174,7 +169,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machin=
eState *ms)
=20
         ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count =3D 1;
-        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(pcms, i);
+        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  x86ms->smp_dies, ms->smp.cores,
                                  ms->smp.threads, &topo);
@@ -331,8 +326,11 @@ static bool load_elfboot(const char *kernel_filename=
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
@@ -342,9 +340,7 @@ void x86_load_linux(PCMachineState *pcms,
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
@@ -387,7 +383,7 @@ void x86_load_linux(PCMachineState *pcms,
          * saving the PVH entry point used by the x86/HVM direct boot AB=
I.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (pcmc->pvh_enabled &&
+        if (pvh_enabled &&
             load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
@@ -417,7 +413,7 @@ void x86_load_linux(PCMachineState *pcms,
=20
                 initrd_data =3D g_mapped_file_get_contents(mapped_file);
                 initrd_size =3D g_mapped_file_get_length(mapped_file);
-                initrd_max =3D x86ms->below_4g_mem_size - pcmc->acpi_dat=
a_size - 1;
+                initrd_max =3D x86ms->below_4g_mem_size - acpi_data_size=
 - 1;
                 if (initrd_size >=3D initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot s=
upport."
                             "(max: %"PRIu32", need %"PRId64")\n",
@@ -495,8 +491,8 @@ void x86_load_linux(PCMachineState *pcms,
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
@@ -645,7 +641,7 @@ void x86_load_linux(PCMachineState *pcms,
=20
     option_rom[nb_option_roms].bootindex =3D 0;
     option_rom[nb_option_roms].name =3D "linuxboot.bin";
-    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 5de2f91845..dbeff4c9aa 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -73,10 +73,10 @@ typedef struct {
 #define X86_MACHINE_CLASS(class) \
     OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
=20
-uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
                                     unsigned int cpu_index);
-void x86_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp);
-void x86_cpus_init(PCMachineState *pcms);
+void x86_new_cpu(X86MachineState *x86ms, int64_t apic_id, Error **errp);
+void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version);
 CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
                                              unsigned cpu_index);
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
@@ -84,6 +84,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machine=
State *ms);
=20
 void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
=20
-void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
+void x86_load_linux(X86MachineState *x86ms,
+                    FWCfgState *fw_cfg,
+                    int acpi_data_size,
+                    bool pvh_enabled,
+                    bool linuxboot_dma_enabled);
=20
 #endif
--=20
2.21.0


