Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7V69-00049u-TK
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 19:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7V66-0002hg-Pz
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 19:28:33 -0400
Date: Wed, 25 Oct 2017 16:28:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1710251623560.574@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH v2] don't hardcode EL1 in
 extended_addresses_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sstabellini@kernel.org, julien.grall@linaro.org

extended_addresses_enabled calls arm_el_is_aa64, hardcoding exception
level 1. Instead, add an additional "el" argument to
extended_addresses_enabled.

The caller will pass the right value. In most cases, it will be
arm_current_el(env). However, arm_debug_excp_handler will
use arm_debug_target_el(env), as the target el for a debug trap can be
different from the current el.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96113fe..2298428 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -500,7 +500,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = arm_env_get_cpu(env);
 
     if (raw_read(env, ri) != value && !arm_feature(env, ARM_FEATURE_PMSA)
-        && !extended_addresses_enabled(env)) {
+        && !extended_addresses_enabled(env, arm_current_el(env))) {
         /* For VMSA (when not using the LPAE long descriptor page table
          * format) this register includes the ASID, so do a TLB flush.
          * For PMSA it is purely a process ID and no action is needed.
@@ -2162,7 +2162,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
     ret = get_phys_addr(env, value, access_type, mmu_idx,
                         &phys_addr, &attrs, &prot, &page_size, &fsr, &fi);
-    if (extended_addresses_enabled(env)) {
+    if (extended_addresses_enabled(env, arm_current_el(env))) {
         /* fsr is a DFSR/IFSR value for the long descriptor
          * translation table format, but with WnR always clear.
          * Convert it to a 64-bit PAR.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 43106a2..6792df2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -217,10 +217,10 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
  * This is always the case if our translation regime is 64 bit,
  * but depends on TTBCR.EAE for 32 bit.
  */
-static inline bool extended_addresses_enabled(CPUARMState *env)
+static inline bool extended_addresses_enabled(CPUARMState *env, unsigned int el)
 {
-    TCR *tcr = &env->cp15.tcr_el[arm_is_secure(env) ? 3 : 1];
-    return arm_el_is_aa64(env, 1) ||
+    TCR *tcr = &env->cp15.tcr_el[el];
+    return arm_el_is_aa64(env, el) ||
            (arm_feature(env, ARM_FEATURE_LPAE) && (tcr->raw_tcr & TTBCR_EAE));
 }
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 3914145..4f46eb8 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1378,7 +1378,7 @@ void arm_debug_excp_handler(CPUState *cs)
 
             cs->watchpoint_hit = NULL;
 
-            if (extended_addresses_enabled(env)) {
+            if (extended_addresses_enabled(env, arm_debug_target_el(env))) {
                 env->exception.fsr = (1 << 9) | 0x22;
             } else {
                 env->exception.fsr = 0x2;
@@ -1402,7 +1402,7 @@ void arm_debug_excp_handler(CPUState *cs)
             return;
         }
 
-        if (extended_addresses_enabled(env)) {
+        if (extended_addresses_enabled(env, arm_debug_target_el(env))) {
             env->exception.fsr = (1 << 9) | 0x22;
         } else {
             env->exception.fsr = 0x2;
