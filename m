Received: from eggs.gnu.org ([2001:4830:134:3::10]:40778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBbtc-0007qD-D5
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBbtY-0000Dd-G2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBbtY-0000DW-Ac
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD5897AE9E
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:00:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 19 May 2017 09:00:04 +0200
Message-Id: <1495177204-16808-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: Simplify the parameter parsing of the
 legacy usb serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Coverity complains about the current code, so let's get rid of
the now unneeded while loop and simply always emit "unrecognized
serial USB option" for all unsupported options.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/dev-serial.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 83a4f0e..76ceca1 100644
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
1.8.3.1
