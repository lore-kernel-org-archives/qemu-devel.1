Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlj-0006GZ-Sp
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tld-0003KS-Sm
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tld-0003K4-J3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:37 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:07 +0200
Message-Id: <20180326150916.9602-30-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 29/38] qmp: introduce asynchronous command
 type
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

Add a new type of command, QmpCommandFuncAsync: those commands can
return later thanks to QmpReturn. This commit introduces the new type
and register function and teach qmp_dipatch() to call it without
qmp_return().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  9 ++++++++-
 qapi/qmp-dispatch.c         |  4 +++-
 qapi/qmp-registry.c         | 27 ++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index f6db06c164..e426317346 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -21,18 +21,23 @@
 typedef struct QmpReturn QmpReturn;
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
+typedef void (QmpCommandAsyncFunc)(QDict *, QmpReturn *);
=20
 typedef enum QmpCommandOptions
 {
     QCO_NO_OPTIONS            =3D  0x0,
     QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
     QCO_ALLOW_OOB             =3D  (1U << 1),
+    QCO_ASYNC                 =3D  (1U << 2),
 } QmpCommandOptions;
=20
 typedef struct QmpCommand
 {
     const char *name;
-    QmpCommandFunc *fn;
+    union {
+        QmpCommandFunc *fn;
+        QmpCommandAsyncFunc *async_fn;
+    };
     QmpCommandOptions options;
     QTAILQ_ENTRY(QmpCommand) node;
     bool enabled;
@@ -88,6 +93,8 @@ void qmp_return_error(QmpReturn *qret, Error *err);
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
+void qmp_register_async_command(QmpCommandList *cmds, const char *name,
+                          QmpCommandAsyncFunc *fn, QmpCommandOptions opt=
ions);
 void qmp_unregister_command(QmpCommandList *cmds, const char *name);
 QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index aa8b71a2c0..f7d9931734 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -195,7 +195,9 @@ void qmp_dispatch(QmpSession *session, QDict *req)
         QINCREF(args);
     }
=20
-    {
+    if (cmd->options & QCO_ASYNC) {
+        cmd->async_fn(args, qmp_return_new(session, req));
+    } else {
         QObject *ret =3D NULL;
         cmd->fn(args, &ret, &err);
         if (err || cmd->options & QCO_NO_SUCCESS_RESP) {
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index 5af484cd9a..180b1c1e69 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -15,16 +15,37 @@
 #include "qemu/osdep.h"
 #include "qapi/qmp/dispatch.h"
=20
-void qmp_register_command(QmpCommandList *cmds, const char *name,
-                          QmpCommandFunc *fn, QmpCommandOptions options)
+
+static QmpCommand *qmp_command_new(QmpCommandList *cmds, const char *nam=
e,
+                                   QmpCommandOptions options)
 {
     QmpCommand *cmd =3D g_malloc0(sizeof(*cmd));
=20
     cmd->name =3D name;
-    cmd->fn =3D fn;
     cmd->enabled =3D true;
     cmd->options =3D options;
     QTAILQ_INSERT_TAIL(cmds, cmd, node);
+
+    return cmd;
+}
+
+
+void qmp_register_command(QmpCommandList *cmds, const char *name,
+                          QmpCommandFunc *fn, QmpCommandOptions options)
+{
+    QmpCommand *cmd =3D qmp_command_new(cmds, name, options);
+
+    assert(!(options & QCO_ASYNC));
+    cmd->fn =3D fn;
+}
+
+void qmp_register_async_command(QmpCommandList *cmds, const char *name,
+                            QmpCommandAsyncFunc *fn, QmpCommandOptions o=
ptions)
+{
+    QmpCommand *cmd =3D qmp_command_new(cmds, name, options);
+
+    assert(options & QCO_ASYNC);
+    cmd->async_fn =3D fn;
 }
=20
 void qmp_unregister_command(QmpCommandList *cmds, const char *name)
--=20
2.17.0.rc1.1.g4c4f2b46a3
