Received: from eggs.gnu.org ([209.51.188.92]:43545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Grk-0003uh-RN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Grj-0006HC-Ss
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:00 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:08 +0100
Message-Id: <20190311090322.21603-20-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 19/33] s390x/tcg: Implement VECTOR MERGE
 (HIGH|LOW)
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

We cannot use gvec expansion as source and destination elements are
have different element numbers. So we'll expand using a fancy loop.
Also, we have to take care of overlapping source and destination
registers, therefore use a safe evaluation irder depending on the
operation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-19-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 42 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 3c0b14bafd88..f7232f861575 100644
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
index b8e69856cdf3..9c2cf8a77b8f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -532,3 +532,45 @@ static DisasJumpType op_vll(DisasContext *s, DisasOps *o)
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
+    int dst_idx, src_idx;
+    TCGv_i64 tmp;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    if (s->fields->op2 == 0x61) {
+        /* iterate backwards to avoid overwriting data we might need later */
+        for (dst_idx = NUM_VEC_ELEMENTS(es) - 1; dst_idx >= 0; dst_idx--) {
+            src_idx = dst_idx / 2;
+            if (dst_idx % 2 == 0) {
+                read_vec_element_i64(tmp, v2, src_idx, es);
+            } else {
+                read_vec_element_i64(tmp, v3, src_idx, es);
+            }
+            write_vec_element_i64(tmp, v1, dst_idx, es);
+        }
+    } else {
+        /* iterate forward to avoid overwriting data we might need later */
+        for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(es); dst_idx++) {
+            src_idx = (dst_idx + NUM_VEC_ELEMENTS(es)) / 2;
+            if (dst_idx % 2 == 0) {
+                read_vec_element_i64(tmp, v2, src_idx, es);
+            } else {
+                read_vec_element_i64(tmp, v3, src_idx, es);
+            }
+            write_vec_element_i64(tmp, v1, dst_idx, es);
+        }
+    }
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
