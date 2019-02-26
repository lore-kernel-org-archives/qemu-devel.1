Received: from eggs.gnu.org ([209.51.188.92]:47270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5M-0004VH-2T
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5J-0006nb-H9
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:43 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:49 +0100
Message-Id: <20190226113915.20150-8-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 07/33] s390x/tcg: Implement VECTOR GENERATE
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

This is the first instruction that uses gvec expansion for duplicating
elements. We will use makros for most gvec calls to simplify translating
vector numbers into offsets (and to not have to worry about oprsz and
maxsz).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate.c        |  1 +
 target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 1bdfcf8130..a3a0df7788 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -979,6 +979,8 @@
     E(0xe712, VGEG,    VRV,   V,   la2, 0, 0, 0, vge, 0, MO_64, IF_VEC)
 /* VECTOR GENERATE BYTE MASK */
     F(0xe744, VGBM,    VRI_a, V,   0, 0, 0, 0, vgbm, 0, IF_VEC)
+/* VECTOR GENERATE MASK */
+    F(0xe746, VGM,     VRI_b, V,   0, 0, 0, 0, vgm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 3935bc8bb7..56c146f91e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -34,6 +34,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 7775401dd3..ed63b2ca22 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -43,6 +43,7 @@
 
 #define NUM_VEC_ELEMENT_BYTES(es) (1 << (es))
 #define NUM_VEC_ELEMENTS(es) (16 / NUM_VEC_ELEMENT_BYTES(es))
+#define NUM_VEC_ELEMENT_BITS(es) (NUM_VEC_ELEMENT_BYTES(es) * BITS_PER_BYTE)
 
 static inline bool valid_vec_element(uint8_t enr, TCGMemOp es)
 {
@@ -136,6 +137,9 @@ static void load_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
     tcg_temp_free_i64(tmp);
 }
 
+#define gen_gvec_dup_i64(es, v1, c) \
+    tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
+
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es = s->insn->data;
@@ -175,3 +179,33 @@ static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
     tcg_temp_free_i32(zeroes);
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
+    TCGv_i64 tmp;
+    int i;
+
+    if (es > MO_64) {
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
+    tmp = tcg_temp_new_i64();
+    tcg_gen_movi_i64(tmp, mask);
+    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
