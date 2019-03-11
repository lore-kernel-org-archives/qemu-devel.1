Received: from eggs.gnu.org ([209.51.188.92]:43937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsX-0004bq-PT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsT-0007CS-TK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:15 +0100
Message-Id: <20190311090322.21603-27-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 26/33] s390x/tcg: Implement VECTOR SELECT
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

Provide an implementation based on i64 and on real host vectors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-26-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 8d7c834e7d4a..ae58ff440b51 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1030,6 +1030,8 @@
 /* VECTOR SCATTER ELEMENT */
     E(0xe71b, VSCEF,   VRV,   V,   la2, 0, 0, 0, vsce, 0, ES_32, IF_VEC)
     E(0xe71a, VSCEG,   VRV,   V,   la2, 0, 0, 0, vsce, 0, ES_64, IF_VEC)
+/* VECTOR SELECT */
+    F(0xe78d, VSEL,    VRR_e, V,   0, 0, 0, 0, vsel, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index cd8c173b36eb..e685506b8c39 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -141,6 +141,10 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
 #define gen_gvec_3_ptr(v1, v2, v3, ptr, data, fn) \
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                        vec_full_reg_offset(v3), ptr, 16, 16, data, fn)
+#define gen_gvec_4(v1, v2, v3, v4, gen) \
+    tcg_gen_gvec_4(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                   vec_full_reg_offset(v3), vec_full_reg_offset(v4), \
+                   16, 16, gen)
 #define gen_gvec_4_ool(v1, v2, v3, v4, data, fn) \
     tcg_gen_gvec_4_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                        vec_full_reg_offset(v3), vec_full_reg_offset(v4), \
@@ -743,3 +747,40 @@ static DisasJumpType op_vsce(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static void gen_sel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    /* bit in c not set -> copy bit from b */
+    tcg_gen_andc_i64(t, b, c);
+    /* bit in c set -> copy bit from a */
+    tcg_gen_and_i64(d, a, c);
+    /* merge the results */
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_sel_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b,
+                        TCGv_vec c)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_andc_vec(vece, t, b, c);
+    tcg_gen_and_vec(vece, d, a, c);
+    tcg_gen_or_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+static DisasJumpType op_vsel(DisasContext *s, DisasOps *o)
+{
+    static const GVecGen4 gvec_op = {
+        .fni8 = gen_sel_i64,
+        .fniv = gen_sel_vec,
+        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    };
+
+    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), get_field(s->fields, v4), &gvec_op);
+    return DISAS_NEXT;
+}
-- 
2.17.2
