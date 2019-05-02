Received: from eggs.gnu.org ([209.51.188.92]:39232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRF-0001K4-LK
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRE-0007d9-Ki
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:53 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:17 +0200
Message-Id: <20190502141019.6385-39-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 38/40] s390x/tcg: Implement VECTOR SUM
 ACROSS QUADWORD
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

Similar to VECTOR SUM ACROSS DOUBLEWORD, however without a loop and
using 128-bit calculations.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index dd37003082..2483ee01d7 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1184,6 +1184,8 @@
     F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
 /* VECTOR SUM ACROSS DOUBLEWORD */
     F(0xe765, VSUMG,   VRR_c, V,   0, 0, 0, 0, vsumg, 0, IF_VEC)
+/* VECTOR SUM ACROSS QUADWORD */
+    F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 5e948ecff1..c77c224d5d 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2277,3 +2277,35 @@ static DisasJumpType op_vsumg(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsumq(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t max_idx =3D NUM_VEC_ELEMENTS(es) - 1;
+    TCGv_i64 sumh, suml, zero, tmpl;
+    uint8_t idx;
+
+    if (es < ES_32 || es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    sumh =3D tcg_const_i64(0);
+    suml =3D tcg_temp_new_i64();
+    zero =3D tcg_const_i64(0);
+    tmpl =3D tcg_temp_new_i64();
+
+    read_vec_element_i64(suml, get_field(s->fields, v3), max_idx, es);
+    for (idx =3D 0; idx <=3D max_idx; idx++) {
+        read_vec_element_i64(tmpl, get_field(s->fields, v2), idx, es);
+        tcg_gen_add2_i64(suml, sumh, suml, sumh, tmpl, zero);
+    }
+    write_vec_element_i64(sumh, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(suml, get_field(s->fields, v1), 1, ES_64);
+
+    tcg_temp_free_i64(sumh);
+    tcg_temp_free_i64(suml);
+    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(tmpl);
+    return DISAS_NEXT;
+}
--=20
2.20.1
