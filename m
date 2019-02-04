Received: from eggs.gnu.org ([209.51.188.92]:36612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gqdF6-0002aL-Vs
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gqdF5-0002T4-M2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:20:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1gqdF5-0002Rq-Ep
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83F2E87648
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 12:20:50 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Mon,  4 Feb 2019 13:20:43 +0100
Message-Id: <20190204122043.43007-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ui: don't send any event if delta_y == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Sergio Lopez <slp@redhat.com>

When the user raises their fingers from the touchpad, we may receive a
GDK_SMOOTH_SCROLL event with delta_y =3D=3D 0. Avoid generating a WHEEL_U=
P
event in this situation.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 ui/gtk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 77bd19025d..57af69b0c4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1004,7 +1004,9 @@ static gboolean gd_scroll_event(GtkWidget *widget, =
GdkEventScroll *scroll,
                                          &delta_x, &delta_y)) {
             return TRUE;
         }
-        if (delta_y > 0) {
+        if (delta_y =3D=3D 0) {
+            return TRUE;
+        } else if (delta_y > 0) {
             btn =3D INPUT_BUTTON_WHEEL_DOWN;
         } else {
             btn =3D INPUT_BUTTON_WHEEL_UP;
--=20
2.20.1
