Received: from eggs.gnu.org ([2001:4830:134:3::10]:55166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlT-0005zq-Of
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlQ-0003Bn-BD
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlQ-0003BP-71
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:24 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:02 +0200
Message-Id: <20180326150916.9602-25-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 24/38] qmp: remove qmp_build_error_object()
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

Now that we have a single caller, we may as well fold the function.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  1 -
 qapi/qmp-dispatch.c         | 12 ++++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 7ca8ab17d9..c5ac3bd41e 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -105,7 +105,6 @@ void qmp_enable_command(QmpCommandList *cmds, const c=
har *name);
 bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
-QObject *qmp_build_error_object(Error *err);
 QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
 bool qmp_is_oob(const QDict *dict);
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 7b57fa7987..c6089de616 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -49,7 +49,10 @@ void qmp_return(QmpReturn *qret, QObject *rsp)
=20
 void qmp_return_error(QmpReturn *qret, Error *err)
 {
-    qdict_put_obj(qret->rsp, "error", qmp_build_error_object(err));
+    qdict_put_obj(qret->rsp, "error",
+                  qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
+                                     QapiErrorClass_str(error_get_class(=
err)),
+                                     error_get_pretty(err)));
     error_free(err);
     qret->session->return_cb(qret->session, qret->rsp);
     qmp_return_free(qret);
@@ -153,13 +156,6 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
, QDict *dict,
     return ret;
 }
=20
-QObject *qmp_build_error_object(Error *err)
-{
-    return qobject_from_jsonf("{ 'class': %s, 'desc': %s }",
-                              QapiErrorClass_str(error_get_class(err)),
-                              error_get_pretty(err));
-}
-
 /*
  * Detect whether a request should be run out-of-band, by quickly
  * peeking at whether we have: { "control": { "run-oob": true } }. By
--=20
2.17.0.rc1.1.g4c4f2b46a3
