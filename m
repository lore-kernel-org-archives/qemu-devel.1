Received: from eggs.gnu.org ([209.51.188.92]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwn-0004XE-HS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwm-0008Vi-PC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:25 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:28 +0100
Message-Id: <20190307121539.12842-22-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 21/32] s390x/tcg: Implement VECTOR PERMUTE
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 5f77462bb1..7314ae4704 100644
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
index d8cf4360cf..b23955b848 100644
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
