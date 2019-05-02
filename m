Received: from eggs.gnu.org ([209.51.188.92]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQy-0000dW-8P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQx-0007Rd-6l
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:36 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:10 +0200
Message-Id: <20190502141019.6385-32-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 31/40] s390x/tcg: Implement VECTOR SHIFT
 RIGHT ARITHMETIC
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

Similar to VECTOR SHIFT LEFT ARITHMETIC. Add s390_vec_sar() similar to
s390_vec_shr().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
 target/s390x/vec_int_helper.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index b4ddc8a722..fda274d325 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -205,6 +205,7 @@ DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_verim8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 76aec5a21f..587de3eaac 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1166,6 +1166,10 @@
     F(0xe775, VSLB,    VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
 /* VECTOR SHIFT LEFT DOUBLE BY BYTE */
     F(0xe777, VSLDB,   VRI_d, V,   0, 0, 0, 0, vsldb, 0, IF_VEC)
+/* VECTOR SHIFT RIGHT ARITHMETIC */
+    F(0xe77e, VSRA,    VRR_c, V,   0, 0, 0, 0, vsra, 0, IF_VEC)
+/* VECTOR SHIFT RIGHT ARITHMETIC BY BYTE */
+    F(0xe77f, VSRAB,   VRR_c, V,   0, 0, 0, 0, vsra, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index fd9c5a46e0..a54682987a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2085,3 +2085,20 @@ static DisasJumpType op_vsldb(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free(t2);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsra(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 shift =3D tcg_temp_new_i64();
+
+    read_vec_element_i64(shift, get_field(s->fields, v3), 7, ES_8);
+    if (s->fields->op2 =3D=3D 0x7e) {
+        tcg_gen_andi_i64(shift, shift, 0x7);
+    } else {
+        tcg_gen_andi_i64(shift, shift, 0x78);
+    }
+
+    gen_gvec_2i_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                    shift, 0, gen_helper_gvec_vsra);
+    tcg_temp_free_i64(shift);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 3df069f033..67e9f2b0ed 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -49,6 +49,26 @@ static void s390_vec_shl(S390Vector *d, const S390Vect=
or *a, uint64_t count)
     }
 }
=20
+static void s390_vec_sar(S390Vector *d, const S390Vector *a, uint64_t co=
unt)
+{
+    uint64_t tmp;
+
+    if (count =3D=3D 0) {
+        d->doubleword[0] =3D a->doubleword[0];
+        d->doubleword[1] =3D a->doubleword[1];
+    } else if (count =3D=3D 64) {
+        d->doubleword[1] =3D a->doubleword[0];
+        d->doubleword[0] =3D 0;
+    } else if (count < 64) {
+        tmp =3D a->doubleword[1] >> count;
+        d->doubleword[1] =3D deposit64(tmp, 64 - count, count, a->double=
word[0]);
+        d->doubleword[0] =3D (int64_t)a->doubleword[0] >> count;
+    } else {
+        d->doubleword[1] =3D (int64_t)a->doubleword[0] >> (count - 64);
+        d->doubleword[0] =3D 0;
+    }
+}
+
 static void s390_vec_shr(S390Vector *d, const S390Vector *a, uint64_t co=
unt)
 {
     uint64_t tmp;
@@ -535,3 +555,9 @@ void HELPER(gvec_vsl)(void *v1, const void *v2, uint6=
4_t count,
 {
     s390_vec_shl(v1, v2, count);
 }
+
+void HELPER(gvec_vsra)(void *v1, const void *v2, uint64_t count,
+                       uint32_t desc)
+{
+    s390_vec_sar(v1, v2, count);
+}
--=20
2.20.1
