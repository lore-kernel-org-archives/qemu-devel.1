Received: from eggs.gnu.org ([209.51.188.92]:50187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyEs4-0006H6-Gj
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyErx-0005qz-NC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:56:26 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 12:55:52 +0100
Message-Id: <20190225115552.7534-8-david@redhat.com>
In-Reply-To: <20190225115552.7534-1-david@redhat.com>
References: <20190225115552.7534-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 7/7] s390x/tcg: Implement LOAD COUNT TO
 BLOCK BOUNDARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Use a new CC helper to calculate the CC lazily if needed. While the
PoP mentions that "A 32-bit unsigned binary integer" is placed into the
first operand, there is no word telling that the other 32 bits (high
part) are left untouched. Maybe the other 32-bit are unpredictable.
So store 64 bit for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cc_helper.c   |  8 ++++++++
 target/s390x/helper.c      |  1 +
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/internal.h    |  1 +
 target/s390x/mem_helper.c  | 12 ++++++++++++
 target/s390x/translate.c   | 18 ++++++++++++++++++
 7 files changed, 43 insertions(+)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 307ad61aee..0e467bf2b6 100644
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
index a7edd5df7d..8e9573221c 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -417,6 +417,7 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_SLA_32]    = "CC_OP_SLA_32",
         [CC_OP_SLA_64]    = "CC_OP_SLA_64",
         [CC_OP_FLOGR]     = "CC_OP_FLOGR",
+        [CC_OP_LCBB]      = "CC_OP_LCBB",
     };
 
     return cc_names[cc_op];
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6260b50496..a2f8f96aae 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -122,6 +122,7 @@ DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
 DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
+DEF_HELPER_FLAGS_2(lcbb, TCG_CALL_NO_RWG_SE, i64, i64, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fb6ee18650..f4f1d63ab4 100644
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
index b2966a3adc..9d0a45d1fe 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -236,6 +236,7 @@ enum cc_op {
     CC_OP_SLA_32,               /* Calculate shift left signed (32bit) */
     CC_OP_SLA_64,               /* Calculate shift left signed (64bit) */
     CC_OP_FLOGR,                /* find leftmost one */
+    CC_OP_LCBB,                 /* load count to block boundary */
     CC_OP_MAX
 };
 
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a506d9ef99..7bca848cda 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2623,3 +2623,15 @@ uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
     return convert_unicode(env, r1, r2, m3, GETPC(),
                            decode_utf32, encode_utf16);
 }
+
+uint64_t HELPER(lcbb)(uint64_t addr, uint32_t m3)
+{
+    const uint32_t block_size = 1ul << (m3 + 6);
+    const uint64_t rounded_addr = ROUND_UP(addr, block_size);
+    uint32_t to_load = 16;
+
+    if (rounded_addr != addr) {
+        to_load = MIN(rounded_addr - addr, to_load);
+    }
+    return to_load;
+}
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 34799a8704..fd08ae6a5d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -556,6 +556,7 @@ static void gen_op_calc_cc(DisasContext *s)
     case CC_OP_NZ_F32:
     case CC_OP_NZ_F64:
     case CC_OP_FLOGR:
+    case CC_OP_LCBB:
         /* 1 argument */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, dummy, cc_dst, dummy);
         break;
@@ -3141,6 +3142,22 @@ static DisasJumpType op_lzrb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_lcbb(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 m3;
+
+    if (get_field(s->fields, m3) > 6) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    m3 = tcg_const_i32(get_field(s->fields, m3));
+    gen_helper_lcbb(o->out, o->addr1, m3);
+    tcg_temp_free_i32(m3);
+    gen_op_update1_cc_i64(s, CC_OP_LCBB, o->out);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 {
     o->out = o->in2;
@@ -5930,6 +5947,7 @@ enum DisasInsnEnum {
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
+#define FAC_V           S390_FEAT_VECTOR /* vector facility */
 
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
-- 
2.17.2
