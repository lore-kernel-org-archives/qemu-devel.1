Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKc-0003O6-7i
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001pI-QK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKG-0001mI-C3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:59 +0200
Message-Id: <20180817150559.16243-61-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 60/60] json: Support %% in JSON strings when
 interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

The previous commit makes JSON strings containing '%' awkward to
express in templates: you'd have to mask the '%' with an Unicode
escape \u0025.  No template currently contains such JSON strings.
Support the printf conversion specification %% in JSON strings as a
convenience anyway, because it's trivially easy to do.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 3 ++-
 tests/check-qjson.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 273e354ccd..a63e2c33c8 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -208,10 +208,11 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
             }
             break;
         case '%':
-            if (ctxt->ap) {
+            if (ctxt->ap && ptr[1] != '%') {
                 parse_error(ctxt, token, "can't interpolate into string");
                 goto out;
             }
+            ptr++;
             /* fall through */
         default:
             cp = mod_utf8_codepoint(ptr, 6, &end);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 89fd6ad6f6..d086b146f7 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1270,7 +1270,7 @@ static void simple_interpolation(void)
     QObject *obj;
     QLitObject decoded = QLIT_QLIST(((QLitObject[]){
             QLIT_QNUM(1),
-            QLIT_QNUM(2),
+            QLIT_QSTR("100%"),
             QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(32),
                         QLIT_QNUM(42),
@@ -1280,7 +1280,7 @@ static void simple_interpolation(void)
     embedded_obj = qobject_from_json("[32, 42]", &error_abort);
     g_assert(embedded_obj != NULL);
 
-    obj = qobject_from_jsonf_nofail("[%d, 2, %p]", 1, embedded_obj);
+    obj = qobject_from_jsonf_nofail("[%d, '100%%', %p]", 1, embedded_obj);
     g_assert(qlit_equal_qobject(&decoded, obj));
 
     qobject_unref(obj);
-- 
2.17.1
