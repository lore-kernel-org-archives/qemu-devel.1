Received: from eggs.gnu.org ([2001:4830:134:3::10]:35053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uk-00064C-Bh
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uj-000380-F3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:34 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uj-00037Z-9F
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:33 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so12524550pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:27 -0800
Message-Id: <20170111021820.24416-13-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 12/65] tcg/s390: Support deposit into zero
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

Since we can no longer use matching constraints, this does
mean we must handle that data movement by hand.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 2faa761..22e121a 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -43,6 +43,7 @@
 #define TCG_CT_CONST_XORI  0x400
 #define TCG_CT_CONST_CMPI  0x800
 #define TCG_CT_CONST_ADLI  0x1000
+#define TCG_CT_CONST_ZERO  0x2000
 
 /* Several places within the instruction set 0 means "no register"
    rather than TCG_REG_R0.  */
@@ -399,6 +400,9 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
     case 'C':
         ct->ct |= TCG_CT_CONST_CMPI;
         break;
+    case 'Z':
+        ct->ct |= TCG_CT_CONST_ZERO;
+        break;
     default:
         return -1;
     }
@@ -538,6 +542,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return tcg_match_xori(type, val);
     } else if (ct & TCG_CT_CONST_CMPI) {
         return tcg_match_cmpi(type, val);
+    } else if (ct & TCG_CT_CONST_ZERO) {
+        return val == 0;
     }
 
     return 0;
@@ -1245,11 +1251,11 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
 }
 
 static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
-                         int ofs, int len)
+                         int ofs, int len, int z)
 {
     int lsb = (63 - ofs);
     int msb = lsb - (len - 1);
-    tcg_out_risbg(s, dest, src, msb, lsb, ofs, 0);
+    tcg_out_risbg(s, dest, src, msb, lsb, ofs, z);
 }
 
 static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
@@ -2162,8 +2168,24 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     OP_32_64(deposit):
-        tgen_deposit(s, args[0], args[2], args[3], args[4]);
+        a0 = args[0], a1 = args[1], a2 = args[2];
+        if (const_args[1]) {
+            tgen_deposit(s, a0, a2, args[3], args[4], 1);
+        } else {
+            /* Since we can't support "0Z" as a constraint, we allow a1 in
+               any register.  Fix things up as if a matching constraint.  */
+            if (a0 != a1) {
+                TCGType type = (opc == INDEX_op_deposit_i64);
+                if (a0 == a2) {
+                    tcg_out_mov(s, type, TCG_TMP0, a2);
+                    a2 = TCG_TMP0;
+                }
+                tcg_out_mov(s, type, a0, a1);
+            }
+            tgen_deposit(s, a0, a2, args[3], args[4], 0);
+        }
         break;
+
     OP_32_64(extract):
         tgen_extract(s, args[0], args[1], args[2], args[3]);
         break;
@@ -2235,7 +2257,7 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { INDEX_op_brcond_i32, { "r", "rC" } },
     { INDEX_op_setcond_i32, { "r", "r", "rC" } },
     { INDEX_op_movcond_i32, { "r", "r", "rC", "r", "0" } },
-    { INDEX_op_deposit_i32, { "r", "0", "r" } },
+    { INDEX_op_deposit_i32, { "r", "rZ", "r" } },
     { INDEX_op_extract_i32, { "r", "r" } },
 
     { INDEX_op_qemu_ld_i32, { "r", "L" } },
-- 
2.9.3
