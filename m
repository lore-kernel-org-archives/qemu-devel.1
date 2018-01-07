Received: from eggs.gnu.org ([2001:4830:134:3::10]:50778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eYJDb-0003Fz-Q7
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 17:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eYJDa-0001KM-NZ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 17:15:03 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patricktsen@gmail.com>)
	id 1eYJDa-0001Jn-HR
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 17:15:02 -0500
Received: by mail-pf0-x242.google.com with SMTP id t12so1815823pfg.2
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 14:15:02 -0800 (PST)
From: byxk <patricktsen@gmail.com>
Date: Sun,  7 Jan 2018 14:14:55 -0800
Message-Id: <20180107221455.25504-2-patricktsen@gmail.com>
In-Reply-To: <20180107221455.25504-1-patricktsen@gmail.com>
References: <20180107221455.25504-1-patricktsen@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] input-linux: provide hotkeys for evdev
 toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, byxk <patricktsen@gmail.com>

---
 ui/input-linux.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index 9720333b2c..a553d2b4cc 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -5,6 +5,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
@@ -62,6 +63,8 @@ struct InputLinux {
     int         abs_y_max;
     struct input_event event;
     int         read_offset;
+    long        rhotkey;
+    long        lhotkey;
 
     QTAILQ_ENTRY(InputLinux) next;
 };
@@ -134,8 +137,8 @@ static void input_linux_handle_keyboard(InputLinux *il,
         }
 
         /* hotkey -> record switch request ... */
-        if (il->keydown[KEY_LEFTCTRL] &&
-            il->keydown[KEY_RIGHTCTRL]) {
+        if (il->keydown[il->rhotkey] &&
+            il->keydown[il->lhotkey]) {
             il->grab_request = true;
         }
 
@@ -274,6 +277,14 @@ static void input_linux_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (!il->rhotkey) {
+        il->rhotkey = KEY_RIGHTCTRL;
+    }
+
+    if (!il->lhotkey) {
+        il->lhotkey = KEY_LEFTCTRL;
+    }
+
     il->fd = open(il->evdev, O_RDWR);
     if (il->fd < 0)  {
         error_setg_file_open(errp, errno, il->evdev);
@@ -395,6 +406,62 @@ static void input_linux_set_grab_all(Object *obj, bool value,
     il->grab_all = value;
 }
 
+static void input_linux_set_rhotkey(Object *obj, const char *value,
+                                   Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+    InputLinux *item;
+    long rhotkey;
+    int res = qemu_strtol(value, NULL, 0, &rhotkey);
+    if (res != 0) {
+        rhotkey = KEY_RIGHTCTRL;
+    }
+    il->rhotkey = rhotkey;
+
+    QTAILQ_FOREACH(item, &inputs, next) {
+        if (item == il || item->rhotkey) {
+            continue;
+        }
+        item->rhotkey = rhotkey;
+    }
+}
+
+static char *input_linux_get_rhotkey(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+    char buf[sizeof(int) * 4];
+    sprintf(buf, "%ld", il->rhotkey);
+    return g_strdup(buf);
+}
+
+static void input_linux_set_lhotkey(Object *obj, const char *value,
+                                   Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+    InputLinux *item;
+    long lhotkey = KEY_LEFTCTRL;
+    int res = qemu_strtol(value, NULL, 0, &lhotkey);
+    if (res != 0) {
+        lhotkey = KEY_LEFTCTRL;
+    }
+    il->lhotkey = lhotkey;
+
+    QTAILQ_FOREACH(item, &inputs, next) {
+        if (item == il || item->lhotkey) {
+            continue;
+        }
+        item->lhotkey = lhotkey;
+    }
+}
+
+static char *input_linux_get_lhotkey(Object *obj, Error **errp)
+{
+    InputLinux *il = INPUT_LINUX(obj);
+    char buf[sizeof(int) * 4];
+    sprintf(buf, "%ld", il->lhotkey);
+    return g_strdup(buf);
+}
+
 static bool input_linux_get_repeat(Object *obj, Error **errp)
 {
     InputLinux *il = INPUT_LINUX(obj);
@@ -421,6 +488,12 @@ static void input_linux_instance_init(Object *obj)
     object_property_add_bool(obj, "repeat",
                              input_linux_get_repeat,
                              input_linux_set_repeat, NULL);
+    object_property_add_str(obj, "rhotkey",
+                            input_linux_get_rhotkey,
+                            input_linux_set_rhotkey, NULL);
+    object_property_add_str(obj, "lhotkey",
+                            input_linux_get_lhotkey,
+                            input_linux_set_lhotkey, NULL);
 }
 
 static void input_linux_class_init(ObjectClass *oc, void *data)
-- 
2.15.1
