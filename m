Received: from eggs.gnu.org ([2001:4830:134:3::10]:54466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhw-0004yY-GW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZht-0008RI-H2
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQZht-0008Qr-BN
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:49 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:09:35 +0100
Message-Id: <1483967385-12891-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 01/11] ui/gtk: fix crash at startup when no
 console is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

This patch fixes a segfault at QEMU startup, introduced in a08156321ab9a7=
d2fed9ee77dbfeea2a61ffd153.
gd_vc_find_current() return NULL, which is dereferenced without checking =
it.

While at it, disable the whole 'View' menu if no console exists.

Reproducer: qemu-system-i386 -M none -nodefaults

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 1483263585-8101-1-git-send-email-hpoussin@reactos.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
1.8.3.1
