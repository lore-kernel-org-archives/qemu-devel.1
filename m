Received: from eggs.gnu.org ([2001:4830:134:3::10]:43811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPl-0003IM-H7
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPi-0003hl-Mr
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:17 -0500
Received: from clearmind.me ([178.32.49.9]:41905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cilPi-0003gT-8p
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:14 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Tue, 28 Feb 2017 18:19:18 +0100
Message-Id: <20170228171921.21602-5-ale+qemu@clearmind.me>
In-Reply-To: <20170228171921.21602-1-ale+qemu@clearmind.me>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [PATCH 4/7] *-user targets object files decoupling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move some functions around in target/$arch/*.c to reduce the coupling
among the various compilation units. In particular, we want to make the
various translate.c and cpu.c as much standalone as possible, so that
they can be easily employed by libtcg.
---
 exec.c                      |   6 ++-
 target/alpha/cpu.c          |  38 +++++++++++++++
 target/alpha/helper.c       |  39 ----------------
 target/arm/cpu.h            |  74 ++++++++++++++++++++---------
 target/arm/helper.c         |  85 ++++++----------------------------
 target/arm/translate.c      |  33 +++++++++++++
 target/m68k/cpu.c           |  61 ++++++++++++++++++++++++
 target/m68k/cpu.h           |  49 ++++++++++++++++++++
 target/m68k/helper.c        | 110 --------------------------------------------
 target/mips/op_helper.c     |   8 ----
 target/mips/translate.c     |   8 ++++
 target/ppc/gdbstub.c        |  20 --------
 target/ppc/translate_init.c |  20 ++++++++
 target/s390x/cpu.c          |  75 ++++++++++++++++++++++++++++++
 target/s390x/helper.c       |  75 ------------------------------
 target/sparc/cpu.h          |   2 +
 target/unicore32/cpu.c      |   5 ++
 target/unicore32/helper.c   |   5 --
 18 files changed, 360 insertions(+), 353 deletions(-)

diff --git a/exec.c b/exec.c
index 865a1e8295..cf9f039dba 100644
--- a/exec.c
+++ b/exec.c
@@ -665,16 +665,18 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
 
 void cpu_exec_unrealizefn(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
     cpu_list_remove(cpu);
 
+#ifndef CONFIG_USER_ONLY
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
     if (cc->vmsd != NULL) {
         vmstate_unregister(NULL, cc->vmsd, cpu);
     }
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
     }
+#endif
 }
 
 void cpu_exec_initfn(CPUState *cpu)
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b4f97983e5..a1125fca93 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -266,6 +266,44 @@ static const TypeInfo ev68_cpu_type_info = {
     .parent = TYPE("ev67"),
 };
 
+#define CONVERT_BIT(X, SRC, DST) \
+    (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
+
+void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val)
+{
+    uint32_t fpcr = val >> 32;
+    uint32_t t = 0;
+
+    t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
+    t |= CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
+    t |= CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
+    t |= CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
+    t |= CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
+
+    env->fpcr = fpcr;
+    env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
+
+    switch (fpcr & FPCR_DYN_MASK) {
+    case FPCR_DYN_NORMAL:
+    default:
+        t = float_round_nearest_even;
+        break;
+    case FPCR_DYN_CHOPPED:
+        t = float_round_to_zero;
+        break;
+    case FPCR_DYN_MINUS:
+        t = float_round_down;
+        break;
+    case FPCR_DYN_PLUS:
+        t = float_round_up;
+        break;
+    }
+    env->fpcr_dyn_round = t;
+
+    env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
+    env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
+}
+
 static void alpha_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 041a9d1c2c..a20c7cd421 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -24,50 +24,11 @@
 #include "fpu/softfloat.h"
 #include "exec/helper-proto.h"
 
-
-#define CONVERT_BIT(X, SRC, DST) \
-    (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
-
 uint64_t cpu_alpha_load_fpcr (CPUAlphaState *env)
 {
     return (uint64_t)env->fpcr << 32;
 }
 
-void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val)
-{
-    uint32_t fpcr = val >> 32;
-    uint32_t t = 0;
-
-    t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
-    t |= CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
-    t |= CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
-    t |= CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
-    t |= CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
-
-    env->fpcr = fpcr;
-    env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
-
-    switch (fpcr & FPCR_DYN_MASK) {
-    case FPCR_DYN_NORMAL:
-    default:
-        t = float_round_nearest_even;
-        break;
-    case FPCR_DYN_CHOPPED:
-        t = float_round_to_zero;
-        break;
-    case FPCR_DYN_MINUS:
-        t = float_round_down;
-        break;
-    case FPCR_DYN_PLUS:
-        t = float_round_up;
-        break;
-    }
-    env->fpcr_dyn_round = t;
-
-    env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
-    env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
-}
-
 uint64_t helper_load_fpcr(CPUAlphaState *env)
 {
     return cpu_alpha_load_fpcr(env);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0956a54e89..a0067e0ffe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1038,7 +1038,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_AARCH64_MASK      (0x3fff & ~SCR_NET)
 
 /* Return the current FPSCR value.  */
-uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 
 /* For A64 the FPSCR is split into two logically distinct registers,
@@ -1047,27 +1046,6 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
  */
 #define FPSR_MASK 0xf800009f
 #define FPCR_MASK 0x07f79f00
-static inline uint32_t vfp_get_fpsr(CPUARMState *env)
-{
-    return vfp_get_fpscr(env) & FPSR_MASK;
-}
-
-static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
-{
-    uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPSR_MASK) | (val & FPSR_MASK);
-    vfp_set_fpscr(env, new_fpscr);
-}
-
-static inline uint32_t vfp_get_fpcr(CPUARMState *env)
-{
-    return vfp_get_fpscr(env) & FPCR_MASK;
-}
-
-static inline void vfp_set_fpcr(CPUARMState *env, uint32_t val)
-{
-    uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPCR_MASK) | (val & FPCR_MASK);
-    vfp_set_fpscr(env, new_fpscr);
-}
 
 enum arm_cpu_mode {
   ARM_CPU_MODE_USR = 0x10,
@@ -1201,6 +1179,58 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
 };
 
+/* VFP support.  We follow the convention used for VFP instructions:
+   Single precision routines have a "s" suffix, double precision a
+   "d" suffix.  */
+
+/* Convert host exception flags to vfp form.  */
+static inline int vfp_exceptbits_from_host(int host_bits)
+{
+    int target_bits = 0;
+
+    if (host_bits & float_flag_invalid)
+        target_bits |= 1;
+    if (host_bits & float_flag_divbyzero)
+        target_bits |= 2;
+    if (host_bits & float_flag_overflow)
+        target_bits |= 4;
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal))
+        target_bits |= 8;
+    if (host_bits & float_flag_inexact)
+        target_bits |= 0x10;
+    if (host_bits & float_flag_input_denormal)
+        target_bits |= 0x80;
+    return target_bits;
+}
+
+static inline uint32_t vfp_get_fpscr(CPUARMState *env)
+{
+    int i;
+    uint32_t fpscr;
+
+    fpscr = (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
+            | (env->vfp.vec_len << 16)
+            | (env->vfp.vec_stride << 20);
+    i = get_float_exception_flags(&env->vfp.fp_status);
+    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    fpscr |= vfp_exceptbits_from_host(i);
+    return fpscr;
+}
+
+static inline uint32_t vfp_get_fpsr(CPUARMState *env)
+{
+    return vfp_get_fpscr(env) & FPSR_MASK;
+}
+
+void vfp_set_fpsr(CPUARMState *env, uint32_t val);
+
+static inline uint32_t vfp_get_fpcr(CPUARMState *env)
+{
+    return vfp_get_fpscr(env) & FPCR_MASK;
+}
+
+void vfp_set_fpcr(CPUARMState *env, uint32_t val);
+
 static inline int arm_feature(CPUARMState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 47250bcf16..d4075d2afb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5560,11 +5560,6 @@ void define_arm_cp_regs_with_opaque(ARMCPU *cpu,
     }
 }
 
-const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp)
-{
-    return g_hash_table_lookup(cpregs, &encoded_cp);
-}
-
 void arm_cp_write_ignore(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
@@ -8757,47 +8752,9 @@ uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
     return (a & mask) | (b & ~mask);
 }
 
-/* VFP support.  We follow the convention used for VFP instructions:
-   Single precision routines have a "s" suffix, double precision a
-   "d" suffix.  */
-
-/* Convert host exception flags to vfp form.  */
-static inline int vfp_exceptbits_from_host(int host_bits)
-{
-    int target_bits = 0;
-
-    if (host_bits & float_flag_invalid)
-        target_bits |= 1;
-    if (host_bits & float_flag_divbyzero)
-        target_bits |= 2;
-    if (host_bits & float_flag_overflow)
-        target_bits |= 4;
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal))
-        target_bits |= 8;
-    if (host_bits & float_flag_inexact)
-        target_bits |= 0x10;
-    if (host_bits & float_flag_input_denormal)
-        target_bits |= 0x80;
-    return target_bits;
-}
-
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
-    int i;
-    uint32_t fpscr;
-
-    fpscr = (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
-    i = get_float_exception_flags(&env->vfp.fp_status);
-    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
-    fpscr |= vfp_exceptbits_from_host(i);
-    return fpscr;
-}
-
-uint32_t vfp_get_fpscr(CPUARMState *env)
-{
-    return HELPER(vfp_get_fpscr)(env);
+    return vfp_get_fpscr(env);
 }
 
 /* Convert vfp exception flags to target form.  */
@@ -8820,6 +8777,18 @@ static inline int vfp_exceptbits_to_host(int target_bits)
     return host_bits;
 }
 
+void vfp_set_fpsr(CPUARMState *env, uint32_t val)
+{
+    uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPSR_MASK) | (val & FPSR_MASK);
+    vfp_set_fpscr(env, new_fpscr);
+}
+
+void vfp_set_fpcr(CPUARMState *env, uint32_t val)
+{
+    uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPCR_MASK) | (val & FPCR_MASK);
+    vfp_set_fpscr(env, new_fpscr);
+}
+
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     int i;
@@ -9670,34 +9639,6 @@ float64 HELPER(rintd)(float64 x, void *fp_status)
     return ret;
 }
 
-/* Convert ARM rounding mode to softfloat */
-int arm_rmode_to_sf(int rmode)
-{
-    switch (rmode) {
-    case FPROUNDING_TIEAWAY:
-        rmode = float_round_ties_away;
-        break;
-    case FPROUNDING_ODD:
-        /* FIXME: add support for TIEAWAY and ODD */
-        qemu_log_mask(LOG_UNIMP, "arm: unimplemented rounding mode: %d\n",
-                      rmode);
-    case FPROUNDING_TIEEVEN:
-    default:
-        rmode = float_round_nearest_even;
-        break;
-    case FPROUNDING_POSINF:
-        rmode = float_round_up;
-        break;
-    case FPROUNDING_NEGINF:
-        rmode = float_round_down;
-        break;
-    case FPROUNDING_ZERO:
-        rmode = float_round_to_zero;
-        break;
-    }
-    return rmode;
-}
-
 /* CRC helpers.
  * The upper bytes of val (above the number specified by 'bytes') must have
  * been zeroed out by the caller.
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4436d8f3a2..495f967eb6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3007,6 +3007,34 @@ static int handle_vminmaxnm(uint32_t insn, uint32_t rd, uint32_t rn,
     return 0;
 }
 
+/* Convert ARM rounding mode to softfloat */
+int arm_rmode_to_sf(int rmode)
+{
+    switch (rmode) {
+    case FPROUNDING_TIEAWAY:
+        rmode = float_round_ties_away;
+        break;
+    case FPROUNDING_ODD:
+        /* FIXME: add support for TIEAWAY and ODD */
+        qemu_log_mask(LOG_UNIMP, "arm: unimplemented rounding mode: %d\n",
+                      rmode);
+    case FPROUNDING_TIEEVEN:
+    default:
+        rmode = float_round_nearest_even;
+        break;
+    case FPROUNDING_POSINF:
+        rmode = float_round_up;
+        break;
+    case FPROUNDING_NEGINF:
+        rmode = float_round_down;
+        break;
+    case FPROUNDING_ZERO:
+        rmode = float_round_to_zero;
+        break;
+    }
+    return rmode;
+}
+
 static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t dp,
                         int rounding)
 {
@@ -7435,6 +7463,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
+const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp)
+{
+    return g_hash_table_lookup(cpregs, &encoded_cp);
+}
+
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index fa10b6e4cd..3b00d00461 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -43,6 +43,47 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
     env->features |= (1u << feature);
 }
 
+void m68k_switch_sp(CPUM68KState *env)
+{
+    int new_sp;
+
+    env->sp[env->current_sp] = env->aregs[7];
+    new_sp = (env->sr & SR_S && env->cacr & M68K_CACR_EUSP)
+             ? M68K_SSP : M68K_USP;
+    env->aregs[7] = env->sp[new_sp];
+    env->current_sp = new_sp;
+}
+
+void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t ccr)
+{
+    env->cc_x = (ccr & CCF_X ? 1 : 0);
+    env->cc_n = (ccr & CCF_N ? -1 : 0);
+    env->cc_z = (ccr & CCF_Z ? 0 : 1);
+    env->cc_v = (ccr & CCF_V ? -1 : 0);
+    env->cc_c = (ccr & CCF_C ? 1 : 0);
+    env->cc_op = CC_OP_FLAGS;
+}
+
+uint32_t cpu_m68k_get_ccr(CPUM68KState *env)
+{
+    uint32_t x, c, n, z, v;
+    uint32_t res, src1, src2;
+
+    x = env->cc_x;
+    n = env->cc_n;
+    z = env->cc_z;
+    v = env->cc_v;
+    c = env->cc_c;
+
+    COMPUTE_CCR(env->cc_op, x, n, z, v, c);
+
+    n = n >> 31;
+    z = (z == 0);
+    v = v >> 31;
+
+    return x * CCF_X + n * CCF_N + z * CCF_Z + v * CCF_V + c * CCF_C;
+}
+
 /* CPUClass::reset() */
 static void m68k_cpu_reset(CPUState *s)
 {
@@ -250,6 +291,26 @@ static void m68k_cpu_initfn(Object *obj)
     }
 }
 
+M68kCPU *cpu_m68k_init(const char *cpu_model)
+{
+    M68kCPU *cpu;
+    CPUM68KState *env;
+    ObjectClass *oc;
+
+    oc = cpu_class_by_name(TYPE_M68K_CPU, cpu_model);
+    if (oc == NULL) {
+        return NULL;
+    }
+    cpu = M68K_CPU(object_new(object_class_get_name(oc)));
+    env = &cpu->env;
+
+    register_m68k_insns(env);
+
+    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
+
+    return cpu;
+}
+
 static const VMStateDescription vmstate_m68k_cpu = {
     .name = "cpu",
     .unmigratable = 1,
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 809582212d..1b219c4952 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -262,6 +262,55 @@ void m68k_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
 void register_m68k_insns (CPUM68KState *env);
 
+#define EXTSIGN(val, index) (     \
+    (index == 0) ? (int8_t)(val) : ((index == 1) ? (int16_t)(val) : (val)) \
+)
+
+#define COMPUTE_CCR(op, x, n, z, v, c) {                                   \
+    switch (op) {                                                          \
+    case CC_OP_FLAGS:                                                      \
+        /* Everything in place.  */                                        \
+        break;                                                             \
+    case CC_OP_ADDB:                                                       \
+    case CC_OP_ADDW:                                                       \
+    case CC_OP_ADDL:                                                       \
+        res = n;                                                           \
+        src2 = v;                                                          \
+        src1 = EXTSIGN(res - src2, op - CC_OP_ADDB);                       \
+        c = x;                                                             \
+        z = n;                                                             \
+        v = (res ^ src1) & ~(src1 ^ src2);                                 \
+        break;                                                             \
+    case CC_OP_SUBB:                                                       \
+    case CC_OP_SUBW:                                                       \
+    case CC_OP_SUBL:                                                       \
+        res = n;                                                           \
+        src2 = v;                                                          \
+        src1 = EXTSIGN(res + src2, op - CC_OP_SUBB);                       \
+        c = x;                                                             \
+        z = n;                                                             \
+        v = (res ^ src1) & (src1 ^ src2);                                  \
+        break;                                                             \
+    case CC_OP_CMPB:                                                       \
+    case CC_OP_CMPW:                                                       \
+    case CC_OP_CMPL:                                                       \
+        src1 = n;                                                          \
+        src2 = v;                                                          \
+        res = EXTSIGN(src1 - src2, op - CC_OP_CMPB);                       \
+        n = res;                                                           \
+        z = res;                                                           \
+        c = src1 < src2;                                                   \
+        v = (res ^ src1) & (src1 ^ src2);                                  \
+        break;                                                             \
+    case CC_OP_LOGIC:                                                      \
+        c = v = 0;                                                         \
+        z = n;                                                             \
+        break;                                                             \
+    default:                                                               \
+        cpu_abort(CPU(m68k_env_get_cpu(env)), "Bad CC_OP %d", op);         \
+    }                                                                      \
+} while (0)
+
 #ifdef CONFIG_USER_ONLY
 /* Coldfire Linux uses 8k pages
  * and m68k linux uses 4k pages
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index f750d3dbaa..987dc78296 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -100,26 +100,6 @@ static int fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-M68kCPU *cpu_m68k_init(const char *cpu_model)
-{
-    M68kCPU *cpu;
-    CPUM68KState *env;
-    ObjectClass *oc;
-
-    oc = cpu_class_by_name(TYPE_M68K_CPU, cpu_model);
-    if (oc == NULL) {
-        return NULL;
-    }
-    cpu = M68K_CPU(object_new(object_class_get_name(oc)));
-    env = &cpu->env;
-
-    register_m68k_insns(env);
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
 void m68k_cpu_init_gdb(M68kCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -188,17 +168,6 @@ void HELPER(set_macsr)(CPUM68KState *env, uint32_t val)
     env->macsr = val;
 }
 
-void m68k_switch_sp(CPUM68KState *env)
-{
-    int new_sp;
-
-    env->sp[env->current_sp] = env->aregs[7];
-    new_sp = (env->sr & SR_S && env->cacr & M68K_CACR_EUSP)
-             ? M68K_SSP : M68K_USP;
-    env->aregs[7] = env->sp[new_sp];
-    env->current_sp = new_sp;
-}
-
 #if defined(CONFIG_USER_ONLY)
 
 int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
@@ -532,90 +501,11 @@ void HELPER(mac_set_flags)(CPUM68KState *env, uint32_t acc)
     }
 }
 
-#define EXTSIGN(val, index) (     \
-    (index == 0) ? (int8_t)(val) : ((index == 1) ? (int16_t)(val) : (val)) \
-)
-
-#define COMPUTE_CCR(op, x, n, z, v, c) {                                   \
-    switch (op) {                                                          \
-    case CC_OP_FLAGS:                                                      \
-        /* Everything in place.  */                                        \
-        break;                                                             \
-    case CC_OP_ADDB:                                                       \
-    case CC_OP_ADDW:                                                       \
-    case CC_OP_ADDL:                                                       \
-        res = n;                                                           \
-        src2 = v;                                                          \
-        src1 = EXTSIGN(res - src2, op - CC_OP_ADDB);                       \
-        c = x;                                                             \
-        z = n;                                                             \
-        v = (res ^ src1) & ~(src1 ^ src2);                                 \
-        break;                                                             \
-    case CC_OP_SUBB:                                                       \
-    case CC_OP_SUBW:                                                       \
-    case CC_OP_SUBL:                                                       \
-        res = n;                                                           \
-        src2 = v;                                                          \
-        src1 = EXTSIGN(res + src2, op - CC_OP_SUBB);                       \
-        c = x;                                                             \
-        z = n;                                                             \
-        v = (res ^ src1) & (src1 ^ src2);                                  \
-        break;                                                             \
-    case CC_OP_CMPB:                                                       \
-    case CC_OP_CMPW:                                                       \
-    case CC_OP_CMPL:                                                       \
-        src1 = n;                                                          \
-        src2 = v;                                                          \
-        res = EXTSIGN(src1 - src2, op - CC_OP_CMPB);                       \
-        n = res;                                                           \
-        z = res;                                                           \
-        c = src1 < src2;                                                   \
-        v = (res ^ src1) & (src1 ^ src2);                                  \
-        break;                                                             \
-    case CC_OP_LOGIC:                                                      \
-        c = v = 0;                                                         \
-        z = n;                                                             \
-        break;                                                             \
-    default:                                                               \
-        cpu_abort(CPU(m68k_env_get_cpu(env)), "Bad CC_OP %d", op);         \
-    }                                                                      \
-} while (0)
-
-uint32_t cpu_m68k_get_ccr(CPUM68KState *env)
-{
-    uint32_t x, c, n, z, v;
-    uint32_t res, src1, src2;
-
-    x = env->cc_x;
-    n = env->cc_n;
-    z = env->cc_z;
-    v = env->cc_v;
-    c = env->cc_c;
-
-    COMPUTE_CCR(env->cc_op, x, n, z, v, c);
-
-    n = n >> 31;
-    z = (z == 0);
-    v = v >> 31;
-
-    return x * CCF_X + n * CCF_N + z * CCF_Z + v * CCF_V + c * CCF_C;
-}
-
 uint32_t HELPER(get_ccr)(CPUM68KState *env)
 {
     return cpu_m68k_get_ccr(env);
 }
 
-void cpu_m68k_set_ccr(CPUM68KState *env, uint32_t ccr)
-{
-    env->cc_x = (ccr & CCF_X ? 1 : 0);
-    env->cc_n = (ccr & CCF_N ? -1 : 0);
-    env->cc_z = (ccr & CCF_Z ? 0 : 1);
-    env->cc_v = (ccr & CCF_V ? -1 : 0);
-    env->cc_c = (ccr & CCF_C ? 1 : 0);
-    env->cc_op = CC_OP_FLAGS;
-}
-
 void HELPER(set_ccr)(CPUM68KState *env, uint32_t ccr)
 {
     cpu_m68k_set_ccr(env, ccr);
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b683fcb025..9f3d25b660 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2432,14 +2432,6 @@ void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
 #define FP_TO_INT32_OVERFLOW 0x7fffffff
 #define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL
 
-/* convert MIPS rounding mode in FCR31 to IEEE library */
-unsigned int ieee_rm[] = {
-    float_round_nearest_even,
-    float_round_to_zero,
-    float_round_up,
-    float_round_down
-};
-
 target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
 {
     target_ulong arg1 = 0;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8b4a072ecb..5077099a78 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -36,6 +36,14 @@
 #include "trace-tcg.h"
 #include "exec/log.h"
 
+/* convert MIPS rounding mode in FCR31 to IEEE library */
+unsigned int ieee_rm[] = {
+    float_round_nearest_even,
+    float_round_to_zero,
+    float_round_up,
+    float_round_down
+};
+
 #define MIPS_DEBUG_DISAS 0
 
 /* MIPS major opcodes */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 7a338136a8..4f74946ec9 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -84,26 +84,6 @@ static int ppc_gdb_register_len(int n)
     }
 }
 
-/* We need to present the registers to gdb in the "current" memory ordering.
-   For user-only mode we get this for free; TARGET_WORDS_BIGENDIAN is set to
-   the proper ordering for the binary, and cannot be changed.
-   For system mode, TARGET_WORDS_BIGENDIAN is always set, and we must check
-   the current mode of the chip to see if we're running in little-endian.  */
-void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
-{
-#ifndef CONFIG_USER_ONLY
-    if (!msr_le) {
-        /* do nothing */
-    } else if (len == 4) {
-        bswap32s((uint32_t *)mem_buf);
-    } else if (len == 8) {
-        bswap64s((uint64_t *)mem_buf);
-    } else {
-        g_assert_not_reached();
-    }
-#endif
-}
-
 /* Old gdb always expects FP registers.  Newer (xml-aware) gdb only
  * expects whatever the target description contains.  Due to a
  * historical mishap the FP registers appear in between core integer
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index be35cbd3a2..12ef379d50 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9458,6 +9458,26 @@ static bool avr_need_swap(CPUPPCState *env)
 #endif
 }
 
+/* We need to present the registers to gdb in the "current" memory ordering.
+   For user-only mode we get this for free; TARGET_WORDS_BIGENDIAN is set to
+   the proper ordering for the binary, and cannot be changed.
+   For system mode, TARGET_WORDS_BIGENDIAN is always set, and we must check
+   the current mode of the chip to see if we're running in little-endian.  */
+void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!msr_le) {
+        /* do nothing */
+    } else if (len == 4) {
+        bswap32s((uint32_t *)mem_buf);
+    } else if (len == 8) {
+        bswap64s((uint64_t *)mem_buf);
+    } else {
+        g_assert_not_reached();
+    }
+#endif
+}
+
 static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 {
     if (n < 32) {
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 066dcd17df..2101d1dbf1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -440,6 +440,81 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     s390_cpu_model_class_register_props(oc);
 }
 
+S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp)
+{
+    static bool features_parsed;
+    char *name, *features;
+    const char *typename;
+    ObjectClass *oc;
+    CPUClass *cc;
+
+    name = g_strdup(cpu_model);
+    features = strchr(name, ',');
+    if (features) {
+        features[0] = 0;
+        features++;
+    }
+
+    oc = cpu_class_by_name(TYPE_S390_CPU, name);
+    if (!oc) {
+        error_setg(errp, "Unknown CPU definition \'%s\'", name);
+        g_free(name);
+        return NULL;
+    }
+    typename = object_class_get_name(oc);
+
+    if (!features_parsed) {
+        features_parsed = true;
+        cc = CPU_CLASS(oc);
+        cc->parse_features(typename, features, errp);
+    }
+    g_free(name);
+
+    if (*errp) {
+        return NULL;
+    }
+    return S390_CPU(CPU(object_new(typename)));
+}
+
+S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp)
+{
+    S390CPU *cpu;
+    Error *err = NULL;
+
+    cpu = cpu_s390x_create(cpu_model, &err);
+    if (err != NULL) {
+        goto out;
+    }
+
+    object_property_set_int(OBJECT(cpu), id, "id", &err);
+    if (err != NULL) {
+        goto out;
+    }
+    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
+
+out:
+    if (err) {
+        error_propagate(errp, err);
+        object_unref(OBJECT(cpu));
+        cpu = NULL;
+    }
+    return cpu;
+}
+
+S390CPU *cpu_s390x_init(const char *cpu_model)
+{
+    Error *err = NULL;
+    S390CPU *cpu;
+    /* Use to track CPU ID for linux-user only */
+    static int64_t next_cpu_id;
+
+    cpu = s390x_new_cpu(cpu_model, next_cpu_id++, &err);
+    if (err) {
+        error_report_err(err);
+    }
+    return cpu;
+}
+
 static const TypeInfo s390_cpu_type_info = {
     .name = TYPE_S390_CPU,
     .parent = TYPE_CPU,
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 68bd2f9784..19bcaf12dc 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -68,81 +68,6 @@ void s390x_cpu_timer(void *opaque)
 }
 #endif
 
-S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp)
-{
-    static bool features_parsed;
-    char *name, *features;
-    const char *typename;
-    ObjectClass *oc;
-    CPUClass *cc;
-
-    name = g_strdup(cpu_model);
-    features = strchr(name, ',');
-    if (features) {
-        features[0] = 0;
-        features++;
-    }
-
-    oc = cpu_class_by_name(TYPE_S390_CPU, name);
-    if (!oc) {
-        error_setg(errp, "Unknown CPU definition \'%s\'", name);
-        g_free(name);
-        return NULL;
-    }
-    typename = object_class_get_name(oc);
-
-    if (!features_parsed) {
-        features_parsed = true;
-        cc = CPU_CLASS(oc);
-        cc->parse_features(typename, features, errp);
-    }
-    g_free(name);
-
-    if (*errp) {
-        return NULL;
-    }
-    return S390_CPU(CPU(object_new(typename)));
-}
-
-S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp)
-{
-    S390CPU *cpu;
-    Error *err = NULL;
-
-    cpu = cpu_s390x_create(cpu_model, &err);
-    if (err != NULL) {
-        goto out;
-    }
-
-    object_property_set_int(OBJECT(cpu), id, "id", &err);
-    if (err != NULL) {
-        goto out;
-    }
-    object_property_set_bool(OBJECT(cpu), true, "realized", &err);
-
-out:
-    if (err) {
-        error_propagate(errp, err);
-        object_unref(OBJECT(cpu));
-        cpu = NULL;
-    }
-    return cpu;
-}
-
-S390CPU *cpu_s390x_init(const char *cpu_model)
-{
-    Error *err = NULL;
-    S390CPU *cpu;
-    /* Use to track CPU ID for linux-user only */
-    static int64_t next_cpu_id;
-
-    cpu = s390x_new_cpu(cpu_model, next_cpu_id++, &err);
-    if (err) {
-        error_report_err(err);
-    }
-    return cpu;
-}
-
 #if defined(CONFIG_USER_ONLY)
 
 void s390_cpu_do_interrupt(CPUState *cs)
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95a36a4bdc..e330bb1f63 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -740,6 +740,8 @@ static inline int cpu_interrupts_enabled(CPUSPARCState *env1)
     return 0;
 }
 
+void compute_psr(CPUSPARCState *env);
+
 static inline int cpu_pil_allowed(CPUSPARCState *env1, int pil)
 {
 #if !defined(TARGET_SPARC64)
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index c9b78ce68e..bab718af7b 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -141,6 +141,11 @@ static void uc32_cpu_initfn(Object *obj)
     }
 }
 
+UniCore32CPU *uc32_cpu_init(const char *cpu_model)
+{
+    return UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
+}
+
 static const VMStateDescription vmstate_uc32_cpu = {
     .name = "cpu",
     .unmigratable = 1,
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f9239dc7b8..309dcd1ae1 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -27,11 +27,6 @@
 #define DPRINTF(fmt, ...) do {} while (0)
 #endif
 
-UniCore32CPU *uc32_cpu_init(const char *cpu_model)
-{
-    return UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
-}
-
 #ifndef CONFIG_USER_ONLY
 void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
         uint32_t cop)
-- 
2.11.1
