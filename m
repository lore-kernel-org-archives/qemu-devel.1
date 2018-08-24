Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003N1-Af
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxN-0001Bp-5z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxM-0001AH-Pp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 695FF402332F
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B2C1010421
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:55 +0200
Message-Id: <20180824193206.25475-48-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 47/58] qjson: Have qobject_from_json() & friends
 reject empty and blank
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The last case where qobject_from_json() & friends return null without
setting an error is empty or blank input.  Callers:

* block.c's parse_json_protocol() reports "Could not parse the JSON
  options".  It's marked as a work-around, because it also covered
  actual bugs, but they got fixed in the previous few commits.

* qobject_input_visitor_new_str() reports "JSON parse error".  Also
  marked as work-around.  The recent fixes have made this unreachable,
  because it currently gets called only for input starting with '{'.

* check-qjson.c's empty_input() and blank_input() demonstrate the
  behavior.

* The other callers are not affected since they only pass input with
  exactly one JSON value or, in the case of negative tests, one error.

Fail with "Expecting a JSON value" instead of returning null, and
simplify callers.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-48-armbru@redhat.com>
---
 block.c                      |  5 -----
 qapi/qobject-input-visitor.c |  5 -----
 qobject/qjson.c              |  4 ++++
 tests/check-qjson.c          | 12 ++++++++++--
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 6161dbe3eb..0dbb1fcc7b 100644
--- a/block.c
+++ b/block.c
@@ -1478,11 +1478,6 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
 
     options_obj = qobject_from_json(filename, errp);
     if (!options_obj) {
-        /* Work around qobject_from_json() lossage TODO fix that */
-        if (errp && !*errp) {
-            error_setg(errp, "Could not parse the JSON options");
-            return NULL;
-        }
         error_prepend(errp, "Could not parse the JSON options: ");
         return NULL;
     }
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index da57f4cc24..3e88b27f9e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -725,11 +725,6 @@ Visitor *qobject_input_visitor_new_str(const char *str,
     if (is_json) {
         obj = qobject_from_json(str, errp);
         if (!obj) {
-            /* Work around qobject_from_json() lossage TODO fix that */
-            if (errp && !*errp) {
-                error_setg(errp, "JSON parse error");
-                return NULL;
-            }
             return NULL;
         }
         args = qobject_to(QDict, obj);
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 7f69036487..b9ccae2c2a 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -70,6 +70,10 @@ static QObject *qobject_from_jsonv(const char *string, va_list *ap,
     json_message_parser_flush(&state.parser);
     json_message_parser_destroy(&state.parser);
 
+    if (!state.result && !state.err) {
+        error_setg(&state.err, "Expecting a JSON value");
+    }
+
     error_propagate(errp, state.err);
     return state.result;
 }
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 0ca4b3c823..936258ddd4 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1291,13 +1291,21 @@ static void simple_interpolation(void)
 
 static void empty_input(void)
 {
-    QObject *obj = qobject_from_json("", &error_abort);
+    Error *err = NULL;
+    QObject *obj;
+
+    obj = qobject_from_json("", &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
 static void blank_input(void)
 {
-    QObject *obj = qobject_from_json("\n ", &error_abort);
+    Error *err = NULL;
+    QObject *obj;
+
+    obj = qobject_from_json("\n ", &err);
+    error_free_or_abort(&err);
     g_assert(obj == NULL);
 }
 
-- 
2.17.1
