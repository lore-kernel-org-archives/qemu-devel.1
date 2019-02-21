Received: from eggs.gnu.org ([209.51.188.92]:34653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmCC-0001sr-CJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmC9-0006kp-Cd
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmC8-0006jK-BJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CBF683F4C
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:07:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:06:53 +0100
Message-Id: <20190221110703.5775-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190221110703.5775-1-marcandre.lureau@redhat.com>
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/11] char/spice: trigger HUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Inform the front-end of disconnected state (spice client
disconnected).

This will wakeup the source handler immediately, so it can detect the
disconnection asap.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Victor Toso <victortoso@redhat.com>
---
 chardev/spice.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/chardev/spice.c b/chardev/spice.c
index 173c257949..c2baeb5461 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -148,15 +148,25 @@ static void vmc_unregister_interface(SpiceChardev *=
scd)
 static gboolean spice_char_source_prepare(GSource *source, gint *timeout=
)
 {
     SpiceCharSource *src =3D (SpiceCharSource *)source;
+    Chardev *chr =3D CHARDEV(src->scd);
=20
     *timeout =3D -1;
=20
+    if (!chr->be_open) {
+        return true;
+    }
+
     return !src->scd->blocked;
 }
=20
 static gboolean spice_char_source_check(GSource *source)
 {
     SpiceCharSource *src =3D (SpiceCharSource *)source;
+    Chardev *chr =3D CHARDEV(src->scd);
+
+    if (!chr->be_open) {
+        return true;
+    }
=20
     return !src->scd->blocked;
 }
@@ -164,9 +174,12 @@ static gboolean spice_char_source_check(GSource *sou=
rce)
 static gboolean spice_char_source_dispatch(GSource *source,
     GSourceFunc callback, gpointer user_data)
 {
+    SpiceCharSource *src =3D (SpiceCharSource *)source;
+    Chardev *chr =3D CHARDEV(src->scd);
     GIOFunc func =3D (GIOFunc)callback;
+    GIOCondition cond =3D chr->be_open ? G_IO_OUT : G_IO_HUP;
=20
-    return func(NULL, G_IO_OUT, user_data);
+    return func(NULL, cond, user_data);
 }
=20
 static GSourceFuncs SpiceCharSourceFuncs =3D {
--=20
2.21.0.rc1
