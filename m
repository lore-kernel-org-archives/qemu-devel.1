Received: from eggs.gnu.org ([2001:4830:134:3::10]:55852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtk-0005j2-2R
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtg-0005xo-VO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:24 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:33714)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtg-0005xb-PH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:20 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Tue, 11 Jul 2017 16:16:05 +0100
Message-ID: <1499786165-9404-3-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
References: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 2/2] mips/malta: load the initrd at the end of
 the low memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

Currently the malta board is loading the initrd just after the kernel.
This doesn't work for kaslr enabled kernels, as the initrd ends-up being
overwritten.

Move the initrd at the end of the low memory, that should leave a
sufficient gap for kaslr.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/mips/mips_malta.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95cdabb..dad2f37 100644
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
2.7.4
