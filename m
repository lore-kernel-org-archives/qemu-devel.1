Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcelaya@gmail.com>) id 1csZLh-0002mV-2Z
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcelaya@gmail.com>) id 1csZLd-000523-40
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:37 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcelaya@gmail.com>) id 1csZLc-00051N-Uj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:33 -0400
Received: by mail-wr0-x241.google.com with SMTP id p52so12782843wrc.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 11:26:32 -0700 (PDT)
From: Javier Celaya <jcelaya@gmail.com>
Date: Mon, 27 Mar 2017 20:26:24 +0200
Message-Id: <20170327182624.2914-1-jcelaya@gmail.com>
Subject: [Qemu-devel] [PATCH v3] Fix input-linux reading from device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

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
---
 ui/input-linux.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index ac31f47719..dc0613ca1f 100644
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
2.11.0
