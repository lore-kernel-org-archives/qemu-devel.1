Received: from eggs.gnu.org ([2001:4830:134:3::10]:54935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkz-0005RK-3q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tky-0002t6-2h
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkx-0002sw-T2
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:51 +0200
Message-Id: <20180326150916.9602-14-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/38] qga: process_event() simplification
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

Simplify the code around qmp_dispatch().

Make qmp_dispatch_check_obj() a pre-requirement, same as qemu monitor.

Have a single send_response() point.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 67 +++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index df1888edc1..71468e68c2 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -579,67 +579,46 @@ static int send_response(GAState *s, QObject *paylo=
ad)
     return 0;
 }
=20
-static void process_command(GAState *s, QDict *req)
-{
-    QObject *rsp =3D NULL;
-    int ret;
-
-    g_assert(req);
-    g_debug("processing command");
-    rsp =3D qmp_dispatch(&ga_commands, QOBJECT(req));
-    if (rsp) {
-        ret =3D send_response(s, rsp);
-        if (ret < 0) {
-            g_warning("error sending response: %s", strerror(-ret));
-        }
-        qobject_decref(rsp);
-    }
-}
-
 /* handle requests/control events coming in over the channel */
 static void process_event(JSONMessageParser *parser, GQueue *tokens)
 {
     GAState *s =3D container_of(parser, GAState, parser);
-    QDict *qdict;
+    QObject *req, *rsp =3D NULL;
     Error *err =3D NULL;
     int ret;
=20
     g_assert(s && parser);
=20
     g_debug("process_event: called");
-    qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err=
));
-    if (err || !qdict) {
-        QDECREF(qdict);
-        qdict =3D qdict_new();
-        if (!err) {
-            g_warning("failed to parse event: unknown error");
-            error_setg(&err, QERR_JSON_PARSING);
-        } else {
-            g_warning("failed to parse event: %s", error_get_pretty(err)=
);
-        }
+
+    req =3D json_parser_parse_err(tokens, NULL, &err);
+    if (err) {
+        goto end;
+    }
+
+    qmp_dispatch_check_obj(req, &err);
+    if (err) {
+        goto end;
+    }
+
+    g_debug("processing command");
+    rsp =3D qmp_dispatch(&ga_commands, req);
+
+end:
+    if (err) {
+        QDict *qdict =3D qdict_new();
         qdict_put_obj(qdict, "error", qmp_build_error_object(err));
         error_free(err);
+        rsp =3D QOBJECT(qdict);
     }
-
-    /* handle host->guest commands */
-    if (qdict_haskey(qdict, "execute")) {
-        process_command(s, qdict);
-    } else {
-        if (!qdict_haskey(qdict, "error")) {
-            QDECREF(qdict);
-            qdict =3D qdict_new();
-            g_warning("unrecognized payload format");
-            error_setg(&err, QERR_UNSUPPORTED);
-            qdict_put_obj(qdict, "error", qmp_build_error_object(err));
-            error_free(err);
-        }
-        ret =3D send_response(s, QOBJECT(qdict));
+    if (rsp) {
+        ret =3D send_response(s, rsp);
         if (ret < 0) {
             g_warning("error sending error response: %s", strerror(-ret)=
);
         }
+        qobject_decref(rsp);
     }
-
-    QDECREF(qdict);
+    qobject_decref(req);
 }
=20
 /* false return signals GAChannel to close the current client connection=
 */
--=20
2.17.0.rc1.1.g4c4f2b46a3
