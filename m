Received: from eggs.gnu.org ([209.51.188.92]:48040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6I-0005UC-Vm
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6G-0007Xr-JP
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:15 +0100
Message-Id: <20190226113915.20150-34-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 33/33] s390x/tcg: Implement VECTOR UNPACK *
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

Combine all variant in a single handler. As source and destination
have different element sizes, we can't use gvec expansion. Expand
manually. Also watch out for overlapping source and destination and
use a temporary register in that case.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  8 +++++++
 target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 5d4d2ecc7e..2c49c63c59 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1046,6 +1046,14 @@
     F(0xe73e, VSTM,    VRS_a, V,   la2, 0, 0, 0, vstm, 0, IF_VEC)
 /* VECTOR STORE WITH LENGTH */
     F(0xe73f, VSTL,    VRS_b, V,   la2, r3_32u, 0, 0, vstl, 0, IF_VEC)
+/* VECTOR UNPACK HIGH */
+    F(0xe7d7, VUPH,    VRR_a, V,   0, 0, 0, 0, vup, 0, IF_VEC)
+/* VECTOR UNPACK LOGICAL HIGH */
+    F(0xe7d5, VUPLH,   VRR_a, V,   0, 0, 0, 0, vup, 0, IF_VEC)
+/* VECTOR UNPACK LOW */
+    F(0xe7d6, VUPL,    VRR_a, V,   0, 0, 0, 0, vup, 0, IF_VEC)
+/* VECTOR UNPACK LOGICAL LOW */
+    F(0xe7d4, VUPLL,   VRR_a, V,   0, 0, 0, 0, vup, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index d87f5bafcf..fde8b06953 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -842,3 +842,44 @@ static DisasJumpType op_vstl(DisasContext *s, DisasOps *o)
     tcg_temp_free_ptr(a0);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vup(DisasContext *s, DisasOps *o)
+{
+    const bool high = s->fields->op2 == 0xd7 || s->fields->op2 == 0xd5;
+    const bool logical = s->fields->op2 == 0xd4 || s->fields->op2 == 0xd5;
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v2 = get_field(s->fields, v2);
+    const uint8_t src_es = get_field(s->fields, m3);
+    const uint8_t dst_es = src_es + 1;
+    uint8_t dst_v = v1;
+    int dst_idx, src_idx;
+    TCGv_i64 tmp;
+
+    if (src_es > MO_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* Source and destination overlap -> use a temporary register */
+    if (v1 == v2) {
+        dst_v = TMP_VREG_0;
+    }
+
+    tmp = tcg_temp_new_i64();
+    for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(dst_es); dst_idx++) {
+        src_idx = dst_idx;
+        if (!high) {
+            src_idx += NUM_VEC_ELEMENTS(src_es) / 2;
+        }
+        read_vec_element_i64(tmp, v2, src_idx,
+                             src_es | (logical ? 0 : MO_SIGN));
+        write_vec_element_i64(tmp, dst_v, dst_idx, dst_es);
+    }
+    tcg_temp_free_i64(tmp);
+
+    /* move the temporary to the destination */
+    if (dst_v != v1) {
+        gen_gvec_mov(v1, dst_v);
+    }
+    return DISAS_NEXT;
+}
-- 
2.17.2
