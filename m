Received: from eggs.gnu.org ([2001:4830:134:3::10]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frqA6-0006g0-Os
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1frqA0-0000AB-SO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:46575
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1frq9w-0008UQ-P7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:48:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 20 Aug 2018 20:47:54 +0100
Message-Id: <20180820194755.30731-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180820194755.30731-1-mark.cave-ayland@ilande.co.uk>
References: <20180820194755.30731-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 1/2] sun4u: ensure kernel_top is always
 initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org

Valgrind reports that when loading a non-ELF kernel, kernel_top may be used
uninitialised when checking for an initrd.

Since there are no known non-ELF kernels for SPARC64 then we can simply
initialise kernel_top to 0 and then skip the initrd load process if it hasn't
been set by load_elf().

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 74b748497e..d16843b30e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -139,7 +139,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
     unsigned int i;
     long kernel_size;
     uint8_t *ptr;
-    uint64_t kernel_top;
+    uint64_t kernel_top = 0;
 
     linux_boot = (kernel_filename != NULL);
 
@@ -172,7 +172,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
         }
         /* load initrd above kernel */
         *initrd_size = 0;
-        if (initrd_filename) {
+        if (initrd_filename && kernel_top) {
             *initrd_addr = TARGET_PAGE_ALIGN(kernel_top);
 
             *initrd_size = load_image_targphys(initrd_filename,
-- 
2.11.0
