Received: from eggs.gnu.org ([209.51.188.92]:38478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQI-0008AG-9p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQG-0006l0-QV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:54 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:50 +0200
Message-Id: <20190502141019.6385-12-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/40] s390x/tcg: Implement VECTOR COUNT
 LEADING ZEROS
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

For 8/16, use the 32 bit variant and properly subtract the added
leading zero bits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 14 ++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 21921397fe..670677427c 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -150,6 +150,8 @@ DEF_HELPER_FLAGS_4(gvec_vavg8, TCG_CALL_NO_RWG, void,=
 ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vavg16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vavgl8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vavgl16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_3(gvec_vclz8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vclz16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 1d159cb201..be3c07aafb 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1084,6 +1084,8 @@
     E(0xe7fb, VCH,     VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GT, IF_VE=
C)
 /* VECTOR COMPARE HIGH LOGICAL */
     E(0xe7f9, VCHL,    VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GTU, IF_V=
EC)
+/* VECTOR COUNT LEADING ZEROS */
+    F(0xe753, VCLZ,    VRR_a, V,   0, 0, 0, 0, vclz, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 3e4e28c742..5f17dbec3f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -182,6 +182,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
=20
+#define gen_gvec_2(v1, v2, gen) \
+    tcg_gen_gvec_2(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                   16, 16, gen)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -1413,3 +1416,31 @@ static DisasJumpType op_vc(DisasContext *s, DisasO=
ps *o)
     }
     return DISAS_NEXT;
 }
+
+static void gen_clz_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_clzi_i32(d, a, 32);
+}
+
+static void gen_clz_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_clzi_i64(d, a, 64);
+}
+
+static DisasJumpType op_vclz(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+    static const GVecGen2 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vclz8, },
+        { .fno =3D gen_helper_gvec_vclz16, },
+        { .fni4 =3D gen_clz_i32, },
+        { .fni8 =3D gen_clz_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 8f97d3f466..016512547c 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -46,3 +46,17 @@ void HELPER(gvec_vavgl##BITS)(void *v1, const void *v2=
, const void *v3,        \
 }
 DEF_VAVGL(8)
 DEF_VAVGL(16)
+
+#define DEF_VCLZ(BITS)                                                  =
       \
+void HELPER(gvec_vclz##BITS)(void *v1, const void *v2, uint32_t desc)   =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, clz32(a) - 32 + BITS);      =
       \
+    }                                                                   =
       \
+}
+DEF_VCLZ(8)
+DEF_VCLZ(16)
--=20
2.20.1
