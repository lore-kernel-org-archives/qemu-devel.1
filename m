Received: from eggs.gnu.org ([2001:4830:134:3::10]:38084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahh-000571-88
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahc-0001UR-JA
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYahc-0001Tt-Ds
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:40 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:25 +0100
Message-Id: <1485877831-28786-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/11] ui/gtk: Fix mouse wheel on 3.4.0 or
 later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Gerd Hoffmann <kraxel@redhat.com>

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

On 3.4.0 or later, send GDK_SCROLL_SMOOTH event, instead of
GDK_SCROLL_UP/DOWN.

This fixes it by converting any smooth scroll to up/down.
(I.e. without smooth support)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 3f67a34..2f81863 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1031,6 +1031,19 @@ static gboolean gd_scroll_event(GtkWidget *widget, GdkEventScroll *scroll,
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (scroll->direction == GDK_SCROLL_DOWN) {
         btn = INPUT_BUTTON_WHEEL_DOWN;
+#if GTK_CHECK_VERSION(3, 4, 0)
+    } else if (scroll->direction == GDK_SCROLL_SMOOTH) {
+        gdouble delta_x, delta_y;
+        if (!gdk_event_get_scroll_deltas((GdkEvent *)scroll,
+                                         &delta_x, &delta_y)) {
+            return TRUE;
+        }
+        if (delta_y > 0) {
+            btn = INPUT_BUTTON_WHEEL_DOWN;
+        } else {
+            btn = INPUT_BUTTON_WHEEL_UP;
+        }
+#endif
     } else {
         return TRUE;
     }
-- 
1.8.3.1
