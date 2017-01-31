Received: from eggs.gnu.org ([2001:4830:134:3::10]:38019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahe-00054f-Os
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahd-0001Uo-3B
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYahc-0001U0-Rm
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:41 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0B059D51F
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 15:50:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:28 +0100
Message-Id: <1485877831-28786-9-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 08/11] spice: wakeup QXL worker to pick up
 mouse changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Without it, server-mode mouse is "slow" to update position: QXL will
wait until new display commands come. This is very visible with
virtio-gpu.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170130104540.14660-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 5e6f78a..64e472e 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -769,6 +769,7 @@ static void display_mouse_set(DisplayChangeListener *=
dcl,
     g_free(ssd->ptr_move);
     ssd->ptr_move =3D qemu_spice_create_cursor_update(ssd, NULL, on);
     qemu_mutex_unlock(&ssd->lock);
+    qemu_spice_wakeup(ssd);
 }
=20
 static void display_mouse_define(DisplayChangeListener *dcl,
@@ -787,6 +788,7 @@ static void display_mouse_define(DisplayChangeListene=
r *dcl,
     g_free(ssd->ptr_define);
     ssd->ptr_define =3D qemu_spice_create_cursor_update(ssd, c, 0);
     qemu_mutex_unlock(&ssd->lock);
+    qemu_spice_wakeup(ssd);
 }
=20
 static const DisplayChangeListenerOps display_listener_ops =3D {
--=20
1.8.3.1
