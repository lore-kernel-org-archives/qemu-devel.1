Received: from eggs.gnu.org ([2001:4830:134:3::10]:33947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhM-0006Xs-Er
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhL-0002QC-Nn
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:52 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhL-0002Pr-Jj
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:51 -0400
Received: by mail-qt0-x242.google.com with SMTP id s33so25676343qtg.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:26 -0700
Message-Id: <20170621024831.26019-12-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 11/16] tcg: Change temp_allocate_frame arg to
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
Cc: aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c228f1e..f8d96fa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1869,10 +1869,8 @@ static void check_regs(TCGContext *s)
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
@@ -1925,7 +1923,7 @@ static void temp_sync(TCGContext *s, TCGTemp *ts,
     }
     if (!ts->mem_coherent) {
         if (!ts->mem_allocated) {
-            temp_allocate_frame(s, temp_idx(s, ts));
+            temp_allocate_frame(s, ts);
         }
         switch (ts->val_type) {
         case TEMP_VAL_CONST:
@@ -2155,7 +2153,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
            liveness analysis disabled). */
         tcg_debug_assert(NEED_SYNC_ARG(0));
         if (!ots->mem_allocated) {
-            temp_allocate_frame(s, op->args[0]);
+            temp_allocate_frame(s, ots);
         }
         tcg_out_st(s, otype, ts->reg, ots->mem_base->reg, ots->mem_offset);
         if (IS_DEAD_ARG(1)) {
-- 
2.9.4
