Received: from eggs.gnu.org ([209.51.188.92]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5d-0004nW-Ig
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5V-0006xb-CS
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:57 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:50 +0100
Message-Id: <20190226113915.20150-9-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 08/33] s390x/tcg: Implement VECTOR LOAD
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

When loading from memory, load to our temporary vector first, so in case
we get an access exception on the second 64 bit element, the vector
won't get modified.

Loading with strange alingment from the end of the address space will
not properly wrap, we can ignore that for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  3 +++
 target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a3a0df7788..c6dd70f2fd 100644
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
index ed63b2ca22..9af5639bfe 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -139,6 +139,9 @@ static void load_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
 
 #define gen_gvec_dup_i64(es, v1, c) \
     tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
+#define gen_gvec_mov(v1, v2) \
+    tcg_gen_gvec_mov(0, vec_full_reg_offset(v1), vec_full_reg_offset(v2), 16, \
+                     16)
 
 static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
 {
@@ -209,3 +212,18 @@ static DisasJumpType op_vgm(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vl(DisasContext *s, DisasOps *o)
+{
+    load_vec_element(s, TMP_VREG_0, 0, o->addr1, MO_64);
+    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    load_vec_element(s, TMP_VREG_0, 1, o->addr1, MO_64);
+    gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);
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
