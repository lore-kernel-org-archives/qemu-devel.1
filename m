Received: from eggs.gnu.org ([2001:4830:134:3::10]:57701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVgj-0005bz-NM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVge-0006Um-RH
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIVge-0006UY-IR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:47:28 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 11:46:30 +0400
Message-Id: <20170607074632.13162-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-1-marcandre.lureau@redhat.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] arch: introduce ELF_NOTE_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Factour out a common pattern to compute the ELF note size.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 target/i386/arch_dump.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 158e056b59..4471f44e3d 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -18,6 +18,11 @@
 #include "elf.h"
 #include "sysemu/memory_mapping.h"
=20
+#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
+    ((DIV_ROUND_UP((hdr_size), 4)                       \
+      + DIV_ROUND_UP((name_size), 4)                    \
+      + DIV_ROUND_UP((desc_size), 4)) * 4)
+
 #ifdef TARGET_X86_64
 typedef struct {
     target_ulong r15, r14, r13, r12, rbp, rbx, r11, r10;
@@ -77,9 +82,7 @@ static int x86_64_write_elf64_note(WriteCoreDumpFunctio=
n f,
     regs.gs =3D env->segs[R_GS].selector;
=20
     descsz =3D sizeof(x86_64_elf_prstatus);
-    note_size =3D (DIV_ROUND_UP(sizeof(Elf64_Nhdr), 4)
-                 + DIV_ROUND_UP(name_size, 4)
-                 + DIV_ROUND_UP(descsz, 4)) * 4;
+    note_size =3D ELF_NOTE_SIZE(sizeof(Elf64_Nhdr), name_size, descsz);
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -157,9 +160,7 @@ static int x86_write_elf64_note(WriteCoreDumpFunction=
 f, CPUX86State *env,
=20
     x86_fill_elf_prstatus(&prstatus, env, id);
     descsz =3D sizeof(x86_elf_prstatus);
-    note_size =3D (DIV_ROUND_UP(sizeof(Elf64_Nhdr), 4)
-                 + DIV_ROUND_UP(name_size, 4)
-                 + DIV_ROUND_UP(descsz, 4)) * 4;
+    note_size =3D ELF_NOTE_SIZE(sizeof(Elf64_Nhdr), name_size, descsz);
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -213,9 +214,7 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f,=
 CPUState *cs,
=20
     x86_fill_elf_prstatus(&prstatus, &cpu->env, cpuid);
     descsz =3D sizeof(x86_elf_prstatus);
-    note_size =3D (DIV_ROUND_UP(sizeof(Elf32_Nhdr), 4)
-                 + DIV_ROUND_UP(name_size, 4)
-                 + DIV_ROUND_UP(descsz, 4)) * 4;
+    note_size =3D ELF_NOTE_SIZE(sizeof(Elf32_Nhdr), name_size, descsz);
     note =3D g_malloc0(note_size);
     note->n_namesz =3D cpu_to_le32(name_size);
     note->n_descsz =3D cpu_to_le32(descsz);
@@ -446,12 +445,8 @@ ssize_t cpu_get_note_size(int class, int machine, in=
t nr_cpus)
 #endif
     qemu_desc_size =3D sizeof(QEMUCPUState);
=20
-    elf_note_size =3D (DIV_ROUND_UP(note_head_size, 4)
-                     + DIV_ROUND_UP(name_size, 4)
-                     + DIV_ROUND_UP(elf_desc_size, 4)) * 4;
-    qemu_note_size =3D (DIV_ROUND_UP(note_head_size, 4)
-                      + DIV_ROUND_UP(name_size, 4)
-                      + DIV_ROUND_UP(qemu_desc_size, 4)) * 4;
+    elf_note_size =3D ELF_NOTE_SIZE(note_head_size, name_size, elf_desc_=
size);
+    qemu_note_size =3D ELF_NOTE_SIZE(note_head_size, name_size, qemu_des=
c_size);
=20
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
--=20
2.13.0.91.g00982b8dd
