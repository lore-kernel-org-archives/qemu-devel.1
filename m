Received: from eggs.gnu.org ([209.51.188.92]:38718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQZ-0008Vf-Tb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQY-0006y6-8Z
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:11 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:58 +0200
Message-Id: <20190502141019.6385-20-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/40] s390x/tcg: Implement VECTOR MULTIPLY *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Yet another set of variants. Implement it similar to VECTOR MULTIPLY AND
ADD *. At least for one variant we have a gvec helper we can reuse.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  16 +++++
 target/s390x/insn-data.def      |  14 +++++
 target/s390x/translate_vx.inc.c |  88 ++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 100 ++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 18f8756d43..1ba1660997 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -180,6 +180,22 @@ DEF_HELPER_FLAGS_5(gvec_vmao32, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, cptr, i3
 DEF_HELPER_FLAGS_5(gvec_vmalo8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vmalo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vmalo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vmh8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vmh16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmlh8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmlh16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vme8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vme16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vme32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmle8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmle16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vmle32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vmo8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vmo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmlo8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vmlo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vmlo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7ccec0544f..2c794a2744 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1120,6 +1120,20 @@
     F(0xe7af, VMAO,    VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
 /* VECTOR MULTIPLY AND ADD LOGICAL ODD */
     F(0xe7ad, VMALO,   VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY HIGH */
+    F(0xe7a3, VMH,     VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR MULTIPLY LOGICAL HIGH */
+    F(0xe7a1, VMLH,    VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR MULTIPLY LOW */
+    F(0xe7a2, VML,     VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR MULTIPLY EVEN */
+    F(0xe7a6, VME,     VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR MULTIPLY LOGICAL EVEN */
+    F(0xe7a4, VMLE,    VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR MULTIPLY ODD */
+    F(0xe7a7, VMO,     VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR MULTIPLY LOGICAL ODD */
+    F(0xe7a5, VMLO,    VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 2d47982cce..d43166a621 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1699,3 +1699,91 @@ static DisasJumpType op_vma(DisasContext *s, Disas=
Ops *o)
                get_field(s->fields, v3), get_field(s->fields, v4), fn);
     return DISAS_NEXT;
 }
+
+static void gen_mh_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t =3D tcg_temp_new_i32();
+
+    tcg_gen_muls2_i32(t, d, a, b);
+    tcg_temp_free_i32(t);
+}
+
+static void gen_mlh_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t =3D tcg_temp_new_i32();
+
+    tcg_gen_mulu2_i32(t, d, a, b);
+    tcg_temp_free_i32(t);
+}
+
+static DisasJumpType op_vm(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g_vmh[3] =3D {
+        { .fno =3D gen_helper_gvec_vmh8, },
+        { .fno =3D gen_helper_gvec_vmh16, },
+        { .fni4 =3D gen_mh_i32, },
+    };
+    static const GVecGen3 g_vmlh[3] =3D {
+        { .fno =3D gen_helper_gvec_vmlh8, },
+        { .fno =3D gen_helper_gvec_vmlh16, },
+        { .fni4 =3D gen_mlh_i32, },
+    };
+    static const GVecGen3 g_vme[3] =3D {
+        { .fno =3D gen_helper_gvec_vme8, },
+        { .fno =3D gen_helper_gvec_vme16, },
+        { .fno =3D gen_helper_gvec_vme32, },
+    };
+    static const GVecGen3 g_vmle[3] =3D {
+        { .fno =3D gen_helper_gvec_vmle8, },
+        { .fno =3D gen_helper_gvec_vmle16, },
+        { .fno =3D gen_helper_gvec_vmle32, },
+    };
+    static const GVecGen3 g_vmo[3] =3D {
+        { .fno =3D gen_helper_gvec_vmo8, },
+        { .fno =3D gen_helper_gvec_vmo16, },
+        { .fno =3D gen_helper_gvec_vmo32, },
+    };
+    static const GVecGen3 g_vmlo[3] =3D {
+        { .fno =3D gen_helper_gvec_vmlo8, },
+        { .fno =3D gen_helper_gvec_vmlo16, },
+        { .fno =3D gen_helper_gvec_vmlo32, },
+    };
+    const GVecGen3 *fn;
+
+    if (es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0xa2:
+        gen_gvec_fn_3(mul, es, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
);
+        return DISAS_NEXT;
+    case 0xa3:
+        fn =3D &g_vmh[es];
+        break;
+    case 0xa1:
+        fn =3D &g_vmlh[es];
+        break;
+    case 0xa6:
+        fn =3D &g_vme[es];
+        break;
+    case 0xa4:
+        fn =3D &g_vmle[es];
+        break;
+    case 0xa7:
+        fn =3D &g_vmo[es];
+        break;
+    case 0xa5:
+        fn =3D &g_vmlo[es];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 171c20fc54..2d7d4766c5 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -364,3 +364,103 @@ void HELPER(gvec_vmalo##BITS)(void *v1, const void =
*v2, const void *v3,        \
 DEF_VMALO(8, 16)
 DEF_VMALO(16, 32)
 DEF_VMALO(32, 64)
+
+#define DEF_VMH(BITS)                                                   =
       \
+void HELPER(gvec_vmh##BITS)(void *v1, const void *v2, const void *v3,   =
       \
+                            uint32_t desc)                              =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const int32_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(v=
2, i);   \
+        const int32_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(v=
3, i);   \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, (a * b) >> BITS);           =
       \
+    }                                                                   =
       \
+}
+DEF_VMH(8)
+DEF_VMH(16)
+
+#define DEF_VMLH(BITS)                                                  =
       \
+void HELPER(gvec_vmlh##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
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
+        s390_vec_write_element##BITS(v1, i, (a * b) >> BITS);           =
       \
+    }                                                                   =
       \
+}
+DEF_VMLH(8)
+DEF_VMLH(16)
+
+#define DEF_VME(BITS, TBITS)                                            =
       \
+void HELPER(gvec_vme##BITS)(void *v1, const void *v2, const void *v3,   =
       \
+                            uint32_t desc)                              =
       \
+{                                                                       =
       \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+        int##TBITS##_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v2, j);  \
+        int##TBITS##_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v3, j);  \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b);                    =
       \
+    }                                                                   =
       \
+}
+DEF_VME(8, 16)
+DEF_VME(16, 32)
+DEF_VME(32, 64)
+
+#define DEF_VMLE(BITS, TBITS)                                           =
       \
+void HELPER(gvec_vmle##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+        const uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j); =
         \
+        const uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j); =
         \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b);                    =
       \
+    }                                                                   =
       \
+}
+DEF_VMLE(8, 16)
+DEF_VMLE(16, 32)
+DEF_VMLE(32, 64)
+
+#define DEF_VMO(BITS, TBITS)                                            =
       \
+void HELPER(gvec_vmo##BITS)(void *v1, const void *v2, const void *v3,   =
       \
+                            uint32_t desc)                              =
       \
+{                                                                       =
       \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+        int##TBITS##_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v2, j);  \
+        int##TBITS##_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v3, j);  \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b);                    =
       \
+    }                                                                   =
       \
+}
+DEF_VMO(8, 16)
+DEF_VMO(16, 32)
+DEF_VMO(32, 64)
+
+#define DEF_VMLO(BITS, TBITS)                                           =
       \
+void HELPER(gvec_vmlo##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+        const uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j); =
         \
+        const uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j); =
         \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b);                    =
       \
+    }                                                                   =
       \
+}
+DEF_VMLO(8, 16)
+DEF_VMLO(16, 32)
+DEF_VMLO(32, 64)
--=20
2.20.1
