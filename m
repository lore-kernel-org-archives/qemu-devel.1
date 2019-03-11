Received: from eggs.gnu.org ([209.51.188.92]:43142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gr1-0003FG-0G
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqx-0005YP-3t
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:13 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:57 +0100
Message-Id: <20190311090322.21603-9-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/33] s390x/tcg: Implement VECTOR LOAD
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

When loading from memory, load both elements into temps first before
modifying the target vector

Loading with strange alingment from the end of the address space will
not properly wrap, we can ignore that for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-8-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  3 +++
 target/s390x/translate_vx.inc.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c8cd5dfa249e..f129e51d4161 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -981,6 +981,9 @@
     F(0xe744, VGBM,    VRI_a, V,   0, 0, 0, 0, vgbm, 0, IF_VEC)
 /* VECTOR GENERATE MASK */
     F(0xe746, VGM,     VRI_b, V,   0, 0, 0, 0, vgm, 0, IF_VEC)
+/* VECTOR LOAD */
+    F(0xe706, VL,      VRX,   V,   la2, 0, 0, 0, vl, 0, IF_VEC)
+    F(0xe756, VLR,     VRR_a, V,   0, 0, 0, 0, vlr, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 28edd9b0c4cc..9063784a7666 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -113,6 +113,9 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
     }
 }
 
+#define gen_gvec_mov(v1, v2) \
+    tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2), 16, \
+                     16)
 #define gen_gvec_dup64i(v1, c) \
     tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
 
@@ -219,3 +222,24 @@ static DisasJumpType op_vgm(DisasContext *s, DisasOps *o)
     gen_gvec_dupi(es, get_field(s->fields, v1), mask);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vl(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(t0, o->addr1, get_mem_index(s), MO_TEQ);
+    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    tcg_gen_qemu_ld_i64(t1, o->addr1, get_mem_index(s), MO_TEQ);
+    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_vlr(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
+    return DISAS_NEXT;
+}
-- 
2.17.2
