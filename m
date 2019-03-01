Received: from eggs.gnu.org ([209.51.188.92]:40078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgkj-0003DO-Mg
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgki-0006bf-RC
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:54:57 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  1 Mar 2019 12:53:56 +0100
Message-Id: <20190301115413.27153-16-david@redhat.com>
In-Reply-To: <20190301115413.27153-1-david@redhat.com>
References: <20190301115413.27153-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/32] s390x/tcg: Implement VECTOR LOAD VR
 ELEMENT FROM GR
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

Very similar to VECTOR LOAD GR FROM VR ELEMENT, just the opposite
direction. Also provide a fast path in case we don't care about the
register content.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ad8df5283c..6814061204 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1004,6 +1004,8 @@
     F(0xe736, VLM,     VRS_a, V,   la2, 0, 0, 0, vlm, 0, IF_VEC)
 /* VECTOR LOAD TO BLOCK BOUNDARY */
     F(0xe707, VLBB,    VRX,   V,   la2, 0, 0, 0, vlbb, 0, IF_VEC)
+/* VECTOR LOAD VR ELEMENT FROM GR */
+    F(0xe722, VLVG,    VRS_b, V,   la2, r3, 0, 0, vlvg, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index f9d0ecf29d..78afecbe06 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -465,3 +465,44 @@ static DisasJumpType op_vlbb(DisasContext *s, DisasOps *o)
     tcg_temp_free_ptr(a0);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlvg(DisasContext *s, DisasOps *o)
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
+        write_vec_element_i64(o->in2, get_field(s->fields, v1), enr, es);
+        return DISAS_NEXT;
+    }
+
+    ptr = tcg_temp_new_ptr();
+    get_vec_element_ptr_i64(ptr, get_field(s->fields, v1), o->addr1, es);
+    switch (es) {
+    case ES_8:
+        tcg_gen_st8_i64(o->in2, ptr, 0);
+        break;
+    case ES_16:
+        tcg_gen_st16_i64(o->in2, ptr, 0);
+        break;
+    case ES_32:
+        tcg_gen_st32_i64(o->in2, ptr, 0);
+        break;
+    case ES_64:
+        tcg_gen_st_i64(o->in2, ptr, 0);
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
