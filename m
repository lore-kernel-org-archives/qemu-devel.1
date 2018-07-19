Received: from eggs.gnu.org ([2001:4830:134:3::10]:48870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrs-0001ia-IW
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrp-0007rX-Sk
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDrk-0007om-3a
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:32 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:40:59 +0200
Message-Id: <20180719184111.5129-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/18] qga: process_event() simplification
 and leak fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

json_parser_parse_err() may return something else than a QDict, in
which case we loose the object. Let's keep track of the original
object to avoid leaks.

When an error occurs, "qdict" contains the response, but we still
check the "execute" key there. Untangle a bit this code, by having a
clear error path.

CC: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qga/main.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 537cc0e162..87372d40ef 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -600,42 +600,42 @@ static void process_command(GAState *s, QDict *req)
 static void process_event(JSONMessageParser *parser, GQueue *tokens)
 {
     GAState *s =3D container_of(parser, GAState, parser);
-    QDict *qdict;
+    QObject *obj;
+    QDict *req, *rsp;
     Error *err =3D NULL;
     int ret;
=20
     g_assert(s && parser);
=20
     g_debug("process_event: called");
-    qdict =3D qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err=
));
-    if (err || !qdict) {
-        qobject_unref(qdict);
-        if (!err) {
-            g_warning("failed to parse event: unknown error");
-            error_setg(&err, QERR_JSON_PARSING);
-        } else {
-            g_warning("failed to parse event: %s", error_get_pretty(err)=
);
-        }
-        qdict =3D qmp_error_response(err);
+    obj =3D json_parser_parse_err(tokens, NULL, &err);
+    if (err) {
+        goto err;
     }
-
-    /* handle host->guest commands */
-    if (qdict_haskey(qdict, "execute")) {
-        process_command(s, qdict);
-    } else {
-        if (!qdict_haskey(qdict, "error")) {
-            qobject_unref(qdict);
-            g_warning("unrecognized payload format");
-            error_setg(&err, QERR_UNSUPPORTED);
-            qdict =3D qmp_error_response(err);
-        }
-        ret =3D send_response(s, qdict);
-        if (ret < 0) {
-            g_warning("error sending error response: %s", strerror(-ret)=
);
-        }
+    req =3D qobject_to(QDict, obj);
+    if (!req) {
+        error_setg(&err, QERR_JSON_PARSING);
+        goto err;
+    }
+    if (!qdict_haskey(req, "execute")) {
+        g_warning("unrecognized payload format");
+        error_setg(&err, QERR_UNSUPPORTED);
+        goto err;
     }
=20
-    qobject_unref(qdict);
+    process_command(s, req);
+    qobject_unref(obj);
+    return;
+
+err:
+    g_warning("failed to parse event: %s", error_get_pretty(err));
+    rsp =3D qmp_error_response(err);
+    ret =3D send_response(s, rsp);
+    if (ret < 0) {
+        g_warning("error sending error response: %s", strerror(-ret));
+    }
+    qobject_unref(rsp);
+    qobject_unref(obj);
 }
=20
 /* false return signals GAChannel to close the current client connection=
 */
--=20
2.18.0.129.ge3331758f1
