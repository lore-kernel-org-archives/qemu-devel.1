Received: from eggs.gnu.org ([209.51.188.92]:44267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GtC-00059r-3P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GtB-0007jq-1o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:06:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:22 +0100
Message-Id: <20190311090322.21603-34-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 33/33] s390x/tcg: Implement VECTOR UNPACK *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Combine all variant in a single handler. As source and destination
have different element sizes, we can't use gvec expansion. Expand
manually. Also watch out for overlapping source and destination
registers. Use a safe evaluation order depending on the operation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-33-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  8 +++++++
 target/s390x/translate_vx.inc.c | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 00ba9444a3b3..71fa9b8d6c53 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1045,6 +1045,14 @@
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
index fcdda0c59147..76f9a5d939c2 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -895,3 +895,41 @@ static DisasJumpType op_vstl(DisasContext *s, DisasOps *o)
     tcg_temp_free_ptr(a0);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vup(DisasContext *s, DisasOps *o)
+{
+    const bool logical = s->fields->op2 == 0xd4 || s->fields->op2 == 0xd5;
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v2 = get_field(s->fields, v2);
+    const uint8_t src_es = get_field(s->fields, m3);
+    const uint8_t dst_es = src_es + 1;
+    int dst_idx, src_idx;
+    TCGv_i64 tmp;
+
+    if (src_es > ES_32) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    if (s->fields->op2 == 0xd7 || s->fields->op2 == 0xd5) {
+        /* iterate backwards to avoid overwriting data we might need later */
+        for (dst_idx = NUM_VEC_ELEMENTS(dst_es) - 1; dst_idx >= 0; dst_idx--) {
+            src_idx = dst_idx;
+            read_vec_element_i64(tmp, v2, src_idx,
+                                 src_es | (logical ? 0 : MO_SIGN));
+            write_vec_element_i64(tmp, v1, dst_idx, dst_es);
+        }
+
+    } else {
+        /* iterate forward to avoid overwriting data we might need later */
+        for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(dst_es); dst_idx++) {
+            src_idx = dst_idx + NUM_VEC_ELEMENTS(src_es) / 2;
+            read_vec_element_i64(tmp, v2, src_idx,
+                                 src_es | (logical ? 0 : MO_SIGN));
+            write_vec_element_i64(tmp, v1, dst_idx, dst_es);
+        }
+    }
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
