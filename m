Received: from eggs.gnu.org ([2001:4830:134:3::10]:54342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzbW-0003VH-UK
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzbT-0007Uz-JO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:52:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cuzbT-0007Ug-DK
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:52:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38C9C4E34E
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 10:52:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Apr 2017 12:52:38 +0200
Message-Id: <20170403105238.23262-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] usb-host: switch to LIBUSB_API_VERSION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

libusbx doesn't exist any more, the fork got merged back to libusb.  So
stop using LIBUSBX_API_VERSION and use LIBUSB_API_VERSION instead.  For
backward compatibility alias LIBUSB_API_VERSION to LIBUSBX_API_VERSION
in case we figure LIBUSB_API_VERSION isn't defined.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c9876a5..f9c8eaf 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -159,7 +159,10 @@ static void usb_host_attach_kernel(USBHostDevice *s);
 #define BULK_TIMEOUT         0        /* unlimited */
 #define INTR_TIMEOUT         0        /* unlimited */
 
-#if LIBUSBX_API_VERSION >= 0x01000103
+#ifndef LIBUSB_API_VERSION
+# define LIBUSB_API_VERSION LIBUSBX_API_VERSION
+#endif
+#if LIBUSB_API_VERSION >= 0x01000103
 # define HAVE_STREAMS 1
 #endif
 
@@ -269,7 +272,7 @@ static int usb_host_get_port(libusb_device *dev, char *port, size_t len)
     size_t off;
     int rc, i;
 
-#if LIBUSBX_API_VERSION >= 0x01000102
+#if LIBUSB_API_VERSION >= 0x01000102
     rc = libusb_get_port_numbers(dev, path, 7);
 #else
     rc = libusb_get_port_path(ctx, dev, path, 7);
-- 
2.9.3
