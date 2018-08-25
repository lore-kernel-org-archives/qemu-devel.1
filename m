Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4Z-0001LL-I6
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4X-0003EX-T6
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ftZ4X-0003E7-NS
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Aug 2018 15:57:23 +0200
Message-Id: <20180825135724.8981-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180825135724.8981-1-marcandre.lureau@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 8/9] qga: process_event() simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index 6d70242d05..f0ec035996 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -544,15 +544,15 @@ fail:
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
@@ -578,53 +578,24 @@ static int send_response(GAState *s, QDict *payload=
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
2.18.0.547.g1d89318c48
