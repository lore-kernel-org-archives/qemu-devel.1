Received: from eggs.gnu.org ([2001:4830:134:3::10]:55209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlZ-00065Y-Jg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlY-0003GI-J5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlY-0003Fs-2w
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:32 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:04 +0200
Message-Id: <20180326150916.9602-27-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 26/38] qmp: fold do_qmp_dispatch() in
 qmp_dispatch()
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

qmp_dispatch() is now a simple wrapper for do_qmp_dispatch(). In order
to prepare for following asynchronous function, merge the two
functions, which result in less code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 62 ++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 92079c0621..4a73cf88b3 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -114,47 +114,50 @@ QDict *qmp_dispatch_check_obj(const QObject *reques=
t, Error **errp)
     return dict;
 }
=20
-static QObject *do_qmp_dispatch(QmpCommandList *cmds, QDict *dict,
-                                Error **errp)
+void qmp_dispatch(QmpSession *session, QDict *req)
 {
-    Error *local_err =3D NULL;
     const char *command;
-    QDict *args;
+    QDict *args =3D NULL;
     QmpCommand *cmd;
-    QObject *ret =3D NULL;
+    Error *err =3D NULL;
=20
-    command =3D qdict_get_str(dict, "execute");
-    cmd =3D qmp_find_command(cmds, command);
+    command =3D qdict_get_str(req, "execute");
+    cmd =3D qmp_find_command(session->cmds, command);
     if (cmd =3D=3D NULL) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+        error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has not been found", command);
-        return NULL;
+        goto end;
     }
     if (!cmd->enabled) {
-        error_setg(errp, "The command %s has been disabled for this inst=
ance",
+        error_setg(&err, "The command %s has been disabled for this inst=
ance",
                    command);
-        return NULL;
+        goto end;
     }
=20
-    if (!qdict_haskey(dict, "arguments")) {
+    if (!qdict_haskey(req, "arguments")) {
         args =3D qdict_new();
     } else {
-        args =3D qdict_get_qdict(dict, "arguments");
+        args =3D qdict_get_qdict(req, "arguments");
         QINCREF(args);
     }
=20
-    cmd->fn(args, &ret, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-    } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
-        g_assert(!ret);
-    } else if (!ret) {
-        ret =3D QOBJECT(qdict_new());
+    {
+        QObject *ret =3D NULL;
+        cmd->fn(args, &ret, &err);
+        if (err || cmd->options & QCO_NO_SUCCESS_RESP) {
+            assert(!ret);
+            goto end;
+        } else if (!ret) {
+            ret =3D QOBJECT(qdict_new());
+        }
+        qmp_return(qmp_return_new(session, req), ret);
     }
=20
+end:
+    if (err) {
+        qmp_return_error(qmp_return_new(session, req), err);
+    }
     QDECREF(args);
-
-    return ret;
 }
=20
 /*
@@ -230,18 +233,3 @@ void qmp_session_destroy(QmpSession *session)
     session->return_cb =3D NULL;
     json_message_parser_destroy(&session->parser);
 }
-
-void qmp_dispatch(QmpSession *session, QDict *req)
-{
-    QmpReturn *qret =3D qmp_return_new(session, req);
-    Error *err =3D NULL;
-    QObject *ret;
-
-    ret =3D do_qmp_dispatch(session->cmds, req, &err);
-    if (err) {
-        assert(!ret);
-        qmp_return_error(qret, err);
-    } else if (ret) {
-        qmp_return(qret, ret);
-    }
-}
--=20
2.17.0.rc1.1.g4c4f2b46a3
