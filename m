Received: from eggs.gnu.org ([2001:4830:134:3::10]:55123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlN-0005sf-P5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlH-00034y-RB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlH-00034V-Kt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:00 +0200
Message-Id: <20180326150916.9602-23-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 22/38] monitor: use QmpSession parsing and
 common dispatch code
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

The previous patch allow to factorize some code out of monitor, and
reuse the JSON parsing in QmpSession.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 50 ++++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/monitor.c b/monitor.c
index ae8c055df0..94ad366c2d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -58,8 +58,6 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/json-streamer.h"
-#include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qlist.h"
 #include "qom/object_interfaces.h"
 #include "trace-root.h"
@@ -625,7 +623,6 @@ static void monitor_data_destroy(Monitor *mon)
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
         qmp_session_destroy(&mon->qmp.session);
-        json_message_parser_destroy(&mon->qmp.parser);
     }
     readline_free(mon->rs);
     QDECREF(mon->outbuf);
@@ -4011,32 +4008,20 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
 #define  QMP_REQ_QUEUE_LEN_MAX  (8)
=20
-static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
+static void qmp_dispatch_cb(QmpSession *session, QDict *req)
 {
-    QObject *req, *id =3D NULL;
-    QDict *qdict =3D NULL;
-    MonitorQMP *mon_qmp =3D container_of(parser, MonitorQMP, parser);
-    Monitor *mon =3D container_of(mon_qmp, Monitor, qmp);
+    QDict *rsp;
+    QObject *id;
+    Monitor *mon =3D container_of(session, Monitor, qmp.session);
     Error *err =3D NULL;
     QMPRequest *req_obj;
=20
-    req =3D json_parser_parse_err(tokens, NULL, &err);
-    if (err) {
-        goto err;
-    }
-
-    /* Check against the request in general layout */
-    qdict =3D qmp_dispatch_check_obj(req, &err);
-    if (!qdict) {
-        goto err;
-    }
-
     /* Check against OOB specific */
-    if (!qmp_cmd_oob_check(mon, qdict, &err)) {
+    if (!qmp_cmd_oob_check(mon, req, &err)) {
         goto err;
     }
=20
-    id =3D qdict_get(qdict, "id");
+    id =3D qdict_get(req, "id");
=20
     /* When OOB is enabled, the "id" field is mandatory. */
     if (qmp_oob_enabled(mon) && !id) {
@@ -4045,12 +4030,13 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
         goto err;
     }
=20
+    QINCREF(req);
     req_obj =3D g_new0(QMPRequest, 1);
     req_obj->mon =3D mon;
     req_obj->id =3D id;
-    req_obj->req =3D qdict;
+    req_obj->req =3D req;
=20
-    if (qmp_is_oob(qdict)) {
+    if (qmp_is_oob(req)) {
         /* Out-Of-Band (OOB) requests are executed directly in parser. *=
/
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->i=
d)
                                           ?: "");
@@ -4076,7 +4062,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
             qapi_event_send_command_dropped(id,
                                             COMMAND_DROP_REASON_QUEUE_FU=
LL,
                                             &error_abort);
-            qobject_decref(req);
+            QDECREF(req);
             g_free(req_obj);
             return;
         }
@@ -4095,19 +4081,18 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
     return;
=20
 err:
-    qdict =3D qdict_new();
-    qdict_put_obj(qdict, "error", qmp_build_error_object(err));
+    rsp =3D qdict_new();
+    qdict_put_obj(rsp, "error", qmp_build_error_object(err));
     error_free(err);
-    monitor_json_emitter(mon, QOBJECT(qdict));
-    QDECREF(qdict);
-    qobject_decref(req);
+    monitor_json_emitter(mon, QOBJECT(rsp));
+    QDECREF(rsp);
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
     Monitor *mon =3D opaque;
=20
-    json_message_parser_feed(&mon->qmp.parser, (const char *) buf, size)=
;
+    qmp_session_feed(&mon->qmp.session, (const char *) buf, size);
 }
=20
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
@@ -4217,7 +4202,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
     case CHR_EVENT_OPENED:
         qmp_session_init(&mon->qmp.session,
                          &qmp_cap_negotiation_commands,
-                         NULL, /* XXX: not in use yet, but in following =
patch */
+                         qmp_dispatch_cb,
                          dispatch_return_cb);
         monitor_qmp_caps_reset(mon);
         data =3D get_qmp_greeting(mon);
@@ -4227,8 +4212,6 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
         break;
     case CHR_EVENT_CLOSED:
         qmp_session_destroy(&mon->qmp.session);
-        json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -4429,7 +4412,6 @@ void monitor_init(Chardev *chr, int flags)
=20
     if (monitor_is_qmp(mon)) {
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         if (mon->use_io_thr) {
             /*
              * Make sure the old iowatch is gone.  It's possible when
--=20
2.17.0.rc1.1.g4c4f2b46a3
