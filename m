Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWse-0002Xe-8e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWdZ-0007A4-IG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:08:54 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:01 +0200
Message-Id: <20190411100836.646-7-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 06/41] s390x/tcg: Implement VECTOR AND (WITH
 COMPLEMENT)
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

Easy, as we can reuse existing gvec helpers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a531b21908..456d5597ca 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1064,6 +1064,10 @@
     F(0xe7bb, VAC,     VRR_d, V,   0, 0, 0, 0, vac, 0, IF_VEC)
 /* VECTOR ADD WITH CARRY COMPUTE CARRY */
     F(0xe7b9, VACCC,   VRR_d, V,   0, 0, 0, 0, vaccc, 0, IF_VEC)
+/* VECTOR AND */
+    F(0xe768, VN,      VRR_c, V,   0, 0, 0, 0, vn, 0, IF_VEC)
+/* VECTOR AND WITH COMPLEMENT */
+    F(0xe769, VNC,     VRR_c, V,   0, 0, 0, 0, vnc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index a264aa0c5a..aaa247e855 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1135,3 +1135,17 @@ static DisasJumpType op_vaccc(DisasContext *s, Dis=
asOps *o)
                    gen_helper_gvec_vaccc128);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vn(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(and, ES_8, get_field(s->fields, v1), get_field(s->fiel=
ds, v2),
+                  get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_vnc(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(andc, ES_8, get_field(s->fields, v1),
+                  get_field(s->fields, v2), get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1
