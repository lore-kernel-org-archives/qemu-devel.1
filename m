Received: from eggs.gnu.org ([2001:4830:134:3::10]:48961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDs0-0001oc-MX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDry-0007vd-LT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDry-0007vH-GF
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DB8281663E7
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:06 +0200
Message-Id: <20180719184111.5129-14-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/18] json-parser: set an error if parsing
 returned NULL
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

Let's make json_parser_parse_err() suck less, and simplify caller
error handling.

 * monitor.c handle_qmp_command(): drop workaround

 * qga/main.c process_event(): improve error report, QERR_JSON_PARSING
   case is handled by json_parser_parse_err() now.

 * qobject/json-parser.c json_parser_parse(): Ignores the error.

 * qobject/qjson.c qobject_from_jsonv() via parse_json()
  - qobject_from_json()
    ~ block.c parse_json_filename() - removed workaround
    ~ block/rbd.c - abort (generated json - should never fail)
    ~ qapi/qobject-input-visitor.c - removed workaround
    ~ tests/check-qjson.c - assert or crash
    ~ tests/test-visitor-serialization.c - assert or crash

  - qobject_from_jsonf()
    Now dies in error_handle_fatal() instead of the assertion.
    Only used in tests, ok.

  - tests/test-qobject-input-visitor.c
  - tests/libqtest.c qmp_fd_sendv()
    Passes &error_abort, does nothing when qobject_from_jsonv() returns
    null.  The fix makes this catch invalid JSON instead of silently
    ignoring it.

Update the function documentation for possible return values.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block.c                      |  5 -----
 monitor.c                    |  4 ----
 qapi/qobject-input-visitor.c |  5 -----
 qga/main.c                   |  2 +-
 qobject/json-parser.c        | 16 +++++++++++++++-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index a2fe05ea96..42eaa8b7dc 100644
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
index 2abb3c2fc7..5a41a230b9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4114,10 +4114,6 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
     QMPRequest *req_obj;
=20
     req =3D json_parser_parse(tokens, NULL, &err);
-    if (!req && !err) {
-        /* json_parser_parse() sucks: can fail without setting @err */
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
diff --git a/qga/main.c b/qga/main.c
index 043f7c3ead..9032bb0c7a 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -614,7 +614,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
     }
     req =3D qobject_to(QDict, obj);
     if (!req) {
-        error_setg(&err, QERR_JSON_PARSING);
+        error_setg(&err, "Input must be a JSON object");
         goto err;
     }
     if (!qdict_haskey(req, "execute")) {
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 0c0b478149..c3b0c216cf 100644
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
@@ -548,6 +549,14 @@ static QObject *parse_value(JSONParserContext *ctxt,=
 va_list *ap)
     }
 }
=20
+/**
+ * json_parser_parse:
+ *
+ * If @tokens is null, return null.
+ * Else if @tokens parse okay, return the parse tree.
+ * Else set an error and return null.
+ *
+ **/
 QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
 {
     JSONParserContext ctxt =3D { .buf =3D tokens };
@@ -559,7 +568,12 @@ QObject *json_parser_parse(GQueue *tokens, va_list *=
ap, Error **errp)
=20
     result =3D parse_value(&ctxt, ap);
=20
-    error_propagate(errp, ctxt.err);
+    if (!result && !ctxt.err) {
+        /* TODO: improve error reporting */
+        error_setg(errp, QERR_JSON_PARSING);
+    } else {
+        error_propagate(errp, ctxt.err);
+    }
=20
     g_queue_free_full(ctxt.buf, g_free);
     g_free(ctxt.current);
--=20
2.18.0.129.ge3331758f1
