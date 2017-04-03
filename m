Received: from eggs.gnu.org ([2001:4830:134:3::10]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzDa-0004sN-Lr
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzDZ-0004AA-PZ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cuzDZ-000495-Kb
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:13 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Apr 2017 12:28:02 +0200
Message-Id: <20170403102803.31820-3-kraxel@redhat.com>
In-Reply-To: <20170403102803.31820-1-kraxel@redhat.com>
References: <20170403102803.31820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] Fix input-linux reading from device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Javier Celaya <jcelaya@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Javier Celaya <jcelaya@gmail.com>

The evdev devices in input-linux.c are read in blocks of one whole
event. If there are not enough bytes available, they are discarded,
instead of being kept for the next read operation. This results in
lost events, of even non-working devices.

This patch keeps track of the number of bytes to be read to fill up
a whole event, and then handle it.

Changes from v1 to v2:
- Fix: Calculate offset on each iteration

Changes from v2 to v3:
- Fix coding style
- Store offset instead of bytes to be read

Signed-off-by: Javier Celaya <jcelaya@gmail.com>
Message-id: 20170327182624.2914-1-jcelaya@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-linux.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index ac31f47..dc0613c 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -169,6 +169,8 @@ struct InputLinux {
     bool        has_abs_x;
     int         num_keys;
     int         num_btns;
+    struct input_event event;
+    int         read_offset;
 
     QTAILQ_ENTRY(InputLinux) next;
 };
@@ -327,25 +329,30 @@ static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
 static void input_linux_event(void *opaque)
 {
     InputLinux *il = opaque;
-    struct input_event event;
     int rc;
+    int read_size;
+    uint8_t *p = (uint8_t *)&il->event;
 
     for (;;) {
-        rc = read(il->fd, &event, sizeof(event));
-        if (rc != sizeof(event)) {
+        read_size = sizeof(il->event) - il->read_offset;
+        rc = read(il->fd, &p[il->read_offset], read_size);
+        if (rc != read_size) {
             if (rc < 0 && errno != EAGAIN) {
                 fprintf(stderr, "%s: read: %s\n", __func__, strerror(errno));
                 qemu_set_fd_handler(il->fd, NULL, NULL, NULL);
                 close(il->fd);
+            } else if (rc > 0) {
+                il->read_offset += rc;
             }
             break;
         }
+        il->read_offset = 0;
 
         if (il->num_keys) {
-            input_linux_handle_keyboard(il, &event);
+            input_linux_handle_keyboard(il, &il->event);
         }
         if (il->has_rel_x && il->num_btns) {
-            input_linux_handle_mouse(il, &event);
+            input_linux_handle_mouse(il, &il->event);
         }
     }
 }
-- 
2.9.3
