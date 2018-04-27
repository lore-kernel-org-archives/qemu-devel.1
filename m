Received: from eggs.gnu.org ([2001:4830:134:3::10]:47787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC0Ue-0006zs-8E
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC0UZ-0003M7-Pv
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC0UZ-0003LQ-Im
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:20:39 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 12:20:32 +0200
Message-Id: <20180427102033.20232-3-kraxel@redhat.com>
In-Reply-To: <20180427102033.20232-1-kraxel@redhat.com>
References: <20180427102033.20232-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] Fix libusb-1.0.22 deprecated
 libusb_set_debug with libusb_set_option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Thomson <git@johnthomson.fastmail.com.au>

From: John Thomson <git@johnthomson.fastmail.com.au>

libusb-1.0.22 marked libusb_set_debug deprecated
it is replaced with
libusb_set_option(libusb_context, LIBUSB_OPTION_LOG_LEVEL, libusb_log_level);

details here: https://github.com/libusb/libusb/commit/539f22e2fd916558d11ab9a66f10f461c5593168

Warning here:

  CC      hw/usb/host-libusb.o
/builds/xen/src/qemu-xen/hw/usb/host-libusb.c: In function 'usb_host_init':
/builds/xen/src/qemu-xen/hw/usb/host-libusb.c:250:5: error: 'libusb_set_debug' is deprecated: Use libusb_set_option instead [-Werror=deprecated-declarations]
     libusb_set_debug(ctx, loglevel);
     ^~~~~~~~~~~~~~~~
In file included from /builds/xen/src/qemu-xen/hw/usb/host-libusb.c:40:0:
/usr/include/libusb-1.0/libusb.h:1300:18: note: declared here
 void LIBUSB_CALL libusb_set_debug(libusb_context *ctx, int level);
                  ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/builds/xen/src/qemu-xen/rules.mak:66: hw/usb/host-libusb.o] Error 1
make: Leaving directory '/builds/xen/src/xen/tools/qemu-xen-build'

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
Message-id: 20180405132046.4968-1-git@johnthomson.fastmail.com.au
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 1b0be071cc..dc0a8fe295 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -247,7 +247,11 @@ static int usb_host_init(void)
     if (rc != 0) {
         return -1;
     }
+#if LIBUSB_API_VERSION >= 0x01000106
+    libusb_set_option(ctx, LIBUSB_OPTION_LOG_LEVEL, loglevel);
+#else
     libusb_set_debug(ctx, loglevel);
+#endif
 #ifdef CONFIG_WIN32
     /* FIXME: add support for Windows. */
 #else
-- 
2.9.3
