Received: from eggs.gnu.org ([2001:4830:134:3::10]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAa-0007Wl-2W
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwl-0003yu-G3
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:53 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:43 +0100
Message-Id: <20181113165247.4806-10-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/13] target: arm: Move CPU state dumping
 routines to helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org

They're not TCG specific and should be living the generic helper file
instead.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
---
 target/arm/internals.h     |  12 +++
 target/arm/translate.h     |   7 --
 target/arm/helper.c        | 214 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 125 ----------------------
 target/arm/translate.c     |  87 ---------------
 5 files changed, 226 insertions(+), 219 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 06439467d2..ddb594d58d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -937,4 +937,16 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                        int *prot, bool *is_subpage,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
 
+#ifdef TARGET_AARCH64
+void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
+                            fprintf_function cpu_fprintf, int flags);
+
+#else
+static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
+                                          fprintf_function cpu_fprintf,
+                                          int flags)
+{
+}
+#endif
+
 #endif
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 1550aa8bc7..059645c23c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -155,8 +155,6 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_set_pc_im(uint64_t val);
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags);
 extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
@@ -167,11 +165,6 @@ static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }
 
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                                          fprintf_function cpu_fprintf,
-                                          int flags)
-{
-}
 #endif
 
 void arm_test_cc(DisasCompare *cmp, int cc);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 996dfbbda2..ff3011fcb6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9555,4 +9555,218 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
         aarch64_sve_narrow_vq(env, new_len + 1);
     }
 }
+
+void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
+                            fprintf_function cpu_fprintf, int flags)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint32_t psr = pstate_read(env);
+    int i;
+    int el = arm_current_el(env);
+    const char *ns_status;
+
+    cpu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
+    for (i = 0; i < 32; i++) {
+        if (i == 31) {
+            cpu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
+        } else {
+            cpu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
+                        (i + 2) % 3 ? " " : "\n");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && el != 3) {
+        ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    } else {
+        ns_status = "";
+    }
+    cpu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
+                psr,
+                psr & PSTATE_N ? 'N' : '-',
+                psr & PSTATE_Z ? 'Z' : '-',
+                psr & PSTATE_C ? 'C' : '-',
+                psr & PSTATE_V ? 'V' : '-',
+                ns_status,
+                el,
+                psr & PSTATE_SP ? 'h' : 't');
+
+    if (!(flags & CPU_DUMP_FPU)) {
+        cpu_fprintf(f, "\n");
+        return;
+    }
+    if (fp_exception_el(env, el) != 0) {
+        cpu_fprintf(f, "    FPU disabled\n");
+        return;
+    }
+    cpu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+                vfp_get_fpcr(env), vfp_get_fpsr(env));
+
+    if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) == 0) {
+        int j, zcr_len = sve_zcr_len_for_el(env, el);
+
+        for (i = 0; i <= FFR_PRED_NUM; i++) {
+            bool eol;
+            if (i == FFR_PRED_NUM) {
+                cpu_fprintf(f, "FFR=");
+                /* It's last, so end the line.  */
+                eol = true;
+            } else {
+                cpu_fprintf(f, "P%02d=", i);
+                switch (zcr_len) {
+                case 0:
+                    eol = i % 8 == 7;
+                    break;
+                case 1:
+                    eol = i % 6 == 5;
+                    break;
+                case 2:
+                case 3:
+                    eol = i % 3 == 2;
+                    break;
+                default:
+                    /* More than one quadword per predicate.  */
+                    eol = true;
+                    break;
+                }
+            }
+            for (j = zcr_len / 4; j >= 0; j--) {
+                int digits;
+                if (j * 4 + 4 <= zcr_len + 1) {
+                    digits = 16;
+                } else {
+                    digits = (zcr_len % 4 + 1) * 4;
+                }
+                cpu_fprintf(f, "%0*" PRIx64 "%s", digits,
+                            env->vfp.pregs[i].p[j],
+                            j ? ":" : eol ? "\n" : " ");
+            }
+        }
+
+        for (i = 0; i < 32; i++) {
+            if (zcr_len == 0) {
+                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                            i, env->vfp.zregs[i].d[1],
+                            env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
+            } else if (zcr_len == 1) {
+                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
+                            ":%016" PRIx64 ":%016" PRIx64 "\n",
+                            i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
+                            env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
+            } else {
+                for (j = zcr_len; j >= 0; j--) {
+                    bool odd = (zcr_len - j) % 2 != 0;
+                    if (j == zcr_len) {
+                        cpu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
+                    } else if (!odd) {
+                        if (j > 0) {
+                            cpu_fprintf(f, "   [%x-%x]=", j, j - 1);
+                        } else {
+                            cpu_fprintf(f, "     [%x]=", j);
+                        }
+                    }
+                    cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
+                                env->vfp.zregs[i].d[j * 2 + 1],
+                                env->vfp.zregs[i].d[j * 2],
+                                odd || j == 0 ? "\n" : ":");
+                }
+            }
+        }
+    } else {
+        for (i = 0; i < 32; i++) {
+            uint64_t *q = aa64_vfp_qreg(env, i);
+            cpu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                        i, q[1], q[0], (i & 1 ? "\n" : " "));
+        }
+    }
+}
+
 #endif
+
+void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                        int flags)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    int i;
+
+    if (is_a64(env)) {
+        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
+        return;
+    }
+
+    for (i = 0; i < 16; i++) {
+        cpu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
+        if ((i % 4) == 3) {
+            cpu_fprintf(f, "\n");
+        } else {
+            cpu_fprintf(f, " ");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        uint32_t xpsr = xpsr_read(env);
+        const char *mode;
+        const char *ns_status = "";
+
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            ns_status = env->v7m.secure ? "S " : "NS ";
+        }
+
+        if (xpsr & XPSR_EXCP) {
+            mode = "handler";
+        } else {
+            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_MASK) {
+                mode = "unpriv-thread";
+            } else {
+                mode = "priv-thread";
+            }
+        }
+
+        cpu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
+                    xpsr,
+                    xpsr & XPSR_N ? 'N' : '-',
+                    xpsr & XPSR_Z ? 'Z' : '-',
+                    xpsr & XPSR_C ? 'C' : '-',
+                    xpsr & XPSR_V ? 'V' : '-',
+                    xpsr & XPSR_T ? 'T' : 'A',
+                    ns_status,
+                    mode);
+    } else {
+        uint32_t psr = cpsr_read(env);
+        const char *ns_status = "";
+
+        if (arm_feature(env, ARM_FEATURE_EL3) &&
+            (psr & CPSR_M) != ARM_CPU_MODE_MON) {
+            ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+        }
+
+        cpu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
+                    psr,
+                    psr & CPSR_N ? 'N' : '-',
+                    psr & CPSR_Z ? 'Z' : '-',
+                    psr & CPSR_C ? 'C' : '-',
+                    psr & CPSR_V ? 'V' : '-',
+                    psr & CPSR_T ? 'T' : 'A',
+                    ns_status,
+                    aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
+    }
+
+    if (flags & CPU_DUMP_FPU) {
+        int numvfpregs = 0;
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            numvfpregs += 16;
+        }
+        if (arm_feature(env, ARM_FEATURE_VFP3)) {
+            numvfpregs += 16;
+        }
+        for (i = 0; i < numvfpregs; i++) {
+            uint64_t v = *aa32_vfp_dreg(env, i);
+            cpu_fprintf(f, "s%02d=%08x s%02d=%08x d%02d=%016" PRIx64 "\n",
+                        i * 2, (uint32_t)v,
+                        i * 2 + 1, (uint32_t)(v >> 32),
+                        i, v);
+        }
+        cpu_fprintf(f, "FPSCR: %08x\n", (int)env->vfp.xregs[ARM_VFP_FPSCR]);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fd36425f1a..642df2f821 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -128,131 +128,6 @@ static inline int get_a64_user_mem_index(DisasContext *s)
     return arm_to_core_mmu_idx(useridx);
 }
 
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    uint32_t psr = pstate_read(env);
-    int i;
-    int el = arm_current_el(env);
-    const char *ns_status;
-
-    cpu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
-    for (i = 0; i < 32; i++) {
-        if (i == 31) {
-            cpu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
-        } else {
-            cpu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
-                        (i + 2) % 3 ? " " : "\n");
-        }
-    }
-
-    if (arm_feature(env, ARM_FEATURE_EL3) && el != 3) {
-        ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-    } else {
-        ns_status = "";
-    }
-    cpu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
-                psr,
-                psr & PSTATE_N ? 'N' : '-',
-                psr & PSTATE_Z ? 'Z' : '-',
-                psr & PSTATE_C ? 'C' : '-',
-                psr & PSTATE_V ? 'V' : '-',
-                ns_status,
-                el,
-                psr & PSTATE_SP ? 'h' : 't');
-
-    if (!(flags & CPU_DUMP_FPU)) {
-        cpu_fprintf(f, "\n");
-        return;
-    }
-    if (fp_exception_el(env, el) != 0) {
-        cpu_fprintf(f, "    FPU disabled\n");
-        return;
-    }
-    cpu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
-                vfp_get_fpcr(env), vfp_get_fpsr(env));
-
-    if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) == 0) {
-        int j, zcr_len = sve_zcr_len_for_el(env, el);
-
-        for (i = 0; i <= FFR_PRED_NUM; i++) {
-            bool eol;
-            if (i == FFR_PRED_NUM) {
-                cpu_fprintf(f, "FFR=");
-                /* It's last, so end the line.  */
-                eol = true;
-            } else {
-                cpu_fprintf(f, "P%02d=", i);
-                switch (zcr_len) {
-                case 0:
-                    eol = i % 8 == 7;
-                    break;
-                case 1:
-                    eol = i % 6 == 5;
-                    break;
-                case 2:
-                case 3:
-                    eol = i % 3 == 2;
-                    break;
-                default:
-                    /* More than one quadword per predicate.  */
-                    eol = true;
-                    break;
-                }
-            }
-            for (j = zcr_len / 4; j >= 0; j--) {
-                int digits;
-                if (j * 4 + 4 <= zcr_len + 1) {
-                    digits = 16;
-                } else {
-                    digits = (zcr_len % 4 + 1) * 4;
-                }
-                cpu_fprintf(f, "%0*" PRIx64 "%s", digits,
-                            env->vfp.pregs[i].p[j],
-                            j ? ":" : eol ? "\n" : " ");
-            }
-        }
-
-        for (i = 0; i < 32; i++) {
-            if (zcr_len == 0) {
-                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
-                            i, env->vfp.zregs[i].d[1],
-                            env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
-            } else if (zcr_len == 1) {
-                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
-                            ":%016" PRIx64 ":%016" PRIx64 "\n",
-                            i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
-                            env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
-            } else {
-                for (j = zcr_len; j >= 0; j--) {
-                    bool odd = (zcr_len - j) % 2 != 0;
-                    if (j == zcr_len) {
-                        cpu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
-                    } else if (!odd) {
-                        if (j > 0) {
-                            cpu_fprintf(f, "   [%x-%x]=", j, j - 1);
-                        } else {
-                            cpu_fprintf(f, "     [%x]=", j);
-                        }
-                    }
-                    cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
-                                env->vfp.zregs[i].d[j * 2 + 1],
-                                env->vfp.zregs[i].d[j * 2],
-                                odd || j == 0 ? "\n" : ":");
-                }
-            }
-        }
-    } else {
-        for (i = 0; i < 32; i++) {
-            uint64_t *q = aa64_vfp_qreg(env, i);
-            cpu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
-                        i, q[1], q[0], (i & 1 ? "\n" : " "));
-        }
-    }
-}
-
 void gen_a64_set_pc_im(uint64_t val)
 {
     tcg_gen_movi_i64(cpu_pc, val);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7c4675ffd8..839ca85cd4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13528,93 +13528,6 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     translator_loop(ops, &dc.base, cpu, tb);
 }
 
-void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    int i;
-
-    if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
-        return;
-    }
-
-    for(i=0;i<16;i++) {
-        cpu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
-        if ((i % 4) == 3)
-            cpu_fprintf(f, "\n");
-        else
-            cpu_fprintf(f, " ");
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        uint32_t xpsr = xpsr_read(env);
-        const char *mode;
-        const char *ns_status = "";
-
-        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            ns_status = env->v7m.secure ? "S " : "NS ";
-        }
-
-        if (xpsr & XPSR_EXCP) {
-            mode = "handler";
-        } else {
-            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_MASK) {
-                mode = "unpriv-thread";
-            } else {
-                mode = "priv-thread";
-            }
-        }
-
-        cpu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
-                    xpsr,
-                    xpsr & XPSR_N ? 'N' : '-',
-                    xpsr & XPSR_Z ? 'Z' : '-',
-                    xpsr & XPSR_C ? 'C' : '-',
-                    xpsr & XPSR_V ? 'V' : '-',
-                    xpsr & XPSR_T ? 'T' : 'A',
-                    ns_status,
-                    mode);
-    } else {
-        uint32_t psr = cpsr_read(env);
-        const char *ns_status = "";
-
-        if (arm_feature(env, ARM_FEATURE_EL3) &&
-            (psr & CPSR_M) != ARM_CPU_MODE_MON) {
-            ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-        }
-
-        cpu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
-                    psr,
-                    psr & CPSR_N ? 'N' : '-',
-                    psr & CPSR_Z ? 'Z' : '-',
-                    psr & CPSR_C ? 'C' : '-',
-                    psr & CPSR_V ? 'V' : '-',
-                    psr & CPSR_T ? 'T' : 'A',
-                    ns_status,
-                    aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
-    }
-
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs = 0;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
-            numvfpregs += 16;
-        }
-        if (arm_feature(env, ARM_FEATURE_VFP3)) {
-            numvfpregs += 16;
-        }
-        for (i = 0; i < numvfpregs; i++) {
-            uint64_t v = *aa32_vfp_dreg(env, i);
-            cpu_fprintf(f, "s%02d=%08x s%02d=%08x d%02d=%016" PRIx64 "\n",
-                        i * 2, (uint32_t)v,
-                        i * 2 + 1, (uint32_t)(v >> 32),
-                        i, v);
-        }
-        cpu_fprintf(f, "FPSCR: %08x\n", (int)env->vfp.xregs[ARM_VFP_FPSCR]);
-    }
-}
-
 void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
-- 
2.19.1
