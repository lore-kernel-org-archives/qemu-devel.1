Received: from eggs.gnu.org ([2001:4830:134:3::10]:39796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ddgHY-0007Gq-Nf
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ddgHX-0001bF-PF
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:21:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 Aug 2017 18:20:48 +0100
Message-Id: <1501867249-1924-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 7/8] target/arm: Allow deliver_fault() caller
 to specify EA bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

For external aborts, we will want to be able to specify the EA
(external abort type) bit in the syndrome field.  Allow callers of
deliver_fault() to do that by adding a field to ARMMMUFaultInfo which
we use when constructing the syndrome values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  2 ++
 target/arm/op_helper.c | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1f6efef..a3adbd8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -448,12 +448,14 @@ void arm_handle_psci_call(ARMCPU *cpu);
  * @s2addr: Address that caused a fault at stage 2
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table walk
+ * @ea: True if we should set the EA (external abort type) bit in syndrome
  */
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
 struct ARMMMUFaultInfo {
     target_ulong s2addr;
     bool stage2;
     bool s1ptw;
+    bool ea;
 };
 
 /* Do a page table walk and add page to TLB if possible */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index aa52a98..7eac272 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -80,7 +80,7 @@ uint32_t HELPER(neon_tbl)(CPUARMState *env, uint32_t ireg, uint32_t def,
 
 static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
                                             unsigned int target_el,
-                                            bool same_el,
+                                            bool same_el, bool ea,
                                             bool s1ptw, bool is_write,
                                             int fsc)
 {
@@ -99,7 +99,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
      */
     if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
         syn = syn_data_abort_no_iss(same_el,
-                                    0, 0, s1ptw, is_write, fsc);
+                                    ea, 0, s1ptw, is_write, fsc);
     } else {
         /* Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the template
          * syndrome created at translation time.
@@ -107,7 +107,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
          */
         syn = syn_data_abort_with_iss(same_el,
                                       0, 0, 0, 0, 0,
-                                      0, 0, s1ptw, is_write, fsc,
+                                      ea, 0, s1ptw, is_write, fsc,
                                       false);
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
@@ -141,11 +141,11 @@ static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
     }
 
     if (access_type == MMU_INST_FETCH) {
-        syn = syn_insn_abort(same_el, 0, fi->s1ptw, fsc);
+        syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
         exc = EXCP_PREFETCH_ABORT;
     } else {
         syn = merge_syn_data_abort(env->exception.syndrome, target_el,
-                                   same_el, fi->s1ptw,
+                                   same_el, fi->ea, fi->s1ptw,
                                    access_type == MMU_DATA_STORE,
                                    fsc);
         if (access_type == MMU_DATA_STORE
-- 
2.7.4
