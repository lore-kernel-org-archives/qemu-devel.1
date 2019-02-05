Received: from eggs.gnu.org ([209.51.188.92]:42600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQs-0007P9-UZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQr-0006IW-4G
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQq-0006B2-RQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:25 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:46 +0100
Message-Id: <20190205105758.4230-3-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] ui: don't send any event if delta_y == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>

From: Sergio Lopez <slp@redhat.com>

When the user raises their fingers from the touchpad, we may receive a
GDK_SMOOTH_SCROLL event with delta_y == 0. Avoid generating a WHEEL_UP
event in this situation.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-id: 20190204122043.43007-1-slp@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 87c0e33d2a..5a584353bd 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1004,7 +1004,9 @@ static gboolean gd_scroll_event(GtkWidget *widget, GdkEventScroll *scroll,
                                          &delta_x, &delta_y)) {
             return TRUE;
         }
-        if (delta_y > 0) {
+        if (delta_y == 0) {
+            return TRUE;
+        } else if (delta_y > 0) {
             btn = INPUT_BUTTON_WHEEL_DOWN;
         } else {
             btn = INPUT_BUTTON_WHEEL_UP;
-- 
2.9.3
