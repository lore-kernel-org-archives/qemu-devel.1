Received: from eggs.gnu.org ([2001:4830:134:3::10]:40975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d6BOb-00055t-LP
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d6BOX-0001Tm-OH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d6BOX-0001TB-Hy
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:41:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6304C61D05
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:41:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  4 May 2017 09:41:44 +0200
Message-Id: <1493883704-27604-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/usb/dev-serial: Do not try to set vendorid
 or productid properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

When starting QEMU with the legacy USB serial device like this:

 qemu-system-x86_64 -usbdevice serial:vendorid=0x1234:stdio

it currently aborts since the vendorid property does not exist
anymore (it has been removed by commit f29783f72ea77dfbd7ea0c9):

 Unexpected error in object_property_find() at qemu/qom/object.c:1008:
 qemu-system-x86_64: -usbdevice serial:vendorid=0x1234:stdio: Property
                     '.vendorid' not found
 Aborted (core dumped)

Fix this crash by issuing a more friendly error message instead
(and simplify the code also a little bit this way).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/dev-serial.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 6d51373..83a4f0e 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -513,27 +513,18 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
 {
     USBDevice *dev;
     Chardev *cdrv;
-    uint32_t vendorid = 0, productid = 0;
     char label[32];
     static int index;
 
     while (*filename && *filename != ':') {
         const char *p;
-        char *e;
+
         if (strstart(filename, "vendorid=", &p)) {
-            vendorid = strtol(p, &e, 16);
-            if (e == p || (*e && *e != ',' && *e != ':')) {
-                error_report("bogus vendor ID %s", p);
-                return NULL;
-            }
-            filename = e;
+            error_report("vendorid is not supported anymore");
+            return NULL;
         } else if (strstart(filename, "productid=", &p)) {
-            productid = strtol(p, &e, 16);
-            if (e == p || (*e && *e != ',' && *e != ':')) {
-                error_report("bogus product ID %s", p);
-                return NULL;
-            }
-            filename = e;
+            error_report("productid is not supported anymore");
+            return NULL;
         } else {
             error_report("unrecognized serial USB option %s", filename);
             return NULL;
@@ -554,10 +545,7 @@ static USBDevice *usb_serial_init(USBBus *bus, const char *filename)
 
     dev = usb_create(bus, "usb-serial");
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
-    if (vendorid)
-        qdev_prop_set_uint16(&dev->qdev, "vendorid", vendorid);
-    if (productid)
-        qdev_prop_set_uint16(&dev->qdev, "productid", productid);
+
     return dev;
 }
 
-- 
1.8.3.1
