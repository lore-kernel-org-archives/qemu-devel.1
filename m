Received: from eggs.gnu.org ([2001:4830:134:3::10]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecG1m-0004d1-J4
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecG1j-0000zE-Tt
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:39:10 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:62654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ecG1j-0000ym-Is
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 14:39:07 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 18 Jan 2018 20:38:45 +0100
Message-Id: <20180118193846.24953-7-laurent@vivier.eu>
In-Reply-To: <20180118193846.24953-1-laurent@vivier.eu>
References: <20180118193846.24953-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v4 6/7] target/m68k: add pflush/ptest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <huth@tuxfamily.org>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4: align logical/physical on TARGET_PAGE_SIZE for tlb_set_page()
v2: change ACCESS_PTEST value because of new ACCESS_DEBUG
    use -page_size to mask address instead of TARGET_PAGE_MASK

 target/m68k/cpu.h       |  3 ++
 target/m68k/helper.c    | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h    |  2 ++
 target/m68k/monitor.c   |  1 +
 target/m68k/op_helper.c |  1 +
 target/m68k/translate.c | 33 ++++++++++++++++++++++
 6 files changed, 113 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index cc1759bb5d..0739c3f5c8 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -131,6 +131,7 @@ typedef struct CPUM68KState {
         uint32_t srp;
         bool fault;
         uint32_t ttr[4];
+        uint32_t mmusr;
     } mmu;
 
     /* Control registers.  */
@@ -512,6 +513,8 @@ enum {
     ACCESS_STORE = 0x02,
     /* 1 bit to indicate debug access */
     ACCESS_DEBUG = 0x04,
+    /* PTEST instruction */
+    ACCESS_PTEST = 0x08,
     /* Type of instruction that generated the access */
     ACCESS_CODE  = 0x10, /* Code fetch access                */
     ACCESS_DATA  = 0x20, /* Data load/store access        */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 80db0b75b0..9fd9d3f1ff 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -221,6 +221,9 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     case M68K_CR_TC:
         env->mmu.tcr = val;
         return;
+    case M68K_CR_MMUSR:
+        env->mmu.mmusr = val;
+        return;
     case M68K_CR_SRP:
         env->mmu.srp = val;
         return;
@@ -272,6 +275,8 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     /* MC680[34]0 */
     case M68K_CR_TC:
         return env->mmu.tcr;
+    case M68K_CR_MMUSR:
+        return env->mmu.mmusr;
     case M68K_CR_SRP:
         return env->mmu.srp;
     case M68K_CR_USP:
@@ -433,6 +438,10 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     for (i = 0; i < M68K_MAX_TTR; i++) {
         if (check_TTR(env->mmu.TTR(access_type, i),
                       prot, address, access_type)) {
+            if (access_type & ACCESS_PTEST) {
+                /* Transparent Translation Register bit */
+                env->mmu.mmusr = M68K_MMU_T_040 | M68K_MMU_R_040;
+            }
             *physical = address & TARGET_PAGE_MASK;
             *page_size = TARGET_PAGE_SIZE;
             return 0;
@@ -461,6 +470,9 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
         stl_phys(cs->as, entry, next | M68K_DESC_USED);
     }
     if (next & M68K_DESC_WRITEPROT) {
+        if (access_type & ACCESS_PTEST) {
+            env->mmu.mmusr |= M68K_MMU_WP_040;
+        }
         *prot &= ~PAGE_WRITE;
         if (access_type & ACCESS_STORE) {
             return -1;
@@ -478,6 +490,9 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
         stl_phys(cs->as, entry, next | M68K_DESC_USED);
     }
     if (next & M68K_DESC_WRITEPROT) {
+        if (access_type & ACCESS_PTEST) {
+            env->mmu.mmusr |= M68K_MMU_WP_040;
+        }
         *prot &= ~PAGE_WRITE;
         if (access_type & ACCESS_STORE) {
             return -1;
@@ -524,6 +539,12 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     page_mask = ~(*page_size - 1);
     *physical = next & page_mask;
 
+    if (access_type & ACCESS_PTEST) {
+        env->mmu.mmusr |= next & M68K_MMU_SR_MASK_040;
+        env->mmu.mmusr |= *physical & 0xfffff000;
+        env->mmu.mmusr |= M68K_MMU_R_040;
+    }
+
     if (next & M68K_DESC_WRITEPROT) {
         *prot &= ~PAGE_WRITE;
         if (access_type & ACCESS_STORE) {
@@ -1078,6 +1099,58 @@ void HELPER(set_mac_extu)(CPUM68KState *env, uint32_t val, uint32_t acc)
 }
 
 #if defined(CONFIG_SOFTMMU)
+void HELPER(ptest)(CPUM68KState *env, uint32_t addr, uint32_t is_read)
+{
+    M68kCPU *cpu = m68k_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    hwaddr physical;
+    int access_type;
+    int prot;
+    int ret;
+    target_ulong page_size;
+
+    access_type = ACCESS_PTEST;
+    if (env->dfc & 4) {
+        access_type |= ACCESS_SUPER;
+    }
+    if ((env->dfc & 3) == 2) {
+        access_type |= ACCESS_CODE;
+    }
+    if (!is_read) {
+        access_type |= ACCESS_STORE;
+    }
+
+    env->mmu.mmusr = 0;
+    env->mmu.ssw = 0;
+    ret = get_physical_address(env, &physical, &prot, addr,
+                               access_type, &page_size);
+    if (ret == 0) {
+        addr &= TARGET_PAGE_MASK;
+        physical += addr & (page_size - 1);
+        tlb_set_page(cs, addr, physical,
+                     prot, access_type & ACCESS_SUPER ?
+                     MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
+    }
+}
+
+void HELPER(pflush)(CPUM68KState *env, uint32_t addr, uint32_t opmode)
+{
+    M68kCPU *cpu = m68k_env_get_cpu(env);
+
+    switch (opmode) {
+    case 0: /* Flush page entry if not global */
+    case 1: /* Flush page entry */
+        tlb_flush_page(CPU(cpu), addr);
+        break;
+    case 2: /* Flush all except global entries */
+        tlb_flush(CPU(cpu));
+        break;
+    case 3: /* Flush all entries */
+        tlb_flush(CPU(cpu));
+        break;
+    }
+}
+
 void HELPER(reset)(CPUM68KState *env)
 {
     /* FIXME: reset all except CPU */
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 57f210aa14..7f400f0def 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -101,5 +101,7 @@ DEF_HELPER_3(chk, void, env, s32, s32)
 DEF_HELPER_4(chk2, void, env, s32, s32, s32)
 
 #if defined(CONFIG_SOFTMMU)
+DEF_HELPER_3(ptest, void, env, i32, i32)
+DEF_HELPER_3(pflush, void, env, i32, i32)
 DEF_HELPER_FLAGS_1(reset, TCG_CALL_NO_RWG, void, env)
 #endif
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index c31feb4b02..486213cd8b 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -39,6 +39,7 @@ static const MonitorDef monitor_defs[] = {
     { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
     { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
     { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
     { NULL },
 };
 
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 4609caa546..ffea9693fc 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -466,6 +466,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
     }
 
     if (m68k_feature(env, M68K_FEATURE_M68040)) {
+        env->mmu.mmusr = 0;
         env->mmu.ssw |= M68K_ATC_040;
         /* FIXME: manage MMU table access error */
         env->mmu.ssw &= ~M68K_TM_040;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 594ab5ddda..102732d612 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4662,6 +4662,35 @@ DISAS_INSN(cinv)
     /* Invalidate cache line.  Implement as no-op.  */
 }
 
+#if defined(CONFIG_SOFTMMU)
+DISAS_INSN(pflush)
+{
+    TCGv opmode;
+
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+
+    opmode = tcg_const_i32((insn >> 3) & 3);
+    gen_helper_pflush(cpu_env, AREG(insn, 0), opmode);
+    tcg_temp_free(opmode);
+}
+
+DISAS_INSN(ptest)
+{
+    TCGv is_read;
+
+    if (IS_USER(s)) {
+        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
+        return;
+    }
+    is_read = tcg_const_i32((insn >> 5) & 1);
+    gen_helper_ptest(cpu_env, AREG(insn, 0), is_read);
+    tcg_temp_free(is_read);
+}
+#endif
+
 DISAS_INSN(wddata)
 {
     gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
@@ -5855,6 +5884,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(cpushl,    f428, ff38, CF_ISA_A);
     INSN(cpush,     f420, ff20, M68040);
     INSN(cinv,      f400, ff20, M68040);
+    INSN(pflush,    f500, ffe0, M68040);
+    INSN(ptest,     f548, ffd8, M68040);
     INSN(wddata,    fb00, ff00, CF_ISA_A);
     INSN(wdebug,    fbc0, ffc0, CF_ISA_A);
 #endif
@@ -6057,6 +6088,8 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
                 env->mmu.ttr[M68K_DTTR0], env->mmu.ttr[M68K_DTTR1],
                 env->mmu.ttr[M68K_ITTR0], env->mmu.ttr[M68K_ITTR1]);
+    cpu_fprintf(f, "MMUSR %08x, fault at %08x\n",
+                env->mmu.mmusr, env->mmu.ar);
 #endif
 }
 
-- 
2.14.3
