Received: from eggs.gnu.org ([209.51.188.92]:54388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsC-0002Us-NT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWeg-0007g9-Jw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:31 +0200
Message-Id: <20190411100836.646-37-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 36/41] s390x/tcg: Implement VECTOR SUBTRACT
 WITH BORROW INDICATION
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

Fairly easy as only 128-bit handling is required. Simply perform the
subtraction and then subtract the borrow.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 94de3c9c7d..a60d8531dc 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1178,6 +1178,8 @@
     F(0xe7f7, VS,      VRR_c, V,   0, 0, 0, 0, vs, 0, IF_VEC)
 /* VECTOR SUBTRACT COMPUTE BORROW INDICATION */
     F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
+/* VECTOR SUBTRACT WITH BORROW INDICATION */
+    F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7770ca4101..3f60b97654 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2185,3 +2185,30 @@ static DisasJumpType op_vscbi(DisasContext *s, Dis=
asOps *o)
                get_field(s->fields, v3), &g[es]);
     return DISAS_NEXT;
 }
+
+static void gen_sbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al, TCGv_i64=
 ah,
+                         TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64=
 ch)
+{
+    TCGv_i64 tl =3D tcg_temp_new_i64();
+    TCGv_i64 th =3D tcg_const_i64(0);
+
+    /* extract the borrow only */
+    tcg_gen_extract_i64(tl, cl, 0, 1);
+    tcg_gen_sub2_i64(dl, dh, al, ah, bl, bh);
+    tcg_gen_sub2_i64(dl, dh, dl, dh, tl, th);
+    tcg_temp_free_i64(tl);
+    tcg_temp_free_i64(th);
+}
+
+static DisasJumpType op_vsbi(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec128_4_i64(gen_sbi2_i64, get_field(s->fields, v1),
+                      get_field(s->fields, v2), get_field(s->fields, v3)=
,
+                      get_field(s->fields, v4));
+    return DISAS_NEXT;
+}
--=20
2.20.1
