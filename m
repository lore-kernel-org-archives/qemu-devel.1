Received: from eggs.gnu.org ([2001:4830:134:3::10]:58739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL8VW-00037B-74
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dL8VU-0007rp-AI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dL8VU-0007rg-0n
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:38:48 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 14 Jun 2017 15:38:19 +0200
Message-Id: <20170614133819.18480-3-david@redhat.com>
In-Reply-To: <20170614133819.18480-1-david@redhat.com>
References: <20170614133819.18480-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] target/s390x: implement mvcos
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com, Miroslav Benes <mbenes@suse.cz>

This adds support for the MOVE WITH OPTIONAL SPECIFICATIONS (MVCOS)
instruction. Allow to enable it for the qemu cpu model using

qemu-system-s390x ... -cpu qemu,mvcos=on ...

This allows to boot linux kernel that uses it for uacccess.

We are missing (as for most other part) low address protection checks,
PSW key / storage key checks and support for AR-mode.

We fake an ADDRESSING exception when called from problem state (which
seems to rely on PSW key checks to be in place) and if AR-mode is used.
user mode will always see a PRIVILEDGED exception.

This patch is based on an original patch by Miroslav Benes (thanks!).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         |  22 +++++-
 target/s390x/cpu_models.c  |   1 +
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def |   2 +
 target/s390x/mem_helper.c  | 180 +++++++++++++++++++++++++++++++++++++++++----
 target/s390x/translate.c   |   9 +++
 6 files changed, 199 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 532a4a0..5b94ace 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -304,6 +304,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #undef PSW_MASK_WAIT
 #undef PSW_MASK_PSTATE
 #undef PSW_MASK_ASC
+#undef PSW_SHIFT_ASC
 #undef PSW_MASK_CC
 #undef PSW_MASK_PM
 #undef PSW_MASK_64
@@ -320,6 +321,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define PSW_MASK_WAIT           0x0002000000000000ULL
 #define PSW_MASK_PSTATE         0x0001000000000000ULL
 #define PSW_MASK_ASC            0x0000C00000000000ULL
+#define PSW_SHIFT_ASC           46
 #define PSW_MASK_CC             0x0000300000000000ULL
 #define PSW_MASK_PM             0x00000F0000000000ULL
 #define PSW_MASK_64             0x0000000100000000ULL
@@ -336,6 +338,12 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define PSW_ASC_SECONDARY       0x0000800000000000ULL
 #define PSW_ASC_HOME            0x0000C00000000000ULL
 
+/* the address space values shifted */
+#define AS_PRIMARY              0
+#define AS_ACCREG               1
+#define AS_SECONDARY            2
+#define AS_HOME                 3
+
 /* tb flags */
 
 #define FLAG_MASK_PER           (PSW_MASK_PER    >> 32)
@@ -354,6 +362,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 
 /* Control register 0 bits */
 #define CR0_LOWPROT             0x0000000010000000ULL
+#define CR0_SECONDARY           0x0000000004000000ULL
 #define CR0_EDAT                0x0000000000800000ULL
 
 /* MMU */
@@ -361,7 +370,18 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define MMU_SECONDARY_IDX       1
 #define MMU_HOME_IDX            2
 
-static inline int cpu_mmu_index (CPUS390XState *env, bool ifetch)
+static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
+{
+    uint16_t pkm = env->cregs[3] >> 16;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        /* PSW key has range 0..15, it is valid if the bit is 1 in the PKM */
+        return pkm & (0x80 >> psw_key);
+    }
+    return true;
+}
+
+static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
     switch (env->psw.mask & PSW_MASK_ASC) {
     case PSW_ASC_PRIMARY:
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c508ae1..348e760 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -682,6 +682,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_LONG_DISPLACEMENT_FAST,
         S390_FEAT_ETF2_ENH,
         S390_FEAT_STORE_CLOCK_FAST,
+        S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_STFLE_45,
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 69249a5..b268367 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -105,6 +105,7 @@ DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
+DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d089707..aa4c5b2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -590,6 +590,8 @@
     C(0xb254, MVPG,    RRE,   Z,   r1_o, r2_o, 0, 0, mvpg, 0)
 /* MOVE STRING */
     C(0xb255, MVST,    RRE,   Z,   r1_o, r2_o, 0, 0, mvst, 0)
+/* MOVE WITH OPTIONAL SPECIFICATION */
+    C(0xc800, MVCOS,   SSF,   MVCOS, la1, a2, 0, 0, mvcos, 0)
 /* MOVE WITH OFFSET */
     /* Really format SS_b, but we pack both lengths into one argument
        for the helper call, so we might as well leave one 8-bit field.  */
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 80caab9..5f76dae 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -110,6 +110,20 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
     }
 }
 
+static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
+{
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        if (!(env->psw.mask & PSW_MASK_32)) {
+            /* 24-Bit mode */
+            a &= 0x00ffffff;
+        } else {
+            /* 31-Bit mode */
+            a &= 0x7fffffff;
+        }
+    }
+    return a;
+}
+
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
                         uint32_t l, uintptr_t ra)
 {
@@ -118,7 +132,7 @@ static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
     while (l > 0) {
         void *p = tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, mmu_idx);
         if (p) {
-            /* Access to the whole page in write mode granted.  */
+            /* Access to the whole page in write mode granted  */
             uint32_t l_adj = adj_len_to_page(l, dest);
             memset(p, byte, l_adj);
             dest += l_adj;
@@ -133,6 +147,68 @@ static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+static void fast_memmove_idx(CPUS390XState *env, uint64_t dest, uint64_t src,
+                             uint32_t len, int dest_idx, int src_idx,
+                             uintptr_t ra)
+{
+    TCGMemOpIdx oi_dest = make_memop_idx(MO_UB, dest_idx);
+    TCGMemOpIdx oi_src = make_memop_idx(MO_UB, src_idx);
+    uint32_t len_adj;
+    void *src_p;
+    void *dest_p;
+    uint8_t x;
+
+    while (len > 0) {
+        src = wrap_address(env, src);
+        dest = wrap_address(env, dest);
+        src_p = tlb_vaddr_to_host(env, src, MMU_DATA_LOAD, src_idx);
+        dest_p = tlb_vaddr_to_host(env, dest, MMU_DATA_STORE, dest_idx);
+
+        if (src_p && dest_p) {
+            /* Access to both whole pages granted.  */
+            len_adj = adj_len_to_page(adj_len_to_page(len, src), dest);
+            memmove(dest_p, src_p, len_adj);
+        } else {
+            /* We failed to get access to one or both whole pages. The next
+               read or write access will likely fill the QEMU TLB for the
+               next iteration.  */
+            len_adj = 1;
+            x = helper_ret_ldub_mmu(env, src, oi_src, ra);
+            helper_ret_stb_mmu(env, dest, x, oi_dest, ra);
+        }
+        src += len_adj;
+        dest += len_adj;
+        len -= len_adj;
+    }
+}
+
+static int mmu_idx_from_as(uint8_t as)
+{
+    switch (as) {
+    case AS_PRIMARY:
+        return MMU_PRIMARY_IDX;
+    case AS_SECONDARY:
+        return MMU_SECONDARY_IDX;
+    case AS_HOME:
+        return MMU_HOME_IDX;
+    }
+    /* FIXME AS_ACCREG */
+    assert(false);
+    return -1;
+}
+
+static void fast_memmove_as(CPUS390XState *env, uint64_t dest, uint64_t src,
+                            uint32_t len, uint8_t dest_as, uint8_t src_as,
+                            uintptr_t ra)
+{
+    int src_idx = mmu_idx_from_as(src_as);
+    int dest_idx = mmu_idx_from_as(dest_as);
+
+    fast_memmove_idx(env, dest, src, len, dest_idx, src_idx, ra);
+}
+#endif
+
 static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
                          uint32_t l, uintptr_t ra)
 {
@@ -408,20 +484,6 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
     return cc;
 }
 
-static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
-{
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        if (!(env->psw.mask & PSW_MASK_32)) {
-            /* 24-Bit mode */
-            a &= 0x00ffffff;
-        } else {
-            /* 31-Bit mode */
-            a &= 0x7fffffff;
-        }
-    }
-    return a;
-}
-
 static inline uint64_t get_address(CPUS390XState *env, int reg)
 {
     return wrap_address(env, env->regs[reg]);
@@ -1789,3 +1851,91 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
        that requires such execution.  */
     env->ex_value = insn | ilen;
 }
+
+uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
+                       uint64_t len)
+{
+    const uint8_t psw_key = (env->psw.mask & PSW_MASK_KEY) >> PSW_SHIFT_KEY;
+    const uint8_t psw_as = (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT_ASC;
+    const uint64_t r0 = env->regs[0];
+    const uintptr_t ra = GETPC();
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+    uint8_t dest_key, dest_as, dest_k, dest_a;
+    uint8_t src_key, src_as, src_k, src_a;
+    uint64_t val;
+    int cc = 0;
+
+    HELPER_LOG("%s dest %" PRIx64 ", src %" PRIx64 ", len %" PRIx64 "\n",
+               __func__, dest, src, len);
+
+    if (!(env->psw.mask & PSW_MASK_DAT)) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIAL_OP, 6);
+    }
+
+    /* OAC (operand access control) for the first operand -> dest */
+    val = (r0 & 0xffff0000ULL) >> 16;
+    dest_key = (val >> 12) & 0xf;
+    dest_as = (val >> 6) & 0x3;
+    dest_k = (val >> 1) & 0x1;
+    dest_a = val & 0x1;
+
+    /* OAC (operand access control) for the second operand -> src */
+    val = (r0 & 0x0000ffffULL);
+    src_key = (val >> 12) & 0xf;
+    src_as = (val >> 6) & 0x3;
+    src_k = (val >> 1) & 0x1;
+    src_a = val & 0x1;
+
+    if (!dest_k) {
+        dest_key = psw_key;
+    }
+    if (!src_k) {
+        src_key = psw_key;
+    }
+    if (!dest_a) {
+        dest_as = psw_as;
+    }
+    if (!src_a) {
+        src_as = psw_as;
+    }
+
+    if (dest_a && dest_as == AS_HOME && (env->psw.mask & PSW_MASK_PSTATE)) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIAL_OP, 6);
+    }
+    if (!(env->cregs[0] & CR0_SECONDARY) &&
+        (dest_as == AS_SECONDARY || src_as == AS_SECONDARY)) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_SPECIAL_OP, 6);
+    }
+    if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_PRIVILEGED, 6);
+    }
+
+    if (len > 4096) {
+        cc = 3;
+        len = 4096;
+    }
+
+    /* FIXME: AR-mode and proper problem state mode (using PSW keys) missing */
+    if (src_as == AS_ACCREG || dest_as == AS_ACCREG ||
+        (env->psw.mask & PSW_MASK_PSTATE)) {
+        qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing\n",
+                      __func__);
+        cpu_restore_state(cs, ra);
+        program_interrupt(env, PGM_ADDRESSING, 6);
+    }
+
+    /* FIXME: a) LAP
+     *        b) Access using correct keys
+     *        c) AR-mode
+     */
+#ifndef CONFIG_USER_ONLY
+    /* psw keys are never valid in user mode, we will never reach this */
+    fast_memmove_as(env, dest, src, len, dest_as, src_as, ra);
+#endif
+
+    return cc;
+}
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index fae006f..e0f3393 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1202,6 +1202,7 @@ typedef enum DisasFacility {
     FAC_SCF,                /* store clock fast */
     FAC_SFLE,               /* store facility list extended */
     FAC_ILA,                /* interlocked access facility 1 */
+    FAC_MVCOS,              /* move-with-optional-specification */
     FAC_LPP,                /* load-program-parameter */
     FAC_DAT_ENH,            /* DAT-enhancement */
     FAC_E2,                 /* extended-translation facility 2 */
@@ -3068,6 +3069,14 @@ static ExitStatus op_mvclu(DisasContext *s, DisasOps *o)
     return NO_EXIT;
 }
 
+static ExitStatus op_mvcos(DisasContext *s, DisasOps *o)
+{
+    int r3 = get_field(s->fields, r3);
+    gen_helper_mvcos(cc_op, cpu_env, o->addr1, o->in2, regs[r3]);
+    set_cc_static(s);
+    return NO_EXIT;
+}
+
 #ifndef CONFIG_USER_ONLY
 static ExitStatus op_mvcp(DisasContext *s, DisasOps *o)
 {
-- 
2.9.3
