Received: from eggs.gnu.org ([209.51.188.92]:42037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rx0-0004mX-Ig
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwz-0000O4-R9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:38 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:36 +0100
Message-Id: <20190307121539.12842-30-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 29/32] s390x/tcg: Implement VECTOR STORE
 ELEMENT
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

As we only store one element, there is nothing to consider regarding
exceptions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  5 +++++
 target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 4525d5b145..ff5b9e7302 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1036,6 +1036,11 @@
     F(0xe75f, VSEG,    VRR_a, V,   0, 0, 0, 0, vseg, 0, IF_VEC)
 /* VECTOR STORE */
     F(0xe70e, VST,     VRX,   V,   la2, 0, 0, 0, vst, 0, IF_VEC)
+/* VECTOR STORE ELEMENT */
+    E(0xe708, VSTEB,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_8, IF_VEC)
+    E(0xe709, VSTEH,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_16, IF_VEC)
+    E(0xe70b, VSTEF,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_32, IF_VEC)
+    E(0xe70a, VSTEG,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_64, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index fcddd0cde7..ecc295da5b 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -834,3 +834,21 @@ static DisasJumpType op_vst(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vste(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = s->insn->data;
+    const uint8_t enr = get_field(s->fields, m3);
+    TCGv_i64 tmp;
+
+    if (!valid_vec_element(enr, es)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
