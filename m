Received: from eggs.gnu.org ([209.51.188.92]:55635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLG-0002oa-1L
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLE-0004qE-MV
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLE-0004na-Dl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:20 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:09:58 +0200
Message-Id: <20190409161009.6322-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/20] qmp: simplify qmp_return_error()
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

It's simple, probably more efficient, to hand-craft the dict.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 405cb291b1..5f75dc27bd 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -50,10 +50,10 @@ void qmp_return(QmpReturn *qret, QObject *rsp)
=20
 void qmp_return_error(QmpReturn *qret, Error *err)
 {
-    qdict_put_obj(qret->rsp, "error",
-                  qobject_from_jsonf_nofail("{ 'class': %s, 'desc': %s }=
",
-                      QapiErrorClass_str(error_get_class(err)),
-                      error_get_pretty(err)));
+    QDict *qdict =3D qdict_new();
+    qdict_put_str(qdict, "class", QapiErrorClass_str(error_get_class(err=
)));
+    qdict_put_str(qdict, "desc", error_get_pretty(err));
+    qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
     qret->session->return_cb(qret->session, qret->rsp);
     qmp_return_free(qret);
--=20
2.21.0.196.g041f5ea1cf
