Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8FC282DA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B133521734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B133521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45731 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtRz-0008RM-NZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:18:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLT-00034p-Et
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLS-00050w-5L
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLR-0004xm-Ph
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A40AE88ACB;
	Tue,  9 Apr 2019 16:11:29 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F39261998;
	Tue,  9 Apr 2019 16:11:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:10:01 +0200
Message-Id: <20190409161009.6322-13-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 09 Apr 2019 16:11:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 12/20] qmp: introduce asynchronous command
 type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409161001.oJZ_Q2i19ehg7tQDfWrq-lndd4R5BNpwzvcusIhy9ZI@z>

Add a new type of command, QmpCommandFuncAsync: those commands can
return later thanks to QmpReturn. This commit introduces the new type
and register function and teach qmp_dipatch() to call it without
qmp_return(). The async_fn callback will be responsible for calling
qmp_return(), either synchronously or asynchronously.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 10 +++++++++-
 qapi/qmp-dispatch.c         | 27 ++++++++++++++++-----------
 qapi/qmp-registry.c         | 27 ++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 92d6fd1afb..6aef0abc70 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -21,6 +21,7 @@
 typedef struct QmpReturn QmpReturn;
=20
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
+typedef void (QmpCommandAsyncFunc)(QDict *, QmpReturn *);
=20
 typedef enum QmpCommandOptions
 {
@@ -28,12 +29,16 @@ typedef enum QmpCommandOptions
     QCO_NO_SUCCESS_RESP       =3D  (1U << 0),
     QCO_ALLOW_OOB             =3D  (1U << 1),
     QCO_ALLOW_PRECONFIG       =3D  (1U << 2),
+    QCO_ASYNC                 =3D  (1U << 3),
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
@@ -88,6 +93,9 @@ void qmp_return_error(QmpReturn *qret, Error *err);
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
+void qmp_register_async_command(QmpCommandList *cmds, const char *name,
+                                QmpCommandAsyncFunc *fn,
+                                QmpCommandOptions options);
 const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
                                    const char *name);
 void qmp_session_init(QmpSession *session,
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 546a6c9f7b..1f493af67a 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -171,7 +171,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *r=
equest, bool allow_oob,
     return dict;
 }
=20
-static QObject *do_qmp_dispatch(const QmpCommandList *cmds, QObject *req=
uest,
+static QObject *do_qmp_dispatch(QmpSession *session, QObject *request,
                                 bool allow_oob, Error **errp)
 {
     Error *local_err =3D NULL;
@@ -193,7 +193,7 @@ static QObject *do_qmp_dispatch(const QmpCommandList =
*cmds, QObject *request,
         command =3D qdict_get_str(dict, "exec-oob");
         oob =3D true;
     }
-    cmd =3D qmp_find_command(cmds, command);
+    cmd =3D qmp_find_command(session->cmds, command);
     if (cmd =3D=3D NULL) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "The command %s has not been found", command);
@@ -224,14 +224,19 @@ static QObject *do_qmp_dispatch(const QmpCommandLis=
t *cmds, QObject *request,
         qobject_ref(args);
     }
=20
-    cmd->fn(args, &ret, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-    } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
-        g_assert(!ret);
-    } else if (!ret) {
-        /* TODO turn into assertion */
-        ret =3D QOBJECT(qdict_new());
+
+    if (cmd->options & QCO_ASYNC) {
+        cmd->async_fn(args, qmp_return_new(session, request));
+    } else {
+        cmd->fn(args, &ret, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
+            g_assert(!ret);
+        } else if (!ret) {
+            /* TODO turn into assertion */
+            ret =3D QOBJECT(qdict_new());
+        }
     }
=20
     qobject_unref(args);
@@ -304,7 +309,7 @@ void qmp_dispatch(QmpSession *session, QObject *reque=
st, bool allow_oob)
     Error *err =3D NULL;
     QObject *ret;
=20
-    ret =3D do_qmp_dispatch(session->cmds, request, allow_oob, &err);
+    ret =3D do_qmp_dispatch(session, request, allow_oob, &err);
     if (err) {
         qmp_return_error(qmp_return_new(session, request), err);
     } else if (ret) {
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index d0f9a1d3e3..0f3d521ce5 100644
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
 const QmpCommand *qmp_find_command(const QmpCommandList *cmds, const cha=
r *name)
--=20
2.21.0.196.g041f5ea1cf


