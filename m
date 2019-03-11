Received: from eggs.gnu.org ([209.51.188.92]:43538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gry-0003uB-9M
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Grw-0006gE-Fi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:13 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:10 +0100
Message-Id: <20190311090322.21603-22-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/33] s390x/tcg: Implement VECTOR PERMUTE
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

Take care of overlying inputs and outputs by using a temporary vector.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-21-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  1 +
 target/s390x/translate_vx.inc.c | 12 ++++++++++++
 target/s390x/vec_helper.c       | 20 ++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 315495f49fc2..577edb384fe6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -141,6 +141,7 @@ DEF_HELPER_FLAGS_4(gvec_vpkls64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
 DEF_HELPER_5(gvec_vpkls_cc16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vpkls_cc32, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vpkls_cc64, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, cptr, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 39cd6f27c159..5f77462bb1a2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1020,6 +1020,7 @@
     F(0xe797, VPKS,    VRR_b, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
 /* VECTOR PACK LOGICAL SATURATE */
     F(0xe795, VPKLS,   VRR_b, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
+    F(0xe78c, VPERM,   VRR_e, V,   0, 0, 0, 0, vperm, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 7ae38f71f75e..d8cf4360cf61 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -141,6 +141,10 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
 #define gen_gvec_3_ptr(v1, v2, v3, ptr, data, fn) \
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                        vec_full_reg_offset(v3), ptr, 16, 16, data, fn)
+#define gen_gvec_4_ool(v1, v2, v3, v4, data, fn) \
+    tcg_gen_gvec_4_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                       vec_full_reg_offset(v3), vec_full_reg_offset(v4), \
+                       16, 16, data, fn)
 #define gen_gvec_dup_i64(es, v1, c) \
     tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
 #define gen_gvec_mov(v1, v2) \
@@ -663,3 +667,11 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vperm(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), get_field(s->fields, v4),
+                   0, gen_helper_gvec_vperm);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
index 7f680201b5f5..021695b38c21 100644
--- a/target/s390x/vec_helper.c
+++ b/target/s390x/vec_helper.c
@@ -147,3 +147,23 @@ void HELPER(gvec_vpkls_cc##BITS)(void *v1, const void *v2, const void *v3,     \
 DEF_VPKLS(64, 32)
 DEF_VPKLS(32, 16)
 DEF_VPKLS(16, 8)
+
+void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
+                        const void *v4, uint32_t desc)
+{
+    S390Vector tmp;
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        const uint8_t selector = s390_vec_read_element8(v4, i) & 0x1f;
+        uint8_t byte;
+
+        if (selector < 16) {
+            byte = s390_vec_read_element8(v2, selector);
+        } else {
+            byte = s390_vec_read_element8(v3, selector - 16);
+        }
+        s390_vec_write_element8(&tmp, i, byte);
+    }
+    *(S390Vector *)v1 = tmp;
+}
-- 
2.17.2
