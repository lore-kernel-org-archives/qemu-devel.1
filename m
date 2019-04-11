Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsD-0002dl-Cu
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWed-0007dN-BN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:00 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:30 +0200
Message-Id: <20190411100836.646-36-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 35/41] s390x/tcg: Implement VECTOR SUBTRACT
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

Let's keep it simple for now and handle 8/16/128 bit elements via helpers=
.
Especially for 8/16, we could come up with some bit tricks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  3 +++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 30 +++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 47 +++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index af7fb10f76..33e3e003f8 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -230,6 +230,9 @@ DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, p=
tr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vsldb, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
 DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
+DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vscbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
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
index 83463155f6..7770ca4101 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2155,3 +2155,33 @@ static DisasJumpType op_vs(DisasContext *s, DisasO=
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
+static DisasJumpType op_vscbi(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[5] =3D {
+        { .fno =3D gen_helper_gvec_vscbi8, },
+        { .fno =3D gen_helper_gvec_vscbi16, },
+        { .fni4 =3D gen_scbi_i32, },
+        { .fni8 =3D gen_scbi_i64, },
+        { .fno =3D gen_helper_gvec_vscbi128, },
+    };
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 12502b48e8..699b399a26 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -38,6 +38,27 @@ static bool s390_vec_add(S390Vector *d, const S390Vect=
or *a,
     return high_carry;
 }
=20
+/*
+ * Subtract two 128 bit vectors, returning the borrow.
+ */
+static bool s390_vec_sub(S390Vector *d, const S390Vector *a,
+                         const S390Vector *b)
+{
+    bool low_borrow =3D false, high_borrow =3D false;
+
+    if (a->doubleword[0] < b->doubleword[0]) {
+        high_borrow =3D true;
+    } else if (a->doubleword[1] < b->doubleword[0]) {
+        low_borrow =3D true;
+        if (a->doubleword[0] =3D=3D b->doubleword[0]) {
+            high_borrow =3D true;
+        }
+    }
+    d->doubleword[0] =3D a->doubleword[0] - b->doubleword[0] - low_borro=
w;
+    d->doubleword[1] =3D a->doubleword[1] - b->doubleword[1];
+    return high_borrow;
+}
+
 static bool s390_vec_is_zero(const S390Vector *v)
 {
     return !v->doubleword[0] && !v->doubleword[1];
@@ -756,3 +777,29 @@ void HELPER(gvec_vsrl)(void *v1, const void *v2, uin=
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
+
+void HELPER(gvec_vscbi128)(void *v1, const void *v2, const void *v3,
+                           uint32_t desc)
+{
+    S390Vector *dst =3D v1;
+    S390Vector tmp;
+
+    dst->doubleword[0] =3D 0;
+    dst->doubleword[1] =3D s390_vec_sub(&tmp, v2, v3);
+}
--=20
2.20.1
