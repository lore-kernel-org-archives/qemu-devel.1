Received: from eggs.gnu.org ([209.51.188.92]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5i-0004qA-N0
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5h-00076H-LY
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:06 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:56 +0100
Message-Id: <20190226113915.20150-15-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 14/33] s390x/tcg: Implement VECTOR LOAD
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

Also fairly easy to implement. One issue we have is that exceptions will
result in some vectors already being modified. At least handle it
consistently per vector by using a temporary vector. Good enough for
now, add a FIXME.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 46a0739703..65ff8bbd2e 100644
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
index 301408d1f2..c9f57afd4a 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -377,3 +377,29 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
     gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlm(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v3 = get_field(s->fields, v3);
+    uint8_t v1 = get_field(s->fields, v1);
+
+    while (v3 < v1 || (v3 - v1 + 1) > 16) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /*
+     * FIXME: On exceptions we must not modify any vector.
+     */
+    for (;; v1++) {
+        load_vec_element(s, TMP_VREG_0, 0, o->addr1, MO_64);
+        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+        load_vec_element(s, TMP_VREG_0, 1, o->addr1, MO_64);
+        gen_gvec_mov(v1, TMP_VREG_0);
+        if (v1 == v3) {
+            break;
+        }
+        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    }
+    return DISAS_NEXT;
+}
-- 
2.17.2
