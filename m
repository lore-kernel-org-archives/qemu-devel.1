Received: from eggs.gnu.org ([209.51.188.92]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPw-0007qf-Uo
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPv-0005wd-S3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:32 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:41 +0200
Message-Id: <20190502141019.6385-3-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/40] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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

128-bit handling courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 +
 target/s390x/translate_vx.inc.c | 94 +++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 74a0ccc770..f0e62b9aa8 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1058,6 +1058,8 @@
=20
 /* VECTOR ADD */
     F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
+/* VECTOR ADD COMPUTE CARRY */
+    F(0xe7f1, VACC,    VRR_c, V,   0, 0, 0, 0, vacc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 2f84ea0511..312c5f67be 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -136,6 +136,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
=20
+#define gen_gvec_3(v1, v2, v3, gen) \
+    tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                   vec_full_reg_offset(v3), 16, 16, gen)
 #define gen_gvec_3_ool(v1, v2, v3, data, fn) \
     tcg_gen_gvec_3_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
                        vec_full_reg_offset(v3), 16, 16, data, fn)
@@ -985,3 +988,94 @@ static DisasJumpType op_va(DisasContext *s, DisasOps=
 *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static void gen_acc(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, uint8_t es)
+{
+    const uint8_t msb_bit_nr =3D NUM_VEC_ELEMENT_BITS(es) - 1;
+    TCGv_i64 msb_mask =3D tcg_const_i64(dup_const(es, 1ull << msb_bit_nr=
));
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+    TCGv_i64 t3 =3D tcg_temp_new_i64();
+
+    /* Calculate the carry into the MSB, ignoring the old MSBs */
+    tcg_gen_andc_i64(t1, a, msb_mask);
+    tcg_gen_andc_i64(t2, b, msb_mask);
+    tcg_gen_add_i64(t1, t1, t2);
+    /* Calculate the MSB without any carry into it */
+    tcg_gen_xor_i64(t3, a, b);
+    /* Calculate the carry out of the MSB in the MSB bit position */
+    tcg_gen_and_i64(d, a, b);
+    tcg_gen_and_i64(t1, t1, t3);
+    tcg_gen_or_i64(d, d, t1);
+    /* Isolate and shift the carry into position */
+    tcg_gen_and_i64(d, d, msb_mask);
+    tcg_gen_shri_i64(d, d, msb_bit_nr);
+
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t3);
+}
+
+static void gen_acc8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_8);
+}
+
+static void gen_acc16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_16);
+}
+
+static void gen_acc32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    gen_acc(d, a, b, ES_32);
+}
+
+static void gen_acc_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t =3D tcg_temp_new_i64();
+
+    tcg_gen_add_i64(t, a, b);
+    tcg_gen_setcond_i64(TCG_COND_LTU, d, t, b);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_acc2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al,
+                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
+{
+    TCGv_i64 th =3D tcg_temp_new_i64();
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 zero =3D tcg_const_i64(0);
+
+    tcg_gen_add2_i64(tl, th, al, zero, bl, zero);
+    tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
+    tcg_gen_add2_i64(tl, dl, tl, th, bh, zero);
+    tcg_gen_mov_i64(dh, zero);
+
+    tcg_temp_free_i64(th);
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vacc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fni8 =3D gen_acc8_i64, },
+        { .fni8 =3D gen_acc16_i64, },
+        { .fni8 =3D gen_acc32_i64, },
+        { .fni8 =3D gen_acc_i64, },
+    };
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    } else if (es =3D=3D ES_128) {
+        gen_gvec128_3_i64(gen_acc2_i64, get_field(s->fields, v1),
+                          get_field(s->fields, v2), get_field(s->fields,=
 v3));
+        return DISAS_NEXT;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
--=20
2.20.1
