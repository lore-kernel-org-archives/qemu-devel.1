Received: from eggs.gnu.org ([209.51.188.92]:38506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQJ-0008Bp-GK
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQI-0006mE-CD
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:55 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:51 +0200
Message-Id: <20190502141019.6385-13-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/40] s390x/tcg: Implement VECTOR COUNT
 TRAILING ZEROS
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

Implement it similar to VECTOR COUNT LEADING ZEROS.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 28 ++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 14 ++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 670677427c..60b8bd3c43 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -152,6 +152,8 @@ DEF_HELPER_FLAGS_4(gvec_vavgl8, TCG_CALL_NO_RWG, void=
, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vavgl16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_3(gvec_vclz8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vclz16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vctz8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vctz16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index be3c07aafb..a355b7f62f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1086,6 +1086,8 @@
     E(0xe7f9, VCHL,    VRR_b, V,   0, 0, 0, 0, vc, 0, TCG_COND_GTU, IF_V=
EC)
 /* VECTOR COUNT LEADING ZEROS */
     F(0xe753, VCLZ,    VRR_a, V,   0, 0, 0, 0, vclz, 0, IF_VEC)
+/* VECTOR COUNT TRAILING ZEROS */
+    F(0xe752, VCTZ,    VRR_a, V,   0, 0, 0, 0, vctz, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 5f17dbec3f..ac1a2d77ad 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1444,3 +1444,31 @@ static DisasJumpType op_vclz(DisasContext *s, Disa=
sOps *o)
     gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
     return DISAS_NEXT;
 }
+
+static void gen_ctz_i32(TCGv_i32 d, TCGv_i32 a)
+{
+    tcg_gen_ctzi_i32(d, a, 32);
+}
+
+static void gen_ctz_i64(TCGv_i64 d, TCGv_i64 a)
+{
+    tcg_gen_ctzi_i64(d, a, 64);
+}
+
+static DisasJumpType op_vctz(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+    static const GVecGen2 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vctz8, },
+        { .fno =3D gen_helper_gvec_vctz16, },
+        { .fni4 =3D gen_ctz_i32, },
+        { .fni8 =3D gen_ctz_i64, },
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
index 016512547c..d1b1f28509 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -60,3 +60,17 @@ void HELPER(gvec_vclz##BITS)(void *v1, const void *v2,=
 uint32_t desc)          \
 }
 DEF_VCLZ(8)
 DEF_VCLZ(16)
+
+#define DEF_VCTZ(BITS)                                                  =
       \
+void HELPER(gvec_vctz##BITS)(void *v1, const void *v2, uint32_t desc)   =
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
+        s390_vec_write_element##BITS(v1, i, a ? ctz32(a) : BITS);       =
       \
+    }                                                                   =
       \
+}
+DEF_VCTZ(8)
+DEF_VCTZ(16)
--=20
2.20.1
