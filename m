Received: from eggs.gnu.org ([2001:4830:134:3::10]:39667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cWRJZ-0006Nc-Ik
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cWRJW-0000Dc-Eh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:24:57 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cWRJW-0000DQ-7K
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:24:54 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so44114938wmd.2
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:24:52 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 25 Jan 2017 18:24:35 +0100
Message-Id: <1485365075-32702-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH v3] hw/usb/dev-hid: Improve guest compatibility
 of usb-tablet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Phil Dennis-Jordan <phil@philjordan.eu>

 1. Set bInterfaceProtocol to 0x00 for usb-tablet. This should be non-zero for boot protocol devices only, which the usb-tablet is not.
 2. Set the usb-tablet's usage to "mouse" in the report descriptor.

The boot protocol of 0x02 specifically confused OS X/macOS' HID driver stack, causing it to generate additional bogus HID events with relative motion in addition to the tablet's absolute coordinate events.

Absolute pointing devices with HID Report Descriptor usage of 0x01 (pointing) are treated by the macOS HID driver as analog sticks, and absolute coordinates are not directly translated to absolute mouse cursor positions. Changing it to 0x02 (mouse) fixes the problem, and does not have any adverse effect in other operating systems and windowing systems. (VMWare does the same thing.)

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---

Changelog
=========

v2 -> v3:
 * v2 Thread was "[PATCH v2 0/2] hw/usb/dev-hid: Make usb-tablet work with OS X/macOS guests"
 * Changing the report descriptor to 0x02 (mouse) does not seem to have an adverse effect on any guests, so just change it for everyone instead of adding an option.
 * The 2 patches are now tiny, so combine them back into one.

v1 -> v2:
 * v1 Thread was "[PATCH] hw/usb/dev-hid: add a Mac guest compatibility option to usb-tablet"
 * Always apply the boot protocol (bInterfaceProtocol) change to usb-tablet, not just when the Mac compatibility option is active. The original value of 0x02 was determined to be incorrect according to the spec anyway.
 * As the boot protocol change is permanent, separate interface and device descriptor constants for the Mac/non-Mac variants of the tablet are no longer required, and have been removed.


 hw/usb/dev-hid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 24d05f7..dda0bf0 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -144,7 +144,7 @@ static const USBDescIface desc_iface_tablet = {
     .bInterfaceNumber              = 0,
     .bNumEndpoints                 = 1,
     .bInterfaceClass               = USB_CLASS_HID,
-    .bInterfaceProtocol            = 0x02,
+    .bInterfaceProtocol            = 0x00,
     .ndesc                         = 1,
     .descs = (USBDescOther[]) {
         {
@@ -174,7 +174,7 @@ static const USBDescIface desc_iface_tablet2 = {
     .bInterfaceNumber              = 0,
     .bNumEndpoints                 = 1,
     .bInterfaceClass               = USB_CLASS_HID,
-    .bInterfaceProtocol            = 0x02,
+    .bInterfaceProtocol            = 0x00,
     .ndesc                         = 1,
     .descs = (USBDescOther[]) {
         {
@@ -487,7 +487,7 @@ static const uint8_t qemu_mouse_hid_report_descriptor[] = {
 
 static const uint8_t qemu_tablet_hid_report_descriptor[] = {
     0x05, 0x01,		/* Usage Page (Generic Desktop) */
-    0x09, 0x01,		/* Usage (Pointer) */
+    0x09, 0x02,		/* Usage (Mouse) */
     0xa1, 0x01,		/* Collection (Application) */
     0x09, 0x01,		/*   Usage (Pointer) */
     0xa1, 0x00,		/*   Collection (Physical) */
-- 
2.3.2 (Apple Git-55)
