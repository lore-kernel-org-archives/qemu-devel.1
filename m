Received: from eggs.gnu.org ([209.51.188.92]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05r-0005sa-M9
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05p-0008Vv-TQ
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:36069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gt05o-00085p-54
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:05 -0500
Received: by mail-pl1-x635.google.com with SMTP id g9so4514744plo.3
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 17:08:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 10 Feb 2019 17:08:11 -0800
Message-Id: <20190211010829.29869-9-richard.henderson@linaro.org>
In-Reply-To: <20190211010829.29869-1-richard.henderson@linaro.org>
References: <20190211010829.29869-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/26] target/arm: Fill in helper_mte_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Implements the rules of "PE generation of Checked and Unchecked
accesses" which aren't already implied by TB_FLAGS_MTE_ACTIVE.
Implements the rules of "PE handling of Tag Check Failure".

Does not implement tag physical address space, so all operations
reduce to unchecked so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix TFSR update.
---
 target/arm/mte_helper.c | 94 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index f1174d6f9f..d086925a91 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -25,6 +25,8 @@
 #include "exec/helper-proto.h"
 
 
+#if 0
+/* Don't break bisect.  This will gain another user before we're done.  */
 static uint64_t strip_tbi(CPUARMState *env, uint64_t ptr)
 {
     /*
@@ -49,9 +51,97 @@ static uint64_t strip_tbi(CPUARMState *env, uint64_t ptr)
         return ptr;
     }
 }
+#endif
+
+static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
+{
+    /* Tag storage not implemented.  */
+    return -1;
+}
+
+static int allocation_tag_from_addr(uint64_t ptr)
+{
+    ptr += 1ULL << 55;  /* carry ptr[55] into ptr[59:56].  */
+    return extract64(ptr, 56, 4);
+}
 
 uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
 {
-    /* Only unchecked implemented so far.  */
-    return strip_tbi(env, ptr);
+    ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, true);
+    int el = arm_current_el(env);
+    int ptr_tag, mem_tag;
+    uintptr_t ra = GETPC();
+
+    /*
+     * If TBI is disabled, then the access is unchecked.
+     * While we filtered out TBI0==0 && TBI1==0 in cpu_get_tb_cpu_state,
+     * we did not save separate bits for TBI0 != TBI1.
+     */
+    if (!param.tbi) {
+        /* Do not ignore the top byte.  */
+        return ptr;
+    }
+
+    /*
+     * If TCMA is enabled, then physical tag 0 is unchecked.
+     * Note the rules R0076 & R0077 are written with logical tags,
+     * and we need the physical tag below anyway.
+     */
+    ptr_tag = allocation_tag_from_addr(ptr);
+    if (param.tcma && ptr_tag == 0) {
+        goto pass;
+    }
+
+    /*
+     * If an access is made to an address that does not provide tag storage,
+     * the result is implementation defined (R0006).  We choose to treat the
+     * access as unchecked.
+     * This is similar to MemAttr != Tagged, which are also unchecked.
+     */
+    mem_tag = get_allocation_tag(env, ptr, ra);
+    if (mem_tag < 0) {
+        goto pass;
+    }
+
+    /* If the tags do not match, the tag check operation fails.  */
+    if (ptr_tag != mem_tag) {
+        int tcf;
+
+        if (el == 0) {
+            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+            tcf = extract64(env->cp15.sctlr_el[1], 38, 2);
+        } else {
+            tcf = extract64(env->cp15.sctlr_el[el], 40, 2);
+        }
+        if (tcf == 1) {
+            /*
+             * Tag check fail causes a synchronous exception.
+             *
+             * In restore_state_to_opc, we set the exception syndrome
+             * for the load or store operation.  Do that first so we
+             * may overwrite that with the syndrome for the tag check.
+             */
+            cpu_restore_state(ENV_GET_CPU(env), ra, true);
+            env->exception.vaddress = ptr;
+            raise_exception(env, EXCP_DATA_ABORT,
+                            syn_data_abort_no_iss(el != 0, 0, 0, 0, 0, 0x11),
+                            exception_target_el(env));
+        } else if (tcf == 2) {
+            /* Tag check fail causes asynchronous flag set.  */
+            env->cp15.tfsr_el[el] |= 1 << param.select;
+        }
+    }
+
+ pass:
+    /*
+     * Unchecked, tag check pass, or tag check fail does not trap.
+     * Ignore the top byte.
+     */
+    if (el >= 2) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        return extract64(ptr, 0, 56);
+    } else {
+        return sextract64(ptr, 0, 56);
+    }
 }
-- 
2.17.2
