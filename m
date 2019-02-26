Received: from eggs.gnu.org ([209.51.188.92]:47944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb66-0005Ge-K7
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5u-0007Pq-VH
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:20 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:05 +0100
Message-Id: <20190226113915.20150-24-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 23/33] s390x/tcg: Implement VECTOR PERMUTE
 DOUBLEWORD IMMEDIATE
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

Read the whole input before modifying the destination vector.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index b4b4be651b..eb4dea2e2d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1022,6 +1022,8 @@
     F(0xe795, VPKLS,   VRR_b, V,   0, 0, 0, 0, vpks, 0, IF_VEC)
 /* VECTOR PERMUTE */
     F(0xe78c, VPERM,   VRR_e, V,   0, 0, 0, 0, vperm, 0, IF_VEC)
+/* VECTOR PERMUTE DOUBLEWORD IMMEDIATE */
+    F(0xe784, VPDI,    VRR_c, V,   0, 0, 0, 0, vpdi, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index a57d4816c4..e67b47f262 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -614,3 +614,19 @@ static DisasJumpType op_vperm(DisasContext *s, DisasOps *o)
                    0, gen_helper_gvec_vperm);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
+{
+    const uint8_t i2 = extract32(get_field(s->fields, m4), 2, 1);
+    const uint8_t i3 = extract32(get_field(s->fields, m4), 0, 1);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    read_vec_element_i64(t0, get_field(s->fields, v2), i2, MO_64);
+    read_vec_element_i64(t1, get_field(s->fields, v3), i3, MO_64);
+    write_vec_element_i64(t0, get_field(s->fields, v1), 0, MO_64);
+    write_vec_element_i64(t1, get_field(s->fields, v1), 1, MO_64);
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    return DISAS_NEXT;
+}
-- 
2.17.2
