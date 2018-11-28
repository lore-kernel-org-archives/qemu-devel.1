Received: from eggs.gnu.org ([2001:4830:134:3::10]:47881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYi-0003tC-GB
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYg-0004LL-GJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:48 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYd-0004JT-9b
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:44 -0500
Received: by mail-pl1-x642.google.com with SMTP id 101so10531006pld.6
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:26 -0800
Message-Id: <20181128053834.10861-5-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/12] tcg: Add preferred_reg argument to
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
Cc: cota@braap.org

Pass this through to temp_sync.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 509e5974bd..c83ca238aa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3099,7 +3099,8 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
 }
 
 static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
-                                  tcg_target_ulong val, TCGLifeData arg_life)
+                                  tcg_target_ulong val, TCGLifeData arg_life,
+                                  TCGRegSet preferred_regs)
 {
     if (ots->fixed_reg) {
         /* For fixed registers, we do not do any constant propagation.  */
@@ -3115,7 +3116,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
     ots->val = val;
     ots->mem_coherent = 0;
     if (NEED_SYNC_ARG(0)) {
-        temp_sync(s, ots, s->reserved_regs, 0, IS_DEAD_ARG(0));
+        temp_sync(s, ots, s->reserved_regs, preferred_regs, IS_DEAD_ARG(0));
     } else if (IS_DEAD_ARG(0)) {
         temp_dead(s, ots);
     }
@@ -3126,7 +3127,7 @@ static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
     TCGTemp *ots = arg_temp(op->args[0]);
     tcg_target_ulong val = op->args[1];
 
-    tcg_reg_alloc_do_movi(s, ots, val, op->life);
+    tcg_reg_alloc_do_movi(s, ots, val, op->life, 0);
 }
 
 static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
@@ -3150,7 +3151,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         if (IS_DEAD_ARG(1)) {
             temp_dead(s, ts);
         }
-        tcg_reg_alloc_do_movi(s, ots, val, arg_life);
+        tcg_reg_alloc_do_movi(s, ots, val, arg_life, 0);
         return;
     }
 
-- 
2.17.2
