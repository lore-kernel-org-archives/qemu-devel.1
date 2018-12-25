Received: from eggs.gnu.org ([208.118.235.92]:50652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnW-0007ed-0v
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnV-0001P9-6i
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:29 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:42169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtnV-0001OX-13
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id 64so7071864pfr.9
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:59:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:19 +1100
Message-Id: <20181225205529.10874-33-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 32/42] tcg: Add preferred_reg argument to
 temp_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Pass this through to tcg_reg_alloc.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 351d302a68..fe060c481a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2865,8 +2865,8 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
    registers needs to be allocated to store a constant.  If 'free_or_dead'
    is non-zero, subsequently release the temporary; if it is positive, the
    temp is dead; if it is negative, the temp is free.  */
-static void temp_sync(TCGContext *s, TCGTemp *ts,
-                      TCGRegSet allocated_regs, int free_or_dead)
+static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
+                      TCGRegSet preferred_regs, int free_or_dead)
 {
     if (ts->fixed_reg) {
         return;
@@ -2886,7 +2886,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
                 break;
             }
             temp_load(s, ts, tcg_target_available_regs[ts->type],
-                      allocated_regs, 0);
+                      allocated_regs, preferred_regs);
             /* fallthrough */
 
         case TEMP_VAL_REG:
@@ -2913,7 +2913,7 @@ static void tcg_reg_free(TCGContext *s, TCGReg reg, TCGRegSet allocated_regs)
 {
     TCGTemp *ts = s->reg_to_temp[reg];
     if (ts != NULL) {
-        temp_sync(s, ts, allocated_regs, -1);
+        temp_sync(s, ts, allocated_regs, 0, -1);
     }
 }
 
@@ -3093,7 +3093,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     ots->val = val;
     ots->mem_coherent = 0;
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, IS_DEAD_ARG(0));
+        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
     } else if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
     }
@@ -3176,7 +3176,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         ots->mem_coherent = 0;
         s->reg_to_temp[ots->reg] = ots;
         if (NEED_SYNC_ARG(0)) {
-            temp_sync(s, ots, allocated_regs, 0);
+            temp_sync(s, ots, allocated_regs, 0, 0);
         }
     }
 }
@@ -3346,7 +3346,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             tcg_out_mov(s, ts->type, ts->reg, reg);
         }
         if (NEED_SYNC_ARG(i)) {
-            temp_sync(s, ts, o_allocated_regs, IS_DEAD_ARG(i));
+            temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
         } else if (IS_DEAD_ARG(i)) {
             temp_dead(s, ts);
         }
@@ -3480,7 +3480,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
             ts->mem_coherent = 0;
             s->reg_to_temp[reg] = ts;
             if (NEED_SYNC_ARG(i)) {
-                temp_sync(s, ts, allocated_regs, IS_DEAD_ARG(i));
+                temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
             } else if (IS_DEAD_ARG(i)) {
                 temp_dead(s, ts);
             }
-- 
2.17.2
