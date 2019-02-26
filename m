Received: from eggs.gnu.org ([209.51.188.92]:48043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6J-0005UF-03
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6G-0007XT-GB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:11 +0100
Message-Id: <20190226113915.20150-30-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 29/33] s390x/tcg: Implement VECTOR STORE
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

Add a FIXME regarding exceptions during the second store.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ab3309c54b..2b18f4ab54 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1035,6 +1035,8 @@
     F(0xe78d, VSEL,    VRR_e, V,   0, 0, 0, 0, vsel, 0, IF_VEC)
 /* VECTOR SIGN EXTEND TO DOUBLEWORD */
     F(0xe75f, VSEG,    VRR_a, V,   0, 0, 0, 0, vseg, 0, IF_VEC)
+/* VECTOR STORE */
+    F(0xe70e, VST,     VRX,   V,   la2, 0, 0, 0, vst, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 23cdae0970..69b12e79a1 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -137,6 +137,17 @@ static void load_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
     tcg_temp_free_i64(tmp);
 }
 
+static void store_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
+                              TCGv_i64 addr, TCGMemOp es)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    read_vec_element_i64(tmp, reg, enr, es);
+    tcg_gen_qemu_st_i64(tmp, addr, get_mem_index(s), MO_TE | es);
+
+    tcg_temp_free_i64(tmp);
+}
+
 static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
                                     uint8_t es)
 {
@@ -764,3 +775,14 @@ static DisasJumpType op_vseg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vst(DisasContext *s, DisasOps *o)
+{
+    /*
+     * FIXME: On exceptions we must not modify any memory.
+     */
+    store_vec_element(s, get_field(s->fields, v1), 0, o->addr1, MO_64);
+    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    store_vec_element(s, get_field(s->fields, v1), 1, o->addr1, MO_64);
+    return DISAS_NEXT;
+}
-- 
2.17.2
