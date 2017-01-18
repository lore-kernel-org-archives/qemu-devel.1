Received: from eggs.gnu.org ([2001:4830:134:3::10]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiL-0002pn-Q0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiH-0007Sc-JK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiH-0007Rj-Ap
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:53 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77FF5DCD99
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:03:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:10 +0400
Message-Id: <20170118160332.13390-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/25] qmp: teach qmp_dispatch() to take a
 pre-filled QDict
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

Give an optional qdict for the dispatch call to be used for the
reply. The qemu monitor has the request "id" pre-filled, simplifying the
code a bit.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/dispatch.h |  2 +-
 monitor.c                   | 26 +++++++++++---------------
 qapi/qmp-dispatch.c         |  5 ++---
 qga/main.c                  |  2 +-
 tests/test-qmp-commands.c   |  8 ++++----
 5 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 57651ea955..db483481b0 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -38,7 +38,7 @@ void qmp_register_command(const char *name, QmpCommandF=
unc *fn,
                           QmpCommandOptions options);
 void qmp_unregister_command(const char *name);
 QmpCommand *qmp_find_command(const char *name);
-QObject *qmp_dispatch(QObject *request);
+QObject *qmp_dispatch(QObject *request, QDict *rsp);
 void qmp_disable_command(const char *name);
 void qmp_enable_command(const char *name);
 bool qmp_command_is_enabled(const QmpCommand *cmd);
diff --git a/monitor.c b/monitor.c
index 0841d436b0..edd30e4d8f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3725,12 +3725,13 @@ static QDict *qmp_check_input_obj(QObject *input_=
obj, Error **errp)
=20
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
 {
-    QObject *req, *rsp =3D NULL, *id =3D NULL;
-    QDict *qdict =3D NULL;
+    QObject *req, *rsp, *id =3D NULL;
+    QDict *qdict, *rqdict =3D qdict_new();
     const char *cmd_name;
     Monitor *mon =3D cur_mon;
     Error *err =3D NULL;
=20
+    rsp =3D QOBJECT(rqdict);
     req =3D json_parser_parse_err(tokens, NULL, &err);
     if (err || !req || qobject_type(req) !=3D QTYPE_QDICT) {
         if (!err) {
@@ -3745,8 +3746,11 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
     }
=20
     id =3D qdict_get(qdict, "id");
-    qobject_incref(id);
-    qdict_del(qdict, "id");
+    if (id) {
+        qobject_incref(id);
+        qdict_del(qdict, "id");
+        qdict_put_obj(rqdict, "id", id);
+    }
=20
     cmd_name =3D qdict_get_str(qdict, "execute");
     trace_handle_qmp_command(mon, cmd_name);
@@ -3755,27 +3759,19 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
         goto err_out;
     }
=20
-    rsp =3D qmp_dispatch(req);
+    rsp =3D qmp_dispatch(req, rqdict);
=20
 err_out:
     if (err) {
-        qdict =3D qdict_new();
-        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
+        qdict_put_obj(rqdict, "error", qmp_build_error_object(err));
         error_free(err);
-        rsp =3D QOBJECT(qdict);
     }
=20
     if (rsp) {
-        if (id) {
-            qdict_put_obj(qobject_to_qdict(rsp), "id", id);
-            id =3D NULL;
-        }
-
         monitor_json_emitter(mon, rsp);
     }
=20
-    qobject_decref(id);
-    qobject_decref(rsp);
+    QDECREF(rqdict);
     qobject_decref(req);
 }
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 505eb418ac..dbf2e5b655 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -116,15 +116,14 @@ QObject *qmp_build_error_object(Error *err)
                               error_get_pretty(err));
 }
=20
-QObject *qmp_dispatch(QObject *request)
+QObject *qmp_dispatch(QObject *request, QDict *rsp)
 {
     Error *err =3D NULL;
     QObject *ret;
-    QDict *rsp;
=20
     ret =3D do_qmp_dispatch(request, &err);
=20
-    rsp =3D qdict_new();
+    rsp =3D rsp ?: qdict_new();
     if (err) {
         qdict_put_obj(rsp, "error", qmp_build_error_object(err));
         error_free(err);
diff --git a/qga/main.c b/qga/main.c
index 6caf215575..442990c869 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -555,7 +555,7 @@ static void process_command(GAState *s, QDict *req)
=20
     g_assert(req);
     g_debug("processing command");
-    rsp =3D qmp_dispatch(QOBJECT(req));
+    rsp =3D qmp_dispatch(QOBJECT(req), NULL);
     if (rsp) {
         ret =3D send_response(s, rsp);
         if (ret) {
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index e46981eb1e..a6d8e4b141 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -94,7 +94,7 @@ static void test_dispatch_cmd(void)
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
-    resp =3D qmp_dispatch(QOBJECT(req));
+    resp =3D qmp_dispatch(QOBJECT(req), NULL);
     assert(resp !=3D NULL);
     assert(!qdict_haskey(qobject_to_qdict(resp), "error"));
=20
@@ -111,7 +111,7 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
2")));
=20
-    resp =3D qmp_dispatch(QOBJECT(req));
+    resp =3D qmp_dispatch(QOBJECT(req), NULL);
     assert(resp !=3D NULL);
     assert(qdict_haskey(qobject_to_qdict(resp), "error"));
=20
@@ -125,7 +125,7 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
-    resp =3D qmp_dispatch(QOBJECT(req));
+    resp =3D qmp_dispatch(QOBJECT(req), NULL);
     assert(resp !=3D NULL);
     assert(qdict_haskey(qobject_to_qdict(resp), "error"));
=20
@@ -139,7 +139,7 @@ static QObject *test_qmp_dispatch(QDict *req)
     QDict *resp;
     QObject *ret;
=20
-    resp_obj =3D qmp_dispatch(QOBJECT(req));
+    resp_obj =3D qmp_dispatch(QOBJECT(req), NULL);
     assert(resp_obj);
     resp =3D qobject_to_qdict(resp_obj);
     assert(resp && !qdict_haskey(resp, "error"));
--=20
2.11.0.295.gd7dffce1c
