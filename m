Received: from eggs.gnu.org ([2001:4830:134:3::10]:55241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlc-00068H-Fj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlW-0003FJ-R2
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlW-0003Ez-M6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:03 +0200
Message-Id: <20180326150916.9602-26-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 25/38] qmp: remove need for
 qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index c6089de616..92079c0621 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -49,10 +49,11 @@ void qmp_return(QmpReturn *qret, QObject *rsp)
=20
 void qmp_return_error(QmpReturn *qret, Error *err)
 {
-    qdict_put_obj(qret->rsp, "error",
-                  qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                                     QapiErrorClass_str(error_get_class(=
err)),
-                                     error_get_pretty(err)));
+    QDict *qdict =3D qdict_new();
+
+    qdict_put_str(qdict, "class", QapiErrorClass_str(error_get_class(err=
)));
+    qdict_put_str(qdict, "desc", error_get_pretty(err));
+    qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
     qret->session->return_cb(qret->session, qret->rsp);
     qmp_return_free(qret);
--=20
2.17.0.rc1.1.g4c4f2b46a3
