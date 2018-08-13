Received: from eggs.gnu.org ([2001:4830:134:3::10]:59887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH3I-0005sQ-55
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpH39-0007ED-Co
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55856 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpH38-0007Bu-PN
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:54:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 13 Aug 2018 19:53:47 +0200
Message-Id: <1534182832-554-83-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 82/87] linux-user: Add support for nanoMIPS
 core files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

nanoMIPs core files require value EF_NANOMIPS_ABI_P32 to be passed
to the e_flags part of the core's elf header.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/elfload.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612..366ef3b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1291,6 +1291,10 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_CLASS ELFCLASS64
 #endif
 
+#ifdef TARGET_ABI_MIPSP32
+#define ELF_FLAGS EF_NANOMIPS_ABI_P32
+#endif
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1400,6 +1404,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_HWCAP 0
 #endif
 
+#ifndef ELF_FLAGS
+#define ELF_FLAGS 0
+#endif
+
 #ifndef STACK_GROWS_DOWN
 #define STACK_GROWS_DOWN 1
 #endif
@@ -3432,7 +3440,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
      * Construct valid coredump ELF header.  We also
      * add one more segment for notes.
      */
-    fill_elf_header(&elf, segs + 1, ELF_MACHINE, 0);
+    fill_elf_header(&elf, segs + 1, ELF_MACHINE, ELF_FLAGS);
     if (dump_write(fd, &elf, sizeof (elf)) != 0)
         goto out;
 
-- 
2.7.4
