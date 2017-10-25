Received: from eggs.gnu.org ([2001:4830:134:3::10]:45488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6P-0008CQ-VQ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6N-000842-68
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6M-00082Q-VC
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:55 -0400
Received: by mail-wm0-x243.google.com with SMTP id u138so622803wmu.4
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:55 +0200
Message-Id: <20171025093535.10175-12-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/51] tcg: Change temp_allocate_frame arg to
 TCGTemp
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 840e65c0d4..c10e73babe 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2096,10 +2096,8 @@ static void check_regs(TCGContext *s)
 }
 #endif
 
-static void temp_allocate_frame(TCGContext *s, int temp)
+static void temp_allocate_frame(TCGContext *s, TCGTemp *ts)
 {
-    TCGTemp *ts;
-    ts = &s->temps[temp];
 #if !(defined(__sparc__) && TCG_TARGET_REG_BITS == 64)
     /* Sparc64 stack is accessed with offset of 2047 */
     s->current_frame_offset = (s->current_frame_offset +
@@ -2152,7 +2150,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
     }
     if (!ts->mem_coherent) {
         if (!ts->mem_allocated) {
-            temp_allocate_frame(s, temp_idx(s, ts));
+            temp_allocate_frame(s, ts);
         }
         switch (ts->val_type) {
         case TEMP_VAL_CONST:
@@ -2382,7 +2380,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
            liveness analysis disabled). */
         tcg_debug_assert(NEED_SYNC_ARG(0));
         if (!ots->mem_allocated) {
-            temp_allocate_frame(s, op->args[0]);
+            temp_allocate_frame(s, ots);
         }
         tcg_out_st(s, otype, ts->reg, ots->mem_base->reg, ots->mem_offset);
         if (IS_DEAD_ARG(1)) {
-- 
2.13.6
