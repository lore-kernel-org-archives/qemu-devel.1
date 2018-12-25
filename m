Received: from eggs.gnu.org ([208.118.235.92]:50704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtnd-0007m2-Ap
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtna-0001Ui-72
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:37 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:38009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtna-0001Tv-1U
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:59:34 -0500
Received: by mail-pl1-x629.google.com with SMTP id e5so6810979plb.5
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:59:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:20 +1100
Message-Id: <20181225205529.10874-34-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 33/42] tcg: Add preferred_reg argument to
 tcg_reg_alloc_do_movi
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

Pass this through to temp_sync.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index fe060c481a..7844158a8a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3077,7 +3077,8 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
 }
 
 static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
-                                  tcg_target_ulong val, TCGLifeData arg_life)
+                                  tcg_target_ulong val, TCGLifeData arg_life,
+                                  TCGRegSet preferred_regs)
 {
     if (ots->fixed_reg) {
         /* For fixed registers, we do not do any constant propagation.  */
@@ -3093,7 +3094,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     ots->val = val;
     ots->mem_coherent = 0;
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
+        temp_sync(s, ots, s->reserved_regs, preferred_regs, IS_DEAD_ARG(0));
     } else if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
     }
@@ -3104,7 +3105,7 @@ static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
     TCGTemp *ots = arg_temp(op->args[0]);
     tcg_target_ulong val = op->args[1];
 
-    tcg_reg_alloc_do_movi(s, ots, val, op->life);
+    tcg_reg_alloc_do_movi(s, ots, val, op->life, 0);
 }
 
 static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
@@ -3128,7 +3129,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, ts);
         }
-        tcg_reg_alloc_do_movi(s, ots, val, arg_life);
+        tcg_reg_alloc_do_movi(s, ots, val, arg_life, 0);
         return;
     }
 
-- 
2.17.2
