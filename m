Received: from eggs.gnu.org ([209.51.188.92]:47036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hMXAi-0004rp-UJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hMXAi-0006BV-2M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:20:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1hMXAh-0006An-SR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:20:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id h11so6492804wmb.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:20:11 -0700 (PDT)
Date: Fri, 3 May 2019 14:20:07 +0200
From: Giuseppe Musacchio <thatlemon@gmail.com>
Message-ID: <20190503122007.lkjsvztgt4ycovac@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] linux-user: elf: Map empty PT_LOAD segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, peter.maydell@linaro.org

Some PT_LOAD segments may be completely zeroed out and their p_filesize
is zero, in that case the loader should just allocate a page that's at
least p_memsz bytes large (plus eventual alignment padding).

Calling zero_bss does this job for us, all we have to do is make sure we
don't try to mmap a zero-length page.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..138735b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2366,11 +2366,19 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
             vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, vaddr_len,
-                                elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                image_fd, eppnt->p_offset - vaddr_po);
-            if (error == -1) {
-                goto exit_perror;
+            /*
+             * Some segments may be completely empty without any backing file
+             * segment, in that case just let zero_bss allocate an empty buffer
+             * for it.
+             */
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
