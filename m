Received: from eggs.gnu.org ([209.51.188.92]:41602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwW-0004Jj-JF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwV-0008Mn-Mz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:08 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:19 +0100
Message-Id: <20190307121539.12842-13-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/32] s390x/tcg: Implement VECTOR LOAD
 LOGICAL ELEMENT AND ZERO
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

Fairly easy, zero out the vector before we load the desired element.
Load the element before touching the vector.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index de811ddc47..2b36205c84 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -998,6 +998,8 @@
     E(0xe742, VLEIG,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_64, IF_VEC)
 /* VECTOR LOAD GR FROM VR ELEMENT */
     F(0xe721, VLGV,    VRS_c, V,   la2, 0, r1, 0, vlgv, 0, IF_VEC)
+/* VECTOR LOAD LOGICAL ELEMENT AND ZERO */
+    F(0xe704, VLLEZ,   VRX,   V,   la2, 0, 0, 0, vllez, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index b163100b0d..cdad2a52f0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -163,6 +163,11 @@ static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
     }
 }
 
+static void zero_vec(uint8_t reg)
+{
+    tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, 0);
+}
+
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es = s->insn->data;
@@ -360,3 +365,44 @@ static DisasJumpType op_vlgv(DisasContext *s, DisasOps *o)
 
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
+{
+    uint8_t es = get_field(s->fields, m3);
+    uint8_t enr;
+    TCGv_i64 t;
+
+    switch (es) {
+    /* rightmost sub-element of leftmost doubleword */
+    case ES_8:
+        enr = 7;
+        break;
+    case ES_16:
+        enr = 3;
+        break;
+    case ES_32:
+        enr = 1;
+        break;
+    case ES_64:
+        enr = 0;
+        break;
+    /* leftmost sub-element of leftmost doubleword */
+    case 6:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            es = ES_32;
+            enr = 0;
+            break;
+        }
+    default:
+        /* fallthrough */
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    t = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TE | es);
+    zero_vec(get_field(s->fields, v1));
+    write_vec_element_i64(t, get_field(s->fields, v1), enr, es);
+    tcg_temp_free_i64(t);
+    return DISAS_NEXT;
+}
-- 
2.17.2
