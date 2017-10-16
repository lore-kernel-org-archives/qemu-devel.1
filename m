Received: from eggs.gnu.org ([2001:4830:134:3::10]:52266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499n-0001yR-Eb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499l-0003MN-Nn
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:27 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:55270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499l-0003LY-I2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:25 -0400
Received: by mail-pg0-x22c.google.com with SMTP id l24so7292738pgu.11
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:27 -0700
Message-Id: <20171016172609.23422-9-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 08/50] tcg: Introduce temp_arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 7 +++++++
 tcg/tcg.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5fcdec1fc5..1e456d8e5a 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -729,6 +729,13 @@ struct TCGContext {
 extern TCGContext tcg_ctx;
 extern bool parallel_cpus;
 
+static inline TCGArg temp_arg(TCGTemp *ts)
+{
+    ptrdiff_t n = ts - tcg_ctx.temps;
+    tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
+    return n;
+}
+
 static inline TCGTemp *arg_temp(TCGArg a)
 {
     return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 915e041bea..31279ab3bb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1941,7 +1941,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                     TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
 
                     lop->args[0] = dir;
-                    lop->args[1] = temp_idx(s, its->mem_base);
+                    lop->args[1] = temp_arg(its->mem_base);
                     lop->args[2] = its->mem_offset;
 
                     /* Loaded, but synced with memory.  */
@@ -2012,7 +2012,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                 TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
 
                 sop->args[0] = dir;
-                sop->args[1] = temp_idx(s, its->mem_base);
+                sop->args[1] = temp_arg(its->mem_base);
                 sop->args[2] = its->mem_offset;
 
                 temp_state[arg] = TS_MEM;
-- 
2.13.6
