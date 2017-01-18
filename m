Received: from eggs.gnu.org ([2001:4830:134:3::10]:42276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTrGZ-0007JH-78
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cTrGU-0006Ka-GK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:31:11 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cTrGU-0006J5-5n
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:31:06 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so4475011wmr.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 06:31:05 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 18 Jan 2017 15:30:50 +0100
Message-Id: <1484749850-87206-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH] hw/usb/dev-hid: add a Mac guest compatibility
 option to usb-tablet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>

Darwin/OS X/macOS's HID driver stack does not correctly drive Qemu's simulated USB Tablet. This adds a boolean option "mac_compat" which subtly changes the device so it behaves in a way that Mac guests can handle.

The specific incompatibilities with the regular Qemu USB tablet are:

 1. Absolute pointing devices with HID Report Descriptor usage page of 0x01 (pointing) are handled by the macOS HID driver as analog sticks, so the movement of the cursor ends up being the cumulative deviance from the centre position.
 2. The bInterfaceProtocol of 0x02 enables a particular macOS HID driver mode which only works properly with mice (relative motion) not absolute pointing devices, so spurious events with relative coordinates are generated in addition to absolute ones. This manifests as a very jittery cursor.

The workaround is to report a usage page of 0x02 (mouse) and a bInterfaceProtocol value of 0x00.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

---
 hw/usb/dev-hid.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 24d05f7..0f5b796 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -51,6 +51,7 @@ typedef struct USBHIDState {
     uint32_t usb_version;
     char *display;
     uint32_t head;
+    bool mac_compat;
 } USBHIDState;
 
 #define TYPE_USB_HID "usb-hid"
@@ -200,6 +201,66 @@ static const USBDescIface desc_iface_tablet2 = {
     },
 };
 
+static const USBDescIface desc_iface_tablet_mac_compat = {
+    .bInterfaceNumber              = 0,
+    .bNumEndpoints                 = 1,
+    .bInterfaceClass               = USB_CLASS_HID,
+    .bInterfaceProtocol            = 0x00, /* OSX/macOS can't handle 2 here */
+    .ndesc                         = 1,
+    .descs = (USBDescOther[]) {
+        {
+            /* HID descriptor */
+            .data = (uint8_t[]) {
+                0x09,          /*  u8  bLength */
+                USB_DT_HID,    /*  u8  bDescriptorType */
+                0x01, 0x00,    /*  u16 HID_class */
+                0x00,          /*  u8  country_code */
+                0x01,          /*  u8  num_descriptors */
+                USB_DT_REPORT, /*  u8  type: Report */
+                74, 0,         /*  u16 len */
+            },
+        },
+    },
+    .eps = (USBDescEndpoint[]) {
+        {
+            .bEndpointAddress      = USB_DIR_IN | 0x01,
+            .bmAttributes          = USB_ENDPOINT_XFER_INT,
+            .wMaxPacketSize        = 8,
+            .bInterval             = 0x0a,
+        },
+    },
+};
+
+static const USBDescIface desc_iface_tablet_mac_compat2 = {
+    .bInterfaceNumber              = 0,
+    .bNumEndpoints                 = 1,
+    .bInterfaceClass               = USB_CLASS_HID,
+    .bInterfaceProtocol            = 0x00, /* OSX/macOS can't handle 2 here */
+    .ndesc                         = 1,
+    .descs = (USBDescOther[]) {
+        {
+            /* HID descriptor */
+            .data = (uint8_t[]) {
+                0x09,          /*  u8  bLength */
+                USB_DT_HID,    /*  u8  bDescriptorType */
+                0x01, 0x00,    /*  u16 HID_class */
+                0x00,          /*  u8  country_code */
+                0x01,          /*  u8  num_descriptors */
+                USB_DT_REPORT, /*  u8  type: Report */
+                74, 0,         /*  u16 len */
+            },
+        },
+    },
+    .eps = (USBDescEndpoint[]) {
+        {
+            .bEndpointAddress      = USB_DIR_IN | 0x01,
+            .bmAttributes          = USB_ENDPOINT_XFER_INT,
+            .wMaxPacketSize        = 8,
+            .bInterval             = 4, /* 2 ^ (4-1) * 125 usecs = 1 ms */
+        },
+    },
+};
+
 static const USBDescIface desc_iface_keyboard = {
     .bInterfaceNumber              = 0,
     .bNumEndpoints                 = 1,
@@ -330,6 +391,40 @@ static const USBDescDevice desc_device_tablet2 = {
     },
 };
 
+static const USBDescDevice desc_device_tablet_mac_compat = {
+    .bcdUSB                        = 0x0100,
+    .bMaxPacketSize0               = 8,
+    .bNumConfigurations            = 1,
+    .confs = (USBDescConfig[]) {
+        {
+            .bNumInterfaces        = 1,
+            .bConfigurationValue   = 1,
+            .iConfiguration        = STR_CONFIG_TABLET,
+            .bmAttributes          = USB_CFG_ATT_ONE | USB_CFG_ATT_WAKEUP,
+            .bMaxPower             = 50,
+            .nif = 1,
+            .ifs = &desc_iface_tablet_mac_compat,
+        },
+    },
+};
+
+static const USBDescDevice desc_device_tablet_mac_compat2 = {
+    .bcdUSB                        = 0x0200,
+    .bMaxPacketSize0               = 64,
+    .bNumConfigurations            = 1,
+    .confs = (USBDescConfig[]) {
+        {
+            .bNumInterfaces        = 1,
+            .bConfigurationValue   = 1,
+            .iConfiguration        = STR_CONFIG_TABLET,
+            .bmAttributes          = USB_CFG_ATT_ONE | USB_CFG_ATT_WAKEUP,
+            .bMaxPower             = 50,
+            .nif = 1,
+            .ifs = &desc_iface_tablet_mac_compat2,
+        },
+    },
+};
+
 static const USBDescDevice desc_device_keyboard = {
     .bcdUSB                        = 0x0100,
     .bMaxPacketSize0               = 8,
@@ -426,6 +521,35 @@ static const USBDesc desc_tablet2 = {
     .msos = &desc_msos_suspend,
 };
 
+static const USBDesc desc_tablet_mac_compat = {
+    .id = {
+        .idVendor          = 0x0627,
+        .idProduct         = 0x0002,
+        .bcdDevice         = 0,
+        .iManufacturer     = STR_MANUFACTURER,
+        .iProduct          = STR_PRODUCT_TABLET,
+        .iSerialNumber     = STR_SERIALNUMBER,
+    },
+    .full = &desc_device_tablet_mac_compat,
+    .str  = desc_strings,
+    .msos = &desc_msos_suspend,
+};
+
+static const USBDesc desc_tablet_mac_compat2 = {
+    .id = {
+        .idVendor          = 0x0627,
+        .idProduct         = 0x0002,
+        .bcdDevice         = 0,
+        .iManufacturer     = STR_MANUFACTURER,
+        .iProduct          = STR_PRODUCT_TABLET,
+        .iSerialNumber     = STR_SERIALNUMBER,
+    },
+    .full = &desc_device_tablet_mac_compat,
+    .high = &desc_device_tablet_mac_compat2,
+    .str  = desc_strings,
+    .msos = &desc_msos_suspend,
+};
+
 static const USBDesc desc_keyboard = {
     .id = {
         .idVendor          = 0x0627,
@@ -599,6 +723,9 @@ static void usb_hid_handle_control(USBDevice *dev, USBPacket *p,
                 memcpy(data, qemu_tablet_hid_report_descriptor,
 		       sizeof(qemu_tablet_hid_report_descriptor));
                 p->actual_length = sizeof(qemu_tablet_hid_report_descriptor);
+                if (us->mac_compat) {
+                    data[3] = 0x02; /* Set usage to mouse, not pointing (1) */
+                }
             } else if (hs->kind == HID_KEYBOARD) {
                 memcpy(data, qemu_keyboard_hid_report_descriptor,
                        sizeof(qemu_keyboard_hid_report_descriptor));
@@ -731,8 +858,14 @@ static void usb_hid_initfn(USBDevice *dev, int kind,
 
 static void usb_tablet_realize(USBDevice *dev, Error **errp)
 {
-
-    usb_hid_initfn(dev, HID_TABLET, &desc_tablet, &desc_tablet2, errp);
+    USBHIDState *us = USB_HID(dev);
+    if (us->mac_compat) {
+        usb_hid_initfn(
+            dev, HID_TABLET,
+            &desc_tablet_mac_compat, &desc_tablet_mac_compat2, errp);
+    } else {
+        usb_hid_initfn(dev, HID_TABLET, &desc_tablet, &desc_tablet2, errp);
+    }
 }
 
 static void usb_mouse_realize(USBDevice *dev, Error **errp)
@@ -801,6 +934,7 @@ static Property usb_tablet_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_STRING("display", USBHIDState, display),
         DEFINE_PROP_UINT32("head", USBHIDState, head, 0),
+        DEFINE_PROP_BOOL("mac_compat", USBHIDState, mac_compat, false),
         DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.3.2 (Apple Git-55)
