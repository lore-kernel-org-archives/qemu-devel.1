Received: from eggs.gnu.org ([209.51.188.92]:47587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5h-0004pI-QW
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5d-00071h-EU
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:05 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:54 +0100
Message-Id: <20190226113915.20150-13-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 12/33] s390x/tcg: Implement VECTOR LOAD GR
 FROM VR ELEMENT
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

To avoid an helper, we have to do the actual calculation of the element
address (offset in cpu_env + cpu_env) manually. Factor that out into
get_vec_element_ptr_i64(). The same logic will be reused for "VECTOR
LOAD VR ELEMENT FROM GR".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 55 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 46610e808f..f4201ff55a 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -996,6 +996,8 @@
     E(0xe741, VLEIH,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_16, IF_VEC)
     E(0xe743, VLEIF,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_32, IF_VEC)
     E(0xe742, VLEIG,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_64, IF_VEC)
+/* VECTOR LOAD GR FROM VR ELEMENT */
+    F(0xe721, VLGV,    VRS_c, V,   la2, 0, r1, 0, vlgv, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 1bf654ff4e..a02a3ba81f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -137,6 +137,28 @@ static void load_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
     tcg_temp_free_i64(tmp);
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
+    tcg_gen_muli_i64(tmp, tmp, NUM_VEC_ELEMENT_BYTES(es));
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
@@ -279,3 +301,36 @@ static DisasJumpType op_vlei(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlgv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m4);
+    TCGv_ptr ptr;
+
+    if (es > MO_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    ptr = tcg_temp_new_ptr();
+    get_vec_element_ptr_i64(ptr, get_field(s->fields, v3), o->addr1, es);
+    switch (es) {
+    case MO_8:
+        tcg_gen_ld8u_i64(o->out, ptr, 0);
+        break;
+    case MO_16:
+        tcg_gen_ld16u_i64(o->out, ptr, 0);
+        break;
+    case MO_32:
+        tcg_gen_ld32u_i64(o->out, ptr, 0);
+        break;
+    case MO_64:
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
