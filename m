Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfHa-0005vq-5n
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfHU-0003sg-DE
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:30:22 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:49812)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1fFfHU-0003s2-3t
	for qemu-devel@nongnu.org; Mon, 07 May 2018 08:30:16 -0400
From: Geoffrey McRae <geoff@hostfission.com>
Date: Mon, 7 May 2018 21:42:10 +1000
Message-Id: <20180507123014.C67BE3818FB@moya.office.hostfission.com>
Subject: [Qemu-devel] (resend)[PATCH 1/2] ps2: Clear the queue on PS/2 mouse
 reset and obey device disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This allows guest's to correctly reinitialize and identify the mouse
should the guest decide to re-scan or reset during mouse input events.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 hw/input/ps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 06f5d2ac4a..6edf046820 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -673,6 +673,9 @@ static void ps2_mouse_sync(DeviceState *dev)
 {
     PS2MouseState *s = (PS2MouseState *)dev;
 
+    if (!(s->mouse_status & MOUSE_STATUS_ENABLED))
+        return;
+
     if (s->mouse_buttons) {
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
     }
@@ -776,6 +779,7 @@ void ps2_write_mouse(void *opaque, int val)
             s->mouse_resolution = 2;
             s->mouse_status = 0;
             s->mouse_type = 0;
+            ps2_reset_queue(&s->common);
             ps2_queue(&s->common, AUX_ACK);
             ps2_queue(&s->common, 0xaa);
             ps2_queue(&s->common, s->mouse_type);
-- 
2.14.2
