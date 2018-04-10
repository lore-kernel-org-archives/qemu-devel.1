Received: from eggs.gnu.org ([2001:4830:134:3::10]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDT-0007vE-T7
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDP-0000ig-P9
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDP-0000iH-Hx
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDO-0007dz-Ky
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:23 +0100
Message-Id: <20180410121724.8549-12-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/12] tcg: Introduce tcg_set_insn_start_param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The parameters for tcg_gen_insn_start are target_ulong, which may be split
into two TCGArg parameters for storage in the opcode on 32-bit hosts.

Fixes the ARM target and its direct use of tcg_set_insn_param, which would
set the wrong argument in the 64-on-32 case.

Cc: qemu-stable@nongnu.org
Reported-by: alarson@ddci.com
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180410003558.2470-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.16.2
