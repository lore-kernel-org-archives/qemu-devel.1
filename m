Received: from eggs.gnu.org ([209.51.188.92]:56459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwU1a-0006gF-GM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwU1Z-0001X2-9J
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwU1Y-0001WF-Vg
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:05 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 16:42:53 +0100
Message-Id: <20190220154253.26982-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190220154253.26982-1-marcandre.lureau@redhat.com>
References: <20190220154253.26982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] qmp: common 'id' handling & make QGA
 conform to QMP spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let qmp_dispatch() copy the 'id' field. That way any qmp client will
conform to the specification, including QGA. Furthermore, it
simplifies the work for qemu monitor.

CC: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c           | 33 ++++++++++++---------------------
 qapi/qmp-dispatch.c | 10 ++++++++--
 tests/test-qga.c    | 13 +++++--------
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/monitor.c b/monitor.c
index 33ccbf3957..c0bc089645 100644
--- a/monitor.c
+++ b/monitor.c
@@ -249,8 +249,6 @@ QEMUBH *qmp_dispatcher_bh;
 struct QMPRequest {
     /* Owner of the request */
     Monitor *mon;
-    /* "id" field of the request */
-    QObject *id;
     /*
      * Request object to be handled or Error to be reported
      * (exactly one of them is non-null)
@@ -352,7 +350,6 @@ int monitor_read_password(Monitor *mon, ReadLineFunc =
*readline_func,
=20
 static void qmp_request_free(QMPRequest *req)
 {
-    qobject_unref(req->id);
     qobject_unref(req->req);
     error_free(req->err);
     g_free(req);
@@ -4026,18 +4023,14 @@ static int monitor_can_read(void *opaque)
  * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
  * Nothing is emitted then.
  */
-static void monitor_qmp_respond(Monitor *mon, QDict *rsp, QObject *id)
+static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
 {
     if (rsp) {
-        if (id) {
-            qdict_put_obj(rsp, "id", qobject_ref(id));
-        }
-
         qmp_send_response(mon, rsp);
     }
 }
=20
-static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id=
)
+static void monitor_qmp_dispatch(Monitor *mon, QObject *req)
 {
     Monitor *old_mon;
     QDict *rsp;
@@ -4062,7 +4055,7 @@ static void monitor_qmp_dispatch(Monitor *mon, QObj=
ect *req, QObject *id)
         }
     }
=20
-    monitor_qmp_respond(mon, rsp, id);
+    monitor_qmp_respond(mon, rsp);
     qobject_unref(rsp);
 }
=20
@@ -4126,13 +4119,15 @@ static void monitor_qmp_bh_dispatcher(void *data)
         mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
     if (req_obj->req) {
-        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
-        monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
+        QDict *qdict =3D qobject_to(QDict, req_obj->req);
+        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
+        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
+        monitor_qmp_dispatch(mon, req_obj->req);
     } else {
         assert(req_obj->err);
         rsp =3D qmp_error_response(req_obj->err);
         req_obj->err =3D NULL;
-        monitor_qmp_respond(mon, rsp, NULL);
+        monitor_qmp_respond(mon, rsp);
         qobject_unref(rsp);
     }
=20
@@ -4157,8 +4152,7 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
=20
     qdict =3D qobject_to(QDict, req);
     if (qdict) {
-        id =3D qobject_ref(qdict_get(qdict, "id"));
-        qdict_del(qdict, "id");
+        id =3D qdict_get(qdict, "id");
     } /* else will fail qmp_dispatch() */
=20
     if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
@@ -4169,17 +4163,14 @@ static void handle_qmp_command(void *opaque, QObj=
ect *req, Error *err)
=20
     if (qdict && qmp_is_oob(qdict)) {
         /* OOB commands are executed immediately */
-        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
-                                          ?: "");
-        monitor_qmp_dispatch(mon, req, id);
+        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id) ?: "")=
;
+        monitor_qmp_dispatch(mon, req);
         qobject_unref(req);
-        qobject_unref(id);
         return;
     }
=20
     req_obj =3D g_new0(QMPRequest, 1);
     req_obj->mon =3D mon;
-    req_obj->id =3D id;
     req_obj->req =3D req;
     req_obj->err =3D err;
=20
@@ -4199,7 +4190,7 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
=20
     /*
      * Put the request to the end of queue so that requests will be
-     * handled in time order.  Ownership for req_obj, req, id,
+     * handled in time order.  Ownership for req_obj, req,
      * etc. will be delivered to the handler side.
      */
     assert(mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX);
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 1d922e04f7..5f812bb9f2 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -58,6 +58,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, bool allow_oob,
                            "QMP input member 'arguments' must be an obje=
ct");
                 return NULL;
             }
+        } else if (!strcmp(arg_name, "id")) {
+            continue;
         } else {
             error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
@@ -165,11 +167,11 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *=
request,
                     bool allow_oob)
 {
     Error *err =3D NULL;
-    QObject *ret;
+    QDict *dict =3D qobject_to(QDict, request);
+    QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;
     QDict *rsp;
=20
     ret =3D do_qmp_dispatch(cmds, request, allow_oob, &err);
-
     if (err) {
         rsp =3D qmp_error_response(err);
     } else if (ret) {
@@ -180,5 +182,9 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
         rsp =3D NULL;
     }
=20
+    if (rsp && id) {
+        qdict_put_obj(rsp, "id", qobject_ref(id));
+    }
+
     return rsp;
 }
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 3d6377436a..891aa3d322 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -225,18 +225,15 @@ static void test_qga_ping(gconstpointer fix)
     qobject_unref(ret);
 }
=20
-static void test_qga_invalid_id(gconstpointer fix)
+static void test_qga_id(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
-    QDict *ret, *error;
-    const char *class;
+    QDict *ret;
=20
     ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
     g_assert_nonnull(ret);
-
-    error =3D qdict_get_qdict(ret, "error");
-    class =3D qdict_get_try_str(error, "class");
-    g_assert_cmpstr(class, =3D=3D, "GenericError");
+    qmp_assert_no_error(ret);
+    g_assert_cmpint(qdict_get_int(ret, "id"), =3D=3D, 1);
=20
     qobject_unref(ret);
 }
@@ -992,7 +989,7 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/file-ops", &fix, test_qga_file_ops);
     g_test_add_data_func("/qga/file-write-read", &fix, test_qga_file_wri=
te_read);
     g_test_add_data_func("/qga/get-time", &fix, test_qga_get_time);
-    g_test_add_data_func("/qga/invalid-id", &fix, test_qga_invalid_id);
+    g_test_add_data_func("/qga/id", &fix, test_qga_id);
     g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob)=
;
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd)=
;
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_arg=
s);
--=20
2.21.0.rc1
