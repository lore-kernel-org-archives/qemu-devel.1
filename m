Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRB-0001Dq-Ss
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCRA-0007au-Vw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:15 +0200
Message-Id: <20190502141019.6385-37-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 36/40] s390x/tcg: Implement VECTOR SUBTRACT
 WITH BORROW COMPUTE BORROW INDICATION
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

Mostly courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a60d8531dc..a8d90517f6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1180,6 +1180,8 @@
     F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
 /* VECTOR SUBTRACT WITH BORROW INDICATION */
     F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
+/* VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION */
+    F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 6e9cbe4c1a..b0b4d3640e 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2214,3 +2214,37 @@ static DisasJumpType op_vsbi(DisasContext *s, Disa=
sOps *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static void gen_sbcbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i=
64 ah,
+                           TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i=
64 ch)
+{
+    TCGv_i64 th =3D tcg_temp_new_i64();
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 zero =3D tcg_const_i64(0);
+
+    tcg_gen_andi_i64(tl, cl, 1);
+    tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
+    tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
+    tcg_gen_andi_i64(th, th, 1);
+    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
+    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
+    tcg_gen_andi_i64(dl, th, 1);
+    tcg_gen_mov_i64(dh, zero);
+
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(th);
+    tcg_temp_free_i64(zero);
+}
+
+static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec128_4_i64(gen_sbcbi2_i64, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
,
+                      get_field(s->fields, v4));
+    return DISAS_NEXT;
+}
--=20
2.20.1
