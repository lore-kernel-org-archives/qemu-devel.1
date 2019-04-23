Received: from eggs.gnu.org ([209.51.188.92]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hIzMH-00081U-GM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hIzKY-00086B-Ts
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:35:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49630 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hIzKW-00080Y-T2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:35:41 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Apr 2019 19:35:26 +0200
Message-Id: <1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info and,
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, daniel.santos@pobox.com, jcmvbkbc@gmail.com, lvivier@redhat.com, thuth@redhat.com

From: Daniel Santos <daniel.santos@pobox.com>

Sanitize interp_info structure in load_elf_binary() and, for mips only,
init its field fp_abi. This fixes appearances of "Unexpected FPU mode"
message in some MIPS use cases.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..7f09d57 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     char *elf_interpreter = NULL;
     char *scratch;
 
+    memset(&interp_info, 0, sizeof(interp_info));
+#ifdef TARGET_MIPS
+    interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
+#endif
+
     info->start_mmap = (abi_ulong)ELF_START_MMAP;
 
     load_elf_image(bprm->filename, bprm->fd, info,
-- 
2.7.4
