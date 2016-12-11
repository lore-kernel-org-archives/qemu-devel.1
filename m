Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4Ky-0002BT-O1
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4Kv-0001ZM-JK
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:44 -0500
Received: from [114.242.206.163] (port=49197 helo=loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cG4Ku-0001Xk-Ox
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 08:38:41 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Sun, 11 Dec 2016 21:36:24 +0800
Message-Id: <1481463385-15898-10-git-send-email-jinguojie@loongson.cn>
In-Reply-To: <1481463385-15898-1-git-send-email-jinguojie@loongson.cn>
References: <1481463385-15898-1-git-send-email-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH v6 09/10] tcg-mips: Adjust calling conventions
 for mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>, Richard Henderson <rth@twiddle.net>, Jin Guojie <jinguojie@loongson.cn>

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: James Hogan <james.hogan@imgtec.com>
Tested-by: YunQiang Su <wzssyqa@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 tcg/mips/tcg-target.h     | 19 +++++++++++++++----
 tcg/mips/tcg-target.inc.c | 21 +++++++++++++++------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 4b7d3ae..d352c97 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -27,7 +27,14 @@
 #ifndef MIPS_TCG_TARGET_H
 #define MIPS_TCG_TARGET_H
 
-#define TCG_TARGET_REG_BITS 32
+#if _MIPS_SIM == _ABIO32
+# define TCG_TARGET_REG_BITS 32
+#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
+# define TCG_TARGET_REG_BITS 64
+#else
+# error "Unknown ABI"
+#endif
+
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
@@ -71,9 +78,13 @@ typedef enum {
 } TCGReg;
 
 /* used for function call generation */
-#define TCG_TARGET_STACK_ALIGN 8
-#define TCG_TARGET_CALL_STACK_OFFSET 16
-#define TCG_TARGET_CALL_ALIGN_ARGS 1
+#define TCG_TARGET_STACK_ALIGN        16
+#if _MIPS_SIM == _ABIO32
+# define TCG_TARGET_CALL_STACK_OFFSET 16
+#else
+# define TCG_TARGET_CALL_STACK_OFFSET 0
+#endif
+#define TCG_TARGET_CALL_ALIGN_ARGS    1
 
 /* MOVN/MOVZ instructions detection */
 #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 1)) || \
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index b7e2586..7282a4a 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -91,10 +91,6 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_S8,
 
     /* Call clobbered registers.  */
-    TCG_REG_T0,
-    TCG_REG_T1,
-    TCG_REG_T2,
-    TCG_REG_T3,
     TCG_REG_T4,
     TCG_REG_T5,
     TCG_REG_T6,
@@ -105,17 +101,27 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_V0,
 
     /* Argument registers, opposite order of allocation.  */
+    TCG_REG_T3,
+    TCG_REG_T2,
+    TCG_REG_T1,
+    TCG_REG_T0,
     TCG_REG_A3,
     TCG_REG_A2,
     TCG_REG_A1,
     TCG_REG_A0,
 };
 
-static const TCGReg tcg_target_call_iarg_regs[4] = {
+static const TCGReg tcg_target_call_iarg_regs[] = {
     TCG_REG_A0,
     TCG_REG_A1,
     TCG_REG_A2,
-    TCG_REG_A3
+    TCG_REG_A3,
+#if _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
+    TCG_REG_T0,
+    TCG_REG_T1,
+    TCG_REG_T2,
+    TCG_REG_T3,
+#endif
 };
 
 static const TCGReg tcg_target_call_oarg_regs[2] = {
@@ -2427,6 +2433,9 @@ static void tcg_target_init(TCGContext *s)
 {
     tcg_target_detect_isa();
     tcg_regset_set(tcg_target_available_regs[TCG_TYPE_I32], 0xffffffff);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_regset_set(tcg_target_available_regs[TCG_TYPE_I64], 0xffffffff);
+    }
     tcg_regset_set(tcg_target_call_clobber_regs,
                    (1 << TCG_REG_V0) |
                    (1 << TCG_REG_V1) |
-- 
2.1.0
