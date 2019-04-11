Received: from eggs.gnu.org ([209.51.188.92]:54895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsW-00039p-Eb
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWe9-0007QC-Bz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 11 Apr 2019 12:08:16 +0200
Message-Id: <20190411100836.646-22-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 21/41] s390x/tcg: Implement VECTOR NAND
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

Part of vector enhancements facility 1, but easy to implement.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      | 2 ++
 target/s390x/translate.c        | 1 +
 target/s390x/translate_vx.inc.c | 7 +++++++
 3 files changed, 10 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2c794a2744..bc8b84e1c2 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1134,6 +1134,8 @@
     F(0xe7a7, VMO,     VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
 /* VECTOR MULTIPLY LOGICAL ODD */
     F(0xe7a5, VMLO,    VRR_c, V,   0, 0, 0, 0, vm, 0, IF_VEC)
+/* VECTOR NAND */
+    F(0xe76e, VNN,     VRR_c, VE,  0, 0, 0, 0, vnn, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a800aa9dc9..c6378b2b53 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6099,6 +6099,7 @@ enum DisasInsnEnum {
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
 #define FAC_V           S390_FEAT_VECTOR /* vector facility */
+#define FAC_VE          S390_FEAT_VECTOR_ENH /* vector enhancements faci=
lity 1 */
=20
 static const DisasInsn insn_info[] =3D {
 #include "insn-data.def"
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 53bbb4a2ce..aa01d6274c 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1789,3 +1789,10 @@ static DisasJumpType op_vm(DisasContext *s, DisasO=
ps *o)
                get_field(s->fields, v3), fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vnn(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_fn_3(nand, ES_8, get_field(s->fields, v1),
+                  get_field(s->fields, v2), get_field(s->fields, v3));
+    return DISAS_NEXT;
+}
--=20
2.20.1
