Received: from eggs.gnu.org ([209.51.188.92]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPu-0007qW-UK
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPt-0005vJ-Il
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:40 +0200
Message-Id: <20190502141019.6385-2-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/40] s390x/tcg: Implement VECTOR ADD
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

Introduce two types of fancy new helpers that will be reused a couple of
times

1. gen_gvec_fn_3: Call an existing tcg_gen_gvec_X function with 3
   parameters, simplifying parameter passing
2. gen_gvec128_3_i64: Call a function that performs 128 bit calculations
   using two 64 bit values per vector.

Luckily, for VECTOR ADD we already have everything we need.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  5 ++++
 target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 71fa9b8d6c..74a0ccc770 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1054,6 +1054,11 @@
 /* VECTOR UNPACK LOGICAL LOW */
     F(0xe7d4, VUPLL,   VRR_a, V,   0, 0, 0, 0, vup, 0, IF_VEC)
=20
+/* =3D=3D=3D Vector Integer Instructions =3D=3D=3D */
+
+/* VECTOR ADD */
+    F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL=
, IF_PRIV)
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 76f9a5d939..2f84ea0511 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -157,6 +157,41 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, ui=
nt8_t reg, TCGv_i64 enr,
                      16)
 #define gen_gvec_dup64i(v1, c) \
     tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
+#define gen_gvec_fn_3(fn, es, v1, v2, v3) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      vec_full_reg_offset(v3), 16, 16)
+
+/*
+ * Helper to carry out a 128 bit vector computation using 2 i64 values p=
er
+ * vector.
+ */
+typedef void (*gen_gvec128_3_i64_fn)(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 =
al,
+                                     TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 =
bh);
+static void gen_gvec128_3_i64(gen_gvec128_3_i64_fn fn, uint8_t d, uint8_=
t a,
+                              uint8_t b)
+{
+        TCGv_i64 dh =3D tcg_temp_new_i64();
+        TCGv_i64 dl =3D tcg_temp_new_i64();
+        TCGv_i64 ah =3D tcg_temp_new_i64();
+        TCGv_i64 al =3D tcg_temp_new_i64();
+        TCGv_i64 bh =3D tcg_temp_new_i64();
+        TCGv_i64 bl =3D tcg_temp_new_i64();
+
+        read_vec_element_i64(ah, a, 0, ES_64);
+        read_vec_element_i64(al, a, 1, ES_64);
+        read_vec_element_i64(bh, b, 0, ES_64);
+        read_vec_element_i64(bl, b, 1, ES_64);
+        fn(dl, dh, al, ah, bl, bh);
+        write_vec_element_i64(dh, d, 0, ES_64);
+        write_vec_element_i64(dl, d, 1, ES_64);
+
+        tcg_temp_free_i64(dh);
+        tcg_temp_free_i64(dl);
+        tcg_temp_free_i64(ah);
+        tcg_temp_free_i64(al);
+        tcg_temp_free_i64(bh);
+        tcg_temp_free_i64(bl);
+}
=20
 static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
 {
@@ -933,3 +968,20 @@ static DisasJumpType op_vup(DisasContext *s, DisasOp=
s *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_va(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    } else if (es =3D=3D ES_128) {
+        gen_gvec128_3_i64(tcg_gen_add2_i64, get_field(s->fields, v1),
+                          get_field(s->fields, v2), get_field(s->fields,=
 v3));
+        return DISAS_NEXT;
+    }
+    gen_gvec_fn_3(add, es, get_field(s->fields, v1), get_field(s->fields=
, v2),
+                  get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1
