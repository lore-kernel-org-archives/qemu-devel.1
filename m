Received: from eggs.gnu.org ([2001:4830:134:3::10]:41499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8K-0001jW-NH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8G-00047Y-Pe
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1v8G-00047A-Kn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:40 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:03:31 +0200
Message-Id: <20171010140334.8231-4-kraxel@redhat.com>
In-Reply-To: <20171010140334.8231-1-kraxel@redhat.com>
References: <20171010140334.8231-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 3/6] ui/pixman: add
 qemu_drm_format_to_pixman()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Map drm fourcc codes to pixman formats.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/qemu-pixman.h |  1 +
 ui/qemu-pixman.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 4a67e01232..75661db080 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -51,6 +51,7 @@
 
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
 pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
+pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
 int qemu_pixman_get_type(int rshift, int gshift, int bshift);
 pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf);
 bool qemu_pixman_check_format(DisplayChangeListener *dcl,
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 6e591ab821..2c389ad323 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "ui/console.h"
+#include "standard-headers/drm/drm_fourcc.h"
 
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
 {
@@ -88,6 +89,25 @@ pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian)
     return 0;
 }
 
+/* Note: drm is little endian, pixman is native endian */
+pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format)
+{
+    static const struct {
+        uint32_t drm_format;
+        pixman_format_code_t pixman;
+    } map[] = {
+        { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 }
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(map); i++) {
+        if (drm_format == map[i].drm_format) {
+            return map[i].pixman;
+        }
+    }
+    return 0;
+}
+
 int qemu_pixman_get_type(int rshift, int gshift, int bshift)
 {
     int type = PIXMAN_TYPE_OTHER;
-- 
2.9.3
