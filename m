Received: from eggs.gnu.org ([2001:4830:134:3::10]:55761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWS-00074c-RL
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWR-0005zY-Ot
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:28 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWR-0005xn-J1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:27 -0500
Received: by mail-pg0-x243.google.com with SMTP id i5so2480811pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:25 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:26 -0800
Message-Id: <20161224040042.12654-50-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 49/65] tcg/i386: Rely on undefined/undocumented
 behaviour of BSF/BSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The ISA manual documents the output is undefined if the input was zero.

However, we document in target-i386 that the behavior of real silicon
is to preserve the contents of the output register.  We also mention
that there are real applications that depend on this.  That this is
baked into silicon is mentioned as a potential cause for some false
sharing behaviour wrt lzcnt/tzcnt.

Taking advantage of this allows us to save 2 insns in the normal case,
and 4 insns for i686 emulating a 64-bit clz.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.inc.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3ed8cd1..3650340 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1146,9 +1146,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
         tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         tcg_out_modrm(s, OPC_TZCNT + rexw, dest, arg1);
     } else {
-        tcg_debug_assert(dest != arg2);
+        /* ??? The manual says that the output is undefined when the
+           input is zero, but real hardware leaves it unchanged.  As
+           noted in target-i386/translate.c, real programs depend on
+           this -- now we are one more of those.  */
+        tcg_debug_assert(dest == arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
     }
 }
 
@@ -1161,20 +1164,26 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
+            /* LZCNT sets C if the input was zero.  */
             tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
         }
     } else {
-        tcg_debug_assert(!const_a2);
-        tcg_debug_assert(dest != arg1);
-        tcg_debug_assert(dest != arg2);
+        TCGType type = rexw ? TCG_TYPE_I64: TCG_TYPE_I32;
+        TCGArg rev = rexw ? 63 : 31;
 
-        /* Recall that the output of BSR is the index not the count.  */
+        /* Recall that the output of BSR is the index not the count.
+           Therefore we must adjust the result by ^ (SIZE-1).  In some
+           cases below, we prefer an extra XOR to a JMP.  */
+        /* ??? See the comment in tcg_out_ctz re BSF.  */
+        if (const_a2) {
+            tcg_debug_assert(dest != arg1);
+            tcg_out_movi(s, type, dest, arg2 ^ rev);
+        } else {
+            tcg_debug_assert(dest == arg2);
+            tgen_arithi(s, ARITH_XOR + rexw, dest, rev, 0);
+        }
         tcg_out_modrm(s, OPC_BSR + rexw, dest, arg1);
-        tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
-
-        /* Since we have destroyed the flags from BSR, we have to re-test.  */
-        tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tgen_arithi(s, ARITH_XOR + rexw, dest, rev, 0);
     }
 }
 
@@ -2443,7 +2452,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ctz_i64:
         {
             static const TCGTargetOpDef ctz[2] = {
-                { .args_ct_str = { "&r", "r", "r" } },
+                { .args_ct_str = { "r", "r", "0" } },
                 { .args_ct_str = { "&r", "r", "rW" } },
             };
             return &ctz[have_bmi1];
@@ -2452,7 +2461,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_clz_i64:
         {
             static const TCGTargetOpDef clz[2] = {
-                { .args_ct_str = { "&r", "r", "r" } },
+                { .args_ct_str = { "&r", "r", "0i" } },
                 { .args_ct_str = { "&r", "r", "rW" } },
             };
             return &clz[have_lzcnt];
-- 
2.9.3
