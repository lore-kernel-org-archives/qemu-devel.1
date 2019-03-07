Received: from eggs.gnu.org ([209.51.188.92]:41889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwq-0004Z7-Vj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwq-00005i-0T
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:28 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:30 +0100
Message-Id: <20190307121539.12842-24-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 23/32] s390x/tcg: Implement VECTOR REPLICATE
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 14e010765d..99fb697d91 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1025,6 +1025,8 @@
     F(0xe784, VPDI,    VRR_c, V,   0, 0, 0, 0, vpdi, 0, IF_VEC)
 /* VECTOR REPLICATE */
     F(0xe74d, VREP,    VRI_c, V,   0, 0, 0, 0, vrep, 0, IF_VEC)
+/* VECTOR REPLICATE IMMEDIATE */
+    F(0xe745, VREPI,   VRI_a, V,   0, 0, 0, 0, vrepi, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 21bf2dc58f..b6061d7acf 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -707,3 +707,17 @@ static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
                          16, 16);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
+{
+    const int64_t data = (int16_t)get_field(s->fields, i2);
+    const uint8_t es = get_field(s->fields, m3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_dupi(es, get_field(s->fields, v1), data);
+    return DISAS_NEXT;
+}
-- 
2.17.2
