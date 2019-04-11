Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsh-0002dl-U2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdX-00079O-Vm
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:08:53 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:00 +0200
Message-Id: <20190411100836.646-6-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 05/41] s390x/tcg: Implement VECTOR ADD WITH
 CARRY COMPUTE CARRY
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

Again, use a helper as calculating the carry is even more involved than
for VECTOR ADD COMPUTE CARRY.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 target/s390x/vec_int_helper.c   | 16 ++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 2c1b223248..e1847e8877 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -147,6 +147,7 @@ DEF_HELPER_FLAGS_4(vstl, TCG_CALL_NO_WG, void, env, c=
ptr, i64, i64)
=20
 /* =3D=3D=3D Vector Integer Instructions =3D=3D=3D */
 DEF_HELPER_FLAGS_4(gvec_vacc128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_5(gvec_vaccc128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 38d1e22a6d..a531b21908 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1062,6 +1062,8 @@
     F(0xe7f1, VACC,    VRR_c, V,   0, 0, 0, 0, vacc, 0, IF_VEC)
 /* VECTOR ADD WITH CARRY */
     F(0xe7bb, VAC,     VRR_d, V,   0, 0, 0, 0, vac, 0, IF_VEC)
+/* VECTOR ADD WITH CARRY COMPUTE CARRY */
+    F(0xe7b9, VACCC,   VRR_d, V,   0, 0, 0, 0, vaccc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 111b0b7c69..a264aa0c5a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1122,3 +1122,16 @@ static DisasJumpType op_vac(DisasContext *s, Disas=
Ops *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vaccc(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), get_field(s->fields, v4), 0=
,
+                   gen_helper_gvec_vaccc128);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 0b232571bc..97fc559da0 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -45,3 +45,19 @@ void HELPER(gvec_vacc128)(void *v1, const void *v2, co=
nst void *v3,
     dst->doubleword[0] =3D 0;
     dst->doubleword[1] =3D s390_vec_add(&tmp, v2, v3);
 }
+
+void HELPER(gvec_vaccc128)(void *v1, const void *v2, const void *v3,
+                           const void *v4, uint32_t desc)
+{
+    const S390Vector old_carry =3D {
+        .doubleword[0] =3D 0,
+        .doubleword[1] =3D ((S390Vector *)v4)->doubleword[1] & 1,
+    };
+    S390Vector tmp, *dst =3D v1;
+    bool carry;
+
+    carry =3D s390_vec_add(&tmp, v2, v3);
+    carry |=3D s390_vec_add(&tmp, &tmp, &old_carry);
+    dst->doubleword[0] =3D 0;
+    dst->doubleword[1] =3D carry;
+}
--=20
2.20.1
