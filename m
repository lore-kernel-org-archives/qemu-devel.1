Received: from eggs.gnu.org ([2001:4830:134:3::10]:39974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle02-0007m3-C8
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle01-0001Bl-MD
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle01-0001Aw-Gi
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13285F2B40
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:05 +0200
Message-Id: <20180803173614.12358-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/10] char/spice: trigger HUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Inform the front-end of disconnected state (spice client
disconnected).

This will wakeup the source handler immediately, so it can detect the
disconnection asap.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/spice.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/chardev/spice.c b/chardev/spice.c
index e66e3ad568..fe06034d7f 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -152,15 +152,25 @@ static void vmc_unregister_interface(SpiceChardev *=
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
@@ -168,9 +178,12 @@ static gboolean spice_char_source_check(GSource *sou=
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
2.18.0.547.g1d89318c48
