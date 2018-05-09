Received: from eggs.gnu.org ([2001:4830:134:3::10]:41378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGRKr-0000uV-0N
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGRKp-00070H-Qr
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:57 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGRKp-0006zR-L3
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:55 -0400
Received: by mail-pg0-x244.google.com with SMTP id n1-v6so343535pgs.2
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 08:48:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 08:48:49 -0700
Message-Id: <20180509154849.27979-3-richard.henderson@linaro.org>
In-Reply-To: <20180509154849.27979-1-richard.henderson@linaro.org>
References: <20180509154849.27979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] tcg: Limit the number of ops in a TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, qemu-stable@nongnu.org

In 6001f7729e12 we partially attempt to address the branch
displacement overflow caused by 15fa08f845.

However, gcc/testsuite/gcc.target/aarch64/advsimd-intrinsics/vqtbX.c
is a testcase that contains a TB so large as to overflow anyway.
The limit here of 8000 ops produces a maximum output TB size of
24112 bytes on a ppc64le host with that test case.  This is still
much less than the maximum forward branch distance of 32764 bytes.

Cc: qemu-stable@nongnu.org
Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.h | 8 +++++++-
 tcg/tcg.c | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 75fbad128b..88378be310 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -655,6 +655,7 @@ struct TCGContext {
     int nb_globals;
     int nb_temps;
     int nb_indirects;
+    int nb_ops;
 
     /* goto_tb support */
     tcg_insn_unit *code_buf;
@@ -844,7 +845,12 @@ static inline TCGOp *tcg_last_op(void)
 /* Test for whether to terminate the TB for using too many opcodes.  */
 static inline bool tcg_op_buf_full(void)
 {
-    return false;
+    /* This is not a hard limit, it merely stops translation when
+     * we have produced "enough" opcodes.  We want to limit TB size
+     * such that a RISC host can reasonably use a 16-bit signed
+     * branch within the TB.
+     */
+    return tcg_ctx->nb_ops >= 8000;
 }
 
 /* pool based memory allocation */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 551caf1c53..6eeebe0624 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -866,6 +866,7 @@ void tcg_func_start(TCGContext *s)
     /* No temps have been previously allocated for size or locality.  */
     memset(s->free_temps, 0, sizeof(s->free_temps));
 
+    s->nb_ops = 0;
     s->nb_labels = 0;
     s->current_frame_offset = s->frame_start;
 
@@ -1956,6 +1957,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
 {
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
+    s->nb_ops--;
 
 #ifdef CONFIG_PROFILER
     atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
@@ -1975,6 +1977,7 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc)
     }
     memset(op, 0, offsetof(TCGOp, link));
     op->opc = opc;
+    s->nb_ops++;
 
     return op;
 }
-- 
2.17.0
