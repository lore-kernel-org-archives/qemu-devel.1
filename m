Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZK-0008EZ-Ub
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZH-0007mq-F5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:02 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:61223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYgZG-0007hc-JA
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:59 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:47 +0100
Message-Id: <20180108231048.23966-6-laurent@vivier.eu>
In-Reply-To: <20180108231048.23966-1-laurent@vivier.eu>
References: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 5/6] target/m68k: add pflush/ptest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h       |  3 +++
 target/m68k/helper.c    | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.h    |  2 ++
 target/m68k/monitor.c   |  1 +
 target/m68k/op_helper.c |  1 +
 target/m68k/translate.c | 33 +++++++++++++++++++++++
 6 files changed, 112 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 4877be93ec..2f5a716139 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -130,6 +130,7 @@ typedef struct CPUM68KState {
         uint32_t urp;
         uint32_t srp;
         uint32_t ttr[4];
+        uint32_t mmusr;
     } mmu;
 
     /* Control registers.  */
@@ -512,6 +513,8 @@ enum {
     ACCESS_SUPER = 0x01,
     /* 1 bit to indicate direction */
     ACCESS_STORE = 0x02,
+    /* PTEST instruction */
+    ACCESS_PTEST = 0x04,
     /* Type of instruction that generated the access */
     ACCESS_CODE  = 0x10, /* Code fetch access                */
     ACCESS_INT   = 0x20, /* Integer load/store access        */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 090f50fa05..ef9ef6f55c 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -222,6 +222,9 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     case M68K_CR_TC:
         env->mmu.tcr = val;
         return;
+    case M68K_CR_MMUSR:
+        env->mmu.mmusr = val;
+        return;
     case M68K_CR_SRP:
         env->mmu.srp = val;
         return;
@@ -273,6 +276,8 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     /* MC680[34]0 */
     case M68K_CR_TC:
         return env->mmu.tcr;
+    case M68K_CR_MMUSR:
+        return env->mmu.mmusr;
     case M68K_CR_SRP:
         return env->mmu.srp;
     case M68K_CR_USP:
@@ -432,6 +437,10 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     for (i = 0; i < M68K_MAX_TTR; i++) {
         if (check_TTR(env->mmu.TTR(access_type, i),
                       prot, address, access_type)) {
+            if (access_type & ACCESS_PTEST) {
+                /* Transparent Translation Register bit */
+                env->mmu.mmusr = M68K_MMU_T_040 | M68K_MMU_R_040;
+            }
             *physical = address;
             *page_size = TARGET_PAGE_SIZE;
             return 0;
@@ -460,6 +469,9 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
         stl_phys(cs->as, entry, next | M68K_DESC_USED);
     }
     if (next & M68K_DESC_WRITEPROT) {
+        if (access_type & ACCESS_PTEST) {
+            env->mmu.mmusr |= M68K_MMU_WP_040;
+        }
         *prot &= ~PAGE_WRITE;
         if (access_type & ACCESS_STORE) {
             return -1;
@@ -477,6 +489,9 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
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
         *physical = (next & ~0x0fff) + page_offset;
     }
 
+    if (access_type & ACCESS_PTEST) {
+        env->mmu.mmusr |= next & M68K_MMU_SR_MASK_040;
+        env->mmu.mmusr |= *physical & 0xfffff000;
+        env->mmu.mmusr |= M68K_MMU_R_040;
+    }
+
     if (next & M68K_DESC_WRITEPROT) {
         *prot &= ~PAGE_WRITE;
         if (access_type & ACCESS_STORE) {
@@ -1148,6 +1169,57 @@ uint32_t HELPER(moves_load)(CPUM68KState *env, uint32_t addr, uint32_t size)
     return val;
 }
 
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
+        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
+                     physical & TARGET_PAGE_MASK,
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
index 620c6d5686..48bfc2acf9 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -103,5 +103,7 @@ DEF_HELPER_4(chk2, void, env, s32, s32, s32)
 #if defined(CONFIG_SOFTMMU)
 DEF_HELPER_FLAGS_4(moves_store, TCG_CALL_NO_WG, void, env, i32, i32, i32)
 DEF_HELPER_FLAGS_3(moves_load, TCG_CALL_NO_WG, i32, env, i32, i32)
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
index 6bf16695ac..28a72845ea 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -467,6 +467,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
     }
 
     if (m68k_feature(env, M68K_FEATURE_M68040)) {
+        env->mmu.mmusr = 0;
         env->mmu.ssw |= M68K_ATC_040;
         /* FIXME: manage MMU table access error */
         env->mmu.ssw &= ~M68K_TM_040;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 7cb0e12ee7..df1bb247fb 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4666,6 +4666,35 @@ DISAS_INSN(cinv)
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
@@ -5857,6 +5886,8 @@ void register_m68k_insns (CPUM68KState *env)
     INSN(cpushl,    f428, ff38, CF_ISA_A);
     INSN(cpush,     f420, ff20, M68040);
     INSN(cinv,      f400, ff20, M68040);
+    INSN(pflush,    f500, ffe0, M68040);
+    INSN(ptest,     f548, ffd8, M68040);
     INSN(wddata,    fb00, ff00, CF_ISA_A);
     INSN(wdebug,    fbc0, ffc0, CF_ISA_A);
 #endif
@@ -6060,6 +6091,8 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
                 env->mmu.ttr[M68K_DTTR0], env->mmu.ttr[M68K_DTTR1],
                 env->mmu.ttr[M68K_ITTR0], env->mmu.ttr[M68K_ITTR1]);
+    cpu_fprintf(f, "MMUSR %08x, fault at %08x\n",
+                env->mmu.mmusr, env->mmu.ar);
 #endif
 }
 
-- 
2.14.3
