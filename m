Received: from eggs.gnu.org ([209.51.188.92]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPy-0007rU-Ox
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPx-0005y3-Mi
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:42 +0200
Message-Id: <20190502141019.6385-4-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/40] s390x/tcg: Implement VECTOR ADD WITH
 CARRY
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

Only slightly ugly, perform two additions. At least it is only supported
for 128 bit elements.

Introduce gen_gvec128_4_i64() similar to gen_gvec128_3_i64().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f0e62b9aa8..38d1e22a6d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1060,6 +1060,8 @@
     F(0xe7f3, VA,      VRR_c, V,   0, 0, 0, 0, va, 0, IF_VEC)
 /* VECTOR ADD COMPUTE CARRY */
     F(0xe7f1, VACC,    VRR_c, V,   0, 0, 0, 0, vacc, 0, IF_VEC)
+/* VECTOR ADD WITH CARRY */
+    F(0xe7bb, VAC,     VRR_d, V,   0, 0, 0, 0, vac, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 312c5f67be..c70f380209 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -196,6 +196,41 @@ static void gen_gvec128_3_i64(gen_gvec128_3_i64_fn f=
n, uint8_t d, uint8_t a,
         tcg_temp_free_i64(bl);
 }
=20
+typedef void (*gen_gvec128_4_i64_fn)(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 =
al,
+                                     TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 =
bh,
+                                     TCGv_i64 cl, TCGv_i64 ch);
+static void gen_gvec128_4_i64(gen_gvec128_4_i64_fn fn, uint8_t d, uint8_=
t a,
+                              uint8_t b, uint8_t c)
+{
+        TCGv_i64 dh =3D tcg_temp_new_i64();
+        TCGv_i64 dl =3D tcg_temp_new_i64();
+        TCGv_i64 ah =3D tcg_temp_new_i64();
+        TCGv_i64 al =3D tcg_temp_new_i64();
+        TCGv_i64 bh =3D tcg_temp_new_i64();
+        TCGv_i64 bl =3D tcg_temp_new_i64();
+        TCGv_i64 ch =3D tcg_temp_new_i64();
+        TCGv_i64 cl =3D tcg_temp_new_i64();
+
+        read_vec_element_i64(ah, a, 0, ES_64);
+        read_vec_element_i64(al, a, 1, ES_64);
+        read_vec_element_i64(bh, b, 0, ES_64);
+        read_vec_element_i64(bl, b, 1, ES_64);
+        read_vec_element_i64(ch, c, 0, ES_64);
+        read_vec_element_i64(cl, c, 1, ES_64);
+        fn(dl, dh, al, ah, bl, bh, cl, ch);
+        write_vec_element_i64(dh, d, 0, ES_64);
+        write_vec_element_i64(dl, d, 1, ES_64);
+
+        tcg_temp_free_i64(dh);
+        tcg_temp_free_i64(dl);
+        tcg_temp_free_i64(ah);
+        tcg_temp_free_i64(al);
+        tcg_temp_free_i64(bh);
+        tcg_temp_free_i64(bl);
+        tcg_temp_free_i64(ch);
+        tcg_temp_free_i64(cl);
+}
+
 static void gen_gvec_dupi(uint8_t es, uint8_t reg, uint64_t c)
 {
     switch (es) {
@@ -1079,3 +1114,31 @@ static DisasJumpType op_vacc(DisasContext *s, Disa=
sOps *o)
                get_field(s->fields, v3), &g[es]);
     return DISAS_NEXT;
 }
+
+static void gen_ac2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i64 =
ah,
+                        TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64 =
ch)
+{
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 th =3D tcg_const_i64(0);
+
+    /* extract the carry only */
+    tcg_gen_extract_i64(tl, cl, 0, 1);
+    tcg_gen_add2_i64(dl, dh, al, ah, bl, bh);
+    tcg_gen_add2_i64(dl, dh, dl, dh, tl, th);
+
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(th);
+}
+
+static DisasJumpType op_vac(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec128_4_i64(gen_ac2_i64, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
,
+                      get_field(s->fields, v4));
+    return DISAS_NEXT;
+}
--=20
2.20.1
