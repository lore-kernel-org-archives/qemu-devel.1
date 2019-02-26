Received: from eggs.gnu.org ([209.51.188.92]:48034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6I-0005U7-VB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6G-0007X4-DK
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:10 +0100
Message-Id: <20190226113915.20150-29-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 28/33] s390x/tcg: Implement VECTOR SIGN
 EXTEND TO DOUBLEWORD
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

Load both elements signed and store them into the two 64 bit elements.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a8d43b588c..ab3309c54b 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1033,6 +1033,8 @@
     E(0xe71a, VSCEG,   VRV,   V,   la2, 0, 0, 0, vsce, 0, MO_64, IF_VEC)
 /* VECTOR SELECT */
     F(0xe78d, VSEL,    VRR_e, V,   0, 0, 0, 0, vsel, 0, IF_VEC)
+/* VECTOR SIGN EXTEND TO DOUBLEWORD */
+    F(0xe75f, VSEG,    VRR_a, V,   0, 0, 0, 0, vseg, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index d3463c9ef3..23cdae0970 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -731,3 +731,36 @@ static DisasJumpType op_vsel(DisasContext *s, DisasOps *o)
                get_field(s->fields, v3), get_field(s->fields, v4), &gvec_op);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vseg(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m3);
+    int idx1, idx2;
+    TCGv_i64 tmp;
+
+    switch (es) {
+    case MO_8:
+        idx1 = 7;
+        idx2 = 15;
+        break;
+    case MO_16:
+        idx1 = 3;
+        idx2 = 7;
+        break;
+    case MO_32:
+        idx1 = 1;
+        idx2 = 3;
+        break;
+    default:
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, get_field(s->fields, v2), idx1, es | MO_SIGN);
+    write_vec_element_i64(tmp, get_field(s->fields, v1), 0, MO_64);
+    read_vec_element_i64(tmp, get_field(s->fields, v2), idx2, es | MO_SIGN);
+    write_vec_element_i64(tmp, get_field(s->fields, v1), 1, MO_64);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
