Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwY-0008UQ-Ly
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwX-0001ZK-Co
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50158
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1TwX-0001Xx-6C
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:29 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Apr 2017 09:28:35 +0100
Message-Id: <1492763327-12742-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 01/13] cg3: remove TARGET_PAGE_SIZE rounding
 on dirty page detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This was an artifact from very early versions of the code from before the
memory API and is no longer needed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cg3.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 1174220..7d43694 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "cpu.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
@@ -114,7 +113,7 @@ static void cg3_update_display(void *opaque)
     for (y = 0; y < height; y++) {
         int update = s->full_update;
 
-        page = (y * width) & TARGET_PAGE_MASK;
+        page = y * width;
         update |= memory_region_get_dirty(&s->vram_mem, page, page + width,
                                           DIRTY_MEMORY_VGA);
         if (update) {
@@ -148,8 +147,7 @@ static void cg3_update_display(void *opaque)
     }
     if (page_max >= page_min) {
         memory_region_reset_dirty(&s->vram_mem,
-                              page_min, page_max - page_min + TARGET_PAGE_SIZE,
-                              DIRTY_MEMORY_VGA);
+                              page_min, page_max - page_min, DIRTY_MEMORY_VGA);
     }
     /* vsync interrupt? */
     if (s->regs[0] & CG3_CR_ENABLE_INTS) {
-- 
1.7.10.4
