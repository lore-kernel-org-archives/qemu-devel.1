Received: from eggs.gnu.org ([209.51.188.92]:47629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5i-0004q0-JC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5h-00076N-Nd
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:06 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:59 +0100
Message-Id: <20190226113915.20150-18-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 17/33] s390x/tcg: Implement VECTOR LOAD VR
 FROM GRS DISJOINT
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

Fairly easy, just load from to gprs into a single vector.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      | 2 ++
 target/s390x/translate_vx.inc.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 8b6957b750..1594366d7e 100644
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
index edf471b8a7..93cbc9328f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -461,3 +461,10 @@ static DisasJumpType op_vlvg(DisasContext *s, DisasOps *o)
 
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlvgp(DisasContext *s, DisasOps *o)
+{
+    write_vec_element_i64(o->in1, get_field(s->fields, v1), 0, MO_64);
+    write_vec_element_i64(o->in2, get_field(s->fields, v1), 1, MO_64);
+    return DISAS_NEXT;
+}
-- 
2.17.2
