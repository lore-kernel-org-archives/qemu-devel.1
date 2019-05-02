Received: from eggs.gnu.org ([209.51.188.92]:38692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQX-0008Pv-Cb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQV-0006w3-LW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:09 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:57 +0200
Message-Id: <20190502141019.6385-19-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 18/40] s390x/tcg: Implement VECTOR MULTIPLY
 AND ADD *
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

Quite some variants to handle. At least handle some 32-bit element
variants via gvec expansion (we could also handle 16/32-bit variants
for ODD and EVEN easily via gvec expansion, but let's keep it simple
for now).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  18 +++++
 target/s390x/insn-data.def      |  14 ++++
 target/s390x/translate_vx.inc.c | 122 +++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 123 ++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6e6ba9bf32..18f8756d43 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -162,6 +162,24 @@ DEF_HELPER_FLAGS_5(gvec_vgfma8, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, cptr, i3
 DEF_HELPER_FLAGS_5(gvec_vgfma16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vgfma32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vgfma64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmal8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, c=
ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmal16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmah8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, c=
ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmah16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmalh8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmalh16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmae8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, c=
ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmae16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmae32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmale8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmale16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmale32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmao8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, c=
ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmao16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmao32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmalo8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmalo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vmalo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index b22d9f0f6a..7ccec0544f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1106,6 +1106,20 @@
     F(0xe7fe, VMN,     VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
 /* VECTOR MINIMUM LOGICAL */
     F(0xe7fc, VMNL,    VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD LOW */
+    F(0xe7aa, VMAL,    VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD HIGH */
+    F(0xe7ab, VMAH,    VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD LOGICAL HIGH */
+    F(0xe7a9, VMALH,   VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD EVEN */
+    F(0xe7ae, VMAE,    VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD LOGICAL EVEN */
+    F(0xe7ac, VMALE,   VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD ODD */
+    F(0xe7af, VMAO,    VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
+/* VECTOR MULTIPLY AND ADD LOGICAL ODD */
+    F(0xe7ad, VMALO,   VRR_d, V,   0, 0, 0, 0, vma, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index efd42c6f9f..2d47982cce 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1577,3 +1577,125 @@ static DisasJumpType op_vmx(DisasContext *s, Disa=
sOps *o)
     }
     return DISAS_NEXT;
 }
+
+static void gen_mal_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, TCGv_i32 c)
+{
+    TCGv_i32 t0 =3D tcg_temp_new_i32();
+
+    tcg_gen_mul_i32(t0, a, b);
+    tcg_gen_add_i32(d, t0, c);
+
+    tcg_temp_free_i32(t0);
+}
+
+static void gen_mah_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, TCGv_i32 c)
+{
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+
+    tcg_gen_ext_i32_i64(t0, a);
+    tcg_gen_ext_i32_i64(t1, b);
+    tcg_gen_ext_i32_i64(t2, c);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t2);
+    tcg_gen_extrh_i64_i32(d, t0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+}
+
+static void gen_malh_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b, TCGv_i32 c)
+{
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+
+    tcg_gen_extu_i32_i64(t0, a);
+    tcg_gen_extu_i32_i64(t1, b);
+    tcg_gen_extu_i32_i64(t2, c);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t2);
+    tcg_gen_extrh_i64_i32(d, t0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+}
+
+static DisasJumpType op_vma(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m5);
+    static const GVecGen4 g_vmal[3] =3D {
+        { .fno =3D gen_helper_gvec_vmal8, },
+        { .fno =3D gen_helper_gvec_vmal16, },
+        { .fni4 =3D gen_mal_i32, },
+    };
+    static const GVecGen4 g_vmah[3] =3D {
+        { .fno =3D gen_helper_gvec_vmah8, },
+        { .fno =3D gen_helper_gvec_vmah16, },
+        { .fni4 =3D gen_mah_i32, },
+    };
+    static const GVecGen4 g_vmalh[3] =3D {
+        { .fno =3D gen_helper_gvec_vmalh8, },
+        { .fno =3D gen_helper_gvec_vmalh16, },
+        { .fni4 =3D gen_malh_i32, },
+    };
+    static const GVecGen4 g_vmae[3] =3D {
+        { .fno =3D gen_helper_gvec_vmae8, },
+        { .fno =3D gen_helper_gvec_vmae16, },
+        { .fno =3D gen_helper_gvec_vmae32, },
+    };
+    static const GVecGen4 g_vmale[3] =3D {
+        { .fno =3D gen_helper_gvec_vmale8, },
+        { .fno =3D gen_helper_gvec_vmale16, },
+        { .fno =3D gen_helper_gvec_vmale32, },
+    };
+    static const GVecGen4 g_vmao[3] =3D {
+        { .fno =3D gen_helper_gvec_vmao8, },
+        { .fno =3D gen_helper_gvec_vmao16, },
+        { .fno =3D gen_helper_gvec_vmao32, },
+    };
+    static const GVecGen4 g_vmalo[3] =3D {
+        { .fno =3D gen_helper_gvec_vmalo8, },
+        { .fno =3D gen_helper_gvec_vmalo16, },
+        { .fno =3D gen_helper_gvec_vmalo32, },
+    };
+    const GVecGen4 *fn;
+
+    if (es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0xaa:
+        fn =3D &g_vmal[es];
+        break;
+    case 0xab:
+        fn =3D &g_vmah[es];
+        break;
+    case 0xa9:
+        fn =3D &g_vmalh[es];
+        break;
+    case 0xae:
+        fn =3D &g_vmae[es];
+        break;
+    case 0xac:
+        fn =3D &g_vmale[es];
+        break;
+    case 0xaf:
+        fn =3D &g_vmao[es];
+        break;
+    case 0xad:
+        fn =3D &g_vmalo[es];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), get_field(s->fields, v4), fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 20a1034dd8..171c20fc54 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -241,3 +241,126 @@ void HELPER(gvec_vgfma64)(void *v1, const void *v2,=
 const void *v3,
     s390_vec_xor(&tmp1, &tmp1, &tmp2);
     s390_vec_xor(v1, &tmp1, v4);
 }
+
+#define DEF_VMAL(BITS)                                                  =
       \
+void HELPER(gvec_vmal##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             const void *v4, uint32_t desc)             =
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
+        const uint##BITS##_t c =3D s390_vec_read_element##BITS(v4, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a * b + c);                 =
       \
+    }                                                                   =
       \
+}
+DEF_VMAL(8)
+DEF_VMAL(16)
+
+#define DEF_VMAH(BITS)                                                  =
       \
+void HELPER(gvec_vmah##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             const void *v4, uint32_t desc)             =
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
+        const int32_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(v=
4, i);   \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, (a * b + c) >> BITS);       =
       \
+    }                                                                   =
       \
+}
+DEF_VMAH(8)
+DEF_VMAH(16)
+
+#define DEF_VMALH(BITS)                                                 =
       \
+void HELPER(gvec_vmalh##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              const void *v4, uint32_t desc)            =
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
+        const uint##BITS##_t c =3D s390_vec_read_element##BITS(v4, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, (a * b + c) >> BITS);       =
       \
+    }                                                                   =
       \
+}
+DEF_VMALH(8)
+DEF_VMALH(16)
+
+#define DEF_VMAE(BITS, TBITS)                                           =
       \
+void HELPER(gvec_vmae##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             const void *v4, uint32_t desc)             =
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
+        int##TBITS##_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v4, j);  \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
+    }                                                                   =
       \
+}
+DEF_VMAE(8, 16)
+DEF_VMAE(16, 32)
+DEF_VMAE(32, 64)
+
+#define DEF_VMALE(BITS, TBITS)                                          =
       \
+void HELPER(gvec_vmale##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              const void *v4, uint32_t desc)            =
       \
+{                                                                       =
       \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0, j =3D 0; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+        uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);       =
         \
+        uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);       =
         \
+        uint##TBITS##_t c =3D s390_vec_read_element##BITS(v4, j);       =
         \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
+    }                                                                   =
       \
+}
+DEF_VMALE(8, 16)
+DEF_VMALE(16, 32)
+DEF_VMALE(32, 64)
+
+#define DEF_VMAO(BITS, TBITS)                                           =
       \
+void HELPER(gvec_vmao##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             const void *v4, uint32_t desc)             =
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
+        int##TBITS##_t c =3D (int##BITS##_t)s390_vec_read_element##BITS(=
v4, j);  \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
+    }                                                                   =
       \
+}
+DEF_VMAO(8, 16)
+DEF_VMAO(16, 32)
+DEF_VMAO(32, 64)
+
+#define DEF_VMALO(BITS, TBITS)                                          =
       \
+void HELPER(gvec_vmalo##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              const void *v4, uint32_t desc)            =
       \
+{                                                                       =
       \
+    int i, j;                                                           =
       \
+                                                                        =
       \
+    for (i =3D 0, j =3D 1; i < (128 / TBITS); i++, j +=3D 2) {          =
             \
+        uint##TBITS##_t a =3D s390_vec_read_element##BITS(v2, j);       =
         \
+        uint##TBITS##_t b =3D s390_vec_read_element##BITS(v3, j);       =
         \
+        uint##TBITS##_t c =3D s390_vec_read_element##BITS(v4, j);       =
         \
+                                                                        =
       \
+        s390_vec_write_element##TBITS(v1, i, a * b + c);                =
       \
+    }                                                                   =
       \
+}
+DEF_VMALO(8, 16)
+DEF_VMALO(16, 32)
+DEF_VMALO(32, 64)
--=20
2.20.1
