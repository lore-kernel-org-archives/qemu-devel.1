Received: from eggs.gnu.org ([2001:4830:134:3::10]:54118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdI9-0001qC-S1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdI8-0005Wz-KR
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:46:41 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdI8-0005WS-Dz
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 22:46:40 -0500
Received: by mail-pg0-x243.google.com with SMTP id n5so2452010pgh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 19:46:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:46:36 -0800
Message-Id: <20161224034637.12207-2-rth@twiddle.net>
In-Reply-To: <20161224034637.12207-1-rth@twiddle.net>
References: <20161224034637.12207-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/2] tcg/s390: Fix setcond expansion
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

We can't use LOAD AND TEST for unsigned data and then expect to
extract the result with ADD LOGICAL WITH CARRY.  Fall through to
using COMPARE LOGICAL IMMEDIATE instead.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 50 ++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 253d4a0..23115b5 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1093,33 +1093,43 @@ static void tgen64_xori(TCGContext *s, TCGReg dest, tcg_target_ulong val)
 }
 
 static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
-                    TCGArg c2, int c2const)
+                    TCGArg c2, bool c2const, bool need_carry)
 {
     bool is_unsigned = is_unsigned_cond(c);
     if (c2const) {
         if (c2 == 0) {
+            if (!(is_unsigned && need_carry)) {
+                if (type == TCG_TYPE_I32) {
+                    tcg_out_insn(s, RR, LTR, r1, r1);
+                } else {
+                    tcg_out_insn(s, RRE, LTGR, r1, r1);
+                }
+                return tcg_cond_to_ltr_cond[c];
+            }
+            /* If we only got here because of load-and-test,
+               and we couldn't use that, then we need to load
+               the constant into a register.  */
+            if (!(facilities & FACILITY_EXT_IMM)) {
+                c2 = TCG_TMP0;
+                tcg_out_movi(s, type, c2, 0);
+                goto do_reg;
+            }
+        }
+        if (is_unsigned) {
             if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RR, LTR, r1, r1);
+                tcg_out_insn(s, RIL, CLFI, r1, c2);
             } else {
-                tcg_out_insn(s, RRE, LTGR, r1, r1);
+                tcg_out_insn(s, RIL, CLGFI, r1, c2);
             }
-            return tcg_cond_to_ltr_cond[c];
         } else {
-            if (is_unsigned) {
-                if (type == TCG_TYPE_I32) {
-                    tcg_out_insn(s, RIL, CLFI, r1, c2);
-                } else {
-                    tcg_out_insn(s, RIL, CLGFI, r1, c2);
-                }
+            if (type == TCG_TYPE_I32) {
+                tcg_out_insn(s, RIL, CFI, r1, c2);
             } else {
-                if (type == TCG_TYPE_I32) {
-                    tcg_out_insn(s, RIL, CFI, r1, c2);
-                } else {
-                    tcg_out_insn(s, RIL, CGFI, r1, c2);
-                }
+                tcg_out_insn(s, RIL, CGFI, r1, c2);
             }
         }
     } else {
+    do_reg:
         if (is_unsigned) {
             if (type == TCG_TYPE_I32) {
                 tcg_out_insn(s, RR, CLR, r1, c2);
@@ -1148,7 +1158,7 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     do_greater:
         /* The result of a compare has CC=2 for GT and CC=3 unused.
            ADD LOGICAL WITH CARRY considers (CC & 2) the carry bit.  */
-        tgen_cmp(s, type, cond, c1, c2, c2const);
+        tgen_cmp(s, type, cond, c1, c2, c2const, true);
         tcg_out_movi(s, type, dest, 0);
         tcg_out_insn(s, RRE, ALCGR, dest, dest);
         return;
@@ -1219,7 +1229,7 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         break;
     }
 
-    cc = tgen_cmp(s, type, cond, c1, c2, c2const);
+    cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
     if (facilities & FACILITY_LOAD_ON_COND) {
         /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
         tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
@@ -1238,11 +1248,11 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
 {
     int cc;
     if (facilities & FACILITY_LOAD_ON_COND) {
-        cc = tgen_cmp(s, type, c, c1, c2, c2const);
+        cc = tgen_cmp(s, type, c, c1, c2, c2const, false);
         tcg_out_insn(s, RRF, LOCGR, dest, r3, cc);
     } else {
         c = tcg_invert_cond(c);
-        cc = tgen_cmp(s, type, c, c1, c2, c2const);
+        cc = tgen_cmp(s, type, c, c1, c2, c2const, false);
 
         /* Emit: if (cc) goto over; dest = r3; over:  */
         tcg_out_insn(s, RI, BRC, cc, (4 + 4) >> 1);
@@ -1374,7 +1384,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
         }
     }
 
-    cc = tgen_cmp(s, type, c, r1, c2, c2const);
+    cc = tgen_cmp(s, type, c, r1, c2, c2const, false);
     tgen_branch(s, cc, l);
 }
 
-- 
2.9.3
