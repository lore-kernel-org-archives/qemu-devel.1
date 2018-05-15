Received: from eggs.gnu.org ([2001:4830:134:3::10]:55040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWUa-0002wy-TG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWUX-0004ut-QN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:43:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIWUX-0004tg-MR
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:43:33 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:43:31 +0200
Message-Id: <20180515094332.4907-2-kraxel@redhat.com>
In-Reply-To: <20180515094332.4907-1-kraxel@redhat.com>
References: <20180515094332.4907-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] ps2: Clear the PS/2 queue and obey disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Geoffrey McRae <geoff@hostfission.com>

This allows guest's to correctly reinitialize and identify the mouse
should the guest decide to re-scan or reset during mouse input events.

When the guest sends the "Identify" command, due to the PC's hardware
architecutre it is impossible to reliably determine the response from
the command amongst other streaming data, such as mouse or keyboard
events. Standard practice is for the guest to disable the device and
then issue the identify command, so this must be obeyed.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
Message-Id: <20180507150303.7486B381924@moya.office.hostfission.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 06f5d2ac4a..4abc8cecdd 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -232,6 +232,11 @@ static void ps2_keyboard_event(DeviceState *dev, QemuConsole *src,
     uint16_t keycode = 0;
     int mod;
 
+    /* do not process events while disabled to prevent stream corruption */
+    if (!s->scan_enabled) {
+        return;
+    }
+
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     assert(evt->type == INPUT_EVENT_KIND_KEY);
     qcode = qemu_input_key_value_to_qcode(key->key);
@@ -673,6 +678,11 @@ static void ps2_mouse_sync(DeviceState *dev)
 {
     PS2MouseState *s = (PS2MouseState *)dev;
 
+    /* do not sync while disabled to prevent stream corruption */
+    if (!(s->mouse_status & MOUSE_STATUS_ENABLED)) {
+        return;
+    }
+
     if (s->mouse_buttons) {
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     }
@@ -776,6 +786,7 @@ void ps2_write_mouse(void *opaque, int val)
             s->mouse_resolution = 2;
             s->mouse_status = 0;
             s->mouse_type = 0;
+            ps2_reset_queue(&s->common);
             ps2_queue(&s->common, AUX_ACK);
             ps2_queue(&s->common, 0xaa);
             ps2_queue(&s->common, s->mouse_type);
-- 
2.9.3
