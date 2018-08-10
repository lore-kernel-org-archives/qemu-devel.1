Received: from eggs.gnu.org ([2001:4830:134:3::10]:53269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo5W6-0000JG-KH
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo5W3-0006L3-GC
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:23:38 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45385
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fo5W3-0006If-8k
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:23:35 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 10 Aug 2018 12:23:23 +0100
Message-Id: <20180810112323.25206-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] sun4u: ensure kernel_top is always initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com, thuth@redhat.com

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
