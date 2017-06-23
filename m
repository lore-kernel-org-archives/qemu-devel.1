Received: from eggs.gnu.org ([2001:4830:134:3::10]:60003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMF-0001Vj-B9
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORME-0007op-30
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:55 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMD-0007ob-VD
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:54 -0400
Received: by mail-qk0-x244.google.com with SMTP id r62so6800429qkf.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:22:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:31 -0700
Message-Id: <20170623162241.8964-6-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 05/15] target/s390x: Implement
 load-on-condition-2 insns
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

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def   |  9 +++++++++
 target/s390x/insn-format.def |  1 +
 target/s390x/translate.c     | 18 +++++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index aa4c5b2..c8ad4da 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -514,6 +514,13 @@
     C(0xb9e2, LOCGR,   RRF_c, LOC, r1, r2, r1, 0, loc, 0)
     C(0xebf2, LOC,     RSY_b, LOC, r1, m2_32u, new, r1_32, loc, 0)
     C(0xebe2, LOCG,    RSY_b, LOC, r1, m2_64, r1, 0, loc, 0)
+/* LOAD HALFWORD IMMEDIATE ON CONDITION */
+    C(0xec42, LOCHI,   RIE_g, LOC2, r1, i2, new, r1_32, loc, 0)
+    C(0xec46, LOCGHI,  RIE_g, LOC2, r1, i2, r1, 0, loc, 0)
+    C(0xec4e, LOCHHI,  RIE_g, LOC2, r1_sr32, i2, new, r1_32h, loc, 0)
+/* LOAD HIGH ON CONDITION */
+    C(0xb9e0, LOCFHR,  RRF_c, LOC2, r1_sr32, r2, new, r1_32h, loc, 0)
+    C(0xebe0, LOCFH,   RSY_b, LOC2, r1_sr32, m2_32u, new, r1_32h, loc, 0)
 /* LOAD PAIR DISJOINT */
     D(0xc804, LPD,     SSF,   ILA, 0, 0, new_P, r3_P32, lpd, 0, MO_TEUL)
     D(0xc805, LPDG,    SSF,   ILA, 0, 0, new_P, r3_P64, lpd, 0, MO_TEQ)
@@ -779,6 +786,8 @@
 /* STORE ON CONDITION */
     D(0xebf3, STOC,    RSY_b, LOC, 0, 0, 0, 0, soc, 0, 0)
     D(0xebe3, STOCG,   RSY_b, LOC, 0, 0, 0, 0, soc, 0, 1)
+/* STORE HIGH ON CONDITION */
+    D(0xebe1, STOCFH,  RSY_b, LOC2, 0, 0, 0, 0, soc, 0, 2)
 /* STORE REVERSED */
     C(0xe33f, STRVH,   RXY_a, Z,   la2, r1_16u, new, m1_16, rev16, 0)
     C(0xe33e, STRV,    RXY_a, Z,   la2, r1_32u, new, m1_32, rev32, 0)
diff --git a/target/s390x/insn-format.def b/target/s390x/insn-format.def
index 0e898b9..a412d90 100644
--- a/target/s390x/insn-format.def
+++ b/target/s390x/insn-format.def
@@ -11,6 +11,7 @@ F4(RIE_c, R(1, 8),     I(2,32, 8),  M(3,12),   I(4,16,16))
 F3(RIE_d, R(1, 8),     I(2,16,16),  R(3,12))
 F3(RIE_e, R(1, 8),     I(2,16,16),  R(3,12))
 F5(RIE_f, R(1, 8),     R(2,12),     I(3,16,8), I(4,24,8),  I(5,32,8))
+F3(RIE_g, R(1, 8),     I(2,16,16),  M(3,12))
 F2(RIL_a, R(1, 8),     I(2,16,32))
 F2(RIL_b, R(1, 8),     I(2,16,32))
 F2(RIL_c, M(1, 8),     I(2,16,32))
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 802ccd9..9932afb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3641,7 +3641,7 @@ static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
 static ExitStatus op_soc(DisasContext *s, DisasOps *o)
 {
     DisasCompare c;
-    TCGv_i64 a;
+    TCGv_i64 a, h;
     TCGLabel *lab;
     int r1;
 
@@ -3661,10 +3661,21 @@ static ExitStatus op_soc(DisasContext *s, DisasOps *o)
 
     r1 = get_field(s->fields, r1);
     a = get_address(s, 0, get_field(s->fields, b2), get_field(s->fields, d2));
-    if (s->insn->data) {
+    switch (s->insn->data) {
+    case 1: /* STOCG */
         tcg_gen_qemu_st64(regs[r1], a, get_mem_index(s));
-    } else {
+        break;
+    case 0: /* STOC */
         tcg_gen_qemu_st32(regs[r1], a, get_mem_index(s));
+        break;
+    case 2: /* STOCFH */
+        h = tcg_temp_new_i64();
+        tcg_gen_shri_i64(h, regs[r1], 32);
+        tcg_gen_qemu_st32(h, a, get_mem_index(s));
+        tcg_temp_free_i64(h);
+        break;
+    default:
+        g_assert_not_reached();
     }
     tcg_temp_free_i64(a);
 
@@ -5416,6 +5427,7 @@ enum DisasInsnEnum {
 #define FAC_MIE         S390_FEAT_STFLE_49 /* misc-instruction-extensions */
 #define FAC_LAT         S390_FEAT_STFLE_49 /* load-and-trap */
 #define FAC_LOC         S390_FEAT_STFLE_45 /* load/store on condition 1 */
+#define FAC_LOC2        S390_FEAT_STFLE_53 /* load/store on condition 2 */
 #define FAC_LD          S390_FEAT_LONG_DISPLACEMENT
 #define FAC_PC          S390_FEAT_STFLE_45 /* population count */
 #define FAC_SCF         S390_FEAT_STORE_CLOCK_FAST
-- 
2.9.4
