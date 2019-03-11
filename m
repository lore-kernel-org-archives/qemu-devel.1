Received: from eggs.gnu.org ([209.51.188.92]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqj-00030L-8X
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqi-0005OI-8P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:57 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:55 +0100
Message-Id: <20190311090322.21603-7-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/33] s390x/tcg: Implement VECTOR GENERATE BYTE
 MASK
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

Let's optimize it for the common cases (setting a vector to zero or all
ones) - courtesy of Richard.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-6-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate.c        |  1 +
 target/s390x/translate_vx.inc.c | 39 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7d128ac9d61d..d3f66c858f32 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -977,6 +977,8 @@
 /* VECTOR GATHER ELEMENT */
     E(0xe713, VGEF,    VRV,   V,   la2, 0, 0, 0, vge, 0, ES_32, IF_VEC)
     E(0xe712, VGEG,    VRV,   V,   la2, 0, 0, 0, vge, 0, ES_64, IF_VEC)
+/* VECTOR GENERATE BYTE MASK */
+    F(0xe744, VGBM,    VRI_a, V,   0, 0, 0, 0, vgbm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a1c6698dea9c..588fc21dd2a7 100644
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
index 9864ec5134de..395c0ebcc2a8 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -112,6 +112,9 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
     }
 }
 
+#define gen_gvec_dup64i(v1, c) \
+    tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
+
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es = s->insn->data;
@@ -133,3 +136,39 @@ static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static uint64_t generate_byte_mask(uint8_t mask)
+{
+    uint64_t r = 0;
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        if ((mask >> i) & 1) {
+            r |= 0xffull << (i * 8);
+        }
+    }
+    return r;
+}
+
+static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
+{
+    const uint16_t i2 = get_field(s->fields, i2);
+
+    if (i2 == (i2 & 0xff) * 0x0101) {
+        /*
+         * Masks for both 64 bit elements of the vector are the same.
+         * Trust tcg to produce a good constant loading.
+         */
+        gen_gvec_dup64i(get_field(s->fields, v1),
+                        generate_byte_mask(i2 & 0xff));
+    } else {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        tcg_gen_movi_i64(t, generate_byte_mask(i2 >> 8));
+        write_vec_element_i64(t, get_field(s->fields, v1), 0, ES_64);
+        tcg_gen_movi_i64(t, generate_byte_mask(i2));
+        write_vec_element_i64(t, get_field(s->fields, v1), 1, ES_64);
+        tcg_temp_free_i64(t);
+    }
+    return DISAS_NEXT;
+}
-- 
2.17.2
