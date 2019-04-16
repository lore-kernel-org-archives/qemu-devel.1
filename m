Received: from eggs.gnu.org ([209.51.188.92]:55287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDv-0005cg-O5
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDu-0006FQ-HU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 16 Apr 2019 20:52:55 +0200
Message-Id: <20190416185301.25344-36-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 35/41] s390x/tcg: Implement VECTOR SUBTRACT
 COMPUTE BORROW INDICATION
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

Let's keep it simple for now and handle 8/16 bit elements via helpers.
Especially for 8/16, we could come up with some bit tricks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 16 ++++++++++
 4 files changed, 72 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e6d86736e2..431e0a8084 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -227,6 +227,8 @@ DEF_HELPER_FLAGS_4(gvec_vesrl16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
 DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
+DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 58a61f41ef..94de3c9c7d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1176,6 +1176,8 @@
     F(0xe77d, VSRLB,   VRR_c, V,   0, 0, 0, 0, vsrl, 0, IF_VEC)
 /* VECTOR SUBTRACT */
     F(0xe7f7, VS,      VRR_c, V,   0, 0, 0, 0, vs, 0, IF_VEC)
+/* VECTOR SUBTRACT COMPUTE BORROW INDICATION */
+    F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 2df03baf07..8e51b6e607 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2193,3 +2193,55 @@ static DisasJumpType op_vs(DisasContext *s, DisasO=
ps *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static void gen_scbi_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_setcond_i32(TCG_COND_LTU, d, a, b);
+}
+
+static void gen_scbi_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_setcond_i64(TCG_COND_LTU, d, a, b);
+}
+
+static void gen_scbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al,
+                          TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
+{
+    TCGv_i64 th =3D tcg_temp_new_i64();
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 zero =3D tcg_const_i64(0);
+
+    tcg_gen_sub2_i64(tl, th, al, zero, bl, zero);
+    tcg_gen_andi_i64(th, th, 1);
+    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
+    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
+    tcg_gen_andi_i64(dl, th, 1);
+    tcg_gen_mov_i64(dh, zero);
+
+    tcg_temp_free_i64(th);
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vscbi(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vscbi8, },
+        { .fno =3D gen_helper_gvec_vscbi16, },
+        { .fni4 =3D gen_scbi_i32, },
+        { .fni8 =3D gen_scbi_i64, },
+    };
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    } else if (es =3D=3D ES_128) {
+        gen_gvec128_3_i64(gen_scbi2_i64, get_field(s->fields, v1),
+                          get_field(s->fields, v2), get_field(s->fields,=
 v3));
+        return DISAS_NEXT;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 04ee2be4f9..5b007adc26 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -680,3 +680,19 @@ void HELPER(gvec_vsrl)(void *v1, const void *v2, uin=
t64_t count,
 {
     s390_vec_shr(v1, v2, count);
 }
+
+#define DEF_VSCBI(BITS)                                                 =
       \
+void HELPER(gvec_vscbi##BITS)(void *v1, const void *v2, const void *v3, =
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
+        const uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a < b);                     =
       \
+    }                                                                   =
       \
+}
+DEF_VSCBI(8)
+DEF_VSCBI(16)
--=20
2.20.1
