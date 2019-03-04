Received: from eggs.gnu.org ([209.51.188.92]:46527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJJ-0000N6-Pg
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mJI-000138-ME
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:03:09 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:55 +0100
Message-Id: <20190304120210.31500-13-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 12/27] s390x/tcg: Implement LOAD COUNT TO BLOCK
 BOUNDARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Use a new CC helper to calculate the CC lazily if needed. While the
PoP mentions that "A 32-bit unsigned binary integer" is placed into the
first operand, there is no word telling that the other 32 bits (high
part) are left untouched. Maybe the other 32-bit are unpredictable.
So store 64 bit for now.

Bit magic courtesy of Richard.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225200318.16102-8-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cc_helper.c   |  8 ++++++++
 target/s390x/helper.c      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/internal.h    |  1 +
 target/s390x/translate.c   | 19 +++++++++++++++++++
 5 files changed, 31 insertions(+)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 307ad61aee3d..0e467bf2b6a2 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -397,6 +397,11 @@ static uint32_t cc_calc_flogr(uint64_t dst)
     return dst ? 2 : 0;
 }
 
+static uint32_t cc_calc_lcbb(uint64_t dst)
+{
+    return dst == 16 ? 0 : 3;
+}
+
 static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
                                   uint64_t src, uint64_t dst, uint64_t vr)
 {
@@ -506,6 +511,9 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_FLOGR:
         r = cc_calc_flogr(dst);
         break;
+    case CC_OP_LCBB:
+        r = cc_calc_lcbb(dst);
+        break;
 
     case CC_OP_NZ_F32:
         r = set_cc_nz_f32(dst);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a7edd5df7d59..8e9573221cdb 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -417,6 +417,7 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_SLA_32]    = "CC_OP_SLA_32",
         [CC_OP_SLA_64]    = "CC_OP_SLA_64",
         [CC_OP_FLOGR]     = "CC_OP_FLOGR",
+        [CC_OP_LCBB]      = "CC_OP_LCBB",
     };
 
     return cc_names[cc_op];
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fb6ee1865057..f4f1d63ab44c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -479,6 +479,8 @@
     F(0xb313, LCDBR,   RRE,   Z,   0, f2, new, f1, negf64, f64, IF_BFP)
     F(0xb343, LCXBR,   RRE,   Z,   x2h, x2l, new_P, x1, negf128, f128, IF_BFP)
     F(0xb373, LCDFR,   RRE,   FPSSH, 0, f2, new, f1, negf64, 0, IF_AFP1 | IF_AFP2)
+/* LOAD COUNT TO BLOCK BOUNDARY */
+    C(0xe727, LCBB,    RXE,   V,   la2, 0, r1, 0, lcbb, 0)
 /* LOAD HALFWORD */
     C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
     C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index b2966a3adcb8..9d0a45d1fef7 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -236,6 +236,7 @@ enum cc_op {
     CC_OP_SLA_32,               /* Calculate shift left signed (32bit) */
     CC_OP_SLA_64,               /* Calculate shift left signed (64bit) */
     CC_OP_FLOGR,                /* find leftmost one */
+    CC_OP_LCBB,                 /* load count to block boundary */
     CC_OP_MAX
 };
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 59e71128d2bf..d9a89625c66c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -557,6 +557,7 @@ static void gen_op_calc_cc(DisasContext *s)
     case CC_OP_NZ_F32:
     case CC_OP_NZ_F64:
     case CC_OP_FLOGR:
+    case CC_OP_LCBB:
         /* 1 argument */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, dummy, cc_dst, dummy);
         break;
@@ -3142,6 +3143,23 @@ static DisasJumpType op_lzrb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
+{
+    const int64_t block_size = (1ull << (get_field(s->fields, m3) + 6));
+
+    if (get_field(s->fields, m3) > 6) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tcg_gen_ori_i64(o->addr1, o->addr1, -block_size);
+    tcg_gen_neg_i64(o->addr1, o->addr1);
+    tcg_gen_movi_i64(o->out, 16);
+    tcg_gen_umin_i64(o->out, o->out, o->addr1);
+    gen_op_update1_cc_i64(s, CC_OP_LCBB, o->out);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 {
     o->out = o->in2;
@@ -5931,6 +5949,7 @@ enum DisasInsnEnum {
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
+#define FAC_V           S390_FEAT_VECTOR /* vector facility */
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
-- 
2.17.2
