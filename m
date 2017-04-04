Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcY-00026h-KN
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvLcT-0002Ck-Kx
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvLcT-0002Bb-Fi
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:23:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  4 Apr 2017 12:23:10 +0200
Message-Id: <20170404102315.24923-6-kraxel@redhat.com>
In-Reply-To: <20170404102315.24923-1-kraxel@redhat.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] cg3: remove TARGET_PAGE_SIZE rounding on
 dirty page detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This was an artifact from very early versions of the code from before the
memory API and is no longer needed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/cg3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 1174220..e05ca92 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -114,7 +114,7 @@ static void cg3_update_display(void *opaque)
     for (y = 0; y < height; y++) {
         int update = s->full_update;
 
-        page = (y * width) & TARGET_PAGE_MASK;
+        page = y * width;
         update |= memory_region_get_dirty(&s->vram_mem, page, page + width,
                                           DIRTY_MEMORY_VGA);
         if (update) {
@@ -148,8 +148,7 @@ static void cg3_update_display(void *opaque)
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
2.9.3
