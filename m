Received: from eggs.gnu.org ([209.51.188.92]:42046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMcLk-0001uk-Gf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMcLh-0000Ar-Vh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:51:56 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56325 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hMcLg-00008B-2Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:51:52 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  3 May 2019 19:50:46 +0200
Message-Id: <1556905846-14074-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/5] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, nchen@wavecomp.com, daniel.santos@pobox.com, jcmvbkbc@gmail.com, lvivier@redhat.com, thuth@redhat.com, philmd@redhat.com

From: Daniel Santos <daniel.santos@pobox.com>

Sanitize interp_info structure in load_elf_binary() and, for MIPS only,
init its field fp_abi to MIPS_ABI_FP_UNKNOWN. This fixes appearances of
"Unexpected FPU mode" message in some MIPS use cases. Currently, this
bug is a complete stopper for some MIPS binaries.

In load_elf_binary(), struct image_info interp_info is used without
being properly initialized. One result is that when the ELF's program
header doesn't contain an entry for the ABI flags, then the value of
the struct image_info's fp_abi field is set to whatever happened to
be in stack memory at the time.

Backporting to 4.0 and, if possible, to 3.1 is recommended.

Fixes: https://bugs.launchpad.net/qemu/+bug/1825002

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..7f09d57 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, str=
uct image_info *info)
     char *elf_interpreter =3D NULL;
     char *scratch;
=20
+    memset(&interp_info, 0, sizeof(interp_info));
+#ifdef TARGET_MIPS
+    interp_info.fp_abi =3D MIPS_ABI_FP_UNKNOWN;
+#endif
+
     info->start_mmap =3D (abi_ulong)ELF_START_MMAP;
=20
     load_elf_image(bprm->filename, bprm->fd, info,
--=20
2.7.4
