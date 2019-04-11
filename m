Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsc-0002dl-54
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdk-0007EC-NB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:05 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:06 +0200
Message-Id: <20190411100836.646-12-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 11/41] s390x/tcg: Implement VECTOR COMPARE *
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

To carry out the comparison, we can reuse the existing gvec comparison
function. In case the CC is to be computed, save the result vector
and compute the CC lazily. The result is a vector consisting of all 1's
for elements that matched and 0's for elements that didn't match.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cc_helper.c        | 17 +++++++++++++++++
 target/s390x/helper.c           |  1 +
 target/s390x/insn-data.def      |  6 ++++++
 target/s390x/internal.h         |  1 +
 target/s390x/translate.c        |  1 +
 target/s390x/translate_vx.inc.c | 28 ++++++++++++++++++++++++++++
 6 files changed, 54 insertions(+)

diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 0e467bf2b6..a00294f183 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -402,6 +402,20 @@ static uint32_t cc_calc_lcbb(uint64_t dst)
     return dst =3D=3D 16 ? 0 : 3;
 }
=20
+static uint32_t cc_calc_vc(uint64_t low, uint64_t high)
+{
+    if (high =3D=3D -1ull && low =3D=3D -1ull) {
+        /* all elements match */
+        return 0;
+    } else if (high =3D=3D 0 && low =3D=3D 0) {
+        /* no elements match */
+        return 3;
+    } else {
+        /* some elements but not all match */
+        return 1;
+    }
+}
+
 static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
                                   uint64_t src, uint64_t dst, uint64_t v=
r)
 {
@@ -514,6 +528,9 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32=
_t cc_op,
     case CC_OP_LCBB:
         r =3D cc_calc_lcbb(dst);
         break;
+    case CC_OP_VC:
+        r =3D cc_calc_vc(src, dst);
+        break;
=20
     case CC_OP_NZ_F32:
         r =3D set_cc_nz_f32(dst);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 8e9573221c..946de15503 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -418,6 +418,7 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_SLA_64]    =3D "CC_OP_SLA_64",
         [CC_OP_FLOGR]     =3D "CC_OP_FLOGR",
         [CC_OP_LCBB]      =3D "CC_OP_LCBB",
+        [CC_OP_VC]        =3D "CC_OP_VC",
     };
=20
     return cc_names[cc_op];
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 52e398f515..1d159cb201 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1078,6 +1078,12 @@
     F(0xe7db, VEC,     VRR_a, V,   0, 0, 0, 0, vec, cmps64, IF_VEC)
 /* VECTOR ELEMENT COMPARE LOGICAL */
     F(0xe7d9, VECL,    VRR_a, V,   0, 0, 0, 0, vec, cmpu64, IF_VEC)
+/* VECTOR COMPARE EQUAL */
+    E(0xe7f8, VCEQ,    VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_EQ, IF_VE=
C)
+/* VECTOR COMPARE HIGH */
+    E(0xe7fb, VCH,     VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GT, IF_VE=
C)
+/* VECTOR COMPARE HIGH LOGICAL */
+    E(0xe7f9, VCHL,    VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GTU, IF_V=
EC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 3b4855c175..00b00fece5 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -200,6 +200,7 @@ enum cc_op {
     CC_OP_SLA_64,               /* Calculate shift left signed (64bit) *=
/
     CC_OP_FLOGR,                /* find leftmost one */
     CC_OP_LCBB,                 /* load count to block boundary */
+    CC_OP_VC,                   /* vector compare result */
     CC_OP_MAX
 };
=20
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 0afa8f7ca5..a800aa9dc9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -572,6 +572,7 @@ static void gen_op_calc_cc(DisasContext *s)
     case CC_OP_SLA_32:
     case CC_OP_SLA_64:
     case CC_OP_NZ_F128:
+    case CC_OP_VC:
         /* 2 arguments */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, =
dummy);
         break;
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index c7462d1bb1..ceb805a406 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1347,3 +1347,31 @@ static DisasJumpType op_vec(DisasContext *s, Disas=
Ops *o)
                          es | logical ? 0 : MO_SIGN);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    TCGCond cond =3D s->insn->data;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tcg_gen_gvec_cmp(cond, es,
+                     vec_full_reg_offset(get_field(s->fields, v1)),
+                     vec_full_reg_offset(get_field(s->fields, v2)),
+                     vec_full_reg_offset(get_field(s->fields, v3)), 16, =
16);
+    if (get_field(s->fields, m5) & 0x1) {
+        TCGv_i64 low =3D tcg_temp_new_i64();
+        TCGv_i64 high =3D tcg_temp_new_i64();
+
+        read_vec_element_i64(high, get_field(s->fields, v1), 0, ES_64);
+        read_vec_element_i64(low, get_field(s->fields, v1), 1, ES_64);
+        gen_op_update2_cc_i64(s, CC_OP_VC, low, high);
+
+        tcg_temp_free_i64(low);
+        tcg_temp_free_i64(high);
+    }
+    return DISAS_NEXT;
+}
--=20
2.20.1
