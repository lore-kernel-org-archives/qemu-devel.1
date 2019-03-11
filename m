Received: from eggs.gnu.org ([209.51.188.92]:43169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gr5-0003Hs-03
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gr3-0005bv-1S
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:18 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:58 +0100
Message-Id: <20190311090322.21603-10-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/33] s390x/tcg: Implement VECTOR LOAD AND
 REPLICATE
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

We can use tcg_gen_gvec_dup_i64() to carry out the duplication.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-9-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f129e51d4161..7be8977989e2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -984,6 +984,8 @@
 /* VECTOR LOAD */
     F(0xe706, VL,      VRX,   V,   la2, 0, 0, 0, vl, 0, IF_VEC)
     F(0xe756, VLR,     VRR_a, V,   0, 0, 0, 0, vlr, 0, IF_VEC)
+/* VECTOR LOAD AND REPLICATE */
+    F(0xe705, VLREP,   VRX,   V,   la2, 0, 0, 0, vlrep, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 9063784a7666..ede4cc4f6df8 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -113,6 +113,8 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
     }
 }
 
+#define gen_gvec_dup_i64(es, v1, c) \
+    tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
 #define gen_gvec_mov(v1, v2) \
     tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2), 16, \
                      16)
@@ -243,3 +245,20 @@ static DisasJumpType op_vlr(DisasContext *s, DisasOps *o)
     gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlrep(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m3);
+    TCGv_i64 tmp;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
