Received: from eggs.gnu.org ([2001:4830:134:3::10]:37678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFg1o-0003ru-AT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFg1i-0001ec-Kk
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:18:08 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:50292)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFg1i-0001e3-AK
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:18:02 -0400
From: Geoffrey McRae <geoff@hostfission.com>
Date: Mon, 7 May 2018 23:01:46 +1000
Message-Id: <20180507131759.A3F8F381908@moya.office.hostfission.com>
Subject: [Qemu-devel] [PATCHv2 1/2] ps2: Clear the PS/2 queue and obey
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

This allows guest's to correctly reinitialize and identify the mouse
should the guest decide to re-scan or reset during mouse input events.

When the guest sends the "Identify" command, due to the PC's hardware
architecutre it is impossible to reliably determine the response from
the command amongst other streaming data, such as mouse or keyboard
events. Standard practice is for the guest to disable the device and
then issue the identify command, so this must be obeyed.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 hw/input/ps2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 06f5d2ac4a..f84a8f5179 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -232,6 +232,9 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     uint16_t keycode = 0;
     int mod;
 
+    if (!s->scan_enabled)
+        return;
+
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
     qcode = qemu_input_key_value_to_qcode(key->key);
@@ -673,6 +676,9 @@ static void ps2_mouse_sync(DeviceState *dev)
 {
     PS2MouseState *s = (PS2MouseState *)dev;
 
+    if (!(s->mouse_status & MOUSE_STATUS_ENABLED))
+        return;
+
     if (s->mouse_buttons) {
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     }
@@ -776,6 +782,7 @@ void ps2_write_mouse(void *opaque, int val)
             s->mouse_resolution = 2;
             s->mouse_status = 0;
             s->mouse_type = 0;
+            ps2_reset_queue(&s->common);
             ps2_queue(&s->common, AUX_ACK);
             ps2_queue(&s->common, 0xaa);
             ps2_queue(&s->common, s->mouse_type);
-- 
2.14.2
