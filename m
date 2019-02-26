Received: from eggs.gnu.org ([209.51.188.92]:47383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5S-0004Zh-1i
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5M-0006pw-Q4
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:47 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:51 +0100
Message-Id: <20190226113915.20150-10-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 09/33] s390x/tcg: Implement VECTOR LOAD AND
 REPLICATE
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

We can use tcg_gen_gvec_dup_i64() to carry out the duplication.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index c6dd70f2fd..5475f04561 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -984,6 +984,8 @@
 /* VECTOR LOAD */
     F(0xe706, VL,      VRX,   V,   la2, 0, 0, 0, vl, 0, IF_VEC)
     F(0xe756, VLR,     VRR_a, V,   0, 0, 0, 0, vlr, 0, IF_VEC)
+/* VECTOR LOAD AND REPLICATE */
+    F(0xe705, VLREP,   VRX,   V,   la2, 0, 0, 0, vlrep, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 9af5639bfe..b898910cd9 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -227,3 +227,20 @@ static DisasJumpType op_vlr(DisasContext *s, DisasOps *o)
     gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlrep(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m3);
+    TCGv_i64 tmp;
+
+    if (es > MO_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
