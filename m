Received: from eggs.gnu.org ([209.51.188.92]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsE-0004Nb-4N
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsA-0006zm-F3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:11 +0100
Message-Id: <20190311090322.21603-23-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 22/33] s390x/tcg: Implement VECTOR PERMUTE
 DOUBLEWORD IMMEDIATE
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

Read the whole input before modifying the destination vector.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-22-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 5f77462bb1a2..7314ae4704b9 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1021,6 +1021,8 @@
 /* VECTOR PACK LOGICAL SATURATE */
     F(0xe795, VPKLS,   VRR_b, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
     F(0xe78c, VPERM,   VRR_e, V,   0, 0, 0, 0, vperm, 0, IF_VEC)
+/* VECTOR PERMUTE DOUBLEWORD IMMEDIATE */
+    F(0xe784, VPDI,    VRR_c, V,   0, 0, 0, 0, vpdi, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index d8cf4360cf61..b23955b8481e 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -675,3 +675,19 @@ static DisasJumpType op_vperm(DisasContext *s, DisasOps *o)
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
+    read_vec_element_i64(t0, get_field(s->fields, v2), i2, ES_64);
+    read_vec_element_i64(t1, get_field(s->fields, v3), i3, ES_64);
+    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    return DISAS_NEXT;
+}
-- 
2.17.2
