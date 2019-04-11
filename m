Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWs9-0002Xe-QY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWey-0007oC-Nw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:35 +0200
Message-Id: <20190411100836.646-41-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 40/41] s390x/tcg: Implement VECTOR SUM
 ACROSS WORD
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

Similar to VECTOR SUM ACROSS DOUBLEWORD.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2483ee01d7..a52db41388 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1186,6 +1186,8 @@
     F(0xe765, VSUMG,   VRR_c, V,   0, 0, 0, 0, vsumg, 0, IF_VEC)
 /* VECTOR SUM ACROSS QUADWORD */
     F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
+/* VECTOR SUM ACROSS WORD */
+    F(0xe764, VSUM,    VRR_c, V,   0, 0, 0, 0, vsum, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 995c2b4461..59a9885892 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2286,3 +2286,32 @@ static DisasJumpType op_vsumq(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free_i64(tmpl);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsum(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    TCGv_i32 sum, tmp;
+    uint8_t dst_idx;
+
+    if (es > ES_16) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    sum =3D tcg_temp_new_i32();
+    tmp =3D tcg_temp_new_i32();
+    for (dst_idx =3D 0; dst_idx < 4; dst_idx++) {
+        uint8_t idx =3D dst_idx * NUM_VEC_ELEMENTS(es) / 4;
+        const uint8_t max_idx =3D idx + NUM_VEC_ELEMENTS(es) / 4 - 1;
+
+        read_vec_element_i32(sum, get_field(s->fields, v3), max_idx, es)=
;
+        for (; idx <=3D max_idx; idx++) {
+            read_vec_element_i32(tmp, get_field(s->fields, v2), idx, es)=
;
+            tcg_gen_add_i32(sum, sum, tmp);
+        }
+        write_vec_element_i32(sum, get_field(s->fields, v1), dst_idx, ES=
_32);
+    }
+    tcg_temp_free_i32(sum);
+    tcg_temp_free_i32(tmp);
+    return DISAS_NEXT;
+}
--=20
2.20.1
