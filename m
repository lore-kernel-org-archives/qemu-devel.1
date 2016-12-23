Received: from eggs.gnu.org ([2001:4830:134:3::10]:58870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKRBL-0006m0-KX
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKRBI-0001tK-FX
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:50:51 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:38967)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKRBI-0001sr-6d
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:50:48 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 23 Dec 2016 23:50:41 +0900
Message-ID: <87bmw2vgvy.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] ui/gtk: Fix mouse wheel on 3.4.0 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 3.4.0 or later, send GDK_SCROLL_SMOOTH event, instead of
GDK_SCROLL_UP/DOWN.

This fixes it by converting any smooth scroll to up/down.
(I.e. without smooth support)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 ui/gtk.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff -puN ui/gtk.c~mouse-wheel-fix ui/gtk.c
--- qemu/ui/gtk.c~mouse-wheel-fix	2016-12-23 23:39:24.419659012 +0900
+++ qemu-hirofumi/ui/gtk.c	2016-12-23 23:39:37.540735673 +0900
@@ -1015,6 +1015,16 @@ static gboolean gd_scroll_event(GtkWidge
         btn = INPUT_BUTTON_WHEEL_UP;
     } else if (scroll->direction == GDK_SCROLL_DOWN) {
         btn = INPUT_BUTTON_WHEEL_DOWN;
+#if GTK_CHECK_VERSION(3, 4, 0)
+    } else if (scroll->direction == GDK_SCROLL_SMOOTH) {
+        gdouble delta_x, delta_y;
+        if (!gdk_event_get_scroll_deltas((GdkEvent*)scroll, &delta_x, &delta_y))
+            return TRUE;
+        if (delta_y > 0)
+            btn = INPUT_BUTTON_WHEEL_DOWN;
+        else
+            btn = INPUT_BUTTON_WHEEL_UP;
+#endif
     } else {
         return TRUE;
     }
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
