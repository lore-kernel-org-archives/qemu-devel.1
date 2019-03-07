Received: from eggs.gnu.org ([209.51.188.92]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rx4-0004nq-GP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rx3-0000QC-LA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:37 +0100
Message-Id: <20190307121539.12842-31-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 30/32] s390x/tcg: Implement VECTOR STORE
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

Similar to VECTOR LOAD MULTIPLE, just the opposite direction. Probe
write access first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ff5b9e7302..17fd9a898b 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1041,6 +1041,8 @@
     E(0xe709, VSTEH,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_16, IF_VEC)
     E(0xe70b, VSTEF,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_32, IF_VEC)
     E(0xe70a, VSTEG,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_64, IF_VEC)
+/* VECTOR STORE MULTIPLE */
+    F(0xe73e, VSTM,    VRS_a, V,   la2, 0, 0, 0, vstm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index ecc295da5b..0c75374203 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -852,3 +852,33 @@ static DisasJumpType op_vste(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vstm(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v3 = get_field(s->fields, v3);
+    uint8_t v1 = get_field(s->fields, v1);
+    TCGv_i64 tmp;
+
+    while (v3 < v1 || (v3 - v1 + 1) > 16) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* Probe write access before actually modifying memory */
+    tmp = tcg_const_i64((v3 - v1 + 1) * 16);
+    gen_helper_probe_write_access(cpu_env, o->addr1, tmp);
+
+    for (;; v1++) {
+        read_vec_element_i64(tmp, v1, 0, ES_64);
+        tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEQ);
+        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+        read_vec_element_i64(tmp, v1, 1, ES_64);
+        tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEQ);
+        if (v1 == v3) {
+            break;
+        }
+        gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    }
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
