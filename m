Received: from eggs.gnu.org ([2001:4830:134:3::10]:55833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckS-0002Xm-2x
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckR-000596-3I
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckQ-0004zB-Q2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:31 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:54 +0800
Message-Id: <1498040401-16361-9-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 08/15] tcg: make cpu_get_fp80()/cpu_set_fp80()
 static
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

Move cpu_get_fp80()/cpu_set_fp80() from fpu_helper.c to
machine.c because fpu_helper.c will be disabled if tcg is
disabled in the build.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 target/i386/cpu.h        |  2 --
 target/i386/fpu_helper.c | 18 ------------------
 target/i386/machine.c    | 18 ++++++++++++++++++
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index de0551f..8b3b535 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1418,8 +1418,6 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 
 /* op_helper.c */
 /* used for debug or cpu save/restore */
-void cpu_get_fp80(uint64_t *pmant, uint16_t *pexp, floatx80 f);
-floatx80 cpu_set_fp80(uint64_t mant, uint16_t upper);
 
 /* cpu-exec.c */
 /* the following helpers are only usable in user mode simulation as
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 69ea33a..34fb5fc 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1539,24 +1539,6 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
     raise_exception_ra(env, EXCP0D_GPF, GETPC());
 }
 
-void cpu_get_fp80(uint64_t *pmant, uint16_t *pexp, floatx80 f)
-{
-    CPU_LDoubleU temp;
-
-    temp.d = f;
-    *pmant = temp.l.lower;
-    *pexp = temp.l.upper;
-}
-
-floatx80 cpu_set_fp80(uint64_t mant, uint16_t upper)
-{
-    CPU_LDoubleU temp;
-
-    temp.l.upper = upper;
-    temp.l.lower = mant;
-    return temp.d;
-}
-
 /* MMX/SSE */
 /* XXX: optimize by storing fptt and fptags in the static cpu state */
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8c7a822..53587ae 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -142,6 +142,24 @@ typedef struct x86_FPReg_tmp {
     uint16_t tmp_exp;
 } x86_FPReg_tmp;
 
+static void cpu_get_fp80(uint64_t *pmant, uint16_t *pexp, floatx80 f)
+{
+    CPU_LDoubleU temp;
+
+    temp.d = f;
+    *pmant = temp.l.lower;
+    *pexp = temp.l.upper;
+}
+
+static floatx80 cpu_set_fp80(uint64_t mant, uint16_t upper)
+{
+    CPU_LDoubleU temp;
+
+    temp.l.upper = upper;
+    temp.l.lower = mant;
+    return temp.d;
+}
+
 static void fpreg_pre_save(void *opaque)
 {
     x86_FPReg_tmp *tmp = opaque;
-- 
1.9.1
