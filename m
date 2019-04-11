Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsB-0002Xe-T0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWek-0007hl-0j
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:07 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:32 +0200
Message-Id: <20190411100836.646-38-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 37/41] s390x/tcg: Implement VECTOR SUBTRACT
 WITH BORROW COMPUTE BORROW INDICATION
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

Reuse s390_vec_sub() to perform two 128-bit subtraction, calculating the
borrow.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 target/s390x/vec_int_helper.c   | 16 ++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 33e3e003f8..d040e4cd07 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -233,6 +233,7 @@ DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, =
ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_5(gvec_vsbcbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cpt=
r, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a60d8531dc..a8d90517f6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1180,6 +1180,8 @@
     F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
 /* VECTOR SUBTRACT WITH BORROW INDICATION */
     F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
+/* VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION */
+    F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 3f60b97654..fd232ba6c3 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2212,3 +2212,16 @@ static DisasJumpType op_vsbi(DisasContext *s, Disa=
sOps *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), get_field(s->fields, v4), 0=
,
+                   gen_helper_gvec_vsbcbi128);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 699b399a26..95686e79fd 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -803,3 +803,19 @@ void HELPER(gvec_vscbi128)(void *v1, const void *v2,=
 const void *v3,
     dst->doubleword[0] =3D 0;
     dst->doubleword[1] =3D s390_vec_sub(&tmp, v2, v3);
 }
+
+void HELPER(gvec_vsbcbi128)(void *v1, const void *v2, const void *v3,
+                            const void *v4, uint32_t desc)
+{
+    const S390Vector old_borrow =3D {
+        .doubleword[0] =3D 0,
+        .doubleword[1] =3D ((S390Vector *)v4)->doubleword[1] & 1,
+    };
+    S390Vector tmp, *dst =3D v1;
+    bool borrow;
+
+    borrow =3D s390_vec_sub(&tmp, v2, v3);
+    borrow |=3D s390_vec_sub(&tmp, &tmp, &old_borrow);
+    dst->doubleword[0] =3D 0;
+    dst->doubleword[1] =3D borrow;
+}
--=20
2.20.1
