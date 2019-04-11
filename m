Received: from eggs.gnu.org ([209.51.188.92]:54895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsc-00039p-7d
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdi-0007DU-Ub
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:05 +0200
Message-Id: <20190411100836.646-11-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 10/41] s390x/tcg: Implement VECTOR ELEMENT
 COMPARE *
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

Fairly easy to implement, we can make use of the existing CC helpers
cmps64 and cmpu64 - we siply have to sign extend the elements.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 64459465c5..52e398f515 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1074,6 +1074,10 @@
     F(0xe7f0, VAVGL,   VRR_c, V,   0, 0, 0, 0, vavgl, 0, IF_VEC)
 /* VECTOR CHECKSUM */
     F(0xe766, VCKSM,   VRR_c, V,   0, 0, 0, 0, vcksm, 0, IF_VEC)
+/* VECTOR ELEMENT COMPARE */
+    F(0xe7db, VEC,     VRR_a, V,   0, 0, 0, 0, vec, cmps64, IF_VEC)
+/* VECTOR ELEMENT COMPARE LOGICAL */
+    F(0xe7d9, VECL,    VRR_a, V,   0, 0, 0, 0, vec, cmpu64, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7a7e185d43..c7462d1bb1 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1327,3 +1327,23 @@ static DisasJumpType op_vcksm(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free_i32(sum);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vec(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+    const uint8_t enr =3D NUM_VEC_ELEMENTS(es) / 2 - 1;
+    const bool logical =3D s->fields->op2 =3D=3D 0xd9;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    o->in1 =3D tcg_temp_new_i64();
+    o->in2 =3D tcg_temp_new_i64();
+    read_vec_element_i64(o->in1, get_field(s->fields, v1), enr,
+                         es | logical ? 0 : MO_SIGN);
+    read_vec_element_i64(o->in2, get_field(s->fields, v2), enr,
+                         es | logical ? 0 : MO_SIGN);
+    return DISAS_NEXT;
+}
--=20
2.20.1
