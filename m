Received: from eggs.gnu.org ([2001:4830:134:3::10]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQf-0002Qq-K8
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQe-0001UN-NQ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:09 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:36810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmnQe-0001U3-HS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:08 -0400
Received: by mail-pf0-x231.google.com with SMTP id z87so13387420pfi.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:48:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Aug 2017 13:47:54 -0700
Message-Id: <20170829204759.6853-4-richard.henderson@linaro.org>
In-Reply-To: <20170829204759.6853-1-richard.henderson@linaro.org>
References: <20170829204759.6853-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/8] tcg/s390: Merge muli facilities check to
 tcg_target_op_def
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, agraf@suse.de, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index e075b4844a..ff3f644f8e 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -38,12 +38,13 @@
    a 32-bit displacement here Just In Case.  */
 #define USE_LONG_BRANCHES 0
 
-#define TCG_CT_CONST_MULI  0x100
-#define TCG_CT_CONST_ORI   0x200
-#define TCG_CT_CONST_XORI  0x400
-#define TCG_CT_CONST_U31   0x800
-#define TCG_CT_CONST_ADLI  0x1000
-#define TCG_CT_CONST_ZERO  0x2000
+#define TCG_CT_CONST_S16   0x100
+#define TCG_CT_CONST_S32   0x200
+#define TCG_CT_CONST_ORI   0x400
+#define TCG_CT_CONST_XORI  0x800
+#define TCG_CT_CONST_U31   0x1000
+#define TCG_CT_CONST_ADLI  0x2000
+#define TCG_CT_CONST_ZERO  0x4000
 
 /* Several places within the instruction set 0 means "no register"
    rather than TCG_REG_R0.  */
@@ -388,8 +389,11 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'A':
         ct->ct |= TCG_CT_CONST_ADLI;
         break;
-    case 'K':
-        ct->ct |= TCG_CT_CONST_MULI;
+    case 'I':
+        ct->ct |= TCG_CT_CONST_S16;
+        break;
+    case 'J':
+        ct->ct |= TCG_CT_CONST_S32;
         break;
     case 'O':
         ct->ct |= TCG_CT_CONST_ORI;
@@ -503,16 +507,10 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
     }
 
     /* The following are mutually exclusive.  */
-    if (ct & TCG_CT_CONST_MULI) {
-        /* Immediates that may be used with multiply.  If we have the
-           general-instruction-extensions, then we have MULTIPLY SINGLE
-           IMMEDIATE with a signed 32-bit, otherwise we have only
-           MULTIPLY HALFWORD IMMEDIATE, with a signed 16-bit.  */
-        if (s390_facilities & FACILITY_GEN_INST_EXT) {
-            return val == (int32_t)val;
-        } else {
-            return val == (int16_t)val;
-        }
+    if (ct & TCG_CT_CONST_S16) {
+        return val == (int16_t)val;
+    } else if (ct & TCG_CT_CONST_S32) {
+        return val == (int32_t)val;
     } else if (ct & TCG_CT_CONST_ADLI) {
         return tcg_match_add2i(type, val);
     } else if (ct & TCG_CT_CONST_ORI) {
@@ -2239,7 +2237,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef r_rZ = { .args_ct_str = { "r", "rZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
-    static const TCGTargetOpDef r_0_rK = { .args_ct_str = { "r", "0", "rK" } };
+    static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
+    static const TCGTargetOpDef r_0_rJ = { .args_ct_str = { "r", "0", "rJ" } };
     static const TCGTargetOpDef r_0_rO = { .args_ct_str = { "r", "0", "rO" } };
     static const TCGTargetOpDef r_0_rX = { .args_ct_str = { "r", "0", "rX" } };
 
@@ -2274,9 +2273,15 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return &r_0_ri;
+
     case INDEX_op_mul_i32:
+        /* If we have the general-instruction-extensions, then we have
+           MULTIPLY SINGLE IMMEDIATE with a signed 32-bit, otherwise we
+           have only MULTIPLY HALFWORD IMMEDIATE, with a signed 16-bit.  */
+        return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_ri : &r_0_rI);
     case INDEX_op_mul_i64:
-        return &r_0_rK;
+        return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_rJ : &r_0_rI);
+
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
         return &r_0_rO;
-- 
2.13.5
