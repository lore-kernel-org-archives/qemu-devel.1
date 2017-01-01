Received: from eggs.gnu.org ([2001:4830:134:3::10]:55273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cNccz-0003QP-3H
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 04:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cNccv-0004JO-Ge
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 04:40:32 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sun,  1 Jan 2017 10:39:45 +0100
Message-Id: <1483263585-8101-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ui/gtk: fix crash at startup when no console
 is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

This patch fixes a segfault at QEMU startup, introduced in a08156321ab9a7=
d2fed9ee77dbfeea2a61ffd153.
gd_vc_find_current() return NULL, which is dereferenced without checking =
it.

While at it, disable the whole 'View' menu if no console exists.

Reproducer: qemu-system-i386 -M none -nodefaults

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 ui/gtk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index a216216..406de4f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2171,6 +2171,8 @@ static gboolean gtkinit;
=20
 void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_h=
over)
 {
+    VirtualConsole *vc;
+
     GtkDisplayState *s =3D g_malloc0(sizeof(*s));
     char *filename;
     GdkDisplay *window_display;
@@ -2249,9 +2251,11 @@ void gtk_display_init(DisplayState *ds, bool full_=
screen, bool grab_on_hover)
     }
 #endif
=20
+    vc =3D gd_vc_find_current(s);
+    gtk_widget_set_sensitive(s->view_menu, vc !=3D NULL);
 #ifdef CONFIG_VTE
     gtk_widget_set_sensitive(s->copy_item,
-                             gd_vc_find_current(s)->type =3D=3D GD_VC_VT=
E);
+                             vc && vc->type =3D=3D GD_VC_VTE);
 #endif
=20
     if (full_screen) {
--=20
2.1.4
