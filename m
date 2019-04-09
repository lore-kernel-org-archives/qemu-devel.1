Received: from eggs.gnu.org ([209.51.188.92]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKy-0002ZF-3V
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKv-0004hG-T2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtKv-0004gh-Jc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:09:56 +0200
Message-Id: <20190409161009.6322-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/20] qga: simplify dispatch_return_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Fold send_response().

qobject_to_json() can't return NULL (it will crash if allocation
failed, either in memcpy() or abort from g_realloc()).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 14e418f9a5..51ab418128 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -522,8 +522,9 @@ fail:
 #endif
 }
=20
-static int send_response(GAState *s, const QDict *rsp)
+static void dispatch_return_cb(QmpSession *session, QDict *rsp)
 {
+    GAState *s =3D container_of(session, GAState, session);
     const char *buf;
     QString *payload_qstr, *response_qstr;
     GIOStatus status;
@@ -531,9 +532,6 @@ static int send_response(GAState *s, const QDict *rsp=
)
     g_assert(rsp && s->channel);
=20
     payload_qstr =3D qobject_to_json(QOBJECT(rsp));
-    if (!payload_qstr) {
-        return -EINVAL;
-    }
=20
     if (s->delimit_response) {
         s->delimit_response =3D false;
@@ -550,18 +548,7 @@ static int send_response(GAState *s, const QDict *rs=
p)
     status =3D ga_channel_write_all(s->channel, buf, strlen(buf));
     qobject_unref(response_qstr);
     if (status !=3D G_IO_STATUS_NORMAL) {
-        return -EIO;
-    }
-
-    return 0;
-}
-
-static void dispatch_return_cb(QmpSession *session, QDict *rsp)
-{
-    GAState *s =3D container_of(session, GAState, session);
-    int ret =3D send_response(s, rsp);
-    if (ret < 0) {
-        g_warning("error sending response: %s", strerror(-ret));
+        g_warning("Failed sending response");
     }
 }
=20
--=20
2.21.0.196.g041f5ea1cf
