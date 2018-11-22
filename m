Received: from eggs.gnu.org ([2001:4830:134:3::10]:41853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPsNu-0002CB-HD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gPsNq-0003WP-Gt
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:03:22 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gPsNp-0003OX-00
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:03:18 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 17:03:09 +0000
Message-Id: <20181122170309.4856-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0] ui/console: Remove
 qemu_create_display_surface_guestmem()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

The qemu_create_display_surface_guestmem() function was added in
commit a77549b3ffcc24c32ee4e but apparently never used. Remove it.

(The API of this function is in any case awkward as a generic
function: it assumes that a physical address uniquely identifies
a piece of memory in the system, which is mostly but not
always true.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/ui/console.h |  4 ----
 ui/console.c         | 36 ------------------------------------
 2 files changed, 40 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index c17803c530a..853fcf4eb75 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -257,10 +257,6 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
                                                 pixman_format_code_t format,
                                                 int linesize, uint8_t *data);
 DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
-DisplaySurface *qemu_create_displaysurface_guestmem(int width, int height,
-                                                    pixman_format_code_t format,
-                                                    int linesize,
-                                                    uint64_t addr);
 DisplaySurface *qemu_create_message_surface(int w, int h,
                                             const char *msg);
 PixelFormat qemu_default_pixelformat(int bpp);
diff --git a/ui/console.c b/ui/console.c
index 3a285bae00a..7076becedd5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1385,42 +1385,6 @@ DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
     return surface;
 }
 
-static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
-                                               void *unused)
-{
-    void *data = pixman_image_get_data(image);
-    uint32_t size = pixman_image_get_stride(image) *
-        pixman_image_get_height(image);
-    cpu_physical_memory_unmap(data, size, 0, 0);
-}
-
-DisplaySurface *qemu_create_displaysurface_guestmem(int width, int height,
-                                                    pixman_format_code_t format,
-                                                    int linesize, uint64_t addr)
-{
-    DisplaySurface *surface;
-    hwaddr size;
-    void *data;
-
-    if (linesize == 0) {
-        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
-    }
-
-    size = (hwaddr)linesize * height;
-    data = cpu_physical_memory_map(addr, &size, 0);
-    if (size != (hwaddr)linesize * height) {
-        cpu_physical_memory_unmap(data, size, 0, 0);
-        return NULL;
-    }
-
-    surface = qemu_create_displaysurface_from
-        (width, height, format, linesize, data);
-    pixman_image_set_destroy_function
-        (surface->image, qemu_unmap_displaysurface_guestmem, NULL);
-
-    return surface;
-}
-
 DisplaySurface *qemu_create_message_surface(int w, int h,
                                             const char *msg)
 {
-- 
2.19.1
