Received: from eggs.gnu.org ([2001:4830:134:3::10]:37783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiV-0002xp-M1
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiP-0007Y8-CK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiP-0007XV-4I
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:01 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45A777FB9E
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:12 +0400
Message-Id: <20170118160332.13390-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/25] qmp: add QmpClient
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

Add a new QmpClient structure holding the dispatch return callback
and the list of pending QmpReturns.

When a client disconnects, call qmp_client_destroy(). This will remove
all pending returns from the client list, and prevent a reply from being
sent later: new clients will only receive reply they expect, and not one
from a previous client.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h | 22 ++++++++++++++++------
 monitor.c                   | 10 +++++++---
 qapi/qmp-dispatch.c         | 44 ++++++++++++++++++++++++++++++++++++++-=
-----
 qga/main.c                  | 10 ++++++----
 tests/test-qmp-commands.c   | 31 ++++++++++++++++++++++---------
 5 files changed, 89 insertions(+), 28 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 780b3e2a09..32876764f3 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -17,14 +17,23 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qdict.h"
=20
-typedef void (QmpDispatchReturn) (QObject *rsp, void *opaque);
+typedef struct QmpClient QmpClient;
+
+typedef void (QmpDispatchReturn) (QmpClient *client, QObject *rsp);
=20
 typedef struct QmpReturn {
     QDict *rsp;
-    QmpDispatchReturn *return_cb;
-    void *opaque;
+    QmpClient *client;
+
+    QLIST_ENTRY(QmpReturn) link;
 } QmpReturn;
=20
+struct QmpClient {
+    QmpDispatchReturn *return_cb;
+
+    QLIST_HEAD(, QmpReturn) pending;
+};
+
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
=20
 typedef enum QmpCommandOptions
@@ -46,8 +55,9 @@ void qmp_register_command(const char *name, QmpCommandF=
unc *fn,
                           QmpCommandOptions options);
 void qmp_unregister_command(const char *name);
 QmpCommand *qmp_find_command(const char *name);
-void qmp_dispatch(QObject *request, QDict *rsp,
-                  QmpDispatchReturn *return_cb, void *opaque);
+void qmp_client_init(QmpClient *client, QmpDispatchReturn *return_cb);
+void qmp_client_destroy(QmpClient *client);
+void qmp_dispatch(QmpClient *client, QObject *request, QDict *rsp);
 void qmp_disable_command(const char *name);
 void qmp_enable_command(const char *name);
 bool qmp_command_is_enabled(const QmpCommand *cmd);
@@ -61,7 +71,7 @@ void qmp_for_each_command(qmp_cmd_callback_fn fn, void =
*opaque);
  * qmp_return{_error}:
  *
  * Construct the command reply, and call the
- * return_cb() associated with the dispatch.
+ * return_cb() associated with the QmpClient.
  *
  * Finally, free the QmpReturn.
  */
diff --git a/monitor.c b/monitor.c
index 462ee127b4..98ba40b573 100644
--- a/monitor.c
+++ b/monitor.c
@@ -165,6 +165,7 @@ typedef struct {
      * mode.
      */
     bool in_command_mode;       /* are we in command mode? */
+    QmpClient client;
 } MonitorQMP;
=20
 /*
@@ -584,6 +585,7 @@ static void monitor_data_destroy(Monitor *mon)
     if (monitor_is_qmp(mon)) {
         json_message_parser_destroy(&mon->qmp.parser);
     }
+    qmp_client_destroy(&mon->qmp.client);
     g_free(mon->rs);
     QDECREF(mon->outbuf);
     qemu_mutex_destroy(&mon->out_lock);
@@ -3723,9 +3725,9 @@ static QDict *qmp_check_input_obj(QObject *input_ob=
j, Error **errp)
     return input_dict;
 }
=20
-static void qmp_dispatch_return(QObject *rsp, void *opaque)
+static void qmp_dispatch_return(QmpClient *client, QObject *rsp)
 {
-    Monitor *mon =3D opaque;
+    Monitor *mon =3D container_of(client, Monitor, qmp.client);
=20
     monitor_json_emitter(mon, rsp);
 }
@@ -3765,7 +3767,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         goto err_out;
     }
=20
-    qmp_dispatch(req, rqdict, qmp_dispatch_return, mon);
+    qmp_dispatch(&mon->qmp.client, req, rqdict);
     qobject_decref(req);
     return;
=20
@@ -3854,6 +3856,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
=20
     switch (event) {
     case CHR_EVENT_OPENED:
+        qmp_client_init(&mon->qmp.client, qmp_dispatch_return);
         mon->qmp.in_command_mode =3D false;
         data =3D get_qmp_greeting();
         monitor_json_emitter(mon, data);
@@ -3863,6 +3866,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
     case CHR_EVENT_CLOSED:
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
+        qmp_client_destroy(&mon->qmp.client);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 7e9d03f262..31227ce6e9 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -120,6 +120,10 @@ static void qmp_return_free(QmpReturn *qret)
 {
     QDict *rsp =3D qret->rsp;
=20
+    if (qret->client) {
+        QLIST_REMOVE(qret, link);
+    }
+
     qobject_decref(QOBJECT(rsp));
     g_free(qret);
 }
@@ -127,8 +131,11 @@ static void qmp_return_free(QmpReturn *qret)
 static void do_qmp_return(QmpReturn *qret)
 {
     QDict *rsp =3D qret->rsp;
+    QmpClient *client =3D qret->client;
=20
-    qret->return_cb(QOBJECT(rsp), qret->opaque);
+    if (client) {
+        client->return_cb(client, QOBJECT(rsp));
+    }
=20
     qmp_return_free(qret);
 }
@@ -148,25 +155,50 @@ void qmp_return_error(QmpReturn *qret, Error *err)
     do_qmp_return(qret);
 }
=20
-void qmp_dispatch(QObject *request, QDict *rsp,
-                  QmpDispatchReturn *return_cb, void *opaque)
+void qmp_client_init(QmpClient *client, QmpDispatchReturn *return_cb)
+{
+    assert(!client->return_cb);
+
+    client->return_cb =3D return_cb;
+    QLIST_INIT(&client->pending);
+}
+
+void qmp_client_destroy(QmpClient *client)
+{
+    QmpReturn *ret, *next;
+
+    client->return_cb =3D NULL;
+    /* Remove the weak references to the pending returns. The
+     * dispatched function is the owner of QmpReturn, and will have to
+     * qmp_return(). (it might be interesting to have a way to notify
+     * that the client disconnected to cancel an on-going
+     * operation) */
+    QLIST_FOREACH_SAFE(ret, &client->pending, link, next) {
+        ret->client =3D NULL;
+        QLIST_REMOVE(ret, link);
+    }
+}
+
+void qmp_dispatch(QmpClient *client, QObject *request, QDict *rsp)
 {
     Error *err =3D NULL;
     QmpReturn *qret =3D g_new0(QmpReturn, 1);
     QObject *ret;
=20
-    assert(return_cb);
+    assert(client);
=20
     qret->rsp =3D rsp ?: qdict_new();
-    qret->return_cb =3D return_cb;
-    qret->opaque =3D opaque;
+    qret->client =3D client;
+    QLIST_INSERT_HEAD(&client->pending, qret, link);
=20
     ret =3D do_qmp_dispatch(request, qret, &err);
=20
     if (err) {
         assert(!ret);
         qmp_return_error(qret, err);
+        return;
     } else if (ret) {
         qmp_return(qret, ret);
+        return;
     }
 }
diff --git a/qga/main.c b/qga/main.c
index a50acf27a5..a75544ed7a 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -89,6 +89,7 @@ struct GAState {
 #endif
     gchar *pstate_filepath;
     GAPersistentState pstate;
+    QmpClient client;
 };
=20
 struct GAState *ga_state;
@@ -548,9 +549,9 @@ static int send_response(GAState *s, QObject *payload=
)
     return 0;
 }
=20
-static void dispatch_return_cb(QObject *rsp, void *opaque)
+static void dispatch_return_cb(QmpClient *client, QObject *rsp)
 {
-    GAState *s =3D opaque;
+    GAState *s =3D container_of(client, GAState, client);
     int ret =3D send_response(s, rsp);
=20
     if (ret) {
@@ -562,7 +563,7 @@ static void process_command(GAState *s, QDict *req)
 {
     g_assert(req);
     g_debug("processing command");
-    qmp_dispatch(QOBJECT(req), NULL, dispatch_return_cb, s);
+    qmp_dispatch(&ga_state->client, QOBJECT(req), NULL);
 }
=20
 /* handle requests/control events coming in over the channel */
@@ -1286,6 +1287,7 @@ static int run_agent(GAState *s, GAConfig *config)
     ga_command_state_init_all(s->command_state);
     json_message_parser_init(&s->parser, process_event);
     ga_state =3D s;
+    qmp_client_init(&s->client, dispatch_return_cb);
 #ifndef _WIN32
     if (!register_signal_handlers()) {
         g_critical("failed to register signal handlers");
@@ -1381,7 +1383,7 @@ end:
     }
     g_free(s->pstate_filepath);
     g_free(s->state_filepath_isfrozen);
-
+    qmp_client_destroy(&s->client);
     if (config->daemonize) {
         unlink(config->pid_filepath);
     }
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 6510245b4f..a3c7c590d1 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -85,7 +85,7 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_qem=
u_x_EnumList *a,
     return ret;
 }
=20
-static void dispatch_cmd_return(QObject *resp, void *opaque)
+static void dispatch_cmd_return(QmpClient *client, QObject *resp)
 {
     assert(resp !=3D NULL);
     assert(!qdict_haskey(qobject_to_qdict(resp), "error"));
@@ -94,16 +94,20 @@ static void dispatch_cmd_return(QObject *resp, void *=
opaque)
 /* test commands with no input and no return value */
 static void test_dispatch_cmd(void)
 {
+    QmpClient client =3D { 0, };
     QDict *req =3D qdict_new();
=20
-    qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
+    qmp_client_init(&client, dispatch_cmd_return);
=20
-    qmp_dispatch(QOBJECT(req), NULL, dispatch_cmd_return, NULL);
+    qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
+    qmp_dispatch(&client, QOBJECT(req), NULL);
     QDECREF(req);
+
+    qmp_client_destroy(&client);
 }
=20
-static void dispatch_cmd_error_return(QObject *resp, void *opaque)
+static void dispatch_cmd_error_return(QmpClient *client, QObject *resp)
 {
     assert(resp !=3D NULL);
     assert(qdict_haskey(qobject_to_qdict(resp), "error"));
@@ -112,13 +116,15 @@ static void dispatch_cmd_error_return(QObject *resp=
, void *opaque)
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
+    QmpClient client =3D { 0, };
     QDict *req =3D qdict_new();
     QDict *args =3D qdict_new();
-    QObject *resp;
+
+    qmp_client_init(&client, dispatch_cmd_error_return);
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
2")));
=20
-    qmp_dispatch(QOBJECT(req), NULL, dispatch_cmd_error_return, NULL);
+    qmp_dispatch(&client, QOBJECT(req), NULL);
     QDECREF(req);
=20
     /* check that with extra arguments it throws an error */
@@ -128,13 +134,16 @@ static void test_dispatch_cmd_failure(void)
=20
     qdict_put_obj(req, "execute", QOBJECT(qstring_from_str("user_def_cmd=
")));
=20
-    qmp_dispatch(QOBJECT(req), NULL, dispatch_cmd_error_return, NULL);
+    qmp_dispatch(&client, QOBJECT(req), NULL);
+
     QDECREF(req);
+
+    qmp_client_destroy(&client);
 }
=20
 static QObject *dispatch_ret;
=20
-static void qmp_dispatch_return(QObject *resp_obj, void *opaque)
+static void qmp_dispatch_return(QmpClient *client, QObject *resp_obj)
 {
     QDict *resp =3D qobject_to_qdict(resp_obj);
     assert(resp && !qdict_haskey(resp, "error"));
@@ -146,8 +155,12 @@ static void qmp_dispatch_return(QObject *resp_obj, v=
oid *opaque)
 static QObject *test_qmp_dispatch(QDict *req)
 {
     QObject *ret;
+    QmpClient client =3D { 0, };
+
+    qmp_client_init(&client, qmp_dispatch_return);
+    qmp_dispatch(&client, QOBJECT(req), NULL);
+    qmp_client_destroy(&client);
=20
-    qmp_dispatch(QOBJECT(req), NULL, qmp_dispatch_return, NULL);
     ret =3D dispatch_ret;
     dispatch_ret =3D NULL;
=20
--=20
2.11.0.295.gd7dffce1c
