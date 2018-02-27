Received: from eggs.gnu.org ([2001:4830:134:3::10]:55127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazs-0003RG-9R
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazr-00083m-Hr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqazr-00083c-C2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:52:05 +0100
Message-Id: <20180227085209.19151-4-kraxel@redhat.com>
In-Reply-To: <20180227085209.19151-1-kraxel@redhat.com>
References: <20180227085209.19151-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v5 3/7] ui/pixman: add
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
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

Map drm fourcc codes to pixman formats.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/qemu-pixman.h |  5 +++++
 ui/qemu-pixman.c         | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 4a67e01232..b7c82d17fc 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -33,6 +33,8 @@
 # define PIXMAN_BE_r8g8b8a8   PIXMAN_r8g8b8a8
 # define PIXMAN_BE_x8b8g8r8   PIXMAN_x8b8g8r8
 # define PIXMAN_BE_a8b8g8r8   PIXMAN_a8b8g8r8
+# define PIXMAN_LE_r8g8b8     PIXMAN_b8g8r8
+# define PIXMAN_LE_a8r8g8b8   PIXMAN_b8g8r8a8
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_b8g8r8x8
 #else
 # define PIXMAN_BE_r8g8b8     PIXMAN_b8g8r8
@@ -44,6 +46,8 @@
 # define PIXMAN_BE_r8g8b8a8   PIXMAN_a8b8g8r8
 # define PIXMAN_BE_x8b8g8r8   PIXMAN_r8g8b8x8
 # define PIXMAN_BE_a8b8g8r8   PIXMAN_r8g8b8a8
+# define PIXMAN_LE_r8g8b8     PIXMAN_r8g8b8
+# define PIXMAN_LE_a8r8g8b8   PIXMAN_a8r8g8b8
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_x8r8g8b8
 #endif
 
@@ -51,6 +55,7 @@
 
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
 pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
+pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
 int qemu_pixman_get_type(int rshift, int gshift, int bshift);
 pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf);
 bool qemu_pixman_check_format(DisplayChangeListener *dcl,
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 6e591ab821..3e52abd92d 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "ui/console.h"
+#include "standard-headers/drm/drm_fourcc.h"
 
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
 {
@@ -88,6 +89,27 @@ pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian)
     return 0;
 }
 
+/* Note: drm is little endian, pixman is native endian */
+pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format)
+{
+    static const struct {
+        uint32_t drm_format;
+        pixman_format_code_t pixman;
+    } map[] = {
+        { DRM_FORMAT_RGB888,   PIXMAN_LE_r8g8b8   },
+        { DRM_FORMAT_ARGB8888, PIXMAN_LE_a8r8g8b8 },
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
