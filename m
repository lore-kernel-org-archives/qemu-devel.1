Received: from eggs.gnu.org ([209.51.188.92]:45535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOT-0004v8-F8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOR-000787-O3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOR-00073l-DM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:19 +0100
Message-Id: <20190130073426.11525-2-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] usb: assign unique serial numbers to hid
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Windows guests have trouble dealing with usb devices having identical
serial numbers.  So, assign unique serial numbers to usb hid devices.
All other usb devices have this already.

In the past the fixed serial number has been used to indicate working
remote setup to linux guests.  Here is a bit of history:

 * First there was nothing.
 * Then I added a rule to udev checking for serial == 42.
   (this is in rhel-6).
 * Then systemd + udev merged.
 * Then I changed the rule to check for serial != 1 instead, so we can
   use any serial but "1" which is the one the old broken devices had
   (this is in rhel-7).  March 2014 in upstream systemd.
 * Then all usb power management rules where dropped from systemd (June
   2015).  Which I figured today (Sept 2018), after wondering that the
   rules are gone in fedora 28.

So, three years ago the serial number check was dropped upstream, yet I
hav't seen a single report about autosuspend issues (or cpu usage for
usb emulation going up, which is the typical symtom).

So I figured I can stop worring that changing the serial number will
break things and just do it.

And even if it turns out autosuspend is still an issue:  I think
meanwhile we can really stop worrying about guests running in old qemu
versions with broken usb suspend (fixed in 0.13 !).  If needed we can
enable autosuspend unconditionally in guests.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190110125108.22834-1-kraxel@redhat.com
---
 hw/core/machine.c |  3 +++
 hw/usb/dev-hid.c  | 26 +++++++++++++++-----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2629515363..077fbd182a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,9 @@ GlobalProperty hw_compat_3_1[] = {
     { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
     { "tpm-crb", "ppi", "false" },
     { "tpm-tis", "ppi", "false" },
+    { "usb-kbd", "serial", "42" },
+    { "usb-mouse", "serial", "42" },
+    { "usb-kbd", "serial", "42" },
 };
 const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 90cd745f06..f9ea3033a1 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -61,10 +61,13 @@ enum {
     STR_PRODUCT_MOUSE,
     STR_PRODUCT_TABLET,
     STR_PRODUCT_KEYBOARD,
-    STR_SERIALNUMBER,
+    STR_SERIAL_COMPAT,
     STR_CONFIG_MOUSE,
     STR_CONFIG_TABLET,
     STR_CONFIG_KEYBOARD,
+    STR_SERIAL_MOUSE,
+    STR_SERIAL_TABLET,
+    STR_SERIAL_KEYBOARD,
 };
 
 static const USBDescStrings desc_strings = {
@@ -72,10 +75,13 @@ static const USBDescStrings desc_strings = {
     [STR_PRODUCT_MOUSE]    = "QEMU USB Mouse",
     [STR_PRODUCT_TABLET]   = "QEMU USB Tablet",
     [STR_PRODUCT_KEYBOARD] = "QEMU USB Keyboard",
-    [STR_SERIALNUMBER]     = "42", /* == remote wakeup works */
+    [STR_SERIAL_COMPAT]    = "42",
     [STR_CONFIG_MOUSE]     = "HID Mouse",
     [STR_CONFIG_TABLET]    = "HID Tablet",
     [STR_CONFIG_KEYBOARD]  = "HID Keyboard",
+    [STR_SERIAL_MOUSE]     = "89126",
+    [STR_SERIAL_TABLET]    = "28754",
+    [STR_SERIAL_KEYBOARD]  = "68284",
 };
 
 static const USBDescIface desc_iface_mouse = {
@@ -375,7 +381,7 @@ static const USBDesc desc_mouse = {
         .bcdDevice         = 0,
         .iManufacturer     = STR_MANUFACTURER,
         .iProduct          = STR_PRODUCT_MOUSE,
-        .iSerialNumber     = STR_SERIALNUMBER,
+        .iSerialNumber     = STR_SERIAL_MOUSE,
     },
     .full = &desc_device_mouse,
     .str  = desc_strings,
@@ -389,7 +395,7 @@ static const USBDesc desc_mouse2 = {
         .bcdDevice         = 0,
         .iManufacturer     = STR_MANUFACTURER,
         .iProduct          = STR_PRODUCT_MOUSE,
-        .iSerialNumber     = STR_SERIALNUMBER,
+        .iSerialNumber     = STR_SERIAL_MOUSE,
     },
     .full = &desc_device_mouse,
     .high = &desc_device_mouse2,
@@ -404,7 +410,7 @@ static const USBDesc desc_tablet = {
         .bcdDevice         = 0,
         .iManufacturer     = STR_MANUFACTURER,
         .iProduct          = STR_PRODUCT_TABLET,
-        .iSerialNumber     = STR_SERIALNUMBER,
+        .iSerialNumber     = STR_SERIAL_TABLET,
     },
     .full = &desc_device_tablet,
     .str  = desc_strings,
@@ -418,7 +424,7 @@ static const USBDesc desc_tablet2 = {
         .bcdDevice         = 0,
         .iManufacturer     = STR_MANUFACTURER,
         .iProduct          = STR_PRODUCT_TABLET,
-        .iSerialNumber     = STR_SERIALNUMBER,
+        .iSerialNumber     = STR_SERIAL_TABLET,
     },
     .full = &desc_device_tablet,
     .high = &desc_device_tablet2,
@@ -433,7 +439,7 @@ static const USBDesc desc_keyboard = {
         .bcdDevice         = 0,
         .iManufacturer     = STR_MANUFACTURER,
         .iProduct          = STR_PRODUCT_KEYBOARD,
-        .iSerialNumber     = STR_SERIALNUMBER,
+        .iSerialNumber     = STR_SERIAL_KEYBOARD,
     },
     .full = &desc_device_keyboard,
     .str  = desc_strings,
@@ -447,7 +453,7 @@ static const USBDesc desc_keyboard2 = {
         .bcdDevice         = 0,
         .iManufacturer     = STR_MANUFACTURER,
         .iProduct          = STR_PRODUCT_KEYBOARD,
-        .iSerialNumber     = STR_SERIALNUMBER,
+        .iSerialNumber     = STR_SERIAL_KEYBOARD,
     },
     .full = &desc_device_keyboard,
     .high = &desc_device_keyboard2,
@@ -718,9 +724,7 @@ static void usb_hid_initfn(USBDevice *dev, int kind,
         return;
     }
 
-    if (dev->serial) {
-        usb_desc_set_string(dev, STR_SERIALNUMBER, dev->serial);
-    }
+    usb_desc_create_serial(dev);
     usb_desc_init(dev);
     us->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
     hid_init(&us->hid, kind, usb_hid_changed);
-- 
2.9.3
