Received: from eggs.gnu.org ([2001:4830:134:3::10]:58807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVwy1-0007xq-8Q
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVwxv-0002Yf-PD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:00:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVwxv-0002YT-J4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:00:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8970D3B721
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:00:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 24 Jan 2017 10:00:28 +0100
Message-Id: <1485248428-575-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: fix overflow in vnc_update_stats
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
---
 ui/vnc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 29aa9c4..e7c029d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2756,8 +2756,10 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, =
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
