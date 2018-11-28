Received: from eggs.gnu.org ([2001:4830:134:3::10]:47836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYe-0003lt-ID
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYd-0004Jw-AN
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:44 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYb-0004J8-Gt
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:42 -0500
Received: by mail-pl1-x644.google.com with SMTP id p8so6529534plo.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:25 -0800
Message-Id: <20181128053834.10861-4-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/12] tcg: Add preferred_reg argument to
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
Cc: cota@braap.org

Pass this through to tcg_reg_alloc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7f29a2045a..509e5974bd 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2887,8 +2887,8 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
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
@@ -2908,7 +2908,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
                 break;
             }
             temp_load(s, ts, tcg_target_available_regs[ts->type],
-                      allocated_regs, 0);
+                      allocated_regs, preferred_regs);
             /* fallthrough */
 
         case TEMP_VAL_REG:
@@ -2935,7 +2935,7 @@ static void tcg_reg_free(TCGContext *s, TCGReg reg, TCGRegSet allocated_regs)
 {
     TCGTemp *ts = s->reg_to_temp[reg];
     if (ts != NULL) {
-        temp_sync(s, ts, allocated_regs, -1);
+        temp_sync(s, ts, allocated_regs, 0, -1);
     }
 }
 
@@ -3115,7 +3115,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     ots->val = val;
     ots->mem_coherent = 0;
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, IS_DEAD_ARG(0));
+        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
     } else if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
     }
@@ -3198,7 +3198,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         ots->mem_coherent = 0;
         s->reg_to_temp[ots->reg] = ots;
         if (NEED_SYNC_ARG(0)) {
-            temp_sync(s, ots, allocated_regs, 0);
+            temp_sync(s, ots, allocated_regs, 0, 0);
         }
     }
 }
@@ -3368,7 +3368,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             tcg_out_mov(s, ts->type, ts->reg, reg);
         }
         if (NEED_SYNC_ARG(i)) {
-            temp_sync(s, ts, o_allocated_regs, IS_DEAD_ARG(i));
+            temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
         } else if (IS_DEAD_ARG(i)) {
             temp_dead(s, ts);
         }
@@ -3502,7 +3502,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
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
