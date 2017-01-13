Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cS3HX-0003Iu-2A
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cS3HT-0003Ku-69
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:56:43 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:34391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cS3HS-0003KB-Pi
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:56:39 -0500
Received: by mail-wm0-x230.google.com with SMTP id f73so12588133wmf.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 06:56:38 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jan 2017 14:56:33 +0000
Message-Id: <20170113145633.15384-4-alex.bennee@linaro.org>
In-Reply-To: <20170113145633.15384-1-alex.bennee@linaro.org>
References: <20170113145633.15384-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] cputlb: drop flush_global flag from
 tlb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

We have never has the concept of global TLB entries which would avoid
the flush so we never actually use this flag. Drop it and make clear
that tlb_flush is the sledge-hammer it has always been.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
[DG: ppc portions]
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 cputlb.c                           | 21 ++++++---------------
 exec.c                             |  4 ++--
 hw/sh4/sh7750.c                    |  2 +-
 include/exec/exec-all.h            | 14 ++++++--------
 target/alpha/cpu.c                 |  2 +-
 target/alpha/sys_helper.c          |  2 +-
 target/arm/helper.c                | 26 +++++++++++++-------------
 target/i386/fpu_helper.c           |  2 +-
 target/i386/helper.c               |  8 ++++----
 target/i386/machine.c              |  2 +-
 target/i386/misc_helper.c          |  2 +-
 target/i386/svm_helper.c           |  2 +-
 target/microblaze/mmu.c            |  2 +-
 target/mips/cpu.h                  |  2 +-
 target/mips/helper.c               |  6 +++---
 target/mips/op_helper.c            |  8 ++++----
 target/openrisc/interrupt.c        |  2 +-
 target/openrisc/interrupt_helper.c |  2 +-
 target/openrisc/sys_helper.c       |  2 +-
 target/ppc/helper_regs.h           |  4 ++--
 target/ppc/misc_helper.c           |  4 ++--
 target/ppc/mmu_helper.c            | 32 ++++++++++++++++----------------
 target/s390x/gdbstub.c             |  2 +-
 target/s390x/mem_helper.c          |  8 ++++----
 target/sh4/helper.c                |  2 +-
 target/sparc/ldst_helper.c         | 12 ++++++------
 target/unicore32/cpu.c             |  2 +-
 target/unicore32/helper.c          |  2 +-
 target/xtensa/op_helper.c          |  2 +-
 29 files changed, 85 insertions(+), 96 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 813279f3bc..6c39927455 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -60,24 +60,15 @@
 /* statistics */
 int tlb_flush_count;
 
-/* NOTE:
- * If flush_global is true (the usual case), flush all tlb entries.
- * If flush_global is false, flush (at least) all tlb entries not
- * marked global.
- *
- * Since QEMU doesn't currently implement a global/not-global flag
- * for tlb entries, at the moment tlb_flush() will also flush all
- * tlb entries in the flush_global == false case. This is OK because
- * CPU architectures generally permit an implementation to drop
- * entries from the TLB at any time, so flushing more entries than
- * required is only an efficiency issue, not a correctness issue.
+/* This is OK because CPU architectures generally permit an
+ * implementation to drop entries from the TLB at any time, so
+ * flushing more entries than required is only an efficiency issue,
+ * not a correctness issue.
  */
-void tlb_flush(CPUState *cpu, int flush_global)
+void tlb_flush(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
-    tlb_debug("(%d)\n", flush_global);
-
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
     memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
@@ -144,7 +135,7 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr)
                   TARGET_FMT_lx "/" TARGET_FMT_lx ")\n",
                   env->tlb_flush_addr, env->tlb_flush_mask);
 
-        tlb_flush(cpu, 1);
+        tlb_flush(cpu);
         return;
     }
 
diff --git a/exec.c b/exec.c
index 47835c1dc1..401a9127c2 100644
--- a/exec.c
+++ b/exec.c
@@ -544,7 +544,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
     /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
        version_id is increased. */
     cpu->interrupt_request &= ~0x01;
-    tlb_flush(cpu, 1);
+    tlb_flush(cpu);
 
     return 0;
 }
@@ -2426,7 +2426,7 @@ static void tcg_commit(MemoryListener *listener)
      */
     d = atomic_rcu_read(&cpuas->as->dispatch);
     atomic_rcu_set(&cpuas->memory_dispatch, d);
-    tlb_flush(cpuas->cpu, 1);
+    tlb_flush(cpuas->cpu);
 }
 
 void address_space_init_dispatch(AddressSpace *as)
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 3132d559d7..166e4bd947 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -417,7 +417,7 @@ static void sh7750_mem_writel(void *opaque, hwaddr addr,
     case SH7750_PTEH_A7:
         /* If asid changes, clear all registered tlb entries. */
         if ((s->cpu->env.pteh & 0xff) != (mem_value & 0xff)) {
-            tlb_flush(CPU(s->cpu), 1);
+            tlb_flush(CPU(s->cpu));
         }
         s->cpu->env.pteh = mem_value;
         return;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a8c13cee66..bbc9478a50 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -95,15 +95,13 @@ void tlb_flush_page(CPUState *cpu, target_ulong addr);
 /**
  * tlb_flush:
  * @cpu: CPU whose TLB should be flushed
- * @flush_global: ignored
  *
- * Flush the entire TLB for the specified CPU.
- * The flush_global flag is in theory an indicator of whether the whole
- * TLB should be flushed, or only those entries not marked global.
- * In practice QEMU does not implement any global/not global flag for
- * TLB entries, and the argument is ignored.
+ * Flush the entire TLB for the specified CPU. Most CPU architectures
+ * allow the implementation to drop entries from the TLB at any time
+ * so this is generally safe. If more selective flushing is required
+ * use one of the other functions for efficiency.
  */
-void tlb_flush(CPUState *cpu, int flush_global);
+void tlb_flush(CPUState *cpu);
 /**
  * tlb_flush_page_by_mmuidx:
  * @cpu: CPU whose TLB should be flushed
@@ -165,7 +163,7 @@ static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
 
-static inline void tlb_flush(CPUState *cpu, int flush_global)
+static inline void tlb_flush(CPUState *cpu)
 {
 }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 30d77ce71c..b4f97983e5 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -273,7 +273,7 @@ static void alpha_cpu_initfn(Object *obj)
     CPUAlphaState *env = &cpu->env;
 
     cs->env_ptr = env;
-    tlb_flush(cs, 1);
+    tlb_flush(cs);
 
     alpha_translate_init();
 
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index bec1e178be..652195de6f 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -44,7 +44,7 @@ uint64_t helper_load_pcc(CPUAlphaState *env)
 #ifndef CONFIG_USER_ONLY
 void helper_tbia(CPUAlphaState *env)
 {
-    tlb_flush(CPU(alpha_env_get_cpu(env)), 1);
+    tlb_flush(CPU(alpha_env_get_cpu(env)));
 }
 
 void helper_tbis(CPUAlphaState *env, uint64_t p)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 77ea5e0025..60fb35c178 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -464,7 +464,7 @@ static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     ARMCPU *cpu = arm_env_get_cpu(env);
 
     raw_write(env, ri, value);
-    tlb_flush(CPU(cpu), 1); /* Flush TLB as domain not tracked in TLB */
+    tlb_flush(CPU(cpu)); /* Flush TLB as domain not tracked in TLB */
 }
 
 static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
@@ -475,7 +475,7 @@ static void fcse_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         /* Unlike real hardware the qemu TLB uses virtual addresses,
          * not modified virtual addresses, so this causes a TLB flush.
          */
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
         raw_write(env, ri, value);
     }
 }
@@ -491,7 +491,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
          * format) this register includes the ASID, so do a TLB flush.
          * For PMSA it is purely a process ID and no action is needed.
          */
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
     raw_write(env, ri, value);
 }
@@ -502,7 +502,7 @@ static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Invalidate all (TLBIALL) */
     ARMCPU *cpu = arm_env_get_cpu(env);
 
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -520,7 +520,7 @@ static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Invalidate by ASID (TLBIASID) */
     ARMCPU *cpu = arm_env_get_cpu(env);
 
-    tlb_flush(CPU(cpu), value == 0);
+    tlb_flush(CPU(cpu));
 }
 
 static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -539,7 +539,7 @@ static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush(other_cs, 1);
+        tlb_flush(other_cs);
     }
 }
 
@@ -549,7 +549,7 @@ static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *other_cs;
 
     CPU_FOREACH(other_cs) {
-        tlb_flush(other_cs, value == 0);
+        tlb_flush(other_cs);
     }
 }
 
@@ -2304,7 +2304,7 @@ static void pmsav7_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     u32p += env->cp15.c6_rgnr;
-    tlb_flush(CPU(cpu), 1); /* Mappings may have changed - purge! */
+    tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
     *u32p = value;
 }
 
@@ -2449,7 +2449,7 @@ static void vmsa_ttbcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         /* With LPAE the TTBCR could result in a change of ASID
          * via the TTBCR.A1 bit, so do a TLB flush.
          */
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
     vmsa_ttbcr_raw_write(env, ri, value);
 }
@@ -2473,7 +2473,7 @@ static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     TCR *tcr = raw_ptr(env, ri);
 
     /* For AArch64 the A1 bit could result in a change of ASID, so TLB flush. */
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
     tcr->raw_tcr = value;
 }
 
@@ -2486,7 +2486,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpreg_field_is_64bit(ri)) {
         ARMCPU *cpu = arm_env_get_cpu(env);
 
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
     raw_write(env, ri, value);
 }
@@ -3154,7 +3154,7 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
     /* ??? Lots of these bits are not implemented.  */
     /* This may enable/disable the MMU, so do a TLB flush.  */
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3622,7 +3622,7 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
      * HCR_DC Disables stage1 and enables stage2 translation
      */
     if ((raw_read(env, ri) ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
     raw_write(env, ri, value);
 }
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 2049a8c01d..66474ad98e 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1465,7 +1465,7 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
         }
         if (env->pkru != old_pkru) {
             CPUState *cs = CPU(x86_env_get_cpu(env));
-            tlb_flush(cs, 1);
+            tlb_flush(cs);
         }
     }
 }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 43e87ddba0..c86272efab 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -586,7 +586,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
 
         /* when a20 is changed, all the MMU mappings are invalid, so
            we must flush everything */
-        tlb_flush(cs, 1);
+        tlb_flush(cs);
         env->a20_mask = ~(1 << 20) | (a20_state << 20);
     }
 }
@@ -599,7 +599,7 @@ void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
     qemu_log_mask(CPU_LOG_MMU, "CR0 update: CR0=0x%08x\n", new_cr0);
     if ((new_cr0 & (CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK)) !=
         (env->cr[0] & (CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK))) {
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
 
 #ifdef TARGET_X86_64
@@ -641,7 +641,7 @@ void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3)
     if (env->cr[0] & CR0_PG_MASK) {
         qemu_log_mask(CPU_LOG_MMU,
                         "CR3 update: CR3=" TARGET_FMT_lx "\n", new_cr3);
-        tlb_flush(CPU(cpu), 0);
+        tlb_flush(CPU(cpu));
     }
 }
 
@@ -656,7 +656,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
     if ((new_cr4 ^ env->cr[4]) &
         (CR4_PGE_MASK | CR4_PAE_MASK | CR4_PSE_MASK |
          CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_LA57_MASK)) {
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
 
     /* Clear bits we're going to recompute.  */
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 760f82b6c7..e002b4fc6d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -387,7 +387,7 @@ static int cpu_post_load(void *opaque, int version_id)
         env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
         cpu_x86_update_dr7(env, dr7);
     }
-    tlb_flush(cs, 1);
+    tlb_flush(cs);
 
     if (tcg_enabled()) {
         cpu_smm_update(cpu);
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 3f666b4b87..5029efef47 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -635,5 +635,5 @@ void helper_wrpkru(CPUX86State *env, uint32_t ecx, uint64_t val)
     }
 
     env->pkru = val;
-    tlb_flush(cs, 1);
+    tlb_flush(cs);
 }
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 782b3f12f0..210f6aa7b5 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -289,7 +289,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
         break;
     case TLB_CONTROL_FLUSH_ALL_ASID:
         /* FIXME: this is not 100% correct but should work for now */
-        tlb_flush(cs, 1);
+        tlb_flush(cs);
         break;
     }
 
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index a22a496ebb..a0f06758f8 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -255,7 +255,7 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
             /* Changes to the zone protection reg flush the QEMU TLB.
                Fortunately, these are very uncommon.  */
             if (v != env->mmu.regs[rn]) {
-                tlb_flush(CPU(cpu), 1);
+                tlb_flush(CPU(cpu));
             }
             env->mmu.regs[rn] = v;
             break;
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3146a6017d..e1c78f55ec 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1054,7 +1054,7 @@ static inline void compute_hflags(CPUMIPSState *env)
     }
 }
 
-void cpu_mips_tlb_flush(CPUMIPSState *env, int flush_global);
+void cpu_mips_tlb_flush(CPUMIPSState *env);
 void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc);
 void cpu_mips_store_status(CPUMIPSState *env, target_ulong val);
 void cpu_mips_store_cause(CPUMIPSState *env, target_ulong val);
diff --git a/target/mips/helper.c b/target/mips/helper.c
index c864b15b97..d2e77958fd 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -223,12 +223,12 @@ static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
     return ret;
 }
 
-void cpu_mips_tlb_flush(CPUMIPSState *env, int flush_global)
+void cpu_mips_tlb_flush(CPUMIPSState *env)
 {
     MIPSCPU *cpu = mips_env_get_cpu(env);
 
     /* Flush qemu's TLB and discard all shadowed entries.  */
-    tlb_flush(CPU(cpu), flush_global);
+    tlb_flush(CPU(cpu));
     env->tlb->tlb_in_use = env->tlb->nb_tlb;
 }
 
@@ -290,7 +290,7 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
 #if defined(TARGET_MIPS64)
     if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
         /* Access to at least one of the 64-bit segments has been disabled */
-        cpu_mips_tlb_flush(env, 1);
+        cpu_mips_tlb_flush(env);
     }
 #endif
     if (env->CP0_Config3 & (1 << CP0C3_MT)) {
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 11d781fc91..b683fcb025 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1409,7 +1409,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
     /* If the ASID changes, flush qemu's TLB.  */
     if ((old & env->CP0_EntryHi_ASID_mask) !=
         (val & env->CP0_EntryHi_ASID_mask)) {
-        cpu_mips_tlb_flush(env, 1);
+        cpu_mips_tlb_flush(env);
     }
 }
 
@@ -1999,7 +1999,7 @@ void r4k_helper_tlbinv(CPUMIPSState *env)
             tlb->EHINV = 1;
         }
     }
-    cpu_mips_tlb_flush(env, 1);
+    cpu_mips_tlb_flush(env);
 }
 
 void r4k_helper_tlbinvf(CPUMIPSState *env)
@@ -2009,7 +2009,7 @@ void r4k_helper_tlbinvf(CPUMIPSState *env)
     for (idx = 0; idx < env->tlb->nb_tlb; idx++) {
         env->tlb->mmu.r4k.tlb[idx].EHINV = 1;
     }
-    cpu_mips_tlb_flush(env, 1);
+    cpu_mips_tlb_flush(env);
 }
 
 void r4k_helper_tlbwi(CPUMIPSState *env)
@@ -2123,7 +2123,7 @@ void r4k_helper_tlbr(CPUMIPSState *env)
 
     /* If this will change the current ASID, flush qemu's TLB.  */
     if (ASID != tlb->ASID)
-        cpu_mips_tlb_flush (env, 1);
+        cpu_mips_tlb_flush(env);
 
     r4k_mips_tlb_flush_extra(env, env->tlb->nb_tlb);
 
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 5fe3f11ffc..e43fc84ef7 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -45,7 +45,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
 
     /* For machine-state changed between user-mode and supervisor mode,
        we need flush TLB when we enter&exit EXCP.  */
-    tlb_flush(cs, 1);
+    tlb_flush(cs);
 
     env->esr = env->sr;
     env->sr &= ~SR_DME;
diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
index 116f9109a7..0ed5146e8d 100644
--- a/target/openrisc/interrupt_helper.c
+++ b/target/openrisc/interrupt_helper.c
@@ -53,7 +53,7 @@ void HELPER(rfe)(CPUOpenRISCState *env)
     }
 
     if (need_flush_tlb) {
-        tlb_flush(cs, 1);
+        tlb_flush(cs);
     }
 #endif
     cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index a719e452be..daea902856 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -47,7 +47,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 17): /* SR */
         if ((env->sr & (SR_IME | SR_DME | SR_SM)) ^
             (rb & (SR_IME | SR_DME | SR_SM))) {
-            tlb_flush(cs, 1);
+            tlb_flush(cs);
         }
         env->sr = rb;
         env->sr |= SR_FO;      /* FO is const equal to 1 */
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 62138163a5..2627a70176 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -161,7 +161,7 @@ static inline void check_tlb_flush(CPUPPCState *env, bool global)
 {
     CPUState *cs = CPU(ppc_env_get_cpu(env));
     if (env->tlb_need_flush & TLB_NEED_LOCAL_FLUSH) {
-        tlb_flush(cs, 1);
+        tlb_flush(cs);
         env->tlb_need_flush &= ~TLB_NEED_LOCAL_FLUSH;
     }
 
@@ -176,7 +176,7 @@ static inline void check_tlb_flush(CPUPPCState *env, bool global)
                 CPUPPCState *other_env = &cpu->env;
 
                 other_env->tlb_need_flush &= ~TLB_NEED_LOCAL_FLUSH;
-                tlb_flush(other_cs, 1);
+                tlb_flush(other_cs);
             }
         }
         env->tlb_need_flush &= ~TLB_NEED_GLOBAL_FLUSH;
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 1e6e705a4e..ab432bafaf 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -85,7 +85,7 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong val)
     if (!env->external_htab) {
         if (env->spr[SPR_SDR1] != val) {
             ppc_store_sdr1(env, val);
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
         }
     }
 }
@@ -114,7 +114,7 @@ void helper_store_403_pbr(CPUPPCState *env, uint32_t num, target_ulong value)
     if (likely(env->pb[num] != value)) {
         env->pb[num] = value;
         /* Should be optimized */
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
 }
 
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index d09fc0a85f..f746f53615 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -248,7 +248,7 @@ static inline void ppc6xx_tlb_invalidate_all(CPUPPCState *env)
         tlb = &env->tlb.tlb6[nr];
         pte_invalidate(&tlb->pte0);
     }
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 static inline void ppc6xx_tlb_invalidate_virt2(CPUPPCState *env,
@@ -661,7 +661,7 @@ static inline void ppc4xx_tlb_invalidate_all(CPUPPCState *env)
         tlb = &env->tlb.tlbe[i];
         tlb->prot &= ~PAGE_VALID;
     }
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
@@ -863,7 +863,7 @@ static void booke206_flush_tlb(CPUPPCState *env, int flags,
         tlb += booke206_tlb_size(env, i);
     }
 
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 static hwaddr booke206_tlb_to_page_size(CPUPPCState *env,
@@ -1769,7 +1769,7 @@ void helper_store_ibatu(CPUPPCState *env, uint32_t nr, target_ulong value)
 #if !defined(FLUSH_ALL_TLBS)
         do_invalidate_BAT(env, env->IBAT[0][nr], mask);
 #else
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
 #endif
     }
 }
@@ -1804,7 +1804,7 @@ void helper_store_dbatu(CPUPPCState *env, uint32_t nr, target_ulong value)
 #if !defined(FLUSH_ALL_TLBS)
         do_invalidate_BAT(env, env->DBAT[0][nr], mask);
 #else
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
 #endif
     }
 }
@@ -1852,7 +1852,7 @@ void helper_store_601_batu(CPUPPCState *env, uint32_t nr, target_ulong value)
         }
 #if defined(FLUSH_ALL_TLBS)
         if (do_inval) {
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
         }
 #endif
     }
@@ -1892,7 +1892,7 @@ void helper_store_601_batl(CPUPPCState *env, uint32_t nr, target_ulong value)
         env->DBAT[1][nr] = value;
 #if defined(FLUSH_ALL_TLBS)
         if (do_inval) {
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
         }
 #endif
     }
@@ -1921,7 +1921,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
         cpu_abort(CPU(cpu), "MPC8xx MMU model is not implemented\n");
         break;
     case POWERPC_MMU_BOOKE:
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
         break;
     case POWERPC_MMU_BOOKE206:
         booke206_flush_tlb(env, -1, 0);
@@ -1937,7 +1937,7 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
     case POWERPC_MMU_2_07a:
 #endif /* defined(TARGET_PPC64) */
         env->tlb_need_flush = 0;
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
         break;
     default:
         /* XXX: TODO */
@@ -2433,13 +2433,13 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
         }
         tlb->PID = env->spr[SPR_440_MMUCR] & 0x000000FF;
         if (do_flush_tlbs) {
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
         }
         break;
     case 1:
         RPN = value & 0xFFFFFC0F;
         if ((tlb->prot & PAGE_VALID) && tlb->RPN != RPN) {
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
         }
         tlb->RPN = RPN;
         break;
@@ -2555,7 +2555,7 @@ void helper_booke_setpid(CPUPPCState *env, uint32_t pidn, target_ulong pid)
 
     env->spr[pidn] = pid;
     /* changing PIDs mean we're in a different address space now */
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 void helper_booke206_tlbwe(CPUPPCState *env)
@@ -2650,7 +2650,7 @@ void helper_booke206_tlbwe(CPUPPCState *env)
     if (booke206_tlb_to_page_size(env, tlb) == TARGET_PAGE_SIZE) {
         tlb_flush_page(CPU(cpu), tlb->mas2 & MAS2_EPN_MASK);
     } else {
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
 }
 
@@ -2775,7 +2775,7 @@ void helper_booke206_tlbivax(CPUPPCState *env, target_ulong address)
         /* flush TLB1 entries */
         booke206_invalidate_ea_tlb(env, 1, address);
         CPU_FOREACH(cs) {
-            tlb_flush(cs, 1);
+            tlb_flush(cs);
         }
     } else {
         /* flush TLB0 entries */
@@ -2811,7 +2811,7 @@ void helper_booke206_tlbilx1(CPUPPCState *env, target_ulong address)
         }
         tlb += booke206_tlb_size(env, i);
     }
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
@@ -2852,7 +2852,7 @@ void helper_booke206_tlbilx3(CPUPPCState *env, target_ulong address)
             tlb->mas1 &= ~MAS1_VALID;
         }
     }
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 void helper_booke206_tlbflush(CPUPPCState *env, target_ulong type)
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 3d223dec97..ea4dc22eeb 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -199,7 +199,7 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
     case S390_C0_REGNUM ... S390_C15_REGNUM:
         env->cregs[n] = ldtul_p(mem_buf);
         if (tcg_enabled()) {
-            tlb_flush(ENV_GET_CPU(env), 1);
+            tlb_flush(ENV_GET_CPU(env));
         }
         cpu_synchronize_post_init(ENV_GET_CPU(env));
         return 8;
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 99bc5e2834..675aba2e44 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -872,7 +872,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
         s390_cpu_recompute_watchpoints(CPU(cpu));
     }
 
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
@@ -900,7 +900,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
         s390_cpu_recompute_watchpoints(CPU(cpu));
     }
 
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
@@ -1036,7 +1036,7 @@ uint32_t HELPER(csp)(CPUS390XState *env, uint32_t r1, uint64_t r2)
         cpu_stl_data(env, a2, env->regs[(r1 + 1) & 15]);
         if (r2 & 0x3) {
             /* flush TLB / ALB */
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
         }
         cc = 0;
     } else {
@@ -1121,7 +1121,7 @@ void HELPER(ptlb)(CPUS390XState *env)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
 
-    tlb_flush(CPU(cpu), 1);
+    tlb_flush(CPU(cpu));
 }
 
 /* load using real address */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index a33ac697c5..036c5ca56c 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -583,7 +583,7 @@ void cpu_load_tlb(CPUSH4State * env)
         entry->v = 0;
     }
 
-    tlb_flush(CPU(sh_env_get_cpu(s)), 1);
+    tlb_flush(CPU(sh_env_get_cpu(s)));
 }
 
 uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index de7d53ae20..a0171f73f7 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -816,7 +816,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
             case 2: /* flush region (16M) */
             case 3: /* flush context (4G) */
             case 4: /* flush entire */
-                tlb_flush(CPU(cpu), 1);
+                tlb_flush(CPU(cpu));
                 break;
             default:
                 break;
@@ -841,7 +841,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                    are invalid in normal mode.  */
                 if ((oldreg ^ env->mmuregs[reg])
                     & (MMU_NF | env->def->mmu_bm)) {
-                    tlb_flush(CPU(cpu), 1);
+                    tlb_flush(CPU(cpu));
                 }
                 break;
             case 1: /* Context Table Pointer Register */
@@ -852,7 +852,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 if (oldreg != env->mmuregs[reg]) {
                     /* we flush when the MMU context changes because
                        QEMU has no MMU context support */
-                    tlb_flush(CPU(cpu), 1);
+                    tlb_flush(CPU(cpu));
                 }
                 break;
             case 3: /* Synchronous Fault Status Register with Clear */
@@ -1509,13 +1509,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                 env->dmmu.mmu_primary_context = val;
                 /* can be optimized to only flush MMU_USER_IDX
                    and MMU_KERNEL_IDX entries */
-                tlb_flush(CPU(cpu), 1);
+                tlb_flush(CPU(cpu));
                 break;
             case 2: /* Secondary context */
                 env->dmmu.mmu_secondary_context = val;
                 /* can be optimized to only flush MMU_USER_SECONDARY_IDX
                    and MMU_KERNEL_SECONDARY_IDX entries */
-                tlb_flush(CPU(cpu), 1);
+                tlb_flush(CPU(cpu));
                 break;
             case 5: /* TSB access */
                 DPRINTF_MMU("dmmu TSB write: 0x%016" PRIx64 " -> 0x%016"
@@ -1654,7 +1654,7 @@ void sparc_cpu_unassigned_access(CPUState *cs, hwaddr addr,
     /* flush neverland mappings created during no-fault mode,
        so the sequential MMU faults report proper fault types */
     if (env->mmuregs[0] & MMU_NF) {
-        tlb_flush(cs, 1);
+        tlb_flush(cs);
     }
 }
 #else
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index c169972b59..c9b78ce68e 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -133,7 +133,7 @@ static void uc32_cpu_initfn(Object *obj)
     env->regs[31] = 0x03000000;
 #endif
 
-    tlb_flush(cs, 1);
+    tlb_flush(cs);
 
     if (tcg_enabled() && !inited) {
         inited = true;
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 7a5613e776..f9239dc7b8 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -106,7 +106,7 @@ void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
     case 6:
         if ((cop <= 6) && (cop >= 2)) {
             /* invalid all tlb */
-            tlb_flush(CPU(cpu), 1);
+            tlb_flush(CPU(cpu));
             return;
         }
         break;
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index dc25625d0d..dc0dd351bb 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -479,7 +479,7 @@ void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
     v = (v & 0xffffff00) | 0x1;
     if (v != env->sregs[RASID]) {
         env->sregs[RASID] = v;
-        tlb_flush(CPU(cpu), 1);
+        tlb_flush(CPU(cpu));
     }
 }
 
-- 
2.11.0
