Received: from eggs.gnu.org ([2001:4830:134:3::10]:55831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckS-0002Xl-2o
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckP-00058l-ET
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckP-0004zB-6L
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:29 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:53 +0800
Message-Id: <1498040401-16361-8-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 07/15] tcg: move cpu_sync_bndcs_hflags()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Move cpu_sync_bndcs_hflags() function from mpx_helper.c
to helper.c because mpx_helper.c need be disabled when
tcg is disabled.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 target/i386/helper.c     | 34 +++++++++++++++++++++++++++++++++-
 target/i386/mpx_helper.c | 30 ------------------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index ef05059..87fd705 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -29,6 +29,36 @@
 #include "hw/i386/apic_internal.h"
 #endif
 
+void cpu_sync_bndcs_hflags(CPUX86State *env)
+{
+    uint32_t hflags = env->hflags;
+    uint32_t hflags2 = env->hflags2;
+    uint32_t bndcsr;
+
+    if ((hflags & HF_CPL_MASK) == 3) {
+        bndcsr = env->bndcs_regs.cfgu;
+    } else {
+        bndcsr = env->msr_bndcfgs;
+    }
+
+    if ((env->cr[4] & CR4_OSXSAVE_MASK)
+        && (env->xcr0 & XSTATE_BNDCSR_MASK)
+        && (bndcsr & BNDCFG_ENABLE)) {
+        hflags |= HF_MPX_EN_MASK;
+    } else {
+        hflags &= ~HF_MPX_EN_MASK;
+    }
+
+    if (bndcsr & BNDCFG_BNDPRESERVE) {
+        hflags2 |= HF2_MPX_PR_MASK;
+    } else {
+        hflags2 &= ~HF2_MPX_PR_MASK;
+    }
+
+    env->hflags = hflags;
+    env->hflags2 = hflags2;
+}
+
 static void cpu_x86_version(CPUX86State *env, int *family, int *model)
 {
     int cpuver = env->cpuid_version;
@@ -1302,10 +1332,12 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-    } else {
+    } else if (tcg_enabled()) {
         cpu_restore_state(cs, cs->mem_io_pc);
 
         apic_handle_tpr_access_report(cpu->apic_state, env->eip, access);
+    } else {
+        abort();
     }
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/i386/mpx_helper.c b/target/i386/mpx_helper.c
index 7e44820..ade5d24 100644
--- a/target/i386/mpx_helper.c
+++ b/target/i386/mpx_helper.c
@@ -24,36 +24,6 @@
 #include "exec/exec-all.h"
 
 
-void cpu_sync_bndcs_hflags(CPUX86State *env)
-{
-    uint32_t hflags = env->hflags;
-    uint32_t hflags2 = env->hflags2;
-    uint32_t bndcsr;
-
-    if ((hflags & HF_CPL_MASK) == 3) {
-        bndcsr = env->bndcs_regs.cfgu;
-    } else {
-        bndcsr = env->msr_bndcfgs;
-    }
-
-    if ((env->cr[4] & CR4_OSXSAVE_MASK)
-        && (env->xcr0 & XSTATE_BNDCSR_MASK)
-        && (bndcsr & BNDCFG_ENABLE)) {
-        hflags |= HF_MPX_EN_MASK;
-    } else {
-        hflags &= ~HF_MPX_EN_MASK;
-    }
-
-    if (bndcsr & BNDCFG_BNDPRESERVE) {
-        hflags2 |= HF2_MPX_PR_MASK;
-    } else {
-        hflags2 &= ~HF2_MPX_PR_MASK;
-    }
-
-    env->hflags = hflags;
-    env->hflags2 = hflags2;
-}
-
 void helper_bndck(CPUX86State *env, uint32_t fail)
 {
     if (unlikely(fail)) {
-- 
1.9.1
