Received: from eggs.gnu.org ([2001:4830:134:3::10]:51603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5hGa-0001rb-TZ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5hGa-0001Se-3j
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:36:08 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5hGZ-0001Rx-Iq
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:36:07 -0400
Received: by mail-pf0-x244.google.com with SMTP id f15so6788432pfn.0
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 17:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Apr 2018 10:35:58 +1000
Message-Id: <20180410003558.2470-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] tcg: Introduce
 tcg_set_insn_start_param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org

The parameters for tcg_gen_insn_start are target_ulong, which may be split
into two TCGArg parameters for storage in the opcode on 32-bit hosts.

Fixes the ARM target and its direct use of tcg_set_insn_param, which would
set the wrong argument in the 64-on-32 case.

Cc: qemu-stable@nongnu.org
Reported-by: alarson@ddci.com
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Peter, I'm not sure what the reproducer is for this reported problem.
I could boot my aa64 images both before and after this patch.  Perhaps
I would have needed to run an aa32 binary within the aa64 kernel?


r~

---
 target/arm/translate.h |  2 +-
 tcg/tcg.h              | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index c47febf99d..4428c98e2e 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -120,7 +120,7 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
     /* We check and clear insn_start_idx to catch multiple updates.  */
     assert(s->insn_start != NULL);
-    tcg_set_insn_param(s->insn_start, 2, syn);
+    tcg_set_insn_start_param(s->insn_start, 2, syn);
     s->insn_start = NULL;
 }
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9e2d909a4a..30896ca304 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -825,6 +825,16 @@ static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)
     op->args[arg] = v;
 }
 
+static inline void tcg_set_insn_start_param(TCGOp *op, int arg, target_ulong v)
+{
+#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+    tcg_set_insn_param(op, arg, v);
+#else
+    tcg_set_insn_param(op, arg * 2, v);
+    tcg_set_insn_param(op, arg * 2 + 1, v >> 32);
+#endif
+}
+
 /* The last op that was emitted.  */
 static inline TCGOp *tcg_last_op(void)
 {
-- 
2.14.3
