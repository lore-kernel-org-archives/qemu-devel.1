Received: from eggs.gnu.org ([2001:4830:134:3::10]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOM3u-0006JB-3p
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOM3t-0006PD-9l
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:43:38 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOM3t-0006C4-4O
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:43:37 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Fri, 23 Jun 2017 12:42:56 +0200
Message-Id: <20170623104256.25868-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH] mips/malta: load the initrd at the end of the
 low memory
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

Currently the malta board is loading the initrd just after the kernel.
This doesn't work for kaslr enabled kernels, as the initrd ends-up being
overwritten.

Move the initrd at the end of the low memory, that should leave a
sufficient gap for kaslr.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 hw/mips/mips_malta.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95cdabb2dd..dad2f37fb1 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -841,8 +841,9 @@ static int64_t load_kernel (void)
     if (loaderparams.initrd_filename) {
         initrd_size = get_image_size (loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
-            if (initrd_offset + initrd_size > ram_size) {
+            initrd_offset = (loaderparams.ram_low_size - initrd_size
+                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
+            if (kernel_high >= initrd_offset) {
                 fprintf(stderr,
                         "qemu: memory too small for initial ram disk '%s'\n",
                         loaderparams.initrd_filename);
-- 
2.11.0
