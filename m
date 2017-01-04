Received: from eggs.gnu.org ([2001:4830:134:3::10]:57755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsN7-0003vs-Me
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsN4-0002vz-LA
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:41:21 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:35789)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cOsN4-0002vo-Cg
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:41:18 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87bmw2vgvy.fsf@mail.parknet.co.jp>
	<1483519725.5670.44.camel@redhat.com>
	<87vatuk19y.fsf@mail.parknet.co.jp>
Date: Thu, 05 Jan 2017 05:41:16 +0900
In-Reply-To: <87vatuk19y.fsf@mail.parknet.co.jp> (OGAWA Hirofumi's message of
	"Thu, 05 Jan 2017 05:39:37 +0900")
Message-ID: <87o9zmk177.fsf_-_@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] ui/gtk: Fix mouse wheel on 3.4.0 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


On 3.4.0 or later, send GDK_SCROLL_SMOOTH event, instead of
GDK_SCROLL_UP/DOWN.

This fixes it by converting any smooth scroll to up/down.
(I.e. without smooth support)

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 ui/gtk.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff -puN ui/gtk.c~mouse-wheel-fix ui/gtk.c
--- qemu/ui/gtk.c~mouse-wheel-fix	2016-12-28 04:52:07.848682967 +0900
+++ qemu-hirofumi/ui/gtk.c	2017-01-05 05:38:24.200601498 +0900
@@ -1015,6 +1015,19 @@ static gboolean gd_scroll_event(GtkWidge
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
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
