Received: from eggs.gnu.org ([2001:4830:134:3::10]:46963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeXF-00059L-7W
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeXA-0007zG-KX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:41 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeXA-0007xY-7W
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:36 -0400
Received: by mail-wm0-x244.google.com with SMTP id y5so30409698wmh.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:42 +0200
Message-Id: <1499238885-26161-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/42] target/i386: split cpu_set_mxcsr() and
 make cpu_set_fpuc() inline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Split the cpu_set_mxcsr() and make cpu_set_fpuc() inline with specific
tcg code.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h        | 21 ++++++++++++++++++---
 target/i386/fpu_helper.c | 11 ++---------
 target/i386/machine.c    |  5 ++++-
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8d9ba36..3495a91 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1594,7 +1594,6 @@ void QEMU_NORETURN raise_interrupt(CPUX86State *nenv, int intno, int is_int,
 /* cc_helper.c */
 extern const uint8_t parity_table[256];
 uint32_t cpu_cc_compute_all(CPUX86State *env1, int op);
-void update_fp_status(CPUX86State *env);
 
 static inline uint32_t cpu_compute_eflags(CPUX86State *env)
 {
@@ -1643,8 +1642,24 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
 }
 
 /* fpu_helper.c */
-void cpu_set_mxcsr(CPUX86State *env, uint32_t val);
-void cpu_set_fpuc(CPUX86State *env, uint16_t val);
+void update_fp_status(CPUX86State *env);
+void update_mxcsr_status(CPUX86State *env);
+
+static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
+{
+    env->mxcsr = mxcsr;
+    if (tcg_enabled()) {
+        update_mxcsr_status(env);
+    }
+}
+
+static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
+{
+     env->fpuc = fpuc;
+     if (tcg_enabled()) {
+        update_fp_status(env);
+     }
+}
 
 /* mem_helper.c */
 void helper_lock_init(void);
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 34fb5fc..9014b6f 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1550,12 +1550,11 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
 #define SSE_RC_CHOP         0x6000
 #define SSE_FZ              0x8000
 
-void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
+void update_mxcsr_status(CPUX86State *env)
 {
+    uint32_t mxcsr = env->mxcsr;
     int rnd_type;
 
-    env->mxcsr = mxcsr;
-
     /* set rounding mode */
     switch (mxcsr & SSE_RC_MASK) {
     default:
@@ -1581,12 +1580,6 @@ void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
     set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->fp_status);
 }
 
-void cpu_set_fpuc(CPUX86State *env, uint16_t val)
-{
-    env->fpuc = val;
-    update_fp_status(env);
-}
-
 void helper_ldmxcsr(CPUX86State *env, uint32_t val)
 {
     cpu_set_mxcsr(env, val);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 53587ae..e0417fe 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -280,7 +280,10 @@ static int cpu_post_load(void *opaque, int version_id)
     for(i = 0; i < 8; i++) {
         env->fptags[i] = (env->fptag_vmstate >> i) & 1;
     }
-    update_fp_status(env);
+    if (tcg_enabled()) {
+        update_fp_status(env);
+        update_mxcsr_status(env);
+    }
 
     cpu_breakpoint_remove_all(cs, BP_CPU);
     cpu_watchpoint_remove_all(cs, BP_CPU);
-- 
1.8.3.1
