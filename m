Received: from eggs.gnu.org ([209.51.188.92]:40023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgke-00037b-HD
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgkd-0006YE-He
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:54:52 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  1 Mar 2019 12:53:54 +0100
Message-Id: <20190301115413.27153-14-david@redhat.com>
In-Reply-To: <20190301115413.27153-1-david@redhat.com>
References: <20190301115413.27153-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/32] s390x/tcg: Implement VECTOR LOAD
 MULTIPLE
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

Try to load the last element first. Access to the first element will
be checked afterwards. This way, we can guarantee that the vector is
not modified before we checked for all possible exceptions. (16 vectors
cannot cross more than two pages)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2b36205c84..fa0f3a9003 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1000,6 +1000,8 @@
     F(0xe721, VLGV,    VRS_c, V,   la2, 0, r1, 0, vlgv, 0, IF_VEC)
 /* VECTOR LOAD LOGICAL ELEMENT AND ZERO */
     F(0xe704, VLLEZ,   VRX,   V,   la2, 0, 0, 0, vllez, 0, IF_VEC)
+/* VECTOR LOAD MULTIPLE */
+    F(0xe736, VLM,     VRS_a, V,   la2, 0, 0, 0, vlm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index cdad2a52f0..93f9c0f804 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -406,3 +406,37 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(t);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlm(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v3 = get_field(s->fields, v3);
+    uint8_t v1 = get_field(s->fields, v1);
+    TCGv_i64 t;
+
+    while (v3 < v1 || (v3 - v1 + 1) > 16) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /*
+     * Check for possible access exceptions by trying to load the last
+     * element. The first element will be checked first next.
+     */
+    t = tcg_temp_new_i64();
+    gen_addi_and_wrap_i64(s, t, o->addr1, (v3 - v1) * 16 + 8);
+    tcg_gen_qemu_ld_i64(t, t, get_mem_index(s), MO_TEQ);
+
+    for (;; v1++) {
+        tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEQ);
+        write_vec_element_i64(t, v1, 0, ES_64);
+        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+        tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEQ);
+        write_vec_element_i64(t, v1, 1, ES_64);
+        if (v1 == v3) {
+            break;
+        }
+        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    }
+    tcg_temp_free_i64(t);
+    return DISAS_NEXT;
+}
-- 
2.17.2
