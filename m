Received: from eggs.gnu.org ([2001:4830:134:3::10]:40118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUYLO-0007YP-R1
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cUYLL-0007gA-22
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:31:02 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cUYLK-0007fi-SM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:30:58 -0500
Received: by mail-wm0-x241.google.com with SMTP id r144so6409191wme.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:30:58 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 20 Jan 2017 13:30:17 +0100
Message-Id: <1484915417-10499-3-git-send-email-phil@philjordan.eu>
In-Reply-To: <1484915417-10499-1-git-send-email-phil@philjordan.eu>
References: <1484915417-10499-1-git-send-email-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] hw/usb/dev-hid: add a usb-tablet Mac
 guest compatibility option
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

Darwin/OS X/macOS's HID driver stack previously did not correctly drive Qemu's simulated USB Tablet. This adds a boolean option "mac_compat" to the device which subtly changes the device's report descriptor so it behaves in a way that Mac guests can handle.

Absolute pointing devices with HID Report Descriptor usage page of 0x01 (pointing) are handled by the macOS HID driver as analog sticks, and absolute coordinates are not directly translated to absolute mouse cursor positions.

The workaround is to report a usage page of 0x02 (mouse) instead. In combination with the previous commit's boot protocol fix, this allows the usb-tablet to correctly control the mouse cursor in OS X/macOS guest systems.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/dev-hid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index a23e5d4..c4a0d22 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -51,6 +51,7 @@ typedef struct USBHIDState {
     uint32_t usb_version;
     char *display;
     uint32_t head;
+    bool mac_compat;
 } USBHIDState;
 
 #define TYPE_USB_HID "usb-hid"
@@ -599,6 +600,9 @@ static void usb_hid_handle_control(USBDevice *dev, USBPacket *p,
                 memcpy(data, qemu_tablet_hid_report_descriptor,
 		       sizeof(qemu_tablet_hid_report_descriptor));
                 p->actual_length = sizeof(qemu_tablet_hid_report_descriptor);
+                if (us->mac_compat) {
+                    data[3] = 0x02; /* Set usage to mouse, not pointing (1) */
+                }
             } else if (hs->kind == HID_KEYBOARD) {
                 memcpy(data, qemu_keyboard_hid_report_descriptor,
                        sizeof(qemu_keyboard_hid_report_descriptor));
@@ -801,6 +805,7 @@ static Property usb_tablet_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_STRING("display", USBHIDState, display),
         DEFINE_PROP_UINT32("head", USBHIDState, head, 0),
+        DEFINE_PROP_BOOL("mac_compat", USBHIDState, mac_compat, false),
         DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.3.2 (Apple Git-55)
