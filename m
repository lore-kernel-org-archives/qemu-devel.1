Received: from eggs.gnu.org ([2001:4830:134:3::10]:33386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GJ-0008Q4-51
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GG-0002Gu-0t
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:55 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GF-0002Ge-RL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:51 -0400
Received: by mail-pg0-x243.google.com with SMTP id j186so17439738pge.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:35 -0700
Message-Id: <20170619181839.25249-9-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 08/12] tcg/arm: Use ldr (literal) for goto_tb
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

The new placement of the TB means that we can use one insn
to load the goto_tb destination directly from the TB.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 42370e5..d1793ec 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1669,14 +1669,27 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_goto_tb:
-        tcg_debug_assert(s->tb_jmp_insn_offset == 0);
         {
             /* Indirect jump method */
-            intptr_t ptr = (intptr_t)(s->tb_jmp_target_addr + args[0]);
-            tcg_out_movi32(s, COND_AL, TCG_REG_R0, ptr & ~0xfff);
-            tcg_out_ld32_12(s, COND_AL, TCG_REG_PC, TCG_REG_R0, ptr & 0xfff);
+            intptr_t ptr, dif, dil;
+            TCGReg base = TCG_REG_PC;
+
+            tcg_debug_assert(s->tb_jmp_insn_offset == 0);
+            ptr = (intptr_t)(s->tb_jmp_target_addr + args[0]);
+            dif = ptr - ((intptr_t)s->code_ptr + 8);
+            dil = sextract32(dif, 0, 12);
+            if (dif != dil) {
+                /* The TB is close, but outside the 12 bits addressable by
+                   the load.  We can extend this to 20 bits with a sub of a
+                   shifted immediate from pc.  In the vastly unlikely event
+                   the code requires more than 1MB, we'll use 2 insns and
+                   be no worse off.  */
+                base = TCG_REG_R0;
+                tcg_out_movi32(s, COND_AL, base, ptr - dil);
+            }
+            tcg_out_ld32_12(s, COND_AL, TCG_REG_PC, base, dil);
+            s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         }
-        s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         break;
     case INDEX_op_goto_ptr:
         tcg_out_bx(s, COND_AL, args[0]);
-- 
2.9.4
