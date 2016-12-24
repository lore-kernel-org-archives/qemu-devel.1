Received: from eggs.gnu.org ([2001:4830:134:3::10]:55724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWO-00071Z-RH
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWN-0005xG-Uz
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:24 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWN-0005wz-QU
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:23 -0500
Received: by mail-pf0-x241.google.com with SMTP id c4so14580706pfb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:23 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:21 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:24 -0800
Message-Id: <20161224040042.12654-48-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 47/65] tcg/i386: Allow bmi2 shiftx to have
 non-matching operands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Previously we could not have different constraints for different ISA levels,
which prevented us from eliding the matching constraint for shifts.

We do now have to make sure that the operands match for constant shifts.
We can also handle some small left shifts via lea.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.inc.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 83572ac..651d96c 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -179,7 +179,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_set_reg(ct->u.regs, TCG_REG_EBX);
         break;
     case 'c':
-    case_c:
         ct->ct |= TCG_CT_REG;
         tcg_regset_set_reg(ct->u.regs, TCG_REG_ECX);
         break;
@@ -208,7 +207,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
         tcg_regset_set32(ct->u.regs, 0, 0xf);
         break;
     case 'r':
-    case_r:
         ct->ct |= TCG_CT_REG;
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_regset_set32(ct->u.regs, 0, 0xffff);
@@ -216,13 +214,6 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
             tcg_regset_set32(ct->u.regs, 0, 0xff);
         }
         break;
-    case 'C':
-        /* With SHRX et al, we need not use ECX as shift count register.  */
-        if (have_bmi2) {
-            goto case_r;
-        } else {
-            goto case_c;
-        }
 
         /* qemu_ld/st address constraint */
     case 'L':
@@ -1959,6 +1950,17 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     OP_32_64(shl):
+        /* For small constant 3-operand shift, use LEA.  */
+        if (const_a2 && a0 != a1 && (a2 - 1) < 3) {
+            if (a2 - 1 == 0) {
+                /* shl $1,a1,a0 -> lea (a1,a1),a0 */
+                tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a1, 0, 0);
+            } else {
+                /* shl $n,a1,a0 -> lea 0(,a1,n),a0 */
+                tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, -1, a1, a2, 0);
+            }
+            break;
+        }
         c = SHIFT_SHL;
         vexop = OPC_SHLX;
         goto gen_shift_maybe_vex;
@@ -1977,9 +1979,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         c = SHIFT_ROR;
         goto gen_shift;
     gen_shift_maybe_vex:
-        if (have_bmi2 && !const_a2) {
-            tcg_out_vex_modrm(s, vexop + rexw, a0, a2, a1);
-            break;
+        if (have_bmi2) {
+            if (!const_a2) {
+                tcg_out_vex_modrm(s, vexop + rexw, a0, a2, a1);
+                break;
+            }
+            tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, a0, a1);
         }
         /* FALLTHRU */
     gen_shift:
@@ -2190,9 +2195,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_q = { .args_ct_str = { "r", "q" } };
     static const TCGTargetOpDef r_re = { .args_ct_str = { "r", "re" } };
     static const TCGTargetOpDef r_0 = { .args_ct_str = { "r", "0" } };
+    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_re = { .args_ct_str = { "r", "r", "re" } };
     static const TCGTargetOpDef r_0_re = { .args_ct_str = { "r", "0", "re" } };
-    static const TCGTargetOpDef r_0_Ci = { .args_ct_str = { "r", "0", "Ci" } };
     static const TCGTargetOpDef r_0_ci = { .args_ct_str = { "r", "0", "ci" } };
     static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
     static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
@@ -2266,7 +2271,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
-        return &r_0_Ci;
+        return have_bmi2 ? &r_r_ri : &r_0_ci;
     case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
-- 
2.9.3
