Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB5C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFB0218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFB0218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1himc3-00048O-0D
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1himUZ-0005n9-1g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1himUX-0006cS-3x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1himUW-0006by-Ru
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31458308FC20;
 Wed,  3 Jul 2019 21:08:33 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B388194AE;
 Wed,  3 Jul 2019 21:08:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 18:07:40 -0300
Message-Id: <20190703210821.27550-3-ehabkost@redhat.com>
In-Reply-To: <20190703210821.27550-1-ehabkost@redhat.com>
References: <20190703210821.27550-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 03 Jul 2019 21:08:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v5 02/43] machine: Refactor smp-related call
 chains to pass MachineState
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

To get rid of the global smp_* variables we're currently using, it's recommended
to pass MachineState in the list of incoming parameters for functions that use
global smp variables, thus some redundant parameters are dropped. It's applied
for legacy smbios_*(), *_machine_reset(), hot_add_cpu() and mips *_create_cpu().

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190518205428.90532-3-like.xu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h          |  4 ++--
 include/hw/firmware/smbios.h |  5 +++--
 include/hw/i386/pc.h         |  2 +-
 hw/arm/virt.c                |  2 +-
 hw/core/machine-qmp-cmds.c   |  2 +-
 hw/hppa/machine.c            |  2 +-
 hw/i386/acpi-build.c         |  2 +-
 hw/i386/pc.c                 |  9 ++++-----
 hw/mips/mips_malta.c         | 22 +++++++++++-----------
 hw/ppc/pnv.c                 |  3 +--
 hw/ppc/spapr.c               |  3 +--
 hw/s390x/s390-virtio-ccw.c   |  6 +++---
 hw/smbios/smbios.c           | 26 +++++++++++++++-----------
 vl.c                         |  2 +-
 14 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9597140936..d84f48c4af 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -173,8 +173,8 @@ struct MachineClass {
     const char *deprecation_reason;
 
     void (*init)(MachineState *state);
-    void (*reset)(void);
-    void (*hot_add_cpu)(const int64_t id, Error **errp);
+    void (*reset)(MachineState *state);
+    void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
 
     BlockInterfaceType block_default_type;
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index 6fef32a3c9..02a0ced0a0 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -268,8 +268,9 @@ void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
                          const char *version, bool legacy_mode,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
-uint8_t *smbios_get_table_legacy(size_t *length);
-void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
+uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length);
+void smbios_get_tables(MachineState *ms,
+                       const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
                        uint8_t **tables, size_t *tables_len,
                        uint8_t **anchor, size_t *anchor_len);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c54cc54a47..884e35b9b2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -186,7 +186,7 @@ void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_cpus_init(PCMachineState *pcms);
-void pc_hot_add_cpu(const int64_t id, Error **errp);
+void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ed009fa447..7b63a924a3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1345,7 +1345,7 @@ static void virt_build_smbios(VirtMachineState *vms)
                         vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
                         true, SMBIOS_ENTRY_POINT_30);
 
-    smbios_get_tables(NULL, 0, &smbios_tables, &smbios_tables_len,
+    smbios_get_tables(MACHINE(vms), NULL, 0, &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len);
 
     if (smbios_anchor) {
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 1e08252af7..14dbad1d6e 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -264,7 +264,7 @@ void qmp_cpu_add(int64_t id, Error **errp)
 
     mc = MACHINE_GET_CLASS(current_machine);
     if (mc->hot_add_cpu) {
-        mc->hot_add_cpu(id, errp);
+        mc->hot_add_cpu(current_machine, id, errp);
     } else {
         error_setg(errp, "Not supported");
     }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d1b1d3caa4..416e67bab1 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -240,7 +240,7 @@ static void machine_hppa_init(MachineState *machine)
     cpu[0]->env.gr[21] = smp_cpus;
 }
 
-static void hppa_machine_reset(void)
+static void hppa_machine_reset(MachineState *ms)
 {
     int i;
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 31a1c1e3ad..8ae7d88b11 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -184,7 +184,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     pm->pcihp_io_len = 0;
 
     assert(obj);
-    init_common_fadt_data(obj, &pm->fadt);
+    init_common_fadt_data(machine, obj, &pm->fadt);
     if (piix) {
         /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
         pm->fadt.rev = 1;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e96360b47a..da1cdd6853 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -958,7 +958,7 @@ static void pc_build_smbios(PCMachineState *pcms)
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
+    smbios_tables = smbios_get_table_legacy(ms, &smbios_tables_len);
     if (smbios_tables) {
         fw_cfg_add_bytes(pcms->fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
@@ -975,7 +975,7 @@ static void pc_build_smbios(PCMachineState *pcms)
             array_count++;
         }
     }
-    smbios_get_tables(mem_array, array_count,
+    smbios_get_tables(ms, mem_array, array_count,
                       &smbios_tables, &smbios_tables_len,
                       &smbios_anchor, &smbios_anchor_len);
     g_free(mem_array);
@@ -1530,9 +1530,8 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
     error_propagate(errp, local_err);
 }
 
-void pc_hot_add_cpu(const int64_t id, Error **errp)
+void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     int64_t apic_id = x86_cpu_apic_id_from_index(id);
     Error *local_err = NULL;
 
@@ -2619,7 +2618,7 @@ static void pc_machine_initfn(Object *obj)
     pc_system_flash_create(pcms);
 }
 
-static void pc_machine_reset(void)
+static void pc_machine_reset(MachineState *machine)
 {
     CPUState *cs;
     X86CPU *cpu;
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 37ec89b07e..132127882d 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1124,15 +1124,15 @@ static void main_cpu_reset(void *opaque)
     }
 }
 
-static void create_cpu_without_cps(const char *cpu_type,
+static void create_cpu_without_cps(MachineState *ms,
                                    qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     CPUMIPSState *env;
     MIPSCPU *cpu;
     int i;
 
-    for (i = 0; i < smp_cpus; i++) {
-        cpu = MIPS_CPU(cpu_create(cpu_type));
+    for (i = 0; i < ms->smp.cpus; i++) {
+        cpu = MIPS_CPU(cpu_create(ms->cpu_type));
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1146,15 +1146,15 @@ static void create_cpu_without_cps(const char *cpu_type,
     *cbus_irq = env->irq[4];
 }
 
-static void create_cps(MaltaState *s, const char *cpu_type,
+static void create_cps(MachineState *ms, MaltaState *s,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     Error *err = NULL;
 
     sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
                           TYPE_MIPS_CPS);
-    object_property_set_str(OBJECT(&s->cps), cpu_type, "cpu-type", &err);
-    object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
+    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
+    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
     object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
     if (err != NULL) {
         error_report("%s", error_get_pretty(err));
@@ -1167,13 +1167,13 @@ static void create_cps(MaltaState *s, const char *cpu_type,
     *cbus_irq = NULL;
 }
 
-static void mips_create_cpu(MaltaState *s, const char *cpu_type,
+static void mips_create_cpu(MachineState *ms, MaltaState *s,
                             qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
-    if ((smp_cpus > 1) && cpu_supports_cps_smp(cpu_type)) {
-        create_cps(s, cpu_type, cbus_irq, i8259_irq);
+    if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
+        create_cps(ms, s, cbus_irq, i8259_irq);
     } else {
-        create_cpu_without_cps(cpu_type, cbus_irq, i8259_irq);
+        create_cpu_without_cps(ms, cbus_irq, i8259_irq);
     }
 }
 
@@ -1217,7 +1217,7 @@ void mips_malta_init(MachineState *machine)
     qdev_init_nofail(dev);
 
     /* create CPU */
-    mips_create_cpu(s, machine->cpu_type, &cbus_irq, &i8259_irq);
+    mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
     if (ram_size > 2 * GiB) {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b87e01e5b9..e364f79efd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -529,9 +529,8 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
     }
 }
 
-static void pnv_reset(void)
+static void pnv_reset(MachineState *machine)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     PnvMachineState *pnv = PNV_MACHINE(machine);
     void *fdt;
     Object *obj;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b502fcac2e..6cf0ac400b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1691,9 +1691,8 @@ static int spapr_reset_drcs(Object *child, void *opaque)
     return 0;
 }
 
-static void spapr_machine_reset(void)
+static void spapr_machine_reset(MachineState *machine)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     PowerPCCPU *first_ppc_cpu;
     uint32_t rtas_limit;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 87b2039f1b..e09bf8f1b6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -339,7 +339,7 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 
-static void s390_machine_reset(void)
+static void s390_machine_reset(MachineState *machine)
 {
     enum s390_reset reset_type;
     CPUState *cs, *t;
@@ -440,9 +440,9 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_hot_add_cpu(const int64_t id, Error **errp)
+static void s390_hot_add_cpu(MachineState *machine,
+                             const int64_t id, Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     ObjectClass *oc;
 
     g_assert(machine->possible_cpus->cpus[0].cpu);
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a36448fc8d..7bcd67b098 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -27,6 +27,7 @@
 #include "sysemu/cpus.h"
 #include "hw/firmware/smbios.h"
 #include "hw/loader.h"
+#include "hw/boards.h"
 #include "exec/cpu-common.h"
 #include "smbios_build.h"
 
@@ -341,9 +342,10 @@ static void smbios_register_config(void)
 
 opts_init(smbios_register_config);
 
-static void smbios_validate_table(void)
+static void smbios_validate_table(MachineState *ms)
 {
-    uint32_t expect_t4_count = smbios_legacy ? smp_cpus : smbios_smp_sockets;
+    uint32_t expect_t4_count = smbios_legacy ?
+                                        ms->smp.cpus : smbios_smp_sockets;
 
     if (smbios_type4_count && smbios_type4_count != expect_t4_count) {
         error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
@@ -428,7 +430,7 @@ static void smbios_build_type_1_fields(void)
     }
 }
 
-uint8_t *smbios_get_table_legacy(size_t *length)
+uint8_t *smbios_get_table_legacy(MachineState *ms, size_t *length)
 {
     if (!smbios_legacy) {
         *length = 0;
@@ -438,7 +440,7 @@ uint8_t *smbios_get_table_legacy(size_t *length)
     if (!smbios_immutable) {
         smbios_build_type_0_fields();
         smbios_build_type_1_fields();
-        smbios_validate_table();
+        smbios_validate_table(ms);
         smbios_immutable = true;
     }
     *length = smbios_entries_len;
@@ -570,7 +572,7 @@ static void smbios_build_type_3_table(void)
     SMBIOS_BUILD_TABLE_POST;
 }
 
-static void smbios_build_type_4_table(unsigned instance)
+static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
 {
     char sock_str[128];
 
@@ -597,8 +599,8 @@ static void smbios_build_type_4_table(unsigned instance)
     SMBIOS_TABLE_SET_STR(4, serial_number_str, type4.serial);
     SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
-    t->core_count = t->core_enabled = smp_cores;
-    t->thread_count = smp_threads;
+    t->core_count = t->core_enabled = ms->smp.cores;
+    t->thread_count = ms->smp.threads;
     t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
@@ -839,7 +841,8 @@ static void smbios_entry_point_setup(void)
     }
 }
 
-void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
+void smbios_get_tables(MachineState *ms,
+                       const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
                        uint8_t **tables, size_t *tables_len,
                        uint8_t **anchor, size_t *anchor_len)
@@ -858,11 +861,12 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
         smbios_build_type_2_table();
         smbios_build_type_3_table();
 
-        smbios_smp_sockets = DIV_ROUND_UP(smp_cpus, smp_cores * smp_threads);
+        smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
+                                          ms->smp.cores * ms->smp.threads);
         assert(smbios_smp_sockets >= 1);
 
         for (i = 0; i < smbios_smp_sockets; i++) {
-            smbios_build_type_4_table(i);
+            smbios_build_type_4_table(ms, i);
         }
 
         smbios_build_type_11_table();
@@ -888,7 +892,7 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
         smbios_build_type_38_table();
         smbios_build_type_127_table();
 
-        smbios_validate_table();
+        smbios_validate_table(ms);
         smbios_entry_point_setup();
         smbios_immutable = true;
     }
diff --git a/vl.c b/vl.c
index 43113386f7..d657faec03 100644
--- a/vl.c
+++ b/vl.c
@@ -1580,7 +1580,7 @@ void qemu_system_reset(ShutdownCause reason)
     cpu_synchronize_all_states();
 
     if (mc && mc->reset) {
-        mc->reset();
+        mc->reset(current_machine);
     } else {
         qemu_devices_reset();
     }
-- 
2.18.0.rc1.1.g3f1ff2140


