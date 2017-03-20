Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qi-0001gR-TD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qf-0004xZ-Hn
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51914
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qf-0004x5-CI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8X4D108450
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:32 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29aeabyxm2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:32 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:32 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:05 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1490051325-3770-42-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 41/81] ui/gtk: fix crash at startup when no
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
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>

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
(cherry picked from commit 3d4da9d6f3b664beb5bee446ad53b69178f46ad4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
