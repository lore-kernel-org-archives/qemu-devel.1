Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTcmy-0000j2-U1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTcmw-0003Hd-3D
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:40 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTcmv-0003Gw-V0
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:38 -0500
Received: by mail-pg0-x244.google.com with SMTP id t6so4950700pgt.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 15:03:37 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 17 Jan 2017 15:03:31 -0800
Message-Id: <20170117230332.16279-2-rth@twiddle.net>
In-Reply-To: <20170117230332.16279-1-rth@twiddle.net>
References: <20170117230332.16279-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 1/2] Revert "tcg/i386: Rely on
 undefined/undocumented behaviour of BSF/BSR"
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

This reverts commit 4ac76910734209dab83ddd3795f08fc7889ef463.

This fixes
  http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03062.html

While I think we could get away with relying on the undocumented
behaviour, the tcg constraint system isn't powerful enough to
properly describe the required (non-)overlap conditions.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.inc.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 01177a9..6489b73 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1148,12 +1148,9 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
         tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         tcg_out_modrm(s, OPC_TZCNT + rexw, dest, arg1);
     } else {
-        /* ??? The manual says that the output is undefined when the
-           input is zero, but real hardware leaves it unchanged.  As
-           noted in target-i386/translate.c, real programs depend on
-           this -- now we are one more of those.  */
-        tcg_debug_assert(dest == arg2);
+        tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
+        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
     }
 }
 
@@ -1166,26 +1163,20 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            /* LZCNT sets C if the input was zero.  */
             tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
         }
     } else {
-        TCGType type = rexw ? TCG_TYPE_I64: TCG_TYPE_I32;
-        TCGArg rev = rexw ? 63 : 31;
+        tcg_debug_assert(!const_a2);
+        tcg_debug_assert(dest != arg1);
+        tcg_debug_assert(dest != arg2);
 
-        /* Recall that the output of BSR is the index not the count.
-           Therefore we must adjust the result by ^ (SIZE-1).  In some
-           cases below, we prefer an extra XOR to a JMP.  */
-        /* ??? See the comment in tcg_out_ctz re BSF.  */
-        if (const_a2) {
-            tcg_debug_assert(dest != arg1);
-            tcg_out_movi(s, type, dest, arg2 ^ rev);
-        } else {
-            tcg_debug_assert(dest == arg2);
-            tgen_arithi(s, ARITH_XOR + rexw, dest, rev, 0);
-        }
+        /* Recall that the output of BSR is the index not the count.  */
         tcg_out_modrm(s, OPC_BSR + rexw, dest, arg1);
-        tgen_arithi(s, ARITH_XOR + rexw, dest, rev, 0);
+        tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
+
+        /* Since we have destroyed the flags from BSR, we have to re-test.  */
+        tcg_out_cmp(s, arg1, 0, 1, rexw);
+        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
     }
 }
 
@@ -2459,7 +2450,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ctz_i64:
         {
             static const TCGTargetOpDef ctz[2] = {
-                { .args_ct_str = { "r", "r", "0" } },
+                { .args_ct_str = { "&r", "r", "r" } },
                 { .args_ct_str = { "&r", "r", "rW" } },
             };
             return &ctz[have_bmi1];
@@ -2468,7 +2459,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_clz_i64:
         {
             static const TCGTargetOpDef clz[2] = {
-                { .args_ct_str = { "&r", "r", "0i" } },
+                { .args_ct_str = { "&r", "r", "r" } },
                 { .args_ct_str = { "&r", "r", "rW" } },
             };
             return &clz[have_lzcnt];
-- 
2.9.3
