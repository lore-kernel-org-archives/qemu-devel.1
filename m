Received: from eggs.gnu.org ([209.51.188.92]:43846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsM-0004Ri-Tu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsL-00076h-PK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:38 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:13 +0100
Message-Id: <20190311090322.21603-25-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 24/33] s390x/tcg: Implement VECTOR REPLICATE
 IMMEDIATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Like VECTOR REPLICATE, but the element to be replicated comes from an
immediate.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-24-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 14e010765d22..99fb697d914b 100644
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
index 21bf2dc58ff9..b6061d7acfec 100644
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
