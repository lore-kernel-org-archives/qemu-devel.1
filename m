Received: from eggs.gnu.org ([209.51.188.92]:46211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hH9Bv-000695-DQ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hH9Bu-0003Nu-Ab
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:43:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1hH9Bt-0002mS-TS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:43:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id h4so3514602wre.7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:43:00 -0700 (PDT)
Date: Thu, 18 Apr 2019 17:42:55 +0200
From: Giuseppe Musacchio <thatlemon@gmail.com>
Message-ID: <20190418153631.rl3lgadzrqqof72p@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: elf: Map empty PT_LOAD sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

Some PT_LOAD sections may be completely zeroed out and their p_filesize
is zero, in that case the loader should just allocate a page that's at
least p_memsz bytes large (plus eventual alignment padding).

Calling zero_bss does this job for us, all we have to do is make sure we
don't try to mmap a zero-length page.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 linux-user/elfload.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..e9a0951 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2366,11 +2366,17 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
             vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, vaddr_len,
-                                elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                image_fd, eppnt->p_offset - vaddr_po);
-            if (error == -1) {
-                goto exit_perror;
+            /* Some sections may be completely empty without any backing file
+             * segment, in that case just let zero_bss allocate an empty buffer
+             * for it. */
+            if (eppnt->p_filesz != 0) {
+                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
+                                    MAP_PRIVATE | MAP_FIXED,
+                                    image_fd, eppnt->p_offset - vaddr_po);
+
+                if (error == -1) {
+                    goto exit_perror;
+                }
             }
 
             vaddr_ef = vaddr + eppnt->p_filesz;
-- 
2.20.1
