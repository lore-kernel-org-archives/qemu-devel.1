Received: from eggs.gnu.org ([209.51.188.92]:47360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5R-0004Zd-ES
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5M-0006pW-KM
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:46 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:48 +0100
Message-Id: <20190226113915.20150-7-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/33] s390x/tcg: Implement VECTOR GENERATE
 BYTE MASK
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

As we are working on byte elements, we can use i32 for element access.
Add write_vec_element_i32().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2b06cc9130..1bdfcf8130 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -977,6 +977,8 @@
 /* VECTOR GATHER ELEMENT */
     E(0xe713, VGEF,    VRV,   V,   la2, 0, 0, 0, vge, 0, MO_32, IF_VEC)
     E(0xe712, VGEG,    VRV,   V,   la2, 0, 0, 0, vge, 0, MO_64, IF_VEC)
+/* VECTOR GENERATE BYTE MASK */
+    F(0xe744, VGBM,    VRI_a, V,   0, 0, 0, 0, vgbm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 56f403e40d..7775401dd3 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -105,6 +105,26 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
     }
 }
 
+static void write_vec_element_i32(TCGv_i32 src, int reg, uint8_t enr,
+                                  TCGMemOp memop)
+{
+    const int offs = vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case MO_8:
+        tcg_gen_st8_i32(src, cpu_env, offs);
+        break;
+    case MO_16:
+        tcg_gen_st16_i32(src, cpu_env, offs);
+        break;
+    case MO_32:
+        tcg_gen_st_i32(src, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void load_vec_element(DisasContext *s, uint8_t reg, uint8_t enr,
                              TCGv_i64 addr, uint8_t es)
 {
@@ -136,3 +156,22 @@ static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vgbm(DisasContext *s, DisasOps *o)
+{
+    const uint16_t i2 = get_field(s->fields, i2);
+    TCGv_i32 ones = tcg_const_i32(-1u);
+    TCGv_i32 zeroes = tcg_const_i32(0);
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        if (extract32(i2, 15 - i, 1)) {
+            write_vec_element_i32(ones, get_field(s->fields, v1), i, MO_8);
+        } else {
+            write_vec_element_i32(zeroes, get_field(s->fields, v1), i, MO_8);
+        }
+    }
+    tcg_temp_free_i32(ones);
+    tcg_temp_free_i32(zeroes);
+    return DISAS_NEXT;
+}
-- 
2.17.2
