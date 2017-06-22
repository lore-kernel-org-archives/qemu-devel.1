Received: from eggs.gnu.org ([2001:4830:134:3::10]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TA-0007kX-VQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1T9-0006vM-VZ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1T9-0006v9-M7
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:19 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:57 +0200
Message-Id: <20170622124204.19407-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 24/31] i386/dump: use DIV_ROUND_UP
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

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 target/i386/arch_dump.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 1d51bb5206..e081f677fa 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -77,8 +77,8 @@ static int x86_64_write_elf64_note(WriteCoreDumpFunctio=
n f,
     regs.gs =3D env->segs[R_GS].selector;
=20
     descsz =3D sizeof(x86_64_elf_prstatus);
-    note_size =3D ((sizeof(Elf64_Nhdr) + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(sizeof(Elf64_Nhdr), 4) + DIV_ROUND_UP(na=
me_size, 4) +
+                DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -156,8 +156,8 @@ static int x86_write_elf64_note(WriteCoreDumpFunction=
 f, CPUX86State *env,
=20
     x86_fill_elf_prstatus(&prstatus, env, id);
     descsz =3D sizeof(x86_elf_prstatus);
-    note_size =3D ((sizeof(Elf64_Nhdr) + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(sizeof(Elf64_Nhdr), 4) + DIV_ROUND_UP(na=
me_size, 4) +
+                DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -211,8 +211,8 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f,=
 CPUState *cs,
=20
     x86_fill_elf_prstatus(&prstatus, &cpu->env, cpuid);
     descsz =3D sizeof(x86_elf_prstatus);
-    note_size =3D ((sizeof(Elf32_Nhdr) + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(sizeof(Elf32_Nhdr), 4) + DIV_ROUND_UP(na=
me_size, 4) +
+                DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -338,8 +338,8 @@ static inline int cpu_write_qemu_note(WriteCoreDumpFu=
nction f,
     } else {
         note_head_size =3D sizeof(Elf64_Nhdr);
     }
-    note_size =3D ((note_head_size + 3) / 4 + (name_size + 3) / 4 +
-                (descsz + 3) / 4) * 4;
+    note_size =3D (DIV_ROUND_UP(note_head_size, 4) + DIV_ROUND_UP(name_s=
ize, 4) +
+                DIV_ROUND_UP(descsz, 4)) * 4;
     note =3D g_malloc0(note_size);
     if (type =3D=3D 0) {
         note32 =3D note;
@@ -443,10 +443,10 @@ ssize_t cpu_get_note_size(int class, int machine, i=
nt nr_cpus)
 #endif
     qemu_desc_size =3D sizeof(QEMUCPUState);
=20
-    elf_note_size =3D ((note_head_size + 3) / 4 + (name_size + 3) / 4 +
-                     (elf_desc_size + 3) / 4) * 4;
-    qemu_note_size =3D ((note_head_size + 3) / 4 + (name_size + 3) / 4 +
-                      (qemu_desc_size + 3) / 4) * 4;
+    elf_note_size =3D (DIV_ROUND_UP(note_head_size, 4) + DIV_ROUND_UP(na=
me_size, 4) +
+                     DIV_ROUND_UP(elf_desc_size, 4)) * 4;
+    qemu_note_size =3D (DIV_ROUND_UP(note_head_size, 4) + DIV_ROUND_UP(n=
ame_size, 4) +
+                      DIV_ROUND_UP(qemu_desc_size, 4)) * 4;
=20
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
--=20
2.13.1.395.gf7b71de06
