Received: from eggs.gnu.org ([2001:4830:134:3::10]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0j-0005px-EC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0i-0006O1-GX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:33 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:41312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0i-0006LS-9K
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:32 -0500
Received: by mail-ot1-x330.google.com with SMTP id u16so4105094otk.8
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:55 -0600
Message-Id: <20181214031923.29527-6-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/32] tcg/aarch64: Fold away "noaddr" branch
 routines
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

There are one use apiece for these.  There is no longer a need for
preserving branch offset operands, as we no longer re-translate.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index a41b633960..28de0226fb 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1129,23 +1129,6 @@ static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
     }
 }
 
-static inline void tcg_out_goto_noaddr(TCGContext *s)
-{
-    /* We pay attention here to not modify the branch target by reading from
-       the buffer. This ensure that caches and memory are kept coherent during
-       retranslation.  Mask away possible garbage in the high bits for the
-       first translation, while keeping the offset bits for retranslation. */
-    uint32_t old = tcg_in32(s);
-    tcg_out_insn(s, 3206, B, old);
-}
-
-static inline void tcg_out_goto_cond_noaddr(TCGContext *s, TCGCond c)
-{
-    /* See comments in tcg_out_goto_noaddr.  */
-    uint32_t old = tcg_in32(s) >> 5;
-    tcg_out_insn(s, 3202, B_C, c, old);
-}
-
 static inline void tcg_out_callr(TCGContext *s, TCGReg reg)
 {
     tcg_out_insn(s, 3207, BLR, reg);
@@ -1192,7 +1175,7 @@ static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 {
     if (!l->has_value) {
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_JUMP26, l, 0);
-        tcg_out_goto_noaddr(s);
+        tcg_out_insn(s, 3206, B, 0);
     } else {
         tcg_out_goto(s, l->u.value_ptr);
     }
@@ -1523,7 +1506,7 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
 
     /* If not equal, we jump to the slow path. */
     *label_ptr = s->code_ptr;
-    tcg_out_goto_cond_noaddr(s, TCG_COND_NE);
+    tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
 }
 
 #endif /* CONFIG_SOFTMMU */
-- 
2.17.2
