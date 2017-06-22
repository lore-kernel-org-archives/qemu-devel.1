Received: from eggs.gnu.org ([2001:4830:134:3::10]:44912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1RD-0005VQ-R2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1R9-0005gz-VT
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1R9-0005g1-MU
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:34 +0200
Message-Id: <20170622124204.19407-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/31] i386: use ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

I used the clang-tidy qemu-round check (with the option OnlyAlignUp)
to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 target/i386/arch_dump.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index fe0aa36932..1d51bb5206 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -84,9 +84,9 @@ static int x86_64_write_elf64_note(WriteCoreDumpFunctio=
n f,
     note->n_descsz =3D cpu_to_le32(descsz);
     note->n_type =3D cpu_to_le32(NT_PRSTATUS);
     buf =3D (char *)note;
-    buf +=3D ((sizeof(Elf64_Nhdr) + 3) / 4) * 4;
+    buf +=3D ROUND_UP(sizeof(Elf64_Nhdr), 4);
     memcpy(buf, name, name_size);
-    buf +=3D ((name_size + 3) / 4) * 4;
+    buf +=3D ROUND_UP(name_size, 4);
     memcpy(buf + 32, &id, 4); /* pr_pid */
     buf +=3D descsz - sizeof(x86_64_user_regs_struct)-sizeof(target_ulon=
g);
     memcpy(buf, &regs, sizeof(x86_64_user_regs_struct));
@@ -163,9 +163,9 @@ static int x86_write_elf64_note(WriteCoreDumpFunction=
 f, CPUX86State *env,
     note->n_descsz =3D cpu_to_le32(descsz);
     note->n_type =3D cpu_to_le32(NT_PRSTATUS);
     buf =3D (char *)note;
-    buf +=3D ((sizeof(Elf64_Nhdr) + 3) / 4) * 4;
+    buf +=3D ROUND_UP(sizeof(Elf64_Nhdr), 4);
     memcpy(buf, name, name_size);
-    buf +=3D ((name_size + 3) / 4) * 4;
+    buf +=3D ROUND_UP(name_size, 4);
     memcpy(buf, &prstatus, sizeof(prstatus));
=20
     ret =3D f(note, note_size, opaque);
@@ -218,9 +218,9 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f,=
 CPUState *cs,
     note->n_descsz =3D cpu_to_le32(descsz);
     note->n_type =3D cpu_to_le32(NT_PRSTATUS);
     buf =3D (char *)note;
-    buf +=3D ((sizeof(Elf32_Nhdr) + 3) / 4) * 4;
+    buf +=3D ROUND_UP(sizeof(Elf32_Nhdr), 4);
     memcpy(buf, name, name_size);
-    buf +=3D ((name_size + 3) / 4) * 4;
+    buf +=3D ROUND_UP(name_size, 4);
     memcpy(buf, &prstatus, sizeof(prstatus));
=20
     ret =3D f(note, note_size, opaque);
@@ -353,9 +353,9 @@ static inline int cpu_write_qemu_note(WriteCoreDumpFu=
nction f,
         note64->n_type =3D 0;
     }
     buf =3D note;
-    buf +=3D ((note_head_size + 3) / 4) * 4;
+    buf +=3D ROUND_UP(note_head_size, 4);
     memcpy(buf, name, name_size);
-    buf +=3D ((name_size + 3) / 4) * 4;
+    buf +=3D ROUND_UP(name_size, 4);
     memcpy(buf, &state, sizeof(state));
=20
     ret =3D f(note, note_size, opaque);
--=20
2.13.1.395.gf7b71de06
