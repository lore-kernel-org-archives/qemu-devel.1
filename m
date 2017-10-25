Received: from eggs.gnu.org ([2001:4830:134:3::10]:45463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6N-0008AB-I1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6J-0007wi-HW
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:54071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6J-0007uY-BL
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:51 -0400
Received: by mail-wr0-x244.google.com with SMTP id u40so17444611wrf.10
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:52 +0200
Message-Id: <20171025093535.10175-9-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/51] tcg: Introduce temp_arg, export temp_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

At the same time, drop the TCGContext argument and use tcg_ctx instead.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 12 ++++++++++++
 tcg/tcg.c | 19 ++++++-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 5fcdec1fc5..828c1e70e5 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -729,6 +729,18 @@ struct TCGContext {
 extern TCGContext tcg_ctx;
 extern bool parallel_cpus;
 
+static inline size_t temp_idx(TCGTemp *ts)
+{
+    ptrdiff_t n = ts - tcg_ctx.temps;
+    tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
+    return n;
+}
+
+static inline TCGArg temp_arg(TCGTemp *ts)
+{
+    return temp_idx(ts);
+}
+
 static inline TCGTemp *arg_temp(TCGArg a)
 {
     return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e2a5f3f4c2..f6e76df3ba 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -473,13 +473,6 @@ void tcg_func_start(TCGContext *s)
     s->gen_next_op_idx = 1;
 }
 
-static inline int temp_idx(TCGContext *s, TCGTemp *ts)
-{
-    ptrdiff_t n = ts - s->temps;
-    tcg_debug_assert(n >= 0 && n < s->nb_temps);
-    return n;
-}
-
 static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
 {
     int n = s->nb_temps++;
@@ -516,7 +509,7 @@ static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
     ts->name = name;
     tcg_regset_set_reg(s->reserved_regs, reg);
 
-    return temp_idx(s, ts);
+    return temp_idx(ts);
 }
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
@@ -605,7 +598,7 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
         ts->mem_offset = offset;
         ts->name = name;
     }
-    return temp_idx(s, ts);
+    return temp_idx(ts);
 }
 
 static int tcg_temp_new_internal(TCGType type, int temp_local)
@@ -645,7 +638,7 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
             ts->temp_allocated = 1;
             ts->temp_local = temp_local;
         }
-        idx = temp_idx(s, ts);
+        idx = temp_idx(ts);
     }
 
 #if defined(CONFIG_DEBUG_TCG)
@@ -1193,7 +1186,7 @@ static void tcg_reg_alloc_start(TCGContext *s)
 static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
                                  TCGTemp *ts)
 {
-    int idx = temp_idx(s, ts);
+    int idx = temp_idx(ts);
 
     if (ts->temp_global) {
         pstrcpy(buf, buf_size, ts->name);
@@ -1941,7 +1934,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                     TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
 
                     lop->args[0] = dir;
-                    lop->args[1] = temp_idx(s, its->mem_base);
+                    lop->args[1] = temp_arg(its->mem_base);
                     lop->args[2] = its->mem_offset;
 
                     /* Loaded, but synced with memory.  */
@@ -2012,7 +2005,7 @@ static bool liveness_pass_2(TCGContext *s, uint8_t *temp_state)
                 TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
 
                 sop->args[0] = dir;
-                sop->args[1] = temp_idx(s, its->mem_base);
+                sop->args[1] = temp_arg(its->mem_base);
                 sop->args[2] = its->mem_offset;
 
                 temp_state[arg] = TS_MEM;
-- 
2.13.6
