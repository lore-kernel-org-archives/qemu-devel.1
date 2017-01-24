Received: from eggs.gnu.org ([2001:4830:134:3::10]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVy2o-0006Vj-UZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVy2i-0001V5-EP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:09:42 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cVy2i-0001V1-4a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:09:36 -0500
Received: by mail-yw0-x244.google.com with SMTP id l16so23775ywb.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 02:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-3-ale+qemu@clearmind.me>
In-Reply-To: <20170121084600.5860-3-ale+qemu@clearmind.me>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Jan 2017 10:09:25 +0000
Message-ID: <CAJ+F1C+B1Ncoh57a1cHUKfum1DVNs3-WbzgbaRSEmqiuxnYJ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] *-user targets object files
 decoupling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Di Federico <ale+qemu@clearmind.me>, qemu-devel@nongnu.org

On Sat, Jan 21, 2017 at 12:49 PM Alessandro Di Federico <
ale+qemu@clearmind.me> wrote:

Move some functions around in target/$arch/*.c to reduce the coupling
among the various compilation unit. In particular, we want to make the
various translate.c as much standalone as possible, so that they will be
easily employed by libtcg.
---
 exec.c                       |   2 +
 target/arm/cpu.c             | 118
+++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h             |  82 ++++++++++++++++++++++--------
 target/arm/helper.c          |  73 +-------------------------
 target/arm/translate-a64.c   |  54 --------------------
 target/arm/translate.c       |  97 ++++++++++++-----------------------
 target/arm/translate.h       |   7 ---
 target/m68k/op_helper.c      |  23 +++++++++
 target/m68k/translate.c      |  23 ---------
 target/mips/op_helper.c      |   8 ---
 target/mips/translate.c      |   8 +++
 target/ppc/gdbstub.c         |  20 --------
 target/ppc/translate_init.c  |  20 ++++++++
 target/unicore32/helper.c    |  68 +++++++++++++++++++++++++
 target/unicore32/translate.c |  68 -------------------------
 15 files changed, 333 insertions(+), 338 deletions(-)

diff --git a/exec.c b/exec.c
index 47835c1dc1..66f8187281 100644
--- a/exec.c
+++ b/exec.c
@@ -672,9 +672,11 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     if (cc->vmsd !=3D NULL) {
         vmstate_unregister(NULL, cc->vmsd, cpu);
     }
+#ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {
         vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
     }
+#endif


Shouldn't this #ifndef block also include the vmsd vmstate_unregister()
above? That would be matching cpu_exec_realizefn() #ifndef.

 }

 void cpu_exec_initfn(CPUState *cpu)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f5cb30af6c..f0af5d5d7d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -238,6 +238,124 @@ static void arm_cpu_reset(CPUState *s)
     hw_watchpoint_update_all(cpu);
 }

+static void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
+                                   fprintf_function cpu_fprintf, int flags=
)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    uint32_t psr =3D pstate_read(env);
+    int i;
+    int el =3D arm_current_el(env);
+    const char *ns_status;
+
+    cpu_fprintf(f, "PC=3D%016"PRIx64"  SP=3D%016"PRIx64"\n",
+            env->pc, env->xregs[31]);
+    for (i =3D 0; i < 31; i++) {
+        cpu_fprintf(f, "X%02d=3D%016"PRIx64, i, env->xregs[i]);
+        if ((i % 4) =3D=3D 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && el !=3D 3) {
+        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    } else {
+        ns_status =3D "";
+    }
+
+    cpu_fprintf(f, "\nPSTATE=3D%08x %c%c%c%c %sEL%d%c\n",
+                psr,
+                psr & PSTATE_N ? 'N' : '-',
+                psr & PSTATE_Z ? 'Z' : '-',
+                psr & PSTATE_C ? 'C' : '-',
+                psr & PSTATE_V ? 'V' : '-',
+                ns_status,
+                el,
+                psr & PSTATE_SP ? 'h' : 't');
+
+    if (flags & CPU_DUMP_FPU) {
+        int numvfpregs =3D 32;
+        for (i =3D 0; i < numvfpregs; i +=3D 2) {
+            uint64_t vlo =3D float64_val(env->vfp.regs[i * 2]);
+            uint64_t vhi =3D float64_val(env->vfp.regs[(i * 2) + 1]);
+            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 " ",
+                        i, vhi, vlo);
+            vlo =3D float64_val(env->vfp.regs[(i + 1) * 2]);
+            vhi =3D float64_val(env->vfp.regs[((i + 1) * 2) + 1]);
+            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "\n",
+                        i + 1, vhi, vlo);
+        }
+        cpu_fprintf(f, "FPCR: %08x  FPSR: %08x\n",
+                    vfp_get_fpcr(env), vfp_get_fpsr(env));
+    }
+}
+
+static const char *cpu_mode_names[16] =3D {
+  "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
+  "???", "???", "hyp", "und", "???", "???", "???", "sys"
+};
+
+void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function
cpu_fprintf,
+                        int flags)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    int i;
+    uint32_t psr;
+    const char *ns_status;
+
+    if (is_a64(env)) {
+        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
+        return;
+    }
+
+    for(i=3D0;i<16;i++) {
+        cpu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
+        if ((i % 4) =3D=3D 3)
+            cpu_fprintf(f, "\n");
+        else
+            cpu_fprintf(f, " ");
+    }
+    psr =3D cpsr_read(env);
+
+    if (arm_feature(env, ARM_FEATURE_EL3) &&
+        (psr & CPSR_M) !=3D ARM_CPU_MODE_MON) {
+        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    } else {
+        ns_status =3D "";
+    }
+
+    cpu_fprintf(f, "PSR=3D%08x %c%c%c%c %c %s%s%d\n",
+                psr,
+                psr & (1 << 31) ? 'N' : '-',
+                psr & (1 << 30) ? 'Z' : '-',
+                psr & (1 << 29) ? 'C' : '-',
+                psr & (1 << 28) ? 'V' : '-',
+                psr & CPSR_T ? 'T' : 'A',
+                ns_status,
+                cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
+
+    if (flags & CPU_DUMP_FPU) {
+        int numvfpregs =3D 0;
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            numvfpregs +=3D 16;
+        }
+        if (arm_feature(env, ARM_FEATURE_VFP3)) {
+            numvfpregs +=3D 16;
+        }
+        for (i =3D 0; i < numvfpregs; i++) {
+            uint64_t v =3D float64_val(env->vfp.regs[i]);
+            cpu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRIx64=
 "\n",
+                        i * 2, (uint32_t)v,
+                        i * 2 + 1, (uint32_t)(v >> 32),
+                        i, v);
+        }
+        cpu_fprintf(f, "FPSCR: %08x\n",
(int)env->vfp.xregs[ARM_VFP_FPSCR]);
+    }
+}
+
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cs);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab119e62ab..3d3bf26f4e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1012,7 +1012,6 @@ static inline void xpsr_write(CPUARMState *env,
uint32_t val, uint32_t mask)
 #define SCR_AARCH64_MASK      (0x3fff & ~SCR_NET)

 /* Return the current FPSCR value.  */
-uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);

 /* For A64 the FPSCR is split into two logically distinct registers,
@@ -1021,27 +1020,6 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
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
-    uint32_t new_fpscr =3D (vfp_get_fpscr(env) & ~FPSR_MASK) | (val &
FPSR_MASK);
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
-    uint32_t new_fpscr =3D (vfp_get_fpscr(env) & ~FPCR_MASK) | (val &
FPCR_MASK);
-    vfp_set_fpscr(env, new_fpscr);
-}

 enum arm_cpu_mode {
   ARM_CPU_MODE_USR =3D 0x10,
@@ -1128,6 +1106,66 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
 };

+/* VFP support.  We follow the convention used for VFP instructions:
+   Single precision routines have a "s" suffix, double precision a
+   "d" suffix.  */
+
+/* Convert host exception flags to vfp form.  */
+static inline int vfp_exceptbits_from_host(int host_bits)
+{
+    int target_bits =3D 0;
+
+    if (host_bits & float_flag_invalid)
+        target_bits |=3D 1;
+    if (host_bits & float_flag_divbyzero)
+        target_bits |=3D 2;
+    if (host_bits & float_flag_overflow)
+        target_bits |=3D 4;
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal))
+        target_bits |=3D 8;
+    if (host_bits & float_flag_inexact)
+        target_bits |=3D 0x10;
+    if (host_bits & float_flag_input_denormal)
+        target_bits |=3D 0x80;
+    return target_bits;
+}
+
+static inline uint32_t vfp_get_fpscr(CPUARMState *env)
+{
+    int i;
+    uint32_t fpscr;
+
+    fpscr =3D (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
+            | (env->vfp.vec_len << 16)
+            | (env->vfp.vec_stride << 20);
+    i =3D get_float_exception_flags(&env->vfp.fp_status);
+    i |=3D get_float_exception_flags(&env->vfp.standard_fp_status);
+    fpscr |=3D vfp_exceptbits_from_host(i);
+    return fpscr;
+}
+
+static inline uint32_t vfp_get_fpsr(CPUARMState *env)
+{
+    return vfp_get_fpscr(env) & FPSR_MASK;
+}
+
+static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
+{
+    uint32_t new_fpscr =3D (vfp_get_fpscr(env) & ~FPSR_MASK) | (val &
FPSR_MASK);
+    vfp_set_fpscr(env, new_fpscr);
+}
+
+static inline uint32_t vfp_get_fpcr(CPUARMState *env)
+{
+    return vfp_get_fpscr(env) & FPCR_MASK;
+}
+
+static inline void vfp_set_fpcr(CPUARMState *env, uint32_t val)
+{
+    uint32_t new_fpscr =3D (vfp_get_fpscr(env) & ~FPCR_MASK) | (val &
FPCR_MASK);
+    vfp_set_fpscr(env, new_fpscr);
+}
+
 static inline int arm_feature(CPUARMState *env, int feature)
 {
     return (env->features & (1ULL << feature)) !=3D 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8dcabbf576..2ec50b94fc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5514,11 +5514,6 @@ void define_arm_cp_regs_with_opaque(ARMCPU *cpu,
     }
 }

-const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t
encoded_cp)
-{
-    return g_hash_table_lookup(cpregs, &encoded_cp);
-}
-
 void arm_cp_write_ignore(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
@@ -8664,47 +8659,9 @@ uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t
a, uint32_t b)
     return (a & mask) | (b & ~mask);
 }

-/* VFP support.  We follow the convention used for VFP instructions:
-   Single precision routines have a "s" suffix, double precision a
-   "d" suffix.  */
-
-/* Convert host exception flags to vfp form.  */
-static inline int vfp_exceptbits_from_host(int host_bits)
-{
-    int target_bits =3D 0;
-
-    if (host_bits & float_flag_invalid)
-        target_bits |=3D 1;
-    if (host_bits & float_flag_divbyzero)
-        target_bits |=3D 2;
-    if (host_bits & float_flag_overflow)
-        target_bits |=3D 4;
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal))
-        target_bits |=3D 8;
-    if (host_bits & float_flag_inexact)
-        target_bits |=3D 0x10;
-    if (host_bits & float_flag_input_denormal)
-        target_bits |=3D 0x80;
-    return target_bits;
-}
-
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
-    int i;
-    uint32_t fpscr;
-
-    fpscr =3D (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
-    i =3D get_float_exception_flags(&env->vfp.fp_status);
-    i |=3D get_float_exception_flags(&env->vfp.standard_fp_status);
-    fpscr |=3D vfp_exceptbits_from_host(i);
-    return fpscr;
-}
-
-uint32_t vfp_get_fpscr(CPUARMState *env)
-{
-    return HELPER(vfp_get_fpscr)(env);
+    return vfp_get_fpscr(env);
 }

 /* Convert vfp exception flags to target form.  */
@@ -9577,34 +9534,6 @@ float64 HELPER(rintd)(float64 x, void *fp_status)
     return ret;
 }

-/* Convert ARM rounding mode to softfloat */
-int arm_rmode_to_sf(int rmode)
-{
-    switch (rmode) {
-    case FPROUNDING_TIEAWAY:
-        rmode =3D float_round_ties_away;
-        break;
-    case FPROUNDING_ODD:
-        /* FIXME: add support for TIEAWAY and ODD */
-        qemu_log_mask(LOG_UNIMP, "arm: unimplemented rounding mode: %d\n",
-                      rmode);
-    case FPROUNDING_TIEEVEN:
-    default:
-        rmode =3D float_round_nearest_even;
-        break;
-    case FPROUNDING_POSINF:
-        rmode =3D float_round_up;
-        break;
-    case FPROUNDING_NEGINF:
-        rmode =3D float_round_down;
-        break;
-    case FPROUNDING_ZERO:
-        rmode =3D float_round_to_zero;
-        break;
-    }
-    return rmode;
-}
-
 /* CRC helpers.
  * The upper bytes of val (above the number specified by 'bytes') must hav=
e
  * been zeroed out by the caller.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f673d939e1..56333c6dd5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -118,60 +118,6 @@ static inline ARMMMUIdx
get_a64_user_mem_index(DisasContext *s)
     }
 }

-void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    uint32_t psr =3D pstate_read(env);
-    int i;
-    int el =3D arm_current_el(env);
-    const char *ns_status;
-
-    cpu_fprintf(f, "PC=3D%016"PRIx64"  SP=3D%016"PRIx64"\n",
-            env->pc, env->xregs[31]);
-    for (i =3D 0; i < 31; i++) {
-        cpu_fprintf(f, "X%02d=3D%016"PRIx64, i, env->xregs[i]);
-        if ((i % 4) =3D=3D 3) {
-            cpu_fprintf(f, "\n");
-        } else {
-            cpu_fprintf(f, " ");
-        }
-    }
-
-    if (arm_feature(env, ARM_FEATURE_EL3) && el !=3D 3) {
-        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-    } else {
-        ns_status =3D "";
-    }
-
-    cpu_fprintf(f, "\nPSTATE=3D%08x %c%c%c%c %sEL%d%c\n",
-                psr,
-                psr & PSTATE_N ? 'N' : '-',
-                psr & PSTATE_Z ? 'Z' : '-',
-                psr & PSTATE_C ? 'C' : '-',
-                psr & PSTATE_V ? 'V' : '-',
-                ns_status,
-                el,
-                psr & PSTATE_SP ? 'h' : 't');
-
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs =3D 32;
-        for (i =3D 0; i < numvfpregs; i +=3D 2) {
-            uint64_t vlo =3D float64_val(env->vfp.regs[i * 2]);
-            uint64_t vhi =3D float64_val(env->vfp.regs[(i * 2) + 1]);
-            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 " ",
-                        i, vhi, vlo);
-            vlo =3D float64_val(env->vfp.regs[(i + 1) * 2]);
-            vhi =3D float64_val(env->vfp.regs[((i + 1) * 2) + 1]);
-            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "\n",
-                        i + 1, vhi, vlo);
-        }
-        cpu_fprintf(f, "FPCR: %08x  FPSR: %08x\n",
-                    vfp_get_fpcr(env), vfp_get_fpsr(env));
-    }
-}
-
 void gen_a64_set_pc_im(uint64_t val)
 {
     tcg_gen_movi_i64(cpu_pc, val);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ad9070b45..a82557eb39 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2971,6 +2971,34 @@ static int handle_vminmaxnm(uint32_t insn, uint32_t
rd, uint32_t rn,
     return 0;
 }

+/* Convert ARM rounding mode to softfloat */
+int arm_rmode_to_sf(int rmode)
+{
+    switch (rmode) {
+    case FPROUNDING_TIEAWAY:
+        rmode =3D float_round_ties_away;
+        break;
+    case FPROUNDING_ODD:
+        /* FIXME: add support for TIEAWAY and ODD */
+        qemu_log_mask(LOG_UNIMP, "arm: unimplemented rounding mode: %d\n",
+                      rmode);
+    case FPROUNDING_TIEEVEN:
+    default:
+        rmode =3D float_round_nearest_even;
+        break;
+    case FPROUNDING_POSINF:
+        rmode =3D float_round_up;
+        break;
+    case FPROUNDING_NEGINF:
+        rmode =3D float_round_down;
+        break;
+    case FPROUNDING_ZERO:
+        rmode =3D float_round_to_zero;
+        break;
+    }
+    return rmode;
+}
+
 static int handle_vrint(uint32_t insn, uint32_t rd, uint32_t rm, uint32_t
dp,
                         int rounding)
 {
@@ -7399,6 +7427,11 @@ static int disas_neon_data_insn(DisasContext *s,
uint32_t insn)
     return 0;
 }

+const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t
encoded_cp)
+{
+    return g_hash_table_lookup(cpregs, &encoded_cp);
+}
+
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
@@ -11976,70 +12009,6 @@ done_generating:
     tb->icount =3D num_insns;
 }

-static const char *cpu_mode_names[16] =3D {
-  "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
-  "???", "???", "hyp", "und", "???", "???", "???", "sys"
-};
-
-void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function
cpu_fprintf,
-                        int flags)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    int i;
-    uint32_t psr;
-    const char *ns_status;
-
-    if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
-        return;
-    }
-
-    for(i=3D0;i<16;i++) {
-        cpu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
-        if ((i % 4) =3D=3D 3)
-            cpu_fprintf(f, "\n");
-        else
-            cpu_fprintf(f, " ");
-    }
-    psr =3D cpsr_read(env);
-
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        (psr & CPSR_M) !=3D ARM_CPU_MODE_MON) {
-        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-    } else {
-        ns_status =3D "";
-    }
-
-    cpu_fprintf(f, "PSR=3D%08x %c%c%c%c %c %s%s%d\n",
-                psr,
-                psr & (1 << 31) ? 'N' : '-',
-                psr & (1 << 30) ? 'Z' : '-',
-                psr & (1 << 29) ? 'C' : '-',
-                psr & (1 << 28) ? 'V' : '-',
-                psr & CPSR_T ? 'T' : 'A',
-                ns_status,
-                cpu_mode_names[psr & 0xf], (psr & 0x10) ? 32 : 26);
-
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs =3D 0;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
-            numvfpregs +=3D 16;
-        }
-        if (arm_feature(env, ARM_FEATURE_VFP3)) {
-            numvfpregs +=3D 16;
-        }
-        for (i =3D 0; i < numvfpregs; i++) {
-            uint64_t v =3D float64_val(env->vfp.regs[i]);
-            cpu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRIx64=
 "\n",
-                        i * 2, (uint32_t)v,
-                        i * 2 + 1, (uint32_t)(v >> 32),
-                        i, v);
-        }
-        cpu_fprintf(f, "FPSCR: %08x\n",
(int)env->vfp.xregs[ARM_VFP_FPSCR]);
-    }
-}
-
 void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 285e96f087..6b93b35a3b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -125,8 +125,6 @@ static inline int default_exception_el(DisasContext *s)
 void a64_translate_init(void);
 void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags);
 #else
 static inline void a64_translate_init(void)
 {
@@ -140,11 +138,6 @@ static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }

-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                                          fprintf_function cpu_fprintf,
-                                          int flags)
-{
-}
 #endif

 void arm_test_cc(DisasCompare *cmp, int cc);
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index e56b815d73..059061e6e8 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -148,6 +148,29 @@ static inline void
do_interrupt_m68k_hardirq(CPUM68KState *env)
 }
 #endif

+void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function
cpu_fprintf,
+                         int flags)
+{
+    M68kCPU *cpu =3D M68K_CPU(cs);
+    CPUM68KState *env =3D &cpu->env;
+    int i;
+    uint16_t sr;
+    CPU_DoubleU u;
+    for (i =3D 0; i < 8; i++)
+      {
+        u.d =3D env->fregs[i];
+        cpu_fprintf(f, "D%d =3D %08x   A%d =3D %08x   F%d =3D %08x%08x (%1=
2g)\n",
+                    i, env->dregs[i], i, env->aregs[i],
+                    i, u.l.upper, u.l.lower, *(double *)&u.d);
+      }
+    cpu_fprintf (f, "PC =3D %08x   ", env->pc);
+    sr =3D env->sr | cpu_m68k_get_ccr(env);
+    cpu_fprintf(f, "SR =3D %04x %c%c%c%c%c ", sr, (sr & CCF_X) ? 'X' : '-'=
,
+                (sr & CCF_N) ? 'N' : '-', (sr & CCF_Z) ? 'Z' : '-',
+                (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
+    cpu_fprintf (f, "FPRESULT =3D %12g\n", *(double *)&env->fp_result);
+}
+
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     M68kCPU *cpu =3D M68K_CPU(cs);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 53293173c5..e0d055c3fe 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4725,29 +4725,6 @@ void gen_intermediate_code(CPUM68KState *env,
TranslationBlock *tb)
     tb->icount =3D num_insns;
 }

-void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function
cpu_fprintf,
-                         int flags)
-{
-    M68kCPU *cpu =3D M68K_CPU(cs);
-    CPUM68KState *env =3D &cpu->env;
-    int i;
-    uint16_t sr;
-    CPU_DoubleU u;
-    for (i =3D 0; i < 8; i++)
-      {
-        u.d =3D env->fregs[i];
-        cpu_fprintf(f, "D%d =3D %08x   A%d =3D %08x   F%d =3D %08x%08x (%1=
2g)\n",
-                    i, env->dregs[i], i, env->aregs[i],
-                    i, u.l.upper, u.l.lower, *(double *)&u.d);
-      }
-    cpu_fprintf (f, "PC =3D %08x   ", env->pc);
-    sr =3D env->sr | cpu_m68k_get_ccr(env);
-    cpu_fprintf(f, "SR =3D %04x %c%c%c%c%c ", sr, (sr & CCF_X) ? 'X' : '-'=
,
-                (sr & CCF_N) ? 'N' : '-', (sr & CCF_Z) ? 'Z' : '-',
-                (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
-    cpu_fprintf (f, "FPRESULT =3D %12g\n", *(double *)&env->fp_result);
-}
-
 void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 7af4c2f084..4965b912ef 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2454,14 +2454,6 @@ void mips_cpu_unassigned_access(CPUState *cs, hwaddr
addr,
 #define FP_TO_INT32_OVERFLOW 0x7fffffff
 #define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL

-/* convert MIPS rounding mode in FCR31 to IEEE library */
-unsigned int ieee_rm[] =3D {
-    float_round_nearest_even,
-    float_round_to_zero,
-    float_round_up,
-    float_round_down
-};
-
 target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
 {
     target_ulong arg1 =3D 0;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 57b824ff2d..697b2a2079 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -36,6 +36,14 @@
 #include "trace-tcg.h"
 #include "exec/log.h"

+/* convert MIPS rounding mode in FCR31 to IEEE library */
+unsigned int ieee_rm[] =3D {
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

-/* We need to present the registers to gdb in the "current" memory
ordering.
-   For user-only mode we get this for free; TARGET_WORDS_BIGENDIAN is set
to
-   the proper ordering for the binary, and cannot be changed.
-   For system mode, TARGET_WORDS_BIGENDIAN is always set, and we must chec=
k
-   the current mode of the chip to see if we're running in little-endian.
*/
-void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
-{
-#ifndef CONFIG_USER_ONLY
-    if (!msr_le) {
-        /* do nothing */
-    } else if (len =3D=3D 4) {
-        bswap32s((uint32_t *)mem_buf);
-    } else if (len =3D=3D 8) {
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
index 626e03186c..74e3339bd8 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9462,6 +9462,26 @@ static bool avr_need_swap(CPUPPCState *env)
 #endif
 }

+/* We need to present the registers to gdb in the "current" memory
ordering.
+   For user-only mode we get this for free; TARGET_WORDS_BIGENDIAN is set
to
+   the proper ordering for the binary, and cannot be changed.
+   For system mode, TARGET_WORDS_BIGENDIAN is always set, and we must chec=
k
+   the current mode of the chip to see if we're running in little-endian.
*/
+void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!msr_le) {
+        /* do nothing */
+    } else if (len =3D=3D 4) {
+        bswap32s((uint32_t *)mem_buf);
+    } else if (len =3D=3D 8) {
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
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index d603bde237..42e753a5ea 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -247,6 +247,74 @@ int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr
address,
 }
 #endif

+static const char *cpu_mode_names[16] =3D {
+    "USER", "REAL", "INTR", "PRIV", "UM14", "UM15", "UM16", "TRAP",
+    "UM18", "UM19", "UM1A", "EXTN", "UM1C", "UM1D", "UM1E", "SUSR"
+};
+
+#undef UCF64_DUMP_STATE
+#ifdef UCF64_DUMP_STATE
+static void cpu_dump_state_ucf64(CPUUniCore32State *env, FILE *f,
+        fprintf_function cpu_fprintf, int flags)
+{
+    int i;
+    union {
+        uint32_t i;
+        float s;
+    } s0, s1;
+    CPU_DoubleU d;
+    /* ??? This assumes float64 and double have the same layout.
+       Oh well, it's only debug dumps.  */
+    union {
+        float64 f64;
+        double d;
+    } d0;
+
+    for (i =3D 0; i < 16; i++) {
+        d.d =3D env->ucf64.regs[i];
+        s0.i =3D d.l.lower;
+        s1.i =3D d.l.upper;
+        d0.f64 =3D d.d;
+        cpu_fprintf(f, "s%02d=3D%08x(%8g) s%02d=3D%08x(%8g)",
+                    i * 2, (int)s0.i, s0.s,
+                    i * 2 + 1, (int)s1.i, s1.s);
+        cpu_fprintf(f, " d%02d=3D%" PRIx64 "(%8g)\n",
+                    i, (uint64_t)d0.f64, d0.d);
+    }
+    cpu_fprintf(f, "FPSCR: %08x\n",
(int)env->ucf64.xregs[UC32_UCF64_FPSCR]);
+}
+#else
+#define cpu_dump_state_ucf64(env, file, pr, flags)      do { } while (0)
+#endif
+
+void uc32_cpu_dump_state(CPUState *cs, FILE *f,
+                         fprintf_function cpu_fprintf, int flags)
+{
+    UniCore32CPU *cpu =3D UNICORE32_CPU(cs);
+    CPUUniCore32State *env =3D &cpu->env;
+    int i;
+    uint32_t psr;
+
+    for (i =3D 0; i < 32; i++) {
+        cpu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
+        if ((i % 4) =3D=3D 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+    psr =3D cpu_asr_read(env);
+    cpu_fprintf(f, "PSR=3D%08x %c%c%c%c %s\n",
+                psr,
+                psr & (1 << 31) ? 'N' : '-',
+                psr & (1 << 30) ? 'Z' : '-',
+                psr & (1 << 29) ? 'C' : '-',
+                psr & (1 << 28) ? 'V' : '-',
+                cpu_mode_names[psr & 0xf]);
+
+    cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
+}
+
 bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 514d460408..92300671a7 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -2036,74 +2036,6 @@ done_generating:
     tb->icount =3D num_insns;
 }

-static const char *cpu_mode_names[16] =3D {
-    "USER", "REAL", "INTR", "PRIV", "UM14", "UM15", "UM16", "TRAP",
-    "UM18", "UM19", "UM1A", "EXTN", "UM1C", "UM1D", "UM1E", "SUSR"
-};
-
-#undef UCF64_DUMP_STATE
-#ifdef UCF64_DUMP_STATE
-static void cpu_dump_state_ucf64(CPUUniCore32State *env, FILE *f,
-        fprintf_function cpu_fprintf, int flags)
-{
-    int i;
-    union {
-        uint32_t i;
-        float s;
-    } s0, s1;
-    CPU_DoubleU d;
-    /* ??? This assumes float64 and double have the same layout.
-       Oh well, it's only debug dumps.  */
-    union {
-        float64 f64;
-        double d;
-    } d0;
-
-    for (i =3D 0; i < 16; i++) {
-        d.d =3D env->ucf64.regs[i];
-        s0.i =3D d.l.lower;
-        s1.i =3D d.l.upper;
-        d0.f64 =3D d.d;
-        cpu_fprintf(f, "s%02d=3D%08x(%8g) s%02d=3D%08x(%8g)",
-                    i * 2, (int)s0.i, s0.s,
-                    i * 2 + 1, (int)s1.i, s1.s);
-        cpu_fprintf(f, " d%02d=3D%" PRIx64 "(%8g)\n",
-                    i, (uint64_t)d0.f64, d0.d);
-    }
-    cpu_fprintf(f, "FPSCR: %08x\n",
(int)env->ucf64.xregs[UC32_UCF64_FPSCR]);
-}
-#else
-#define cpu_dump_state_ucf64(env, file, pr, flags)      do { } while (0)
-#endif
-
-void uc32_cpu_dump_state(CPUState *cs, FILE *f,
-                         fprintf_function cpu_fprintf, int flags)
-{
-    UniCore32CPU *cpu =3D UNICORE32_CPU(cs);
-    CPUUniCore32State *env =3D &cpu->env;
-    int i;
-    uint32_t psr;
-
-    for (i =3D 0; i < 32; i++) {
-        cpu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
-        if ((i % 4) =3D=3D 3) {
-            cpu_fprintf(f, "\n");
-        } else {
-            cpu_fprintf(f, " ");
-        }
-    }
-    psr =3D cpu_asr_read(env);
-    cpu_fprintf(f, "PSR=3D%08x %c%c%c%c %s\n",
-                psr,
-                psr & (1 << 31) ? 'N' : '-',
-                psr & (1 << 30) ? 'Z' : '-',
-                psr & (1 << 29) ? 'C' : '-',
-                psr & (1 << 28) ? 'V' : '-',
-                cpu_mode_names[psr & 0xf]);
-
-    cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
-}
-
 void restore_state_to_opc(CPUUniCore32State *env, TranslationBlock *tb,
                           target_ulong *data)
 {
--
2.11.0


--=20
Marc-Andr=C3=A9 Lureau
