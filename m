Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyV-0005oe-0r
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyQ-0007lJ-8y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:23 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:60224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1cEKyP-0007k9-UQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:18 -0500
From: Fabian Lesniak <fabian@lesniak-it.de>
Date: Tue,  6 Dec 2016 20:00:07 +0100
Message-Id: <20161206190007.7539-4-fabian@lesniak-it.de>
In-Reply-To: <20161206190007.7539-1-fabian@lesniak-it.de>
References: <20161206190007.7539-1-fabian@lesniak-it.de>
Subject: [Qemu-devel] [PATCH v3 3/3] ui: add support for mice with
 extra/side buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>

Adds input event generation for BTN_SIDE and BTN_EXTRA events to gtk and
input-linux methods.

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
---
 ui/gtk.c         | 4 ++++
 ui/input-linux.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index e816428..9cdce83 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -995,6 +995,10 @@ static gboolean gd_button_event(GtkWidget *widget, GdkEventButton *button,
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
2.10.2
