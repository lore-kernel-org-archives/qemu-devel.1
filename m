Received: from eggs.gnu.org ([2001:4830:134:3::10]:57923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyM5-0000Hp-JH
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyM4-0001kG-Ko
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:14583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyM4-0001cL-BW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:20 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:19 +0800
Message-Id: <1499076743-15477-12-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 11/15] tcg: split cpu_set_mxcsr() and make
 cpu_set_fpuc() inline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Split the cpu_set_mxcsr() and make cpu_set_fpuc() inline with specific
tcg code.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 target/i386/cpu.h        | 18 ++++++++++++++++--
 target/i386/fpu_helper.c | 11 ++---------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b3b535..67a6091 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1643,8 +1643,22 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
 }
 
 /* fpu_helper.c */
-void cpu_set_mxcsr(CPUX86State *env, uint32_t val);
-void cpu_set_fpuc(CPUX86State *env, uint16_t val);
+void tcg_update_mxcsr(CPUX86State *env);
+static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
+{
+    env->mxcsr = mxcsr;
+    if (tcg_enabled()) {
+        tcg_update_mxcsr(env);
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
index 34fb5fc..f0facb9 100644
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
-- 
1.9.1
