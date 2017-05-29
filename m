Received: from eggs.gnu.org ([2001:4830:134:3::10]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKR3-0007yk-Vo
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKR0-0002I4-IK
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFKR0-0002HR-CJ
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 15:09:51 +0200
Message-Id: <20170529130956.20297-5-kraxel@redhat.com>
In-Reply-To: <20170529130956.20297-1-kraxel@redhat.com>
References: <20170529130956.20297-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] usb: Simplify the parameter parsing of the
 legacy usb serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Thomas Huth <thuth@redhat.com>

Coverity complains about the current code, so let's get rid of
the now unneeded while loop and simply always emit "unrecognized
serial USB option" for all unsupported options.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1495177204-16808-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 83a4f0e6fb..76ceca1f5c 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -516,27 +516,16 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
     char label[32];
     static int index;
 
-    while (*filename && *filename != ':') {
-        const char *p;
-
-        if (strstart(filename, "vendorid=", &p)) {
-            error_report("vendorid is not supported anymore");
-            return NULL;
-        } else if (strstart(filename, "productid=", &p)) {
-            error_report("productid is not supported anymore");
-            return NULL;
-        } else {
-            error_report("unrecognized serial USB option %s", filename);
-            return NULL;
-        }
-        while(*filename == ',')
-            filename++;
+    if (*filename == ':') {
+        filename++;
+    } else if (*filename) {
+        error_report("unrecognized serial USB option %s", filename);
+        return NULL;
     }
     if (!*filename) {
         error_report("character device specification needed");
         return NULL;
     }
-    filename++;
 
     snprintf(label, sizeof(label), "usbserial%d", index++);
     cdrv = qemu_chr_new(label, filename);
-- 
2.9.3
