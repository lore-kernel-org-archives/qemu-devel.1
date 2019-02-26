Received: from eggs.gnu.org ([209.51.188.92]:47632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5i-0004q4-Lm
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5h-000763-Ho
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:06 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:01 +0100
Message-Id: <20190226113915.20150-20-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 19/33] s390x/tcg: Implement VECTOR MERGE
 (HIGH|LOW)
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

We cannot use gvec expansion as source and destination elements are
have different element numbers. So we'll expand using a fancy loop.
Also, we have to take care of overlapping source and target registers and
use a temporary register in case they do.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  4 +++
 target/s390x/translate_vx.inc.c | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2a9ac9cebc..51003cf917 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1010,6 +1010,10 @@
     F(0xe762, VLVGP,   VRR_f, V,   r2, r3, 0, 0, vlvgp, 0, IF_VEC)
 /* VECTOR LOAD WITH LENGTH */
     F(0xe737, VLL,     VRS_b, V,   la2, r3_32u, 0, 0, vll, 0, IF_VEC)
+/* VECTOR MERGE HIGH */
+    F(0xe761, VMRH,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
+/* VECTOR MERGE LOW */
+    F(0xe760, VMRL,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 37f312fbb4..64a5ee55ca 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -481,3 +481,46 @@ static DisasJumpType op_vll(DisasContext *s, DisasOps *o)
     tcg_temp_free_ptr(a0);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vmr(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v2 = get_field(s->fields, v2);
+    const uint8_t v3 = get_field(s->fields, v3);
+    const uint8_t es = get_field(s->fields, m4);
+    const bool high = s->fields->op2 == 0x61;
+    int dst_idx, src_idx;
+    uint8_t dst_v = v1;
+    TCGv_i64 tmp;
+
+    if (es > MO_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* Source and destination overlap -> use a temporary register */
+    if (v1 == v2 || v1 == v3) {
+        dst_v = TMP_VREG_0;
+    }
+
+    tmp = tcg_temp_new_i64();
+    for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(es); dst_idx++) {
+        src_idx = dst_idx / 2;
+        if (!high) {
+            src_idx += NUM_VEC_ELEMENTS(es) / 2;
+        }
+        if (dst_idx % 2 == 0) {
+            read_vec_element_i64(tmp, v2, src_idx, es);
+        } else {
+            read_vec_element_i64(tmp, v3, src_idx, es);
+        }
+        write_vec_element_i64(tmp, dst_v, dst_idx, es);
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
