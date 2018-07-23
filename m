Received: from eggs.gnu.org ([2001:4830:134:3::10]:42716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKE-0003SC-3h
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKC-00058Z-Sf
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:58 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:15 -0500
Message-Id: <20180723201748.25573-67-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 66/99] tcg: Limit the number of ops in a TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

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
(cherry picked from commit abebf92597186be2bc48d487235da28b1127860f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/tcg.c | 3 +++
 tcg/tcg.h | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index bb24526c93..66997cc653 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -866,6 +866,7 @@ void tcg_func_start(TCGContext *s)
     /* No temps have been previously allocated for size or locality.  */
     memset(s->free_temps, 0, sizeof(s->free_temps));
 
+    s->nb_ops = 0;
     s->nb_labels = 0;
     s->current_frame_offset = s->frame_start;
 
@@ -1983,6 +1984,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
 {
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
+    s->nb_ops--;
 
 #ifdef CONFIG_PROFILER
     atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
@@ -2002,6 +2004,7 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc)
     }
     memset(op, 0, offsetof(TCGOp, link));
     op->opc = opc;
+    s->nb_ops++;
 
     return op;
 }
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 30896ca304..17cf764565 100644
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
-- 
2.17.1
