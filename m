Received: from eggs.gnu.org ([2001:4830:134:3::10]:35473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAvtL-0001An-BQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAvtI-0003y0-4q
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:46:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAvtH-0003tT-SA
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:46:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 13:45:51 +0200
Message-Id: <20181012114551.28809-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] spice: prepare for upcoming spice-server change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org

Future spice-server versions will call the client_monitors_config
callback with the monitors list filtered to only include the monitors
of the given display channel (aka QXLInstance).  Luckily this is easily
detectable at runtime, so we can prepare for that in advance and also
make qemu compatible with both old and new spice-server versions.

While being at it also use the console index instead of head number as
array index.  The later doesn't work correctly in case multiple display
devices are present.

Cc: spice-devel@lists.freedesktop.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 2f8adb6b9f..52f8cb5ae1 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -674,10 +674,28 @@ static int interface_client_monitors_config(QXLInstance *sin,
 
     memset(&info, 0, sizeof(info));
 
-    head = qemu_console_get_head(ssd->dcl.con);
-    if (mc->num_of_monitors > head) {
-        info.width  = mc->monitors[head].width;
-        info.height = mc->monitors[head].height;
+    if (mc->num_of_monitors == 1) {
+        /*
+         * New spice-server version which filters the list of monitors
+         * to only include those that belong to our display channel.
+         *
+         * single-head configuration (where filtering doesn't matter)
+         * takes this code path too.
+         */
+        info.width  = mc->monitors[0].width;
+        info.height = mc->monitors[0].height;
+    } else {
+        /*
+         * Old spice-server which gives us all monitors, so we have to
+         * figure ourself which entry we need.  Array index is the
+         * channel_id, which is the qemu console index, see
+         * qemu_spice_add_display_interface().
+         */
+        head = qemu_console_get_index(ssd->dcl.con);
+        if (mc->num_of_monitors > head) {
+            info.width  = mc->monitors[head].width;
+            info.height = mc->monitors[head].height;
+        }
     }
 
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
-- 
2.9.3
