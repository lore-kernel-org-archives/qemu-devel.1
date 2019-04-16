Received: from eggs.gnu.org ([209.51.188.92]:34748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfS-0004z1-AT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfN-0001PM-K2
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfK-0001Mh-Qp
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so26961548wrq.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:33 +0100
Message-Id: <20190416125744.27770-16-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/26] target/arm: Handle floating point
 registers in exception return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Handle floating point registers in exception return.
This corresponds to pseudocode functions ValidateExceptionReturn(),
ExceptionReturn(), PopStack() and ConsumeExcStackFrame().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 142 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2f6382a0b24..0c5b0a73e95 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8452,6 +8452,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool rettobase = false;
     bool exc_secure = false;
     bool return_to_secure;
+    bool ftype;
+    bool restore_s16_s31;
 
     /* If we're not in Handler mode then jumps to magic exception-exit
      * addresses don't have magic behaviour. However for the v8M
@@ -8489,6 +8491,16 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                       excret);
     }
 
+    ftype = excret & R_V7M_EXCRET_FTYPE_MASK;
+
+    if (!arm_feature(env, ARM_FEATURE_VFP) && !ftype) {
+        qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero FTYPE in exception "
+                      "exit PC value 0x%" PRIx32 " is UNPREDICTABLE "
+                      "if FPU not present\n",
+                      excret);
+        ftype = true;
+    }
+
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         /* EXC_RETURN.ES validation check (R_SMFL). We must do this before
          * we pick which FAULTMASK to clear.
@@ -8589,6 +8601,30 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      */
     write_v7m_control_spsel_for_secstate(env, return_to_sp_process, exc_secure);
 
+    /*
+     * Clear scratch FP values left in caller saved registers; this
+     * must happen before any kind of tail chaining.
+     */
+    if ((env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_CLRONRET_MASK) &&
+        (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
+        if (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPACT_MASK) {
+            env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+            qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
+                          "stackframe: error during lazy state deactivation\n");
+            v7m_exception_taken(cpu, excret, true, false);
+            return;
+        } else {
+            /* Clear s0..s15 and FPSCR */
+            int i;
+
+            for (i = 0; i < 16; i += 2) {
+                *aa32_vfp_dreg(env, i / 2) = 0;
+            }
+            vfp_set_fpscr(env, 0);
+        }
+    }
+
     if (sfault) {
         env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
@@ -8750,8 +8786,105 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             }
         }
 
+        if (!ftype) {
+            /* FP present and we need to handle it */
+            if (!return_to_secure &&
+                (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPACT_MASK)) {
+                armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+                env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+                qemu_log_mask(CPU_LOG_INT,
+                              "...taking SecureFault on existing stackframe: "
+                              "Secure LSPACT set but exception return is "
+                              "not to secure state\n");
+                v7m_exception_taken(cpu, excret, true, false);
+                return;
+            }
+
+            restore_s16_s31 = return_to_secure &&
+                (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK);
+
+            if (env->v7m.fpccr[return_to_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+                /* State in FPU is still valid, just clear LSPACT */
+                env->v7m.fpccr[return_to_secure] &= ~R_V7M_FPCCR_LSPACT_MASK;
+            } else {
+                int i;
+                uint32_t fpscr;
+                bool cpacr_pass, nsacr_pass;
+
+                cpacr_pass = v7m_cpacr_pass(env, return_to_secure,
+                                            return_to_priv);
+                nsacr_pass = return_to_secure ||
+                    extract32(env->v7m.nsacr, 10, 1);
+
+                if (!cpacr_pass) {
+                    armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
+                                            return_to_secure);
+                    env->v7m.cfsr[return_to_secure] |= R_V7M_CFSR_NOCP_MASK;
+                    qemu_log_mask(CPU_LOG_INT,
+                                  "...taking UsageFault on existing "
+                                  "stackframe: CPACR.CP10 prevents unstacking "
+                                  "FP regs\n");
+                    v7m_exception_taken(cpu, excret, true, false);
+                    return;
+                } else if (!nsacr_pass) {
+                    armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, true);
+                    env->v7m.cfsr[M_REG_S] |= R_V7M_CFSR_INVPC_MASK;
+                    qemu_log_mask(CPU_LOG_INT,
+                                  "...taking Secure UsageFault on existing "
+                                  "stackframe: NSACR.CP10 prevents unstacking "
+                                  "FP regs\n");
+                    v7m_exception_taken(cpu, excret, true, false);
+                    return;
+                }
+
+                for (i = 0; i < (restore_s16_s31 ? 32 : 16); i += 2) {
+                    uint32_t slo, shi;
+                    uint64_t dn;
+                    uint32_t faddr = frameptr + 0x20 + 4 * i;
+
+                    if (i >= 16) {
+                        faddr += 8; /* Skip the slot for the FPSCR */
+                    }
+
+                    pop_ok = pop_ok &&
+                        v7m_stack_read(cpu, &slo, faddr, mmu_idx) &&
+                        v7m_stack_read(cpu, &shi, faddr + 4, mmu_idx);
+
+                    if (!pop_ok) {
+                        break;
+                    }
+
+                    dn = (uint64_t)shi << 32 | slo;
+                    *aa32_vfp_dreg(env, i / 2) = dn;
+                }
+                pop_ok = pop_ok &&
+                    v7m_stack_read(cpu, &fpscr, frameptr + 0x60, mmu_idx);
+                if (pop_ok) {
+                    vfp_set_fpscr(env, fpscr);
+                }
+                if (!pop_ok) {
+                    /*
+                     * These regs are 0 if security extension present;
+                     * otherwise merely UNKNOWN. We zero always.
+                     */
+                    for (i = 0; i < (restore_s16_s31 ? 32 : 16); i += 2) {
+                        *aa32_vfp_dreg(env, i / 2) = 0;
+                    }
+                    vfp_set_fpscr(env, 0);
+                }
+            }
+        }
+        env->v7m.control[M_REG_S] = FIELD_DP32(env->v7m.control[M_REG_S],
+                                               V7M_CONTROL, FPCA, !ftype);
+
         /* Commit to consuming the stack frame */
         frameptr += 0x20;
+        if (!ftype) {
+            frameptr += 0x48;
+            if (restore_s16_s31) {
+                frameptr += 0x40;
+            }
+        }
         /* Undo stack alignment (the SPREALIGN bit indicates that the original
          * pre-exception SP was not 8-aligned and we added a padding word to
          * align it, so we undo this by ORing in the bit that increases it
@@ -8764,7 +8897,14 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         *frame_sp_p = frameptr;
     }
     /* This xpsr_write() will invalidate frame_sp_p as it may switch stack */
-    xpsr_write(env, xpsr, ~XPSR_SPREALIGN);
+    xpsr_write(env, xpsr, ~(XPSR_SPREALIGN | XPSR_SFPA));
+
+    if (env->v7m.secure) {
+        bool sfpa = xpsr & XPSR_SFPA;
+
+        env->v7m.control[M_REG_S] = FIELD_DP32(env->v7m.control[M_REG_S],
+                                               V7M_CONTROL, SFPA, sfpa);
+    }
 
     /* The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
-- 
2.20.1
