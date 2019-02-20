Received: from eggs.gnu.org ([209.51.188.92]:56441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwU1Z-0006fg-UP
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwU1Z-0001Ww-1i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwU1X-0001VO-Ka
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 16:42:52 +0100
Message-Id: <20190220154253.26982-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190220154253.26982-1-marcandre.lureau@redhat.com>
References: <20190220154253.26982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qga: process_event() simplification
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

CC: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 47 +++++++++--------------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 87a0711c14..c0d77c79c4 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -523,15 +523,15 @@ fail:
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
@@ -557,53 +557,24 @@ static int send_response(GAState *s, QDict *payload=
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
 static void process_event(void *opaque, QObject *obj, Error *err)
 {
     GAState *s =3D opaque;
-    QDict *req, *rsp;
+    QDict *rsp;
     int ret;
=20
     g_debug("process_event: called");
     assert(!obj !=3D !err);
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
+    rsp =3D qmp_dispatch(&ga_commands, obj, false);
=20
-err:
-    g_warning("failed to parse event: %s", error_get_pretty(err));
-    rsp =3D qmp_error_response(err);
+end:
     ret =3D send_response(s, rsp);
     if (ret < 0) {
         g_warning("error sending error response: %s", strerror(-ret));
--=20
2.21.0.rc1
