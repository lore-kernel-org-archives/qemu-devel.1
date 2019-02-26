Received: from eggs.gnu.org ([209.51.188.92]:47690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5j-0004rW-Qs
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5i-000775-7N
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:07 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:02 +0100
Message-Id: <20190226113915.20150-21-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 20/33] s390x/tcg: Implement VECTOR PACK
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

We cannot use gvex expansion as the element size of source and
destination differs. So expand manually. Luckily, VECTOR PACK does not
care about saturation or setting the CC, so it can be implemented
without a helper. We have to watch out for overlapping source and
destination registers and use a temporary register in this case.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 51003cf917..8374a663bd 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1014,6 +1014,8 @@
     F(0xe761, VMRH,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
 /* VECTOR MERGE LOW */
     F(0xe760, VMRL,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
+/* VECTOR PACK */
+    F(0xe794, VPK,     VRR_c, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 64a5ee55ca..842ff6a02f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -524,3 +524,44 @@ static DisasJumpType op_vmr(DisasContext *s, DisasOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v2 = get_field(s->fields, v2);
+    const uint8_t v3 = get_field(s->fields, v3);
+    const uint8_t src_es = get_field(s->fields, m4);
+    const uint8_t dst_es = src_es - 1;
+    uint8_t dst_v = v1;
+    int dst_idx, src_idx;
+    TCGv_i64 tmp;
+
+    if (src_es == MO_8 || src_es > MO_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* Source and destination overlap -> use a temporary register */
+    if (v1 == v2 || v1 == v3) {
+        dst_v = TMP_VREG_0;
+    }
+
+    tmp = tcg_temp_new_i64();
+    for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(dst_es); dst_idx++) {
+        src_idx = dst_idx;
+        if (src_idx < NUM_VEC_ELEMENTS(src_es)) {
+            read_vec_element_i64(tmp, v2, src_idx, src_es);
+        } else {
+            src_idx -= NUM_VEC_ELEMENTS(src_es);
+            read_vec_element_i64(tmp, v3, src_idx, src_es);
+        }
+        write_vec_element_i64(tmp, dst_v, dst_idx, dst_es);
+    }
+    tcg_temp_free_i64(tmp);
+
+    /* move the temporary to the destination */
+    if (dst_v != v1) {
+        gen_gvec_mov(v1, dst_v);
+    }
+    return DISAS_NEXT;
+}
-- 
2.17.2
