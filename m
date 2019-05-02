Received: from eggs.gnu.org ([209.51.188.92]:38792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQe-0000Ds-Fc
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQd-00073Q-Ib
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:16 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:10:01 +0200
Message-Id: <20190502141019.6385-23-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 22/40] s390x/tcg: Implement VECTOR NOT
 EXCLUSIVE OR
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

Again, part of vector enhancement facility 1. The operation corresponds
to an bitwise equality check.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      | 2 ++
 target/s390x/translate_vx.inc.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 4983867a44..b549b76b96 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1138,6 +1138,8 @@
     F(0xe76e, VNN,     VRR_c, VE,  0, 0, 0, 0, vnn, 0, IF_VEC)
 /* VECTOR NOR */
     F(0xe76b, VNO,     VRR_c, V,   0, 0, 0, 0, vno, 0, IF_VEC)
+/* VECTOR NOT EXCLUSIVE OR */
+    F(0xe76c, VNX,     VRR_c, VE,  0, 0, 0, 0, vnx, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 6aa996d230..c67edd4f44 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1801,3 +1801,10 @@ static DisasJumpType op_vno(DisasContext *s, Disas=
Ops *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vnx(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(eqv, ES_8, get_field(s->fields, v1), get_field(s->fiel=
ds, v2),
+                  get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1
