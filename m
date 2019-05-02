Received: from eggs.gnu.org ([209.51.188.92]:38582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQO-0008Et-N2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQN-0006qU-PU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:00 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:54 +0200
Message-Id: <20190502141019.6385-16-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/40] s390x/tcg: Implement VECTOR LOAD
 COMPLEMENT
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

We can reuse an existing gvec helper for negating the values.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index add174b793..07868ff082 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1094,6 +1094,8 @@
     F(0xe7b4, VGFM,    VRR_c, V,   0, 0, 0, 0, vgfm, 0, IF_VEC)
 /* VECTOR GALOIS FIELD MULTIPLY SUM AND ACCUMULATE */
     F(0xe7bc, VGFMA,   VRR_d, V,   0, 0, 0, 0, vgfma, 0, IF_VEC)
+/* VECTOR LOAD COMPLEMENT */
+    F(0xe7de, VLC,     VRR_a, V,   0, 0, 0, 0, vlc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index dbe0b6a560..e3cc200679 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -209,6 +209,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
                      16)
 #define gen_gvec_dup64i(v1, c) \
     tcg_gen_gvec_dup64i(vec_full_reg_offset(v1), 16, 16, c)
+#define gen_gvec_fn_2(fn, es, v1, v2) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      16, 16)
 #define gen_gvec_fn_3(fn, es, v1, v2, v3) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       vec_full_reg_offset(v3), 16, 16)
@@ -1517,3 +1520,16 @@ static DisasJumpType op_vgfma(DisasContext *s, Dis=
asOps *o)
                get_field(s->fields, v3), get_field(s->fields, v4), &g[es=
]);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_fn_2(neg, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
+    return DISAS_NEXT;
+}
--=20
2.20.1
