Received: from eggs.gnu.org ([2001:4830:134:3::10]:36293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcelaya@gmail.com>) id 1crjom-0005as-CY
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcelaya@gmail.com>) id 1crjoj-0002GI-9s
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:25:12 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcelaya@gmail.com>) id 1crjoj-0002F0-4M
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 07:25:09 -0400
Received: by mail-wm0-x243.google.com with SMTP id x124so2510654wmf.3
	for <qemu-devel@nongnu.org>; Sat, 25 Mar 2017 04:25:08 -0700 (PDT)
From: Javier Celaya <jcelaya@gmail.com>
Date: Sat, 25 Mar 2017 12:25:01 +0100
Message-Id: <20170325112501.15887-1-jcelaya@gmail.com>
Subject: [Qemu-devel] [PATCH] Fix input-linux reading from device
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

Signed-off-by: Javier Celaya <jcelaya@gmail.com>
---
 ui/input-linux.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index ac31f47719..33bcdb00c6 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -169,6 +169,8 @@ struct InputLinux {
     bool        has_abs_x;
     int         num_keys;
     int         num_btns;
+    struct input_event event;
+    int         to_be_read;
 
     QTAILQ_ENTRY(InputLinux) next;
 };
@@ -327,25 +329,29 @@ static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
 static void input_linux_event(void *opaque)
 {
     InputLinux *il = opaque;
-    struct input_event event;
     int rc;
+    int offset = sizeof(il->event) - il->to_be_read;
+    uint8_t *p = (uint8_t *)&il->event;
 
     for (;;) {
-        rc = read(il->fd, &event, sizeof(event));
-        if (rc != sizeof(event)) {
+        rc = read(il->fd, &p[offset], il->to_be_read);
+        if (rc != il->to_be_read) {
             if (rc < 0 && errno != EAGAIN) {
                 fprintf(stderr, "%s: read: %s\n", __func__, strerror(errno));
                 qemu_set_fd_handler(il->fd, NULL, NULL, NULL);
                 close(il->fd);
+            } else if (rc > 0){
+                il->to_be_read -= rc;
             }
             break;
         }
+        il->to_be_read = sizeof(il->event);
 
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
@@ -417,6 +423,7 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
         }
     }
 
+    il->to_be_read = sizeof(il->event);
     qemu_set_fd_handler(il->fd, input_linux_event, NULL, il);
     if (il->keycount) {
         /* delay grab until all keys are released */
-- 
2.11.0
