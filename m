Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-00016L-Ak
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNN-0002Tc-JG
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:30 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:59683)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNN-0002TF-D1
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:25 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:09 +0100
Message-ID: <1501771515-22847-3-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 2/8] mips/malta: leave space for the bootmap
 after the initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

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
Tested-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/mips/mips_malta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 8ecd544..9dcec27 100644
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
2.7.4
