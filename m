Received: from eggs.gnu.org ([2001:4830:134:3::10]:49078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDs5-0001sD-VI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDs4-00080V-S1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDs4-00080L-M3
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 416EB401C090
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:10 +0200
Message-Id: <20180719184111.5129-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/18] qga: process_event() simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Simplify the code around qmp_dispatch():
- rely on qmp_dispatch/check_obj() for message checking
- have a single send_response() point
- constify send_response() argument

It changes a couple of error messages:

* When @req isn't a dictionary, from
    Invalid JSON syntax
  to
    QMP input must be a JSON object

* When @req lacks member "execute", from
    this feature or command is not currently supported
  to
    QMP input lacks member 'execute'

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 54 +++++++++++++-----------------------------------------
 1 file changed, 13 insertions(+), 41 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 9032bb0c7a..f5c772314f 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -545,15 +545,15 @@ fail:
 #endif
 }
=20
-static int send_response(GAState *s, QDict *payload)
+static int send_response(GAState *s, const QDict *rsp)
 {
     const char *buf;
     QString *payload_qstr, *response_qstr;
     GIOStatus status;
=20
-    g_assert(payload && s->channel);
+    g_assert(rsp && s->channel);
=20
-    payload_qstr =3D qobject_to_json(QOBJECT(payload));
+    payload_qstr =3D qobject_to_json(QOBJECT(rsp));
     if (!payload_qstr) {
         return -EINVAL;
     }
@@ -579,63 +579,35 @@ static int send_response(GAState *s, QDict *payload=
)
     return 0;
 }
=20
-static void process_command(GAState *s, QDict *req)
-{
-    QDict *rsp;
-    int ret;
-
-    g_assert(req);
-    g_debug("processing command");
-    rsp =3D qmp_dispatch(&ga_commands, QOBJECT(req), false);
-    if (rsp) {
-        ret =3D send_response(s, rsp);
-        if (ret < 0) {
-            g_warning("error sending response: %s", strerror(-ret));
-        }
-        qobject_unref(rsp);
-    }
-}
-
 /* handle requests/control events coming in over the channel */
 static void process_event(JSONMessageParser *parser, GQueue *tokens)
 {
     GAState *s =3D container_of(parser, GAState, parser);
-    QObject *obj;
-    QDict *req, *rsp;
+    QObject *req;
+    QDict *rsp =3D NULL;
     Error *err =3D NULL;
     int ret;
=20
     g_assert(s && parser);
=20
     g_debug("process_event: called");
-    obj =3D json_parser_parse(tokens, NULL, &err);
+
+    req =3D json_parser_parse(tokens, NULL, &err);
     if (err) {
-        goto err;
-    }
-    req =3D qobject_to(QDict, obj);
-    if (!req) {
-        error_setg(&err, "Input must be a JSON object");
-        goto err;
-    }
-    if (!qdict_haskey(req, "execute")) {
-        g_warning("unrecognized payload format");
-        error_setg(&err, QERR_UNSUPPORTED);
-        goto err;
+        rsp =3D qmp_error_response(err);
+        goto end;
     }
=20
-    process_command(s, req);
-    qobject_unref(obj);
-    return;
+    g_debug("processing command");
+    rsp =3D qmp_dispatch(&ga_commands, req, false);
=20
-err:
-    g_warning("failed to parse event: %s", error_get_pretty(err));
-    rsp =3D qmp_error_response(err);
+end:
     ret =3D send_response(s, rsp);
     if (ret < 0) {
         g_warning("error sending error response: %s", strerror(-ret));
     }
     qobject_unref(rsp);
-    qobject_unref(obj);
+    qobject_unref(req);
 }
=20
 /* false return signals GAChannel to close the current client connection=
 */
--=20
2.18.0.129.ge3331758f1
