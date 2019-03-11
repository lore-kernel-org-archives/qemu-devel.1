Received: from eggs.gnu.org ([209.51.188.92]:43275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrK-0003Sj-QI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrI-0005ph-Tk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:34 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:02 +0100
Message-Id: <20190311090322.21603-14-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/33] s390x/tcg: Implement VECTOR LOAD LOGICAL
 ELEMENT AND ZERO
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

Fairly easy, zero out the vector before we load the desired element.
Load the element before touching the vector.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 46 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index de811ddc4762..2b36205c8429 100644
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
index b163100b0da5..cdad2a52f095 100644
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
