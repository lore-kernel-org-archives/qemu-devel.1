Received: from eggs.gnu.org ([209.51.188.92]:41503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwO-0004BC-Ji
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwJ-0007zs-1K
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:00 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:13 +0100
Message-Id: <20190307121539.12842-7-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/32] s390x/tcg: Implement VECTOR GENERATE
 MASK
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

Add gen_gvec_dupi() for handling duplication of immediates, so it can
be reused later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 47 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d3f66c858f..c8cd5dfa24 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -979,6 +979,8 @@
     E(0xe712, VGEG,    VRV,   V,   la2, 0, 0, 0, vge, 0, ES_64, IF_VEC)
 /* VECTOR GENERATE BYTE MASK */
     F(0xe744, VGBM,    VRI_a, V,   0, 0, 0, 0, vgbm, 0, IF_VEC)
+/* VECTOR GENERATE MASK */
+    F(0xe746, VGM,     VRI_b, V,   0, 0, 0, 0, vgm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 395c0ebcc2..28edd9b0c4 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -44,6 +44,7 @@
 
 #define NUM_VEC_ELEMENT_BYTES(es) (1 << (es))
 #define NUM_VEC_ELEMENTS(es) (16 / NUM_VEC_ELEMENT_BYTES(es))
+#define NUM_VEC_ELEMENT_BITS(es) (NUM_VEC_ELEMENT_BYTES(es) * BITS_PER_BYTE)
 
 #define ES_8    MO_8
 #define ES_16   MO_16
@@ -115,6 +116,26 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
 #define gen_gvec_dup64i(v1, c) \
     tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
 
+static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
+{
+    switch (es) {
+    case ES_8:
+        tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, c);
+        break;
+    case ES_16:
+        tcg_gen_gvec_dup16i(vec_full_reg_offset(reg), 16, 16, c);
+        break;
+    case ES_32:
+        tcg_gen_gvec_dup32i(vec_full_reg_offset(reg), 16, 16, c);
+        break;
+    case ES_64:
+        gen_gvec_dup64i(reg, c);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es = s->insn->data;
@@ -172,3 +193,29 @@ static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vgm(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m4);
+    const uint8_t bits = NUM_VEC_ELEMENT_BITS(es);
+    const uint8_t i2 = get_field(s->fields, i2) & (bits - 1);
+    const uint8_t i3 = get_field(s->fields, i3) & (bits - 1);
+    uint64_t mask = 0;
+    int i;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* generate the mask - take care of wrapping */
+    for (i = i2; ; i = (i + 1) % bits) {
+        mask |= 1ull << (bits - i - 1);
+        if (i == i3) {
+            break;
+        }
+    }
+
+    gen_gvec_dupi(es, get_field(s->fields, v1), mask);
+    return DISAS_NEXT;
+}
-- 
2.17.2
