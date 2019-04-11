Received: from eggs.gnu.org ([209.51.188.92]:55085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWse-0003L1-36
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdc-0007BD-4P
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:08:57 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:02 +0200
Message-Id: <20190411100836.646-8-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 07/41] s390x/tcg: Implement VECTOR AVERAGE
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

Handle 32/64-bit elements via gvec expansion and the 8/16 bits via
ool helpers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 16 +++++++++
 4 files changed, 83 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e1847e8877..2b6b716909 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -148,6 +148,8 @@ DEF_HELPER_FLAGS_4(vstl, TCG_CALL_NO_WG, void, env, c=
ptr, i64, i64)
 /* =3D=3D=3D Vector Integer Instructions =3D=3D=3D */
 DEF_HELPER_FLAGS_4(gvec_vacc128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_5(gvec_vaccc128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vavg8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vavg16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 456d5597ca..6f8b42e327 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1068,6 +1068,8 @@
     F(0xe768, VN,      VRR_c, V,   0, 0, 0, 0, vn, 0, IF_VEC)
 /* VECTOR AND WITH COMPLEMENT */
     F(0xe769, VNC,     VRR_c, V,   0, 0, 0, 0, vnc, 0, IF_VEC)
+/* VECTOR AVERAGE */
+    F(0xe7f2, VAVG,    VRR_c, V,   0, 0, 0, 0, vavg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index aaa247e855..50e03bf151 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -256,6 +256,17 @@ static void zero_vec(uint8_t reg)
     tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, 0);
 }
=20
+static void gen_addi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i6=
4 ah,
+                          uint64_t b)
+{
+    TCGv_i64 bl =3D tcg_const_i64(b);
+    TCGv_i64 bh =3D tcg_const_i64(0);
+
+    tcg_gen_add2_i64(dl, dh, al, ah, bl, bh);
+    tcg_temp_free_i64(bl);
+    tcg_temp_free_i64(bh);
+}
+
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D s->insn->data;
@@ -1149,3 +1160,55 @@ static DisasJumpType op_vnc(DisasContext *s, Disas=
Ops *o)
                   get_field(s->fields, v2), get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static void gen_avg_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+
+    tcg_gen_ext_i32_i64(t0, a);
+    tcg_gen_ext_i32_i64(t1, b);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_addi_i64(t0, t0, 1);
+    tcg_gen_shri_i64(t0, t0, 1);
+    tcg_gen_extrl_i64_i32(d, t0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+
+static void gen_avg_i64(TCGv_i64 dl, TCGv_i64 al, TCGv_i64 bl)
+{
+    TCGv_i64 dh =3D tcg_temp_new_i64();
+    TCGv_i64 ah =3D tcg_temp_new_i64();
+    TCGv_i64 bh =3D tcg_temp_new_i64();
+
+    /* extending the sign by one bit is sufficient */
+    tcg_gen_extract_i64(ah, al, 63, 1);
+    tcg_gen_extract_i64(bh, bl, 63, 1);
+    tcg_gen_add2_i64(dl, dh, al, ah, bl, bh);
+    gen_addi2_i64(dl, dh, dl, dh, 1);
+    tcg_gen_extract2_i64(dl, dl, dh, 1);
+
+    tcg_temp_free_i64(dh);
+    tcg_temp_free_i64(ah);
+    tcg_temp_free_i64(bh);
+}
+static DisasJumpType op_vavg(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vavg8, },
+        { .fno =3D gen_helper_gvec_vavg16, },
+        { .fni4 =3D gen_avg_i32, },
+        { .fni8 =3D gen_avg_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 97fc559da0..149cfaaeae 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -61,3 +61,19 @@ void HELPER(gvec_vaccc128)(void *v1, const void *v2, c=
onst void *v3,
     dst->doubleword[0] =3D 0;
     dst->doubleword[1] =3D carry;
 }
+
+#define DEF_VAVG(BITS)                                                  =
       \
+void HELPER(gvec_vavg##BITS)(void *v1, const void *v2, const void *v3,  =
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
+        const int32_t a =3D (int##BITS##_t)s390_vec_read_element##BITS(v=
2, i);   \
+        const int32_t b =3D (int##BITS##_t)s390_vec_read_element##BITS(v=
3, i);   \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, (a + b + 1) >> 1);          =
       \
+    }                                                                   =
       \
+}
+DEF_VAVG(8)
+DEF_VAVG(16)
--=20
2.20.1
