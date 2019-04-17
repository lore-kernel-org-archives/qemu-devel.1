Received: from eggs.gnu.org ([209.51.188.92]:42388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.santos@pobox.com>) id 1hGqZ9-0005tf-AM
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.santos@pobox.com>) id 1hGqZ8-0004qF-Dq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:49:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <daniel.santos@pobox.com>)
	id 1hGqZ8-0004pd-5e
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:49:54 -0400
From: Daniel Santos <daniel.santos@pobox.com>
Date: Wed, 17 Apr 2019 14:48:21 -0500
Message-Id: <20190417194821.23017-1-daniel.santos@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] mips: Fix "Unexpected FPU mode"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Daniel Santos <daniel.santos@pobox.com>

In load_elf_binary, struct image_info interp_info is used without being
properly initialized.  One result is that when the ELF's program header
doesn't contain an entry for the ABI flags, then the value of the struct
image_info's fp_abi field is set to whatever happened to be in stack
memory at the time.

This patch both sanitizes interp_info and initializes fp_abi for
TARGET_MIPS to MIPS_ABI_FP_UNKNOWN so that when we don't know the FP
ABI, we don't just blow up.  Currently, this bug is a complete stopper
for some MIPS binaries.

***PLEASE NOTE***
There may be other bugs as a result of struct image_info interp_info
fields not being properly initialized -- this patch only addresses the
fp_abi field.  I reccomend somebody who knows the code better than I
audit this function and the whole of that execution path.

Fixes bug #1825002 and affects 3.1.0 and 4.x, reccomend backporting to
3.1.0.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a26021f8..7f09d572a2 100644
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
2.19.2
