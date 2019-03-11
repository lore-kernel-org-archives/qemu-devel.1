Received: from eggs.gnu.org ([209.51.188.92]:43875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsP-0004T8-TB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsJ-00075U-Qi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:41 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:12 +0100
Message-Id: <20190311090322.21603-24-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 23/33] s390x/tcg: Implement VECTOR REPLICATE
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

Replicate via the special gvec helper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-23-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7314ae4704b9..14e010765d22 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1023,6 +1023,8 @@
     F(0xe78c, VPERM,   VRR_e, V,   0, 0, 0, 0, vperm, 0, IF_VEC)
 /* VECTOR PERMUTE DOUBLEWORD IMMEDIATE */
     F(0xe784, VPDI,    VRR_c, V,   0, 0, 0, 0, vpdi, 0, IF_VEC)
+/* VECTOR REPLICATE */
+    F(0xe74d, VREP,    VRI_c, V,   0, 0, 0, 0, vrep, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index b23955b8481e..21bf2dc58ff9 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -691,3 +691,19 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(t1);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
+{
+    const uint8_t enr = get_field(s->fields, i2);
+    const uint8_t es = get_field(s->fields, m4);
+
+    if (es > ES_64 || !valid_vec_element(enr, es)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tcg_gen_gvec_dup_mem(es, vec_full_reg_offset(get_field(s->fields, v1)),
+                         vec_reg_offset(get_field(s->fields, v3), enr, es),
+                         16, 16);
+    return DISAS_NEXT;
+}
-- 
2.17.2
