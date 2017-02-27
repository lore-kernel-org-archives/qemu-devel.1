Received: from eggs.gnu.org ([2001:4830:134:3::10]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMY-00069P-E9
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMT-00010L-2P
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:06 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:34 +0100
Message-Id: <1488194450-28056-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 08/24] qobject: Propagate parse errors through
 qobject_from_jsonv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qjson.h           |  3 ++-
 qobject/qjson.c                    | 12 ++++++++----
 tests/libqtest.c                   |  2 +-
 tests/test-qobject-input-visitor.c |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index 02b1f2c..6fe42d0 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -19,7 +19,8 @@
 
 QObject *qobject_from_json(const char *string);
 QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
-QObject *qobject_from_jsonv(const char *string, va_list *ap) GCC_FMT_ATTR(1, 0);
+QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
+    GCC_FMT_ATTR(1, 0);
 
 QString *qobject_to_json(const QObject *obj);
 QString *qobject_to_json_pretty(const QObject *obj);
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 9a0de89..339c9f7 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
@@ -24,15 +25,17 @@ typedef struct JSONParsingState
     JSONMessageParser parser;
     va_list *ap;
     QObject *result;
+    Error *err;
 } JSONParsingState;
 
 static void parse_json(JSONMessageParser *parser, GQueue *tokens)
 {
     JSONParsingState *s = container_of(parser, JSONParsingState, parser);
-    s->result = json_parser_parse(tokens, s->ap);
+
+    s->result = json_parser_parse_err(tokens, s->ap, &s->err);
 }
 
-QObject *qobject_from_jsonv(const char *string, va_list *ap)
+QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
 {
     JSONParsingState state = {};
 
@@ -43,12 +46,13 @@ QObject *qobject_from_jsonv(const char *string, va_list *ap)
     json_message_parser_flush(&state.parser);
     json_message_parser_destroy(&state.parser);
 
+    error_propagate(errp, state.err);
     return state.result;
 }
 
 QObject *qobject_from_json(const char *string)
 {
-    return qobject_from_jsonv(string, NULL);
+    return qobject_from_jsonv(string, NULL, NULL);
 }
 
 /*
@@ -61,7 +65,7 @@ QObject *qobject_from_jsonf(const char *string, ...)
     va_list ap;
 
     va_start(ap, string);
-    obj = qobject_from_jsonv(string, &ap);
+    obj = qobject_from_jsonv(string, &ap, NULL);
     va_end(ap);
 
     assert(obj != NULL);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index cf27afc..683d5e3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -442,7 +442,7 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
      * is an array type.
      */
     va_copy(ap_copy, ap);
-    qobj = qobject_from_jsonv(fmt, &ap_copy);
+    qobj = qobject_from_jsonv(fmt, &ap_copy, NULL);
     va_end(ap_copy);
 
     /* No need to send anything for an empty QObject.  */
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 650637e..44885ee 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -51,7 +51,7 @@ static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
 {
     visitor_input_teardown(data, NULL);
 
-    data->obj = qobject_from_jsonv(json_string, ap);
+    data->obj = qobject_from_jsonv(json_string, ap, NULL);
     g_assert(data->obj);
 
     if (keyval) {
-- 
2.7.4
