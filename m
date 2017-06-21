Received: from eggs.gnu.org ([2001:4830:134:3::10]:55888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckX-0002cU-EF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckW-0005Ba-F2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckV-0004zB-UD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:36 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:57 +0800
Message-Id: <1498040401-16361-12-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 11/15] tcg: split cpu_set_mxcsr()/cpu_set_fpuc()
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

Split the cpu_set_mxcsr()/cpu_set_fpuc() with specific tcg code.
tcg_update_mxcsr()/tcg_set_fpuc() need be implemented in tcg-stub.c
file if tcg is disabled.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 accel/stubs/tcg-stub.c   |  8 ++++++++
 target/i386/cpu.h        | 15 +++++++++++++--
 target/i386/fpu_helper.c |  8 +++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index dafb1d0..91625a8 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -75,6 +75,14 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
 {
 }
 
+void tcg_update_mxcsr(CPUX86State *env)
+{
+}
+
+void tcg_set_fpuc(CPUX86State *env)
+{
+}
+
 void cpu_loop_exit(CPUState *cpu)
 {
     abort();
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b3b535..229b216 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1643,8 +1643,19 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
 }
 
 /* fpu_helper.c */
-void cpu_set_mxcsr(CPUX86State *env, uint32_t val);
-void cpu_set_fpuc(CPUX86State *env, uint16_t val);
+void tcg_update_mxcsr(CPUX86State *env);
+void tcg_set_fpuc(CPUX86State *env);
+static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
+{
+    env->mxcsr = mxcsr;
+    tcg_update_mxcsr(env);
+}
+
+static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
+{
+     env->fpuc = fpuc;
+     tcg_set_fpuc(env);
+}
 
 /* mem_helper.c */
 void helper_lock_init(void);
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 34fb5fc..a7550c9 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1550,12 +1550,11 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
 #define SSE_RC_CHOP         0x6000
 #define SSE_FZ              0x8000
 
-void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
+void tcg_update_mxcsr(CPUX86State *env)
 {
+    uint32_t mxcsr = env->mxcsr;
     int rnd_type;
 
-    env->mxcsr = mxcsr;
-
     /* set rounding mode */
     switch (mxcsr & SSE_RC_MASK) {
     default:
@@ -1581,9 +1580,8 @@ void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
     set_flush_to_zero((mxcsr & SSE_FZ) ? 1 : 0, &env->fp_status);
 }
 
-void cpu_set_fpuc(CPUX86State *env, uint16_t val)
+void tcg_set_fpuc(CPUX86State *env)
 {
-    env->fpuc = val;
     update_fp_status(env);
 }
 
-- 
1.9.1
