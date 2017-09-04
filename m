Received: from eggs.gnu.org ([2001:4830:134:3::10]:52894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSh-0005Dc-Dx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqST-0004xP-OB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqST-0004wD-F0
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSS-0005c3-2v
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:28 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:26:01 +0100
Message-Id: <1504527967-29248-31-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 30/36] target/arm: Factor out fault delivery code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We currently have some similar code in tlb_fill() and in
arm_cpu_do_unaligned_access() for delivering a data abort or prefetch
abort.  We're also going to want to do the same thing to handle
external aborts.  Factor out the common code into a new function
deliver_fault().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/op_helper.c | 110 +++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 5a94a5f..6114597 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -115,6 +115,51 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
     return syn;
 }
 
+static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
+                          uint32_t fsr, uint32_t fsc, ARMMMUFaultInfo *fi)
+{
+    CPUARMState *env = &cpu->env;
+    int target_el;
+    bool same_el;
+    uint32_t syn, exc;
+
+    target_el = exception_target_el(env);
+    if (fi->stage2) {
+        target_el = 2;
+        env->cp15.hpfar_el2 = extract64(fi->s2addr, 12, 47) << 4;
+    }
+    same_el = (arm_current_el(env) == target_el);
+
+    if (fsc == 0x3f) {
+        /* Caller doesn't have a long-format fault status code. This
+         * should only happen if this fault will never actually be reported
+         * to an EL that uses a syndrome register. Check that here.
+         * 0x3f is a (currently) reserved FSC code, in case the constructed
+         * syndrome does leak into the guest somehow.
+         */
+        assert(target_el != 2 && !arm_el_is_aa64(env, target_el));
+    }
+
+    if (access_type == MMU_INST_FETCH) {
+        syn = syn_insn_abort(same_el, 0, fi->s1ptw, fsc);
+        exc = EXCP_PREFETCH_ABORT;
+    } else {
+        syn = merge_syn_data_abort(env->exception.syndrome, target_el,
+                                   same_el, fi->s1ptw,
+                                   access_type == MMU_DATA_STORE,
+                                   fsc);
+        if (access_type == MMU_DATA_STORE
+            && arm_feature(env, ARM_FEATURE_V6)) {
+            fsr |= (1 << 11);
+        }
+        exc = EXCP_DATA_ABORT;
+    }
+
+    env->exception.vaddress = addr;
+    env->exception.fsr = fsr;
+    raise_exception(env, exc, syn, target_el);
+}
+
 /* try to fill the TLB and return an exception if error. If retaddr is
  * NULL, it means that the function was called in C code (i.e. not
  * from generated code or from helper.c)
@@ -129,23 +174,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
     ret = arm_tlb_fill(cs, addr, access_type, mmu_idx, &fsr, &fi);
     if (unlikely(ret)) {
         ARMCPU *cpu = ARM_CPU(cs);
-        CPUARMState *env = &cpu->env;
-        uint32_t syn, exc, fsc;
-        unsigned int target_el;
-        bool same_el;
+        uint32_t fsc;
 
         if (retaddr) {
             /* now we have a real cpu fault */
             cpu_restore_state(cs, retaddr);
         }
 
-        target_el = exception_target_el(env);
-        if (fi.stage2) {
-            target_el = 2;
-            env->cp15.hpfar_el2 = extract64(fi.s2addr, 12, 47) << 4;
-        }
-        same_el = arm_current_el(env) == target_el;
-
         if (fsr & (1 << 9)) {
             /* LPAE format fault status register : bottom 6 bits are
              * status code in the same form as needed for syndrome
@@ -153,34 +188,15 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
             fsc = extract32(fsr, 0, 6);
         } else {
             /* Short format FSR : this fault will never actually be reported
-             * to an EL that uses a syndrome register. Check that here,
-             * and use a (currently) reserved FSR code in case the constructed
-             * syndrome does leak into the guest somehow.
+             * to an EL that uses a syndrome register. Use a (currently)
+             * reserved FSR code in case the constructed syndrome does leak
+             * into the guest somehow. deliver_fault will assert that
+             * we don't target an EL using the syndrome.
              */
-            assert(target_el != 2 && !arm_el_is_aa64(env, target_el));
             fsc = 0x3f;
         }
 
-        /* For insn and data aborts we assume there is no instruction syndrome
-         * information; this is always true for exceptions reported to EL1.
-         */
-        if (access_type == MMU_INST_FETCH) {
-            syn = syn_insn_abort(same_el, 0, fi.s1ptw, fsc);
-            exc = EXCP_PREFETCH_ABORT;
-        } else {
-            syn = merge_syn_data_abort(env->exception.syndrome, target_el,
-                                       same_el, fi.s1ptw,
-                                       access_type == MMU_DATA_STORE, fsc);
-            if (access_type == MMU_DATA_STORE
-                && arm_feature(env, ARM_FEATURE_V6)) {
-                fsr |= (1 << 11);
-            }
-            exc = EXCP_DATA_ABORT;
-        }
-
-        env->exception.vaddress = addr;
-        env->exception.fsr = fsr;
-        raise_exception(env, exc, syn, target_el);
+        deliver_fault(cpu, addr, access_type, fsr, fsc, &fi);
     }
 }
 
@@ -191,9 +207,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    int target_el;
-    bool same_el;
-    uint32_t syn;
+    uint32_t fsr, fsc;
+    ARMMMUFaultInfo fi = {};
     ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
 
     if (retaddr) {
@@ -201,28 +216,17 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
         cpu_restore_state(cs, retaddr);
     }
 
-    target_el = exception_target_el(env);
-    same_el = (arm_current_el(env) == target_el);
-
-    env->exception.vaddress = vaddr;
-
     /* the DFSR for an alignment fault depends on whether we're using
      * the LPAE long descriptor format, or the short descriptor format
      */
     if (arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        env->exception.fsr = (1 << 9) | 0x21;
+        fsr = (1 << 9) | 0x21;
     } else {
-        env->exception.fsr = 0x1;
-    }
-
-    if (access_type == MMU_DATA_STORE && arm_feature(env, ARM_FEATURE_V6)) {
-        env->exception.fsr |= (1 << 11);
+        fsr = 0x1;
     }
+    fsc = 0x21;
 
-    syn = merge_syn_data_abort(env->exception.syndrome, target_el,
-                               same_el, 0, access_type == MMU_DATA_STORE,
-                               0x21);
-    raise_exception(env, EXCP_DATA_ABORT, syn, target_el);
+    deliver_fault(cpu, vaddr, access_type, fsr, fsc, &fi);
 }
 
 #endif /* !defined(CONFIG_USER_ONLY) */
-- 
2.7.4
