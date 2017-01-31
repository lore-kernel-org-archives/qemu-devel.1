Received: from eggs.gnu.org ([2001:4830:134:3::10]:36328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYhB-00039K-Ad
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYh6-0005yw-Gr
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYYh6-0005yQ-AR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:41:39 +0100
Message-Id: <1485870106-25016-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
References: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] ui: add support for mice with extra/side
 buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Fabian Lesniak <fabian@lesniak-it.de>

Adds input event generation for BTN_SIDE and BTN_EXTRA events to gtk and
input-linux methods.

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
Message-id: 20161206190007.7539-4-fabian@lesniak-it.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c         | 4 ++++
 ui/input-linux.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index bdd831c..3f67a34 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1007,6 +1007,10 @@ static gboolean gd_button_event(GtkWidget *widget, GdkEventButton *button,
         btn = INPUT_BUTTON_MIDDLE;
     } else if (button->button == 3) {
         btn = INPUT_BUTTON_RIGHT;
+    } else if (button->button == 8) {
+        btn = INPUT_BUTTON_SIDE;
+    } else if (button->button == 9) {
+        btn = INPUT_BUTTON_EXTRA;
     } else {
         return TRUE;
     }
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f345317..ac31f47 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -291,6 +291,12 @@ static void input_linux_handle_mouse(InputLinux *il, struct input_event *event)
             qemu_input_queue_btn(NULL, INPUT_BUTTON_WHEEL_DOWN,
                                  event->value);
             break;
+        case BTN_SIDE:
+            qemu_input_queue_btn(NULL, INPUT_BUTTON_SIDE, event->value);
+            break;
+        case BTN_EXTRA:
+            qemu_input_queue_btn(NULL, INPUT_BUTTON_EXTRA, event->value);
+            break;
         };
         break;
     case EV_REL:
-- 
1.8.3.1
