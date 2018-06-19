Received: from eggs.gnu.org ([2001:4830:134:3::10]:46446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5im-0002Ot-FR
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5il-0000HX-Hl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:12 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:23 -0500
Message-Id: <20180619014319.28272-58-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 057/113] tcg: Introduce tcg_set_insn_start_param
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit 9743cd5736263e90d312b2c33bd739ffe1eae70d)
 Conflicts:
	target/arm/translate.h
	tcg/tcg.h
* rework to avoid functional dependency on 15fa08f

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate.h |  2 +-
 tcg/tcg.h              | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 410ba79c0d..0c6a24d287 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -118,7 +118,7 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
     /* We check and clear insn_start_idx to catch multiple updates.  */
     assert(s->insn_start_idx != 0);
-    tcg_set_insn_param(s->insn_start_idx, 2, syn);
+    tcg_set_insn_start_param(s->insn_start_idx, 2, syn);
     s->insn_start_idx = 0;
 }
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index cb7b329876..d88d3520ac 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -783,6 +783,16 @@ static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
     tcg_ctx->gen_op_buf[op_idx].args[arg] = v;
 }
 
+static inline void tcg_set_insn_start_param(int op_idx, int arg, target_ulong v)
+{
+#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+    tcg_set_insn_param(op_idx, arg, v);
+#else
+    tcg_set_insn_param(op_idx, arg * 2, v);
+    tcg_set_insn_param(op_idx, arg * 2 + 1, v >> 32);
+#endif
+}
+
 /* The number of opcodes emitted so far.  */
 static inline int tcg_op_buf_count(void)
 {
-- 
2.11.0
