Received: from eggs.gnu.org ([209.51.188.92]:54388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsR-0002Us-8D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWeO-0007Xa-0q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:45 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:22 +0200
Message-Id: <20190411100836.646-28-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 27/41] s390x/tcg: Implement VECTOR ELEMENT
 ROTATE LEFT LOGICAL
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

Take care of properly taking the modulo of the count. We might later
want to come back and create a variant of VERLL where the base register
is 0, resulting in an immediate.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  4 +++
 target/s390x/insn-data.def      |  3 ++
 target/s390x/translate_vx.inc.c | 60 +++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 40 ++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a306378950..f0efaf9cd5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -202,6 +202,10 @@ DEF_HELPER_FLAGS_4(gvec_vmlo16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vmlo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_3(gvec_vpopct8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vpopct16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_verllv8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_verllv16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_verll8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i=
32)
+DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0f786d6ab1..e765c15941 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1146,6 +1146,9 @@
     F(0xe76f, VOC,     VRR_c, VE,  0, 0, 0, 0, voc, 0, IF_VEC)
 /* VECTOR POPULATION COUNT */
     F(0xe750, VPOPCT,  VRR_a, V,   0, 0, 0, 0, vpopct, 0, IF_VEC)
+/* VECTOR ELEMENT ROTATE LEFT LOGICAL */
+    F(0xe773, VERLLV,  VRR_c, V,   0, 0, 0, 0, verllv, 0, IF_VEC)
+    F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index df17b8242d..92c14174da 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -185,6 +185,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_2(v1, v2, gen) \
     tcg_gen_gvec_2(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    16, 16, gen)
+#define gen_gvec_2s(v1, v2, c, gen) \
+    tcg_gen_gvec_2s(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                    16, 16, c, gen)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -1843,3 +1846,60 @@ static DisasJumpType op_vpopct(DisasContext *s, Di=
sasOps *o)
     gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
     return DISAS_NEXT;
 }
+
+static void gen_rll_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t0 =3D tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t0, b, 31);
+    tcg_gen_rotl_i32(d, a, t0);
+    tcg_temp_free_i32(t0);
+}
+
+static void gen_rll_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t0, b, 63);
+    tcg_gen_rotl_i64(d, a, t0);
+    tcg_temp_free_i64(t0);
+}
+
+static DisasJumpType op_verllv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fno =3D gen_helper_gvec_verllv8, },
+        { .fno =3D gen_helper_gvec_verllv16, },
+        { .fni4 =3D gen_rll_i32, },
+        { .fni8 =3D gen_rll_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_verll(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen2s g[4] =3D {
+        { .fno =3D gen_helper_gvec_verll8, },
+        { .fno =3D gen_helper_gvec_verll16, },
+        { .fni4 =3D gen_rll_i32, },
+        { .fni8 =3D gen_rll_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_2s(get_field(s->fields, v1), get_field(s->fields, v3), o->a=
ddr1,
+                &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index f49d5c2ffb..ed67fa73fb 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -540,3 +540,43 @@ void HELPER(gvec_vpopct##BITS)(void *v1, const void =
*v2, uint32_t desc)        \
 }
 DEF_VPOPCT(8)
 DEF_VPOPCT(16)
+
+#define DEF_ROTL(BITS)                                                  =
       \
+static uint##BITS##_t rotl##BITS(uint##BITS##_t a, uint8_t count)       =
       \
+{                                                                       =
       \
+    count &=3D BITS - 1;                                                =
         \
+    return (a << count) | (a >> (BITS - count));                        =
       \
+}
+DEF_ROTL(8)
+DEF_ROTL(16)
+
+#define DEF_VERLLV(BITS)                                                =
       \
+void HELPER(gvec_verllv##BITS)(void *v1, const void *v2, const void *v3,=
       \
+                               uint32_t desc)                           =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
+        const uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, rotl##BITS(a, b));          =
       \
+    }                                                                   =
       \
+}
+DEF_VERLLV(8)
+DEF_VERLLV(16)
+
+#define DEF_VERLL(BITS)                                                 =
       \
+void HELPER(gvec_verll##BITS)(void *v1, const void *v2, uint64_t count, =
       \
+                              uint32_t desc)                            =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, rotl##BITS(a, count));      =
       \
+    }                                                                   =
       \
+}
+DEF_VERLL(8)
+DEF_VERLL(16)
--=20
2.20.1
