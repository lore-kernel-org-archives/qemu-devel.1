Received: from eggs.gnu.org ([2001:4830:134:3::10]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYhB-00039o-Pv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYh7-00060C-PD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYYh7-0005zG-KZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:42:01 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C63D280475
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 13:42:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:41:45 +0100
Message-Id: <1485870106-25016-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
References: <1485870106-25016-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/10] vnc: fix overflow in vnc_update_stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Commit "bea60dd ui/vnc: fix potential memory corruption issues" is
incomplete.  vnc_update_stats must calculate width and height the same
way vnc_refresh_server_surface does it, to make sure we don't use width
and height values larger than the qemu vnc server can handle.

Commit "e22492d ui/vnc: disable adaptive update calculations if not
needed" masks the issue in the default configuration.  It triggers only
in case the "lossy" option is set to "on" (default is "off").

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1485248428-575-1-git-send-email-kraxel@redhat.com
---
 ui/vnc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 6854fdb..cdeb79c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2724,8 +2724,10 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, =
int x, int y)
=20
 static int vnc_update_stats(VncDisplay *vd,  struct timeval * tv)
 {
-    int width =3D pixman_image_get_width(vd->guest.fb);
-    int height =3D pixman_image_get_height(vd->guest.fb);
+    int width =3D MIN(pixman_image_get_width(vd->guest.fb),
+                    pixman_image_get_width(vd->server));
+    int height =3D MIN(pixman_image_get_height(vd->guest.fb),
+                     pixman_image_get_height(vd->server));
     int x, y;
     struct timeval res;
     int has_dirty =3D 0;
--=20
1.8.3.1
