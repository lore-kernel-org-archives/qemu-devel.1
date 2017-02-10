Received: from eggs.gnu.org ([2001:4830:134:3::10]:40412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3jF-0006Qq-9B
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3jD-0001cI-Ht
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:41 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 10 Feb 2017 16:25:56 +1100
Message-Id: <1486704360-27361-7-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V2 06/10] target/ppc: Don't use SDR1
 when running under a POWER9 cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The SDR1 register was used on pre-POWER9 processors to store the location
of the hash page table, however now this information will be stored in the
partition table so we don't have SDR1 anymore. Additionally this register
was only applicable for powernv as it is a hypervisor resource and thus
shouldn't be accessed on a pseries machine.

We no longer generate the SDR1 register if we are on a POWER9 or later cpu.
We also rename the functions ppc_hash64_set_sdr1->ppc_hash64_set_htab and
ppc_store_sdr1->ppc_store_htab to indicate that they are primarily
concerned with setting htab_[base/mask].

We still set SDR1 in ppc_hash64_set_external_hpt for non-POWER9 cpus as
this is used for kvm-pr to tell the hypervisor where the hash table is,
note this means kvm-pr isn't yet supported on a POWER9 cpu model.

We set SDR1 in ppc_store_htab for non-POWER9 cpus as this is the called
by the powernv machine code to restore the sdr1 (and htab_[mask/base])
on incoming migration, note this means that the powernv machine isn't
yet supported on a POWER9 cpu model.

We also adapt the debug code to only print the SDR1 value if the register
has been created.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h            |  2 +-
 target/ppc/kvm.c            |  2 +-
 target/ppc/machine.c        |  4 ++--
 target/ppc/misc_helper.c    |  3 ++-
 target/ppc/mmu-hash64.c     | 12 +++++++++---
 target/ppc/mmu-hash64.h     |  2 +-
 target/ppc/mmu_helper.c     | 12 +++++++++---
 target/ppc/translate.c      |  7 +++++--
 target/ppc/translate_init.c | 17 ++++++++++++++---
 9 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a148729..1ae0719 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1265,7 +1265,7 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
-void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
+void ppc_store_htab(CPUPPCState *env, target_ulong value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 663d2e7..5e2323c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1228,7 +1228,7 @@ static int kvmppc_get_books_sregs(PowerPCCPU *cpu)
     }
 
     if (!env->external_htab) {
-        ppc_store_sdr1(env, sregs.u.s.sdr1);
+        ppc_store_htab(env, sregs.u.s.sdr1);
     }
 
     /* Sync SLB */
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index df9f7a4..f6d5ade 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -77,7 +77,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     for (i = 0; i < 1024; i++)
         qemu_get_betls(f, &env->spr[i]);
     if (!env->external_htab) {
-        ppc_store_sdr1(env, sdr1);
+        ppc_store_htab(env, sdr1);
     }
     qemu_get_be32s(f, &env->vscr);
     qemu_get_be64s(f, &env->spe_acc);
@@ -230,7 +230,7 @@ static int cpu_post_load(void *opaque, int version_id)
 
     if (!env->external_htab) {
         /* Restore htab_base and htab_mask variables */
-        ppc_store_sdr1(env, env->spr[SPR_SDR1]);
+        ppc_store_htab(env, env->spr[SPR_SDR1]);
     }
 
     /* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring */
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index ab432ba..49ba767 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -84,7 +84,8 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 
     if (!env->external_htab) {
         if (env->spr[SPR_SDR1] != val) {
-            ppc_store_sdr1(env, val);
+            env->spr[SPR_SDR1] = val;
+            ppc_store_htab(env, val);
             tlb_flush(CPU(cpu));
         }
     }
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 7c5d589..e658873 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -285,13 +285,12 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env, target_ulong rb)
 /*
  * 64-bit hash table MMU handling
  */
-void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
+void ppc_hash64_set_htab(PowerPCCPU *cpu, target_ulong value,
                          Error **errp)
 {
     CPUPPCState *env = &cpu->env;
     target_ulong htabsize = value & SDR_64_HTABSIZE;
 
-    env->spr[SPR_SDR1] = value;
     if (htabsize > 28) {
         error_setg(errp,
                    "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
@@ -313,7 +312,14 @@ void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
     } else {
         env->external_htab = MMU_HASH64_KVM_MANAGED_HPT;
     }
-    ppc_hash64_set_sdr1(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18),
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        break; /* Power 9 doesn't have an SDR1 */
+    default:
+        env->spr[SPR_SDR1] = (target_ulong) hpt | (shift - 18);
+        break;
+    }
+    ppc_hash64_set_htab(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18),
                         &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 7a0b7fc..e930934 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -91,7 +91,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
 #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
 
-void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
+void ppc_hash64_set_htab(PowerPCCPU *cpu, target_ulong value,
                          Error **errp);
 void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
                                  Error **errp);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 172a305..e893e72 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1995,17 +1995,23 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
 
 /*****************************************************************************/
 /* Special registers manipulation */
-void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
+void ppc_store_htab(CPUPPCState *env, target_ulong value)
 {
     qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, value);
     assert(!env->external_htab);
-    env->spr[SPR_SDR1] = value;
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00: /* POWER 9 doesn't have an SDR1 */
+        break;
+    default: /* Pre-POWER9 does */
+        env->spr[SPR_SDR1] = value;
+        break;
+    }
 #if defined(TARGET_PPC64)
     if (env->mmu_model & POWERPC_MMU_64) {
         PowerPCCPU *cpu = ppc_env_get_cpu(env);
         Error *local_err = NULL;
 
-        ppc_hash64_set_sdr1(cpu, value, &local_err);
+        ppc_hash64_set_htab(cpu, value, &local_err);
         if (local_err) {
             error_report_err(local_err);
             error_free(local_err);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b48abae..473a40a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6850,9 +6850,12 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     case POWERPC_MMU_2_06a:
     case POWERPC_MMU_2_07:
     case POWERPC_MMU_2_07a:
+    case POWERPC_MMU_3_00:
 #endif
-        cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
-                       "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],
+        if (env->spr_cb[SPR_SDR1].name) {
+            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
+        }
+        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "\n",
                     env->spr[SPR_DAR], env->spr[SPR_DSISR]);
         break;
     case POWERPC_MMU_BOOKE206:
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index be35cbd..f401d31 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
+#include "mmu.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -722,8 +723,8 @@ static void gen_spr_generic (CPUPPCState *env)
                  0x00000000);
 }
 
-/* SPR common to all non-embedded PowerPC, including 601 */
-static void gen_spr_ne_601 (CPUPPCState *env)
+/* SPR common to all non-embedded PowerPC, including POWER9 */
+static void gen_spr_ne_power9(CPUPPCState *env)
 {
     /* Exception processing */
     spr_register_kvm(env, SPR_DSISR, "DSISR",
@@ -739,6 +740,12 @@ static void gen_spr_ne_601 (CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
+}
+
+/* SPR common to all non-embedded PowerPC, including 601 */
+static void gen_spr_ne_601(CPUPPCState *env)
+{
+    gen_spr_ne_power9(env);
     /* Memory management */
     spr_register(env, SPR_SDR1, "SDR1",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -8200,7 +8207,6 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
 
 static void init_proc_book3s_64(CPUPPCState *env, int version)
 {
-    gen_spr_ne_601(env);
     gen_tbl(env);
     gen_spr_book3s_altivec(env);
     gen_spr_book3s_pmu_sup(env);
@@ -8258,6 +8264,11 @@ static void init_proc_book3s_64(CPUPPCState *env, int version)
         gen_spr_power8_book4(env);
         gen_spr_power8_rpr(env);
     }
+    if (version >= BOOK3S_CPU_POWER9) {
+        gen_spr_ne_power9(env);
+    } else {
+        gen_spr_ne_601(env);
+    }
     if (version < BOOK3S_CPU_POWER8) {
         gen_spr_book3s_dbg(env);
     } else {
-- 
2.5.5
