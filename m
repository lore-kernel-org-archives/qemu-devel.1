Received: from eggs.gnu.org ([2001:4830:134:3::10]:60053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaj-0002PP-7I
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzah-0002PV-BI
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:20 +1000
Message-Id: <20180427092126.24812-44-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 43/49] target/ppc: Fold slb_nr into
 PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The env->slb_nr field gives the size of the SLB (Segment Lookaside Buffer).
This is another static-after-initialization parameter of the specific
version of the 64-bit hash MMU in the CPU.  So, this patch folds the field
into PPCHash64Options with the other hash MMU options.

This is a bit more complicated that the things previously put in there,
because slb_nr was foolishly included in the migration stream.  So we need
some of the usual dance to handle backwards compatible migration.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c                |  2 +-
 hw/ppc/spapr.c              | 11 ++++++++---
 target/ppc/cpu.h            |  3 ++-
 target/ppc/kvm.c            |  2 +-
 target/ppc/machine.c        | 23 ++++++++++++++++++++---
 target/ppc/mmu-hash64.c     | 15 +++++++++------
 target/ppc/mmu-hash64.h     |  1 +
 target/ppc/translate_init.c | 17 ++---------------
 8 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0e49c5e9b8..0314881316 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -180,7 +180,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
     _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", env->slb_nr)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts->slb_size)));
     _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
     _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index abf38c62e8..8c2e3ccb89 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -547,8 +547,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
 
     _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
     _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", env->slb_nr)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", env->slb_nr)));
+    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->slb_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts->slb_size)));
     _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
     _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
 
@@ -3958,7 +3958,12 @@ DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
  * pseries-2.12
  */
 #define SPAPR_COMPAT_2_12                                              \
-    HW_COMPAT_2_12
+    HW_COMPAT_2_12                                                     \
+    {                                                                  \
+        .driver = TYPE_POWERPC_CPU,                                    \
+        .property = "pre-2.13-migration",                              \
+        .value    = "on",                                              \
+    },
 
 static void spapr_machine_2_12_instance_options(MachineState *machine)
 {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c0c44fb91d..8c9e03f54d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1025,7 +1025,6 @@ struct CPUPPCState {
 #if defined(TARGET_PPC64)
     /* PowerPC 64 SLB area */
     ppc_slb_t slb[MAX_SLB_ENTRIES];
-    int32_t slb_nr;
     /* tcg TLB needs flush (deferred slb inval instruction typically) */
 #endif
     /* segment registers */
@@ -1216,6 +1215,8 @@ struct PowerPCCPU {
     uint64_t mig_insns_flags2;
     uint32_t mig_nb_BATs;
     bool pre_2_10_migration;
+    bool pre_2_13_migration;
+    int32_t mig_slb_nr;
 };
 
 static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 246b9eab2a..6de59c5b21 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -484,7 +484,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
             break;
         }
     }
-    env->slb_nr = smmu_info.slb_size;
+    cpu->hash64_opts->slb_size = smmu_info.slb_size;
     if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
         cpu->hash64_opts->flags &= ~PPC_HASH64_1TSEG;
     }
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 0634cdb295..3d6434a006 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -18,6 +18,9 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     unsigned int i, j;
     target_ulong sdr1;
     uint32_t fpscr;
+#if defined(TARGET_PPC64)
+    int32_t slb_nr;
+#endif
     target_ulong xer;
 
     for (i = 0; i < 32; i++)
@@ -49,7 +52,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     qemu_get_sbe32s(f, &env->access_type);
 #if defined(TARGET_PPC64)
     qemu_get_betls(f, &env->spr[SPR_ASR]);
-    qemu_get_sbe32s(f, &env->slb_nr);
+    qemu_get_sbe32s(f, &slb_nr);
 #endif
     qemu_get_betls(f, &sdr1);
     for (i = 0; i < 32; i++)
@@ -146,6 +149,15 @@ static bool cpu_pre_2_8_migration(void *opaque, int version_id)
     return cpu->pre_2_8_migration;
 }
 
+#if defined(TARGET_PPC64)
+static bool cpu_pre_2_13_migration(void *opaque, int version_id)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->pre_2_13_migration;
+}
+#endif
+
 static int cpu_pre_save(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -203,6 +215,11 @@ static int cpu_pre_save(void *opaque)
         cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
         cpu->mig_nb_BATs = env->nb_BATs;
     }
+    if (cpu->pre_2_13_migration) {
+        if (cpu->hash64_opts) {
+            cpu->mig_slb_nr = cpu->hash64_opts->slb_size;
+        }
+    }
 
     return 0;
 }
@@ -478,7 +495,7 @@ static int slb_post_load(void *opaque, int version_id)
 
     /* We've pulled in the raw esid and vsid values from the migration
      * stream, but we need to recompute the page size pointers */
-    for (i = 0; i < env->slb_nr; i++) {
+    for (i = 0; i < cpu->hash64_opts->slb_size; i++) {
         if (ppc_store_slb(cpu, i, env->slb[i].esid, env->slb[i].vsid) < 0) {
             /* Migration source had bad values in its SLB */
             return -1;
@@ -495,7 +512,7 @@ static const VMStateDescription vmstate_slb = {
     .needed = slb_needed,
     .post_load = slb_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.slb_nr, PowerPCCPU, NULL),
+        VMSTATE_INT32_TEST(mig_slb_nr, PowerPCCPU, cpu_pre_2_13_migration),
         VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
         VMSTATE_END_OF_LIST()
     }
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a5570c8774..7e0adecfd9 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -52,7 +52,7 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_ulong eaddr)
     esid_256M = (eaddr & SEGMENT_MASK_256M) | SLB_ESID_V;
     esid_1T = (eaddr & SEGMENT_MASK_1T) | SLB_ESID_V;
 
-    for (n = 0; n < env->slb_nr; n++) {
+    for (n = 0; n < cpu->hash64_opts->slb_size; n++) {
         ppc_slb_t *slb = &env->slb[n];
 
         LOG_SLB("%s: slot %d %016" PRIx64 " %016"
@@ -80,7 +80,7 @@ void dump_slb(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu)
     cpu_synchronize_state(CPU(cpu));
 
     cpu_fprintf(f, "SLB\tESID\t\t\tVSID\n");
-    for (i = 0; i < env->slb_nr; i++) {
+    for (i = 0; i < cpu->hash64_opts->slb_size; i++) {
         slbe = env->slb[i].esid;
         slbv = env->slb[i].vsid;
         if (slbe == 0 && slbv == 0) {
@@ -93,10 +93,11 @@ void dump_slb(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu)
 
 void helper_slbia(CPUPPCState *env)
 {
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
     int n;
 
     /* XXX: Warning: slbia never invalidates the first segment */
-    for (n = 1; n < env->slb_nr; n++) {
+    for (n = 1; n < cpu->hash64_opts->slb_size; n++) {
         ppc_slb_t *slb = &env->slb[n];
 
         if (slb->esid & SLB_ESID_V) {
@@ -151,7 +152,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
     const PPCHash64SegmentPageSizes *sps = NULL;
     int i;
 
-    if (slot >= env->slb_nr) {
+    if (slot >= cpu->hash64_opts->slb_size) {
         return -1; /* Bad slot number */
     }
     if (esid & ~(SLB_ESID_ESID | SLB_ESID_V)) {
@@ -202,7 +203,7 @@ static int ppc_load_slb_esid(PowerPCCPU *cpu, target_ulong rb,
     int slot = rb & 0xfff;
     ppc_slb_t *slb = &env->slb[slot];
 
-    if (slot >= env->slb_nr) {
+    if (slot >= cpu->hash64_opts->slb_size) {
         return -1;
     }
 
@@ -217,7 +218,7 @@ static int ppc_load_slb_vsid(PowerPCCPU *cpu, target_ulong rb,
     int slot = rb & 0xfff;
     ppc_slb_t *slb = &env->slb[slot];
 
-    if (slot >= env->slb_nr) {
+    if (slot >= cpu->hash64_opts->slb_size) {
         return -1;
     }
 
@@ -1115,6 +1116,7 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
 
 const PPCHash64Options ppc_hash64_opts_basic = {
     .flags = 0,
+    .slb_size = 64,
     .sps = {
         { .page_shift = 12, /* 4K */
           .slb_enc = 0,
@@ -1129,6 +1131,7 @@ const PPCHash64Options ppc_hash64_opts_basic = {
 
 const PPCHash64Options ppc_hash64_opts_POWER7 = {
     .flags = PPC_HASH64_1TSEG | PPC_HASH64_AMR | PPC_HASH64_CI_LARGEPAGE,
+    .slb_size = 32,
     .sps = {
         {
             .page_shift = 12, /* 4K */
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index f1babb0afc..d5fc03441d 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -157,6 +157,7 @@ struct PPCHash64Options {
 #define PPC_HASH64_AMR          0x00002
 #define PPC_HASH64_CI_LARGEPAGE 0x00004
     unsigned flags;
+    unsigned slb_size;
     PPCHash64SegmentPageSizes sps[PPC_PAGE_SIZES_MAX_SZ];
 };
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index a925cf5cd3..bb79d23b50 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8195,9 +8195,6 @@ static void init_proc_970(CPUPPCState *env)
     gen_spr_970_dbg(env);
 
     /* env variables */
-#if !defined(CONFIG_USER_ONLY)
-    env->slb_nr = 64;
-#endif
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
@@ -8272,9 +8269,6 @@ static void init_proc_power5plus(CPUPPCState *env)
     gen_spr_power5p_ear(env);
 
     /* env variables */
-#if !defined(CONFIG_USER_ONLY)
-    env->slb_nr = 64;
-#endif
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
@@ -8389,9 +8383,6 @@ static void init_proc_POWER7(CPUPPCState *env)
     gen_spr_power7_book4(env);
 
     /* env variables */
-#if !defined(CONFIG_USER_ONLY)
-    env->slb_nr = 32;
-#endif
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
@@ -8543,9 +8534,6 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power8_rpr(env);
 
     /* env variables */
-#if !defined(CONFIG_USER_ONLY)
-    env->slb_nr = 32;
-#endif
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
@@ -8743,9 +8731,6 @@ static void init_proc_POWER9(CPUPPCState *env)
                         KVM_REG_PPC_PSSCR, 0);
 
     /* env variables */
-#if !defined(CONFIG_USER_ONLY)
-    env->slb_nr = 32;
-#endif
     env->dcache_line_size = 128;
     env->icache_line_size = 128;
 
@@ -10486,6 +10471,8 @@ static Property ppc_cpu_properties[] = {
     DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
     DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
                      false),
+    DEFINE_PROP_BOOL("pre-2.13-migration", PowerPCCPU, pre_2_13_migration,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.3
