Received: from eggs.gnu.org ([209.51.188.92]:48038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6I-0005UB-Vk
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6G-0007XE-EJ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:08 +0100
Message-Id: <20190226113915.20150-27-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 26/33] s390x/tcg: Implement VECTOR SCATTER
 ELEMENT
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

Similar to VECTOR GATHER ELEMENT, but the other direction.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  3 +++
 target/s390x/translate_vx.inc.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 9aa508547b..4159ec36f9 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1028,6 +1028,9 @@
     F(0xe74d, VREP,    VRI_c, V,   0, 0, 0, 0, vrep, 0, IF_VEC)
 /* VECTOR REPLICATE IMMEDIATE */
     F(0xe745, VREPI,   VRI_a, V,   0, 0, 0, 0, vrepi, 0, IF_VEC)
+/* VECTOR SCATTER ELEMENT */
+    E(0xe71b, VSCEF,   VRV,   V,   la2, 0, 0, 0, vsce, 0, MO_32, IF_VEC)
+    E(0xe71a, VSCEG,   VRV,   V,   la2, 0, 0, 0, vsce, 0, MO_64, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 761f3dc723..344ac36f93 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -666,3 +666,25 @@ static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsce(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = s->insn->data;
+    const uint8_t enr = get_field(s->fields, m3);
+    TCGv_i64 tmp;
+
+    if (!valid_vec_element(enr, es)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, get_field(s->fields, v2), enr, es);
+    tcg_gen_add_i64(o->addr1, o->addr1, tmp);
+    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 0);
+
+    read_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
