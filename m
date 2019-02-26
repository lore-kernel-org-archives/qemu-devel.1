Received: from eggs.gnu.org ([209.51.188.92]:48042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6I-0005UE-WD
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6G-0007Ww-BP
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:07 +0100
Message-Id: <20190226113915.20150-26-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 25/33] s390x/tcg: Implement VECTOR REPLICATE
 IMMEDIATE
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

Like VECTOR REPLICATE, but the element to be replicated comes from an
immediate.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d2efe6bba2..9aa508547b 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1026,6 +1026,8 @@
     F(0xe784, VPDI,    VRR_c, V,   0, 0, 0, 0, vpdi, 0, IF_VEC)
 /* VECTOR REPLICATE */
     F(0xe74d, VREP,    VRI_c, V,   0, 0, 0, 0, vrep, 0, IF_VEC)
+/* VECTOR REPLICATE IMMEDIATE */
+    F(0xe745, VREPI,   VRI_a, V,   0, 0, 0, 0, vrepi, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index c261e56c6b..761f3dc723 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -648,3 +648,21 @@ static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
+{
+    const int64_t data = (int16_t)get_field(s->fields, i2);
+    const uint8_t es = get_field(s->fields, m3);
+    TCGv_i64 tmp;
+
+    if (es > MO_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    tcg_gen_movi_i64(tmp, data);
+    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
