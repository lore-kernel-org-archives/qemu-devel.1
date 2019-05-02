Received: from eggs.gnu.org ([209.51.188.92]:39013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQw-0000Yw-C2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQv-0007QE-Aj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:09 +0200
Message-Id: <20190502141019.6385-31-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 30/40] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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

Inline expansion courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2621e433cd..76aec5a21f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1164,6 +1164,8 @@
     F(0xe774, VSL,     VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
 /* VECTOR SHIFT LEFT BY BYTE */
     F(0xe775, VSLB,    VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
+/* VECTOR SHIFT LEFT DOUBLE BY BYTE */
+    F(0xe777, VSLDB,   VRI_d, V,   0, 0, 0, 0, vsldb, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index a776b469d3..fd9c5a46e0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2056,3 +2056,32 @@ static DisasJumpType op_vsl(DisasContext *s, Disas=
Ops *o)
     tcg_temp_free_i64(shift);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
+{
+    const uint8_t i4 =3D get_field(s->fields, i4) & 0xf;
+    const int left_shift =3D (i4 & 7) * 8;
+    const int right_shift =3D 64 - left_shift;
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+
+    if ((i4 & 8) =3D=3D 0) {
+        read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
+        read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
+        read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
+    } else {
+        read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
+        read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
+        read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
+    }
+    tcg_gen_extract2_i64(t0, t1, t0, right_shift);
+    tcg_gen_extract2_i64(t1, t2, t1, right_shift);
+    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    return DISAS_NEXT;
+}
--=20
2.20.1
