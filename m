Received: from eggs.gnu.org ([209.51.188.92]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gra-0003pk-D8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrZ-000661-B6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:06 +0100
Message-Id: <20190311090322.21603-18-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 17/33] s390x/tcg: Implement VECTOR LOAD VR FROM
 GRS DISJOINT
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

Fairly easy, just load from to gprs into a single vector.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-17-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      | 2 ++
 target/s390x/translate_vx.inc.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 68140612045e..bdd66758fa62 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1006,6 +1006,8 @@
     F(0xe707, VLBB,    VRX,   V,   la2, 0, 0, 0, vlbb, 0, IF_VEC)
 /* VECTOR LOAD VR ELEMENT FROM GR */
     F(0xe722, VLVG,    VRS_b, V,   la2, r3, 0, 0, vlvg, 0, IF_VEC)
+/* VECTOR LOAD VR FROM GRS DISJOINT */
+    F(0xe762, VLVGP,   VRR_f, V,   r2, r3, 0, 0, vlvgp, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 287bd9627d34..abd33a9e3d96 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -512,3 +512,10 @@ static DisasJumpType op_vlvg(DisasContext *s, DisasOps *o)
 
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlvgp(DisasContext *s, DisasOps *o)
+{
+    write_vec_element_i64(o->in1, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(o->in2, get_field(s->fields, v1), 1, ES_64);
+    return DISAS_NEXT;
+}
-- 
2.17.2
