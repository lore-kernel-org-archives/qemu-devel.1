Received: from eggs.gnu.org ([209.51.188.92]:39325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRL-0001Us-Sl
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRK-0007jV-Gt
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:19 +0200
Message-Id: <20190502141019.6385-41-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 40/40] s390x/tcg: Implement VECTOR TEST
 UNDER MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Let's return the cc value directly via cpu_env. Unfortunately there
isn't a simple way to calculate the value lazily - one would have to
calculate and store e.g. the population count of the mask and the
result so it can be evaluated in a cc helper.

But as VTM only sets the cc, we can assume the value will be needed soon
either way.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 11 +++++++++++
 target/s390x/vec_int_helper.c   | 18 ++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 2cb1f369bd..7755a96c33 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -209,6 +209,7 @@ DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, =
ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
 DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a52db41388..e61475bdc4 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1188,6 +1188,8 @@
     F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
 /* VECTOR SUM ACROSS WORD */
     F(0xe764, VSUM,    VRR_c, V,   0, 0, 0, 0, vsum, 0, IF_VEC)
+/* VECTOR TEST UNDER MASK */
+    F(0xe7d8, VTM,     VRR_a, V,   0, 0, 0, 0, vtm, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 23eca2b332..e12ba00a13 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -191,6 +191,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_2i_ool(v1, v2, c, data, fn) \
     tcg_gen_gvec_2i_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2)=
, \
                         c, 16, 16, data, fn)
+#define gen_gvec_2_ptr(v1, v2, ptr, data, fn) \
+    tcg_gen_gvec_2_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
+                       ptr, 16, 16, data, fn)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -2338,3 +2341,11 @@ static DisasJumpType op_vsum(DisasContext *s, Disa=
sOps *o)
     tcg_temp_free_i32(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vtm(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                   cpu_env, 0, gen_helper_gvec_vtm);
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 09137dab99..3e8837e09a 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -583,3 +583,21 @@ void HELPER(gvec_vscbi##BITS)(void *v1, const void *=
v2, const void *v3,        \
 }
 DEF_VSCBI(8)
 DEF_VSCBI(16)
+
+void HELPER(gvec_vtm)(void *v1, const void *v2, CPUS390XState *env,
+                      uint32_t desc)
+{
+    S390Vector tmp;
+
+    s390_vec_and(&tmp, v1, v2);
+    if (s390_vec_is_zero(&tmp)) {
+        /* Selected bits all zeros; or all mask bits zero */
+        env->cc_op =3D 0;
+    } else if (s390_vec_equal(&tmp, v2)) {
+        /* Selected bits all ones */
+        env->cc_op =3D 3;
+    } else {
+        /* Selected bits a mix of zeros and ones */
+        env->cc_op =3D 1;
+    }
+}
--=20
2.20.1
