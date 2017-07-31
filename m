Received: from eggs.gnu.org ([2001:4830:134:3::10]:43055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dcJY5-0007oA-8l
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 18:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dcJY4-0006Mu-JT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 18:52:29 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:58130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dcJY4-00065l-DK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 18:52:28 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  1 Aug 2017 00:52:10 +0200
Message-Id: <20170731225210.7829-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH for 2.10] mips/malta: leave space for the
 bootmap after the initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Since commit 9768e2abf7 the initrd is loaded at the end of the low
memory to avoid clash for the kernel relocation when kaslr is used.

However this in turn conflicts with the bootmap memory that the kernel
tries to place after initrd, but in low memory. The bootmap spans the
whole usable physical address space. The machine can have at most 2GiB
of memory, 256MiB of low memory mapped at 0x00000000, and 1792MiB of
high memory mapped at 0x90000000. The biggest bootmap therefore
corresponds to the adresses 0x00000000 -> 0xffffffff, which at 1 bit
per 4kiB page corresponds to 128kiB in memory.

Therefore reserve 128kiB after the initrd.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 hw/mips/mips_malta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 8ecd544baa..9dcec27304 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -843,7 +843,10 @@ static int64_t load_kernel (void)
     if (loaderparams.initrd_filename) {
         initrd_size = get_image_size (loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = (loaderparams.ram_low_size - initrd_size
+            /* The kernel allocates the bootmap memory in the low memory after
+               the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
+               pages.  */
+            initrd_offset = (loaderparams.ram_low_size - initrd_size - 131072
                              - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
             if (kernel_high >= initrd_offset) {
                 fprintf(stderr,
-- 
2.13.2
