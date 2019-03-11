Received: from eggs.gnu.org ([209.51.188.92]:43257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrH-0003S3-3q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrF-0005nU-G4
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:31 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:01 +0100
Message-Id: <20190311090322.21603-13-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 12/33] s390x/tcg: Implement VECTOR LOAD GR FROM
 VR ELEMENT
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

To avoid an helper, we have to do the actual calculation of the element
address (offset in cpu_env + cpu_env) manually. Factor that out into
get_vec_element_ptr_i64(). The same logic will be reused for "VECTOR
LOAD VR ELEMENT FROM GR".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-12-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 782d49e1db6e..de811ddc4762 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -996,6 +996,8 @@
     E(0xe741, VLEIH,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_16, IF_VEC)
     E(0xe743, VLEIF,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_32, IF_VEC)
     E(0xe742, VLEIG,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_64, IF_VEC)
+/* VECTOR LOAD GR FROM VR ELEMENT */
+    F(0xe721, VLGV,    VRS_c, V,   la2, 0, r1, 0, vlgv, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index d450ce2d2baf..b163100b0da5 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -113,6 +113,28 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
     }
 }
 
+static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
+                                    uint8_t es)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    /* mask off invalid parts from the element nr */
+    tcg_gen_andi_i64(tmp, enr, NUM_VEC_ELEMENTS(es) - 1);
+
+    /* convert it to an element offset relative to cpu_env (vec_reg_offset() */
+    tcg_gen_shli_i64(tmp, tmp, es);
+#ifndef HOST_WORDS_BIGENDIAN
+    tcg_gen_xori_i64(tmp, tmp, 8 - NUM_VEC_ELEMENT_BYTES(es));
+#endif
+    tcg_gen_addi_i64(tmp, tmp, vec_full_reg_offset(reg));
+
+    /* generate the final ptr by adding cpu_env */
+    tcg_gen_trunc_i64_ptr(ptr, tmp);
+    tcg_gen_add_ptr(ptr, ptr, cpu_env);
+
+    tcg_temp_free_i64(tmp);
+}
+
 #define gen_gvec_dup_i64(es, v1, c) \
     tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
 #define gen_gvec_mov(v1, v2) \
@@ -297,3 +319,44 @@ static DisasJumpType op_vlei(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlgv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m4);
+    TCGv_ptr ptr;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* fast path if we don't need the register content */
+    if (!get_field(s->fields, b2)) {
+        uint8_t enr = get_field(s->fields, d2) & (NUM_VEC_ELEMENTS(es) - 1);
+
+        read_vec_element_i64(o->out, get_field(s->fields, v3), enr, es);
+        return DISAS_NEXT;
+    }
+
+    ptr = tcg_temp_new_ptr();
+    get_vec_element_ptr_i64(ptr, get_field(s->fields, v3), o->addr1, es);
+    switch (es) {
+    case ES_8:
+        tcg_gen_ld8u_i64(o->out, ptr, 0);
+        break;
+    case ES_16:
+        tcg_gen_ld16u_i64(o->out, ptr, 0);
+        break;
+    case ES_32:
+        tcg_gen_ld32u_i64(o->out, ptr, 0);
+        break;
+    case ES_64:
+        tcg_gen_ld_i64(o->out, ptr, 0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_temp_free_ptr(ptr);
+
+    return DISAS_NEXT;
+}
-- 
2.17.2
