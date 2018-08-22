Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsOAQ-0001qi-Bp
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsO1i-00012N-SH
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:58:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 22 Aug 2018 09:57:47 +0200
Message-Id: <20180822075750.12399-6-david@redhat.com>
In-Reply-To: <20180822075750.12399-1-david@redhat.com>
References: <20180822075750.12399-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 5/8] s390x/tcg: check for AFP-register,
 BFP and DFP data exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

With the annotated functions, we can now easily check this at a central
place.

DXC 1 is to be injected if an AFP register is used (for a HFP instruction=
)
when AFP is disabled.
DXC 2 is to be injected if a BFP instruction is used when AFP is
disabled.
DXC =C2=A7 is to be injected if a DFP instruction is used when AFP is
disabled.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8322c81e90..a0c834ebb9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6055,6 +6055,11 @@ static const DisasInsn *extract_insn(CPUS390XState=
 *env, DisasContext *s,
     return info;
 }
=20
+static bool is_afp_reg(int reg)
+{
+    return reg % 2 || reg > 6;
+}
+
 static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 {
     const DisasInsn *insn;
@@ -6081,6 +6086,34 @@ static DisasJumpType translate_one(CPUS390XState *=
env, DisasContext *s)
     }
 #endif
=20
+    /* process flags */
+    if (insn->flags) {
+        /* if AFP is not enabled, instructions and registers are forbidd=
en */
+        if (!(s->base.tb->flags & FLAG_MASK_AFP)) {
+            uint8_t dxc =3D 0;
+
+            if ((insn->flags & IF_HFP1) && is_afp_reg(get_field(&f, r1))=
) {
+                dxc =3D 1;
+            }
+            if ((insn->flags & IF_HFP2) && is_afp_reg(get_field(&f, r2))=
) {
+                dxc =3D 1;
+            }
+            if ((insn->flags & IF_HFP3) && is_afp_reg(get_field(&f, r3))=
) {
+                dxc =3D 1;
+            }
+            if (insn->flags & IF_BFP) {
+                dxc =3D 2;
+            }
+            if (insn->flags & IF_DFP) {
+                dxc =3D 3;
+            }
+            if (dxc) {
+                gen_data_exception(dxc);
+                return DISAS_NORETURN;
+            }
+        }
+    }
+
     /* Check for insn specification exceptions.  */
     if (insn->spec) {
         int spec =3D insn->spec, excp =3D 0, r;
--=20
2.17.1
