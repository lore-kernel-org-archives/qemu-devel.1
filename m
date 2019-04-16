Received: from eggs.gnu.org ([209.51.188.92]:54785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDS-000575-1t
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDO-0005Pk-Kr
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:53:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 16 Apr 2019 20:52:37 +0200
Message-Id: <20190416185301.25344-18-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/41] s390x/tcg: Implement VECTOR LOAD
 POSITIVE
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

Similar to VECTOR LOAD COMPLEMENT but unfortunately we don't have a
gvec helper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 40 +++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 14 ++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6e6ba9bf32..361b1a2077 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -162,6 +162,8 @@ DEF_HELPER_FLAGS_5(gvec_vgfma8, TCG_CALL_NO_RWG, void=
, ptr, cptr, cptr, cptr, i3
 DEF_HELPER_FLAGS_5(gvec_vgfma16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vgfma32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vgfma64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vlp8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vlp16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 07868ff082..fc8886ff42 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1096,6 +1096,8 @@
     F(0xe7bc, VGFMA,   VRR_d, V,   0, 0, 0, 0, vgfma, 0, IF_VEC)
 /* VECTOR LOAD COMPLEMENT */
     F(0xe7de, VLC,     VRR_a, V,   0, 0, 0, 0, vlc, 0, IF_VEC)
+/* VECTOR LOAD POSITIVE */
+    F(0xe7df, VLP,     VRR_a, V,   0, 0, 0, 0, vlp, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index b3d7f3c667..91854ab4a4 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1534,3 +1534,43 @@ static DisasJumpType op_vlc(DisasContext *s, Disas=
Ops *o)
                   get_field(s->fields, v2));
     return DISAS_NEXT;
 }
+
+static void gen_lp_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    TCGv_i32 zero =3D tcg_const_i32(0);
+    TCGv_i32 neg =3D tcg_temp_new_i32();
+
+    tcg_gen_neg_i32(neg, a);
+    tcg_gen_movcond_i32(TCG_COND_LT, d, a, zero, neg, a);
+    tcg_temp_free_i32(neg);
+    tcg_temp_free_i32(zero);
+}
+
+static void gen_lp_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    TCGv_i64 zero =3D tcg_const_i64(0);
+    TCGv_i64 neg =3D tcg_temp_new_i64();
+
+    tcg_gen_neg_i64(neg, a);
+    tcg_gen_movcond_i64(TCG_COND_LT, d, a, zero, neg, a);
+    tcg_temp_free_i64(neg);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vlp(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+    static const GVecGen2 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vlp8, },
+        { .fno =3D gen_helper_gvec_vlp16, },
+        { .fni4 =3D gen_lp_i32, },
+        { .fni8 =3D gen_lp_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 20a1034dd8..b5d538ffcf 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -241,3 +241,17 @@ void HELPER(gvec_vgfma64)(void *v1, const void *v2, =
const void *v3,
     s390_vec_xor(&tmp1, &tmp1, &tmp2);
     s390_vec_xor(v1, &tmp1, v4);
 }
+
+#define DEF_VLP(BITS)                                                   =
       \
+void HELPER(gvec_vlp##BITS)(void *v1, const void *v2, uint32_t desc)    =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const int##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);   =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a < 0 ? -a : a);            =
       \
+    }                                                                   =
       \
+}
+DEF_VLP(8)
+DEF_VLP(16)
--=20
2.20.1
