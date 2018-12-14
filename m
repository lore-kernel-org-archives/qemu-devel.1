Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0l-0005sX-I0
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0k-0006Ur-KT
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:35 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0k-0006TU-Eg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:34 -0500
Received: by mail-ot1-x330.google.com with SMTP id 81so4129229otj.2
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:57 -0600
Message-Id: <20181214031923.29527-8-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/32] tcg/arm: Fold away "noaddr" branch
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
 tcg/arm/tcg-target.inc.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 1142eb13ad..1651f00281 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -366,22 +366,6 @@ static inline void tcg_out_b(TCGContext *s, int cond, int32_t offset)
                     (((offset - 8) >> 2) & 0x00ffffff));
 }
 
-static inline void tcg_out_b_noaddr(TCGContext *s, int cond)
-{
-    /* We pay attention here to not modify the branch target by masking
-       the corresponding bytes.  This ensure that caches and memory are
-       kept coherent during retranslation. */
-    tcg_out32(s, deposit32(*s->code_ptr, 24, 8, (cond << 4) | 0x0a));
-}
-
-static inline void tcg_out_bl_noaddr(TCGContext *s, int cond)
-{
-    /* We pay attention here to not modify the branch target by masking
-       the corresponding bytes.  This ensure that caches and memory are
-       kept coherent during retranslation. */
-    tcg_out32(s, deposit32(*s->code_ptr, 24, 8, (cond << 4) | 0x0b));
-}
-
 static inline void tcg_out_bl(TCGContext *s, int cond, int32_t offset)
 {
     tcg_out32(s, (cond << 28) | 0x0b000000 |
@@ -1082,7 +1066,7 @@ static inline void tcg_out_goto_label(TCGContext *s, int cond, TCGLabel *l)
         tcg_out_goto(s, cond, l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr, R_ARM_PC24, l, 0);
-        tcg_out_b_noaddr(s, cond);
+        tcg_out_b(s, cond, 0);
     }
 }
 
@@ -1628,7 +1612,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is64)
     /* This a conditional BL only to load a pointer within this opcode into LR
        for the slow path.  We will not be using the value for a tail call.  */
     label_ptr = s->code_ptr;
-    tcg_out_bl_noaddr(s, COND_NE);
+    tcg_out_bl(s, COND_NE, 0);
 
     tcg_out_qemu_ld_index(s, opc, datalo, datahi, addrlo, addend);
 
@@ -1760,7 +1744,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 
     /* The conditional call must come last, as we're going to return here.  */
     label_ptr = s->code_ptr;
-    tcg_out_bl_noaddr(s, COND_NE);
+    tcg_out_bl(s, COND_NE, 0);
 
     add_qemu_ldst_label(s, false, oi, datalo, datahi, addrlo, addrhi,
                         s->code_ptr, label_ptr);
-- 
2.17.2
