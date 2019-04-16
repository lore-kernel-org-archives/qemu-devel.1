Received: from eggs.gnu.org ([209.51.188.92]:55397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTE2-0005kg-HG
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTE1-0006Ps-Hl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 16 Apr 2019 20:52:59 +0200
Message-Id: <20190416185301.25344-40-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 39/41] s390x/tcg: Implement VECTOR SUM
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
index 1c781bcd68..82ab42d2d9 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2334,3 +2334,35 @@ static DisasJumpType op_vsumg(DisasContext *s, Dis=
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
