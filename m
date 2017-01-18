Received: from eggs.gnu.org ([2001:4830:134:3::10]:37803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiX-0002zp-PY
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiW-0007bL-Qv
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiW-0007aY-Je
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:08 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C419661BB6
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:14 +0400
Message-Id: <20170118160332.13390-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/25] qmp: introduce async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Qemu used to have command types, but it was removed in
42a502a7a60632234f0dd5028924926a7eac6c94. Add it back, and add a new
type of command, QmpCommandFuncAsync: they can return later thanks to
QmpReturn. This commit introduces the new types and register functions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 14 +++++++++++++-
 qapi/qmp-dispatch.c         | 21 ++++++++++++++-------
 qapi/qmp-registry.c         | 25 ++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index bc64d4ed15..e13e381834 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -35,6 +35,12 @@ struct QmpClient {
 };
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
+typedef void (QmpCommandFuncAsync)(QDict *, QmpReturn *);
+
+typedef enum QmpCommandType {
+    QCT_NORMAL,
+    QCT_ASYNC,
+} QmpCommandType;
=20
 typedef enum QmpCommandOptions
 {
@@ -44,8 +50,12 @@ typedef enum QmpCommandOptions
=20
 typedef struct QmpCommand
 {
+    QmpCommandType type;
     const char *name;
-    QmpCommandFunc *fn;
+    union {
+        QmpCommandFunc *fn;
+        QmpCommandFuncAsync *fn_async;
+    };
     QmpCommandOptions options;
     QTAILQ_ENTRY(QmpCommand) node;
     bool enabled;
@@ -53,6 +63,8 @@ typedef struct QmpCommand
=20
 void qmp_register_command(const char *name, QmpCommandFunc *fn,
                           QmpCommandOptions options);
+void qmp_register_async_command(const char *name, QmpCommandFuncAsync *f=
n,
+                                QmpCommandOptions options);
 void qmp_unregister_command(const char *name);
 QmpCommand *qmp_find_command(const char *name);
 void qmp_client_init(QmpClient *client, QmpDispatchReturn *return_cb);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 6ceece5ef0..26f0a674ae 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -95,13 +95,20 @@ static QObject *do_qmp_dispatch(QObject *request, Qmp=
Return *qret, Error **errp)
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
+    switch (cmd->type) {
+    case QCT_NORMAL:
+        cmd->fn(args, &ret, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
+            g_assert(!ret);
+        } else if (!ret) {
+            ret =3D QOBJECT(qdict_new());
+        }
+        break;
+    case QCT_ASYNC:
+        cmd->fn_async(args, qret);
+        break;
     }
=20
     QDECREF(args);
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index e8053686f3..52b5f4cba0 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -18,16 +18,35 @@
 static QTAILQ_HEAD(QmpCommandList, QmpCommand) qmp_commands =3D
     QTAILQ_HEAD_INITIALIZER(qmp_commands);
=20
-void qmp_register_command(const char *name, QmpCommandFunc *fn,
-                          QmpCommandOptions options)
+static QmpCommand *qmp_command_new(const char *name,
+                                   QmpCommandOptions options)
 {
     QmpCommand *cmd =3D g_malloc0(sizeof(*cmd));
=20
     cmd->name =3D name;
-    cmd->fn =3D fn;
     cmd->enabled =3D true;
     cmd->options =3D options;
     QTAILQ_INSERT_TAIL(&qmp_commands, cmd, node);
+
+    return cmd;
+}
+
+void qmp_register_command(const char *name, QmpCommandFunc *fn,
+                          QmpCommandOptions options)
+{
+    QmpCommand *cmd =3D qmp_command_new(name, options);
+
+    cmd->type =3D QCT_NORMAL;
+    cmd->fn =3D fn;
+}
+
+void qmp_register_async_command(const char *name, QmpCommandFuncAsync *f=
n,
+                                QmpCommandOptions options)
+{
+    QmpCommand *cmd =3D qmp_command_new(name, options);
+
+    cmd->type =3D QCT_ASYNC;
+    cmd->fn_async =3D fn;
 }
=20
 void qmp_unregister_command(const char *name)
--=20
2.11.0.295.gd7dffce1c
