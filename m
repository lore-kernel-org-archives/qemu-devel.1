Received: from eggs.gnu.org ([209.51.188.92]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5j-0004r8-Hs
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5h-00076d-SW
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:07 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:55 +0100
Message-Id: <20190226113915.20150-14-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 13/33] s390x/tcg: Implement VECTOR LOAD
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
Use a temporary vector so we don't modify the target vector on
exceptions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f4201ff55a..46a0739703 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -998,6 +998,8 @@
     E(0xe742, VLEIG,   VRI_a, V,   0, 0, 0, 0, vlei, 0, MO_64, IF_VEC)
 /* VECTOR LOAD GR FROM VR ELEMENT */
     F(0xe721, VLGV,    VRS_c, V,   la2, 0, r1, 0, vlgv, 0, IF_VEC)
+/* VECTOR LOAD LOGICAL ELEMENT AND ZERO */
+    F(0xe704, VLLEZ,   VRX,   V,   la2, 0, 0, 0, vllez, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index a02a3ba81f..301408d1f2 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -165,6 +165,11 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
     tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2), 16, \
                      16)
 
+static void zero_vec(uint8_t reg)
+{
+    tcg_gen_gvec_dup8i(vec_full_reg_offset(reg), 16, 16, 0);
+}
+
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
     const uint8_t es = s->insn->data;
@@ -334,3 +339,41 @@ static DisasJumpType op_vlgv(DisasContext *s, DisasOps *o)
 
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
+{
+    uint8_t es = get_field(s->fields, m3);
+    uint8_t enr;
+
+    switch (es) {
+    /* rightmost sub-element of leftmost doubleword */
+    case MO_8:
+        enr = 7;
+        break;
+    case MO_16:
+        enr = 3;
+        break;
+    case MO_32:
+        enr = 1;
+        break;
+    case MO_64:
+        enr = 0;
+        break;
+    /* leftmost sub-element of leftmost doubleword */
+    case 6:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            es = MO_32;
+            enr = 0;
+            break;
+        }
+    default:
+        /* fallthrough */
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    zero_vec(TMP_VREG_0);
+    load_vec_element(s, TMP_VREG_0, enr, o->addr1, es);
+    gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);
+    return DISAS_NEXT;
+}
-- 
2.17.2
