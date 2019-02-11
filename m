Received: from eggs.gnu.org ([209.51.188.92]:38692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOi-0005tB-K2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOg-000533-4I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:00 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOf-0004T5-Ct
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:57 -0500
Received: by mail-pf1-x441.google.com with SMTP id z9so344620pfi.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:44 -0800
Message-Id: <20190211235258.542-15-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 14/28] target/arm: Define
 arm_cpu_do_unaligned_access for CONFIG_USER_ONLY
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

We will need this to raise unaligned exceptions from user mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/op_helper.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 8698b4dc83..d3cf362e4b 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -87,8 +87,6 @@ uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def, void *vn,
     return val;
 }
 
-#if !defined(CONFIG_USER_ONLY)
-
 static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
                                             unsigned int target_el,
                                             bool same_el, bool ea,
@@ -179,6 +177,22 @@ static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
     raise_exception(env, exc, syn, target_el);
 }
 
+/* Raise a data fault alignment exception for the specified virtual address */
+void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    ARMMMUFaultInfo fi = {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.type = ARMFault_Alignment;
+    deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
+}
+
+#ifndef CONFIG_USER_ONLY
 /* try to fill the TLB and return an exception if error. If retaddr is
  * NULL, it means that the function was called in C code (i.e. not
  * from generated code or from helper.c)
@@ -200,21 +214,6 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     }
 }
 
-/* Raise a data fault alignment exception for the specified virtual address */
-void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
-                                 MMUAccessType access_type,
-                                 int mmu_idx, uintptr_t retaddr)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    ARMMMUFaultInfo fi = {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.type = ARMFault_Alignment;
-    deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
-}
-
 /* arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
  * exception
-- 
2.17.2
