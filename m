Received: from eggs.gnu.org ([2001:4830:134:3::10]:36373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eE8YI-00078E-Hy
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1eE8YF-0005D7-Fd
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 01:49:02 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Mon, 13 Nov 2017 07:48:45 +0100
Message-Id: <20171113064845.29142-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 2.12] target/i386: Fix compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

These gcc warnings are fixed:

target/i386/translate.c:4461:12: warning:
 variable =E2=80=98prefixes=E2=80=99 might be clobbered by =E2=80=98longj=
mp=E2=80=99 or =E2=80=98vfork=E2=80=99 [-Wclobbered]
target/i386/translate.c:4466:9: warning:
 variable =E2=80=98rex_w=E2=80=99 might be clobbered by =E2=80=98longjmp=E2=
=80=99 or =E2=80=98vfork=E2=80=99 [-Wclobbered]
target/i386/translate.c:4466:16: warning:
 variable =E2=80=98rex_r=E2=80=99 might be clobbered by =E2=80=98longjmp=E2=
=80=99 or =E2=80=98vfork=E2=80=99 [-Wclobbered]

Tested with x86_64-w64-mingw32-gcc from Debian stretch.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 target/i386/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 088a9d9766..f410938244 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4467,10 +4467,7 @@ static target_ulong disas_insn(DisasContext *s, CP=
UState *cpu)
     target_ulong pc_start =3D s->base.pc_next;
=20
     s->pc_start =3D s->pc =3D pc_start;
-    prefixes =3D 0;
     s->override =3D -1;
-    rex_w =3D -1;
-    rex_r =3D 0;
 #ifdef TARGET_X86_64
     s->rex_x =3D 0;
     s->rex_b =3D 0;
@@ -4484,6 +4481,10 @@ static target_ulong disas_insn(DisasContext *s, CP=
UState *cpu)
         return s->pc;
     }
=20
+    prefixes =3D 0;
+    rex_w =3D -1;
+    rex_r =3D 0;
+
  next_byte:
     b =3D x86_ldub_code(env, s);
     /* Collect prefixes.  */
--=20
2.11.0
