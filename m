Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNhnO-0007fg-H6
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNhnN-0003fX-3T
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:43:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNhnM-0003ek-R3
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:43:53 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Jun 2017 17:43:47 +0200
Message-Id: <20170621154347.32084-2-kraxel@redhat.com>
In-Reply-To: <20170621154347.32084-1-kraxel@redhat.com>
References: <20170621154347.32084-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] usb-host: support devices with
 sparse/non-sequential USB interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Brian <sam.brian@accelerated.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Samuel Brian <sam.brian@accelerated.com>

Some USB devices have sparse interface numbering which is not able to be
passthroughed.
For example, the Sierra Wireless MC7455/MC7430:

  # lsusb  -D /dev/bus/usb/003/003 | egrep '1199|9071|bNumInterfaces|bInterfaceNumber'
  Device: ID 1199:9071 Sierra Wireless, Inc.
    idVendor           0x1199 Sierra Wireless, Inc.
    idProduct          0x9071
      bNumInterfaces          5
        bInterfaceNumber        0
        bInterfaceNumber        2
        bInterfaceNumber        3
        bInterfaceNumber        8
        bInterfaceNumber       10

In this case, the interface numbers are 0, 2, 3, 8, 10 and not the
0, 1, 2, 3, 4 that QEMU tries to claim.

This change allows sparse USB interface numbering.
Instead of only claiming the interfaces in the range reported by the USB
device through bNumInterfaces, QEMU attempts to claim all possible
interfaces.

v2 to fix broken v1 patch formatting.
v3 to fix indentation.

Signed-off-by: Samuel Brian <sam.brian@accelerated.com>
Message-id: 20170613234039.27201-1-sam.brian@accelerated.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/host-libusb.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index f9c8eafe06..1b0be071cc 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1107,7 +1107,7 @@ static void usb_host_detach_kernel(USBHostDevice *s)
     if (rc != 0) {
         return;
     }
-    for (i = 0; i < conf->bNumInterfaces; i++) {
+    for (i = 0; i < USB_MAX_INTERFACES; i++) {
         rc = libusb_kernel_driver_active(s->dh, i);
         usb_host_libusb_error("libusb_kernel_driver_active", rc);
         if (rc != 1) {
@@ -1130,7 +1130,7 @@ static void usb_host_attach_kernel(USBHostDevice *s)
     if (rc != 0) {
         return;
     }
-    for (i = 0; i < conf->bNumInterfaces; i++) {
+    for (i = 0; i < USB_MAX_INTERFACES; i++) {
         if (!s->ifs[i].detached) {
             continue;
         }
@@ -1145,7 +1145,7 @@ static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
 {
     USBDevice *udev = USB_DEVICE(s);
     struct libusb_config_descriptor *conf;
-    int rc, i;
+    int rc, i, claimed;
 
     for (i = 0; i < USB_MAX_INTERFACES; i++) {
         udev->altsetting[i] = 0;
@@ -1164,14 +1164,19 @@ static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
         return USB_RET_STALL;
     }
 
-    for (i = 0; i < conf->bNumInterfaces; i++) {
+    claimed = 0;
+    for (i = 0; i < USB_MAX_INTERFACES; i++) {
         trace_usb_host_claim_interface(s->bus_num, s->addr, configuration, i);
         rc = libusb_claim_interface(s->dh, i);
-        usb_host_libusb_error("libusb_claim_interface", rc);
-        if (rc != 0) {
-            return USB_RET_STALL;
+        if (rc == 0) {
+            s->ifs[i].claimed = true;
+            if (++claimed == conf->bNumInterfaces) {
+                break;
+            }
         }
-        s->ifs[i].claimed = true;
+    }
+    if (claimed != conf->bNumInterfaces) {
+        return USB_RET_STALL;
     }
 
     udev->ninterfaces   = conf->bNumInterfaces;
@@ -1183,10 +1188,9 @@ static int usb_host_claim_interfaces(USBHostDevice *s, int configuration)
 
 static void usb_host_release_interfaces(USBHostDevice *s)
 {
-    USBDevice *udev = USB_DEVICE(s);
     int i, rc;
 
-    for (i = 0; i < udev->ninterfaces; i++) {
+    for (i = 0; i < USB_MAX_INTERFACES; i++) {
         if (!s->ifs[i].claimed) {
             continue;
         }
-- 
2.9.3
