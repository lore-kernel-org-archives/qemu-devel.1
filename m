Received: from eggs.gnu.org ([2001:4830:134:3::10]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPct-0006kP-Tf
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPcs-0005qQ-Pj
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:14:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbPcs-0005qK-JK
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CAFE407447D
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:14:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 14:13:49 +0200
Message-Id: <20180706121354.2021-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180706121354.2021-1-marcandre.lureau@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/12] json-parser: always set an error if
 return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let's make json_parser_parse_err() suck less, and simplify caller
error handling.

 * qga/main.c process_event() doesn't need further changes after
   previous cleanup.

 * qobject/json-parser.c json_parser_parse()
   Ignores the error.

 * qobject/qjson.c qobject_from_jsonv() via parse_json()
  - qobject_from_json()
    ~ block.c parse_json_filename() - removed workaround
    ~ block/rbd.c - abort (generated json - should never fail)
    ~ qapi/qobject-input-visitor.c - removed workaround
    ~ tests/check-qjson.c - abort, ok
    ~ tests/test-visitor-serialization.c - abort, ok

  - qobject_from_jsonf()
    Now dies in error_handle_fatal() instead of the assertion.
    Only used in tests, ok.

  - tests/test-qobject-input-visitor.c
  - tests/libqtest.c qmp_fd_sendv()
    Passes &error_abort, does nothing when qobject_from_jsonv() returns
    null.  The fix makes this catch invalid JSON instead of silently
    ignoring it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block.c                      | 5 -----
 monitor.c                    | 4 ----
 qapi/qobject-input-visitor.c | 5 -----
 qobject/json-parser.c        | 8 +++++++-
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index ac8b3a3511..9046d66465 100644
--- a/block.c
+++ b/block.c
@@ -1478,11 +1478,6 @@ static QDict *parse_json_filename(const char *file=
name, Error **errp)
=20
     options_obj =3D qobject_from_json(filename, errp);
     if (!options_obj) {
-        /* Work around qobject_from_json() lossage TODO fix that */
-        if (errp && !*errp) {
-            error_setg(errp, "Could not parse the JSON options");
-            return NULL;
-        }
         error_prepend(errp, "Could not parse the JSON options: ");
         return NULL;
     }
diff --git a/monitor.c b/monitor.c
index ec40a80d81..a3efe96d1d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4112,10 +4112,6 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
     QMPRequest *req_obj;
=20
     req =3D json_parser_parse_err(tokens, NULL, &err);
-    if (!req && !err) {
-        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
-        error_setg(&err, QERR_JSON_PARSING);
-    }
=20
     qdict =3D qobject_to(QDict, req);
     if (qdict) {
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index da57f4cc24..3e88b27f9e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -725,11 +725,6 @@ Visitor *qobject_input_visitor_new_str(const char *s=
tr,
     if (is_json) {
         obj =3D qobject_from_json(str, errp);
         if (!obj) {
-            /* Work around qobject_from_json() lossage TODO fix that */
-            if (errp && !*errp) {
-                error_setg(errp, "JSON parse error");
-                return NULL;
-            }
             return NULL;
         }
         args =3D qobject_to(QDict, obj);
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index a5aa790d62..82c3167629 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -24,6 +24,7 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/qerror.h"
=20
 typedef struct JSONParserContext
 {
@@ -591,7 +592,12 @@ QObject *json_parser_parse_err(GQueue *tokens, va_li=
st *ap, Error **errp)
=20
     result =3D parse_value(ctxt, ap);
=20
-    error_propagate(errp, ctxt->err);
+    if (!result && !ctxt->err) {
+        /* TODO: improve error reporting */
+        error_setg(errp, QERR_JSON_PARSING);
+    } else {
+        error_propagate(errp, ctxt->err);
+    }
=20
     parser_context_free(ctxt);
=20
--=20
2.18.0.rc1
