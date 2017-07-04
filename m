Received: from eggs.gnu.org ([2001:4830:134:3::10]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlF-0006qw-Ko
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlE-0001y1-Mc
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:53 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLlE-0001xS-Fo
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:52 -0400
Received: by mail-wr0-x244.google.com with SMTP id k67so46853472wrc.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:09 +0200
Message-Id: <1499166735-39360-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 16/22] target/i386: move
 cpu_sync_bndcs_hflags() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Move cpu_sync_bndcs_hflags() function from mpx_helper.c
to helper.c because mpx_helper.c need be disabled when
tcg is disabled.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v2: moved cpu_report_tpr_access hunk later [Richard]

 target/i386/helper.c     | 30 ++++++++++++++++++++++++++++++
 target/i386/mpx_helper.c | 30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index ef05059..4d584b5 100644
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
1.8.3.1
