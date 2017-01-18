Received: from eggs.gnu.org ([2001:4830:134:3::10]:37738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiN-0002qG-1B
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiL-0007VI-Bb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiL-0007UO-44
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C4BC7A68C
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:03:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:11 +0400
Message-Id: <20170118160332.13390-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/25] qmp: use a return callback for the
 command reply
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

Introduce QmpDispatchReturn, a callback called when a command reply is
ready to be sent. Future patches will extend the context to enable async
replies. Currently, all qmp commands reply in the calling context (they
are all sync).

QmpReturn and associated functions are used internally for the sync
dispatch, but will be the basis of the following async context, that's
the reason why they are exported.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 22 ++++++++++++++++-
 monitor.c                   | 19 +++++++++------
 qapi/qmp-dispatch.c         | 58 +++++++++++++++++++++++++++++++++++----=
------
 qga/main.c                  | 22 ++++++++---------
 tests/test-qmp-commands.c   | 54 ++++++++++++++++++++++-----------------=
--
 5 files changed, 119 insertions(+), 56 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index db483481b0..780b3e2a09 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -17,6 +17,14 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
=20
+typedef void (QmpDispatchReturn) (QObject *rsp, void *opaque);
+
+typedef struct QmpReturn {
+    QDict *rsp;
+    QmpDispatchReturn *return_cb;
+    void *opaque;
+} QmpReturn;
+
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
 typedef enum QmpCommandOptions
@@ -38,7 +46,8 @@ void qmp_register_command(const char *name, QmpCommandF=
unc *fn,
                           QmpCommandOptions options);
 void qmp_unregister_command(const char *name);
 QmpCommand *qmp_find_command(const char *name);
-QObject *qmp_dispatch(QObject *request, QDict *rsp);
+void qmp_dispatch(QObject *request, QDict *rsp,
+                  QmpDispatchReturn *return_cb, void *opaque);
 void qmp_disable_command(const char *name);
 void qmp_enable_command(const char *name);
 bool qmp_command_is_enabled(const QmpCommand *cmd);
@@ -48,4 +57,15 @@ QObject *qmp_build_error_object(Error *err);
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
 void qmp_for_each_command(qmp_cmd_callback_fn fn, void *opaque);
=20
+/*
+ * qmp_return{_error}:
+ *
+ * Construct the command reply, and call the
+ * return_cb() associated with the dispatch.
+ *
+ * Finally, free the QmpReturn.
+ */
+void qmp_return(QmpReturn *qret, QObject *cmd_rsp);
+void qmp_return_error(QmpReturn *qret, Error *err);
+
 #endif
diff --git a/monitor.c b/monitor.c
index edd30e4d8f..462ee127b4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3723,15 +3723,21 @@ static QDict *qmp_check_input_obj(QObject *input_=
obj, Error **errp)
     return input_dict;
 }
=20
+static void qmp_dispatch_return(QObject *rsp, void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    monitor_json_emitter(mon, rsp);
+}
+
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
 {
-    QObject *req, *rsp, *id =3D NULL;
+    QObject *req, *id =3D NULL;
     QDict *qdict, *rqdict =3D qdict_new();
     const char *cmd_name;
     Monitor *mon =3D cur_mon;
     Error *err =3D NULL;
=20
-    rsp =3D QOBJECT(rqdict);
     req =3D json_parser_parse_err(tokens, NULL, &err);
     if (err || !req || qobject_type(req) !=3D QTYPE_QDICT) {
         if (!err) {
@@ -3759,16 +3765,15 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
         goto err_out;
     }
=20
-    rsp =3D qmp_dispatch(req, rqdict);
+    qmp_dispatch(req, rqdict, qmp_dispatch_return, mon);
+    qobject_decref(req);
+    return;
=20
 err_out:
     if (err) {
         qdict_put_obj(rqdict, "error", qmp_build_error_object(err));
         error_free(err);
-    }
-
-    if (rsp) {
-        monitor_json_emitter(mon, rsp);
+        monitor_json_emitter(mon, QOBJECT(rqdict));
     }
=20
     QDECREF(rqdict);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index dbf2e5b655..7e9d03f262 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -62,7 +62,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, Error **errp)
     return dict;
 }
=20
-static QObject *do_qmp_dispatch(QObject *request, Error **errp)
+static QObject *do_qmp_dispatch(QObject *request, QmpReturn *qret, Error=
 **errp)
 {
     Error *local_err =3D NULL;
     const char *command;
@@ -116,23 +116,57 @@ QObject *qmp_build_error_object(Error *err)
                               error_get_pretty(err));
 }
=20
-QObject *qmp_dispatch(QObject *request, QDict *rsp)
+static void qmp_return_free(QmpReturn *qret)
+{
+    QDict *rsp =3D qret->rsp;
+
+    qobject_decref(QOBJECT(rsp));
+    g_free(qret);
+}
+
+static void do_qmp_return(QmpReturn *qret)
+{
+    QDict *rsp =3D qret->rsp;
+
+    qret->return_cb(QOBJECT(rsp), qret->opaque);
+
+    qmp_return_free(qret);
+}
+
+void qmp_return(QmpReturn *qret, QObject *cmd_rsp)
+{
+    qdict_put_obj(qret->rsp, "return", cmd_rsp ?: QOBJECT(qdict_new()));
+
+    do_qmp_return(qret);
+}
+
+void qmp_return_error(QmpReturn *qret, Error *err)
+{
+    qdict_put_obj(qret->rsp, "error", qmp_build_error_object(err));
+    error_free(err);
+
+    do_qmp_return(qret);
+}
+
+void qmp_dispatch(QObject *request, QDict *rsp,
+                  QmpDispatchReturn *return_cb, void *opaque)
 {
     Error *err =3D NULL;
+    QmpReturn *qret =3D g_new0(QmpReturn, 1);
     QObject *ret;
=20
-    ret =3D do_qmp_dispatch(request, &err);
+    assert(return_cb);
+
+    qret->rsp =3D rsp ?: qdict_new();
+    qret->return_cb =3D return_cb;
+    qret->opaque =3D opaque;
+
+    ret =3D do_qmp_dispatch(request, qret, &err);
=20
-    rsp =3D rsp ?: qdict_new();
     if (err) {
-        qdict_put_obj(rsp, "error", qmp_build_error_object(err));
-        error_free(err);
+        assert(!ret);
+        qmp_return_error(qret, err);
     } else if (ret) {
-        qdict_put_obj(rsp, "return", ret);
-    } else {
-        QDECREF(rsp);
-        return NULL;
+        qmp_return(qret, ret);
     }
-
-    return QOBJECT(rsp);
 }
diff --git a/qga/main.c b/qga/main.c
index 442990c869..a50acf27a5 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -548,21 +548,21 @@ static int send_response(GAState *s, QObject *paylo=
ad)
     return 0;
 }
=20
-static void process_command(GAState *s, QDict *req)
+static void dispatch_return_cb(QObject *rsp, void *opaque)
 {
-    QObject *rsp =3D NULL;
-    int ret;
+    GAState *s =3D opaque;
+    int ret =3D send_response(s, rsp);
+
+    if (ret) {
+        g_warning("error sending response: %s", strerror(ret));
+    }
+}
=20
+static void process_command(GAState *s, QDict *req)
+{
     g_assert(req);
     g_debug("processing command");
-    rsp =3D qmp_dispatch(QOBJECT(req), NULL);
-    if (rsp) {
-        ret =3D send_response(s, rsp);
-        if (ret) {
-            g_warning("error sending response: %s", strerror(ret));
-        }
-        qobject_decref(rsp);
-    }
+    qmp_dispatch(QOBJECT(req), NULL, dispatch_return_cb, s);
 }
=20
 /* handle requests/control events coming in over the channel */
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index a6d8e4b141..6510245b4f 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -85,23 +85,30 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_q=
emu_x_EnumList *a,
     return ret;
 }
=20
+static void dispatch_cmd_return(QObject *resp, void *opaque)
+{
+    assert(resp !=3D NULL);
+    assert(!qdict_haskey(qobject_to_qdict(resp), "error"));
+}
=20
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
     QDict *req =3D qdict_new();
-    QObject *resp;
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
-    resp =3D qmp_dispatch(QOBJECT(req), NULL);
-    assert(resp !=3D NULL);
-    assert(!qdict_haskey(qobject_to_qdict(resp), "error"));
+    qmp_dispatch(QOBJECT(req), NULL, dispatch_cmd_return, NULL);
=20
-    qobject_decref(resp);
     QDECREF(req);
 }
=20
+static void dispatch_cmd_error_return(QObject *resp, void *opaque)
+{
+    assert(resp !=3D NULL);
+    assert(qdict_haskey(qobject_to_qdict(resp), "error"));
+}
+
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
@@ -111,11 +118,7 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
2")));
=20
-    resp =3D qmp_dispatch(QOBJECT(req), NULL);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(qobject_to_qdict(resp), "error"));
-
-    qobject_decref(resp);
+    qmp_dispatch(QOBJECT(req), NULL, dispatch_cmd_error_return, NULL);
     QDECREF(req);
=20
     /* check that with extra arguments it throws an error */
@@ -125,28 +128,29 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
-    resp =3D qmp_dispatch(QOBJECT(req), NULL);
-    assert(resp !=3D NULL);
-    assert(qdict_haskey(qobject_to_qdict(resp), "error"));
-
-    qobject_decref(resp);
+    qmp_dispatch(QOBJECT(req), NULL, dispatch_cmd_error_return, NULL);
     QDECREF(req);
 }
=20
+static QObject *dispatch_ret;
+
+static void qmp_dispatch_return(QObject *resp_obj, void *opaque)
+{
+    QDict *resp =3D qobject_to_qdict(resp_obj);
+    assert(resp && !qdict_haskey(resp, "error"));
+    dispatch_ret =3D qdict_get(resp, "return");
+    assert(dispatch_ret);
+    qobject_incref(dispatch_ret);
+}
+
 static QObject *test_qmp_dispatch(QDict *req)
 {
-    QObject *resp_obj;
-    QDict *resp;
     QObject *ret;
=20
-    resp_obj =3D qmp_dispatch(QOBJECT(req), NULL);
-    assert(resp_obj);
-    resp =3D qobject_to_qdict(resp_obj);
-    assert(resp && !qdict_haskey(resp, "error"));
-    ret =3D qdict_get(resp, "return");
-    assert(ret);
-    qobject_incref(ret);
-    qobject_decref(resp_obj);
+    qmp_dispatch(QOBJECT(req), NULL, qmp_dispatch_return, NULL);
+    ret =3D dispatch_ret;
+    dispatch_ret =3D NULL;
+
     return ret;
 }
=20
--=20
2.11.0.295.gd7dffce1c
