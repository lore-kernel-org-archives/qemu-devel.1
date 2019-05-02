Received: from eggs.gnu.org ([209.51.188.92]:38952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQt-0000Vv-1s
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQr-0007Ne-UA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:31 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:07 +0200
Message-Id: <20190502141019.6385-29-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 28/40] s390x/tcg: Implement VECTOR ELEMENT
 SHIFT
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

We can use all the fancy new vector helpers implemented by Richard.

One important thing to take care of is always to properly mask of
unused bits from the shift count.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  9 ++++
 target/s390x/translate_vx.inc.c | 84 +++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 59c323a796..f4b67bda7e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1151,6 +1151,15 @@
     F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
 /* VECTOR ELEMENT ROTATE AND INSERT UNDER MASK */
     F(0xe772, VERIM,   VRI_d, V,   0, 0, 0, 0, verim, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT LEFT */
+    F(0xe770, VESLV,   VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe730, VESL,    VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT RIGHT ARITHMETIC */
+    F(0xe77a, VESRAV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe73a, VESRA,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT RIGHT LOGICAL */
+    F(0xe778, VESRLV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe738, VESRL,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index f5abe41bff..042d940a83 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -218,6 +218,12 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, ui=
nt8_t reg, TCGv_i64 enr,
 #define gen_gvec_fn_2(fn, es, v1, v2) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       16, 16)
+#define gen_gvec_fn_2i(fn, es, v1, v2, c) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      c, 16, 16)
+#define gen_gvec_fn_2s(fn, es, v1, v2, s) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      s, 16, 16)
 #define gen_gvec_fn_3(fn, es, v1, v2, v3) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       vec_full_reg_offset(v3), 16, 16)
@@ -1952,3 +1958,81 @@ static DisasJumpType op_verim(DisasContext *s, Dis=
asOps *o)
                 get_field(s->fields, v3), i4, &g[es]);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v2 =3D get_field(s->fields, v2);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0x70:
+        gen_gvec_fn_3(shlv, es, v1, v2, v3);
+        break;
+    case 0x7a:
+        gen_gvec_fn_3(sarv, es, v1, v2, v3);
+        break;
+    case 0x78:
+        gen_gvec_fn_3(shrv, es, v1, v2, v3);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t d2 =3D get_field(s->fields, d2) &
+                       (NUM_VEC_ELEMENT_BITS(es) - 1);
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+    TCGv_i32 shift;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (likely(!get_field(s->fields, b2))) {
+        switch (s->fields->op2) {
+        case 0x30:
+            gen_gvec_fn_2i(shli, es, v1, v3, d2);
+            break;
+        case 0x3a:
+            gen_gvec_fn_2i(sari, es, v1, v3, d2);
+            break;
+        case 0x38:
+            gen_gvec_fn_2i(shri, es, v1, v3, d2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        shift =3D tcg_temp_new_i32();
+        tcg_gen_extrl_i64_i32(shift, o->addr1);
+        tcg_gen_andi_i32(shift, shift, NUM_VEC_ELEMENT_BITS(es) - 1);
+        switch (s->fields->op2) {
+        case 0x30:
+            gen_gvec_fn_2s(shls, es, v1, v3, shift);
+            break;
+        case 0x3a:
+            gen_gvec_fn_2s(sars, es, v1, v3, shift);
+            break;
+        case 0x38:
+            gen_gvec_fn_2s(shrs, es, v1, v3, shift);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tcg_temp_free_i32(shift);
+    }
+    return DISAS_NEXT;
+}
--=20
2.20.1
