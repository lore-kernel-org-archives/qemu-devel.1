Received: from eggs.gnu.org ([2001:4830:134:3::10]:54079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG5D-0004R6-5q
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG5C-0007k0-5T
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:55 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHG5B-0007jl-VO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:54 -0500
Received: by mail-wm0-x242.google.com with SMTP id b189so6266478wmd.5
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:27:53 -0800 (PST)
Received: from cloudburst.twiddle.net
	(70.red-37-158-60.dynamicip.rima-tde.net. [37.158.60.70])
	by smtp.gmail.com with ESMTPSA id
	e124sm706517wmg.34.2017.11.21.13.27.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 Nov 2017 13:27:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Nov 2017 22:25:21 +0100
Message-Id: <20171121212534.5177-14-richard.henderson@linaro.org>
In-Reply-To: <20171121212534.5177-1-richard.henderson@linaro.org>
References: <20171121212534.5177-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 13/26] tcg: Add tcg_expand_vec_op and
 tcg-target.opc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These will be useful in the next few patches adding shifts,
permutes, and multiplication.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.opc.h |  3 +++
 tcg/tcg-opc.h             |  6 ++++++
 tcg/tcg.h                 | 11 +++++++++++
 tcg/i386/tcg-target.inc.c | 21 +++++++++++++++++++++
 tcg/tcg.c                 |  6 +++---
 5 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 tcg/i386/tcg-target.opc.h

diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
new file mode 100644
index 0000000000..4816a6c3d4
--- /dev/null
+++ b/tcg/i386/tcg-target.opc.h
@@ -0,0 +1,3 @@
+/* Target-specific opcodes for host vector expansion.  These will be
+   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+   consider these to be UNSPEC with names.  */
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 4e62eda14b..b4e16cfbc3 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -229,6 +229,12 @@ DEF(andc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
 DEF(orc_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
 DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
 
+DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
+
+#if TCG_TARGET_MAYBE_vec
+#include "tcg-target.opc.h"
+#endif
+
 #undef TLADDR_ARGS
 #undef DATA64_ARGS
 #undef IMPL
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 49d4c5fe05..2cba208b4c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1207,6 +1207,17 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr);
 
 void tcg_register_jit(void *buf, size_t buf_size);
 
+#if TCG_TARGET_MAYBE_vec
+/* Return zero if the tuple (opc, type, vece) is unsupportable;
+   return > 0 if it is directly supportable;
+   return < 0 if we must call tcg_expand_vec_op.  */
+int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);
+
+/* Expand the tuple (opc, type, vece) on the given arguments.  */
+void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
+#endif
+
+
 /*
  * Memory helpers that will be used by TCG generated code.
  */
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index e9a4d92598..062cf16607 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2942,6 +2942,27 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     return NULL;
 }
 
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+        return true;
+
+    default:
+        return false;
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+}
+
 static const int tcg_target_callee_save_regs[] = {
 #if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 16b8faf66f..e725b1818f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1404,10 +1404,10 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_orc_vec:
         return have_vec && TCG_TARGET_HAS_orc_vec;
 
-    case NB_OPS:
-        break;
+    default:
+        tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
+        return true;
     }
-    g_assert_not_reached();
 }
 
 /* Note: we convert the 64 bit args to 32 bit and do some alignment
-- 
2.13.6
