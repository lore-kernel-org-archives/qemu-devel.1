Received: from eggs.gnu.org ([209.51.188.92]:39199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRD-0001IE-SG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRC-0007c7-V4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:51 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:16 +0200
Message-Id: <20190502141019.6385-38-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 37/40] s390x/tcg: Implement VECTOR SUM
 ACROSS DOUBLEWORD
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

Perform the calculations without a helper. Only 16 bit or 32 bit values
have to be added.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a8d90517f6..dd37003082 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1182,6 +1182,8 @@
     F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
 /* VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION */
     F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
+/* VECTOR SUM ACROSS DOUBLEWORD */
+    F(0xe765, VSUMG,   VRR_c, V,   0, 0, 0, 0, vsumg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index b0b4d3640e..5e948ecff1 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2248,3 +2248,32 @@ static DisasJumpType op_vsbcbi(DisasContext *s, Di=
sasOps *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsumg(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    TCGv_i64 sum, tmp;
+    uint8_t dst_idx;
+
+    if (es =3D=3D ES_8 || es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    sum =3D tcg_temp_new_i64();
+    tmp =3D tcg_temp_new_i64();
+    for (dst_idx =3D 0; dst_idx < 2; dst_idx++) {
+        uint8_t idx =3D dst_idx * NUM_VEC_ELEMENTS(es) / 2;
+        const uint8_t max_idx =3D idx + NUM_VEC_ELEMENTS(es) / 2 - 1;
+
+        read_vec_element_i64(sum, get_field(s->fields, v3), max_idx, es)=
;
+        for (; idx <=3D max_idx; idx++) {
+            read_vec_element_i64(tmp, get_field(s->fields, v2), idx, es)=
;
+            tcg_gen_add_i64(sum, sum, tmp);
+        }
+        write_vec_element_i64(sum, get_field(s->fields, v1), dst_idx, ES=
_64);
+    }
+    tcg_temp_free_i64(sum);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
--=20
2.20.1
