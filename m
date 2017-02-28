Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDu-00056i-1K
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDs-0000Y8-BH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDs-0000Xb-33
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:20 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51D1AC0016BC
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQIaM011091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:25:59 +0100
Message-Id: <1488320775-9849-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 08/24] qobject: Propagate parse errors through
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

The next few commits will put the errors to use where appropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-9-git-send-email-armbru@redhat.com>
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
index 32ba492..36cc4b5 100644
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
