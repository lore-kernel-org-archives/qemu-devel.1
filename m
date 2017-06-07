Received: from eggs.gnu.org ([2001:4830:134:3::10]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dISn9-0005NT-Fa
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dISn4-0004Eh-Jv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:41:59 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dISn4-0004DL-DB
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:41:54 -0400
Received: by mail-pf0-x241.google.com with SMTP id y7so356849pfd.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 21:41:52 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Tue,  6 Jun 2017 21:41:48 -0700
Message-Id: <20170607044148.10481-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] [PATCH] Remove restriction that prevents bootimg elf64
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>

It is possible to create a 64 bit elf image that has valid multiboot header.
qemu should be able to boot such images.

Tested with homemade 64bit OS - now it boots fine with 'qemu -kernel'
and as a grub image.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 hw/i386/multiboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 663f35a658..cf1b4f5fb3 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -192,11 +192,6 @@ int load_multiboot(FWCfgState *fw_cfg,
         int kernel_size;
         fclose(f);
 
-        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
-            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n");
-            exit(1);
-        }
-
         kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
                                &elf_low, &elf_high, 0, I386_ELF_MACHINE,
                                0, 0);
-- 
2.13.1
