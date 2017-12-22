Received: from eggs.gnu.org ([2001:4830:134:3::10]:60818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPDL-0003Rf-IU
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPDK-0001Qf-Nf
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:23 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:47001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1eSPDK-0001Oz-Ft
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:22 -0500
Received: by mail-lf0-x242.google.com with SMTP id r143so31869005lfe.13
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 07:26:22 -0800 (PST)
From: Miika S <miika9764@gmail.com>
Date: Fri, 22 Dec 2017 17:25:31 +0200
Message-Id: <20171222152531.1849-4-miika9764@gmail.com>
In-Reply-To: <20171222152531.1849-1-miika9764@gmail.com>
References: <20171222152531.1849-1-miika9764@gmail.com>
Subject: [Qemu-devel] [PATCH 3/3] input: virtio: don't send mouse wheel
 event twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, Miika S <miika9764@gmail.com>

On Linux, a mouse event is generated for both down and up when mouse
wheel is used. This caused virtio_input_send() to be called twice each
time the wheel was used.

This commit adds a check for the button down state and only calls
virtio_input_send() when it is true.

Signed-off-by: Miika S <miika9764@gmail.com>
---
 hw/input/virtio-input-hid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 2cac659469..587616a932 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -225,8 +225,10 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
         break;
     case INPUT_EVENT_KIND_BTN:
         btn = evt->u.btn.data;
-        if (vhid->wheel_axis && (btn->button == INPUT_BUTTON_WHEEL_UP ||
-                                 btn->button == INPUT_BUTTON_WHEEL_DOWN)) {
+        if (vhid->wheel_axis &&
+            (btn->button == INPUT_BUTTON_WHEEL_UP ||
+             btn->button == INPUT_BUTTON_WHEEL_DOWN) &&
+            btn->down) {
             event.type  = cpu_to_le16(EV_REL);
             event.code  = cpu_to_le16(REL_WHEEL);
             event.value = cpu_to_le32(btn->button == INPUT_BUTTON_WHEEL_UP
-- 
2.15.1
