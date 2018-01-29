Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg6b3-0006Nm-Fc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg6b0-0001VZ-NR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eg6b0-0001Uv-Ij
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:26 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 11:23:15 +0100
Message-Id: <20180129102320.21534-3-kraxel@redhat.com>
In-Reply-To: <20180129102320.21534-1-kraxel@redhat.com>
References: <20180129102320.21534-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] input: virtio: don't send mouse wheel event
 twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Miika S <miika9764@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Miika S <miika9764@gmail.com>

On Linux, a mouse event is generated for both down and up when mouse
wheel is used. This caused virtio_input_send() to be called twice each
time the wheel was used.

This commit adds a check for the button down state and only calls
virtio_input_send() when it is true.

Signed-off-by: Miika S <miika9764@gmail.com>
Message-Id: <20171222152531.1849-4-miika9764@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/virtio-input-hid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index a5917c2754..be054fd272 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -218,8 +218,10 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
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
2.9.3
