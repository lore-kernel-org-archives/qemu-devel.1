Received: from eggs.gnu.org ([2001:4830:134:3::10]:35580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskU-0000Xy-Ac
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskM-0006MY-8h
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsskL-0006Lg-Rh
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:40:23 +0200
Message-Id: <20180823164025.12553-57-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 56/58] json: Improve safety of
 qobject_from_jsonf_nofail() & friends
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

The JSON parser optionally supports interpolation.  This is used to
build QObjects by parsing string templates.  The templates are C
literals, so parse errors (such as invalid interpolation
specifications) are actually programming errors.  Consequently, the
functions providing parsing with interpolation
(qobject_from_jsonf_nofail(), qobject_from_vjsonf_nofail(),
qdict_from_jsonf_nofail(), qdict_from_vjsonf_nofail()) pass
&error_abort to the parser.

However, there's another, more dangerous kind of programming error:
since we use va_arg() to get the value to interpolate, behavior is
undefined when the variable argument isn't consistent with the
interpolation specification.

The same problem exists with printf()-like functions, and the solution
is to have the compiler check consistency.  This is what
GCC_FMT_ATTR() is about.

To enable this type checking for interpolation as well, we carefully
chose our interpolation specifications to match printf conversion
specifications, and decorate functions parsing templates with
GCC_FMT_ATTR().

Note that this only protects against undefined behavior due to type
errors.  It can't protect against use of invalid interpolation
specifications that happen to be valid printf conversion
specifications.

However, there's still a gaping hole in the type checking: GCC
recognizes '%' as start of printf conversion specification anywhere in
the template, but the parser recognizes it only outside JSON strings.
For instance, if someone were to pass a "{ '%s': %d }" template, GCC
would require a char * and an int argument, but the parser would
va_arg() only an int argument, resulting in undefined behavior.

Avoid undefined behavior by catching the programming error at run
time: have the parser recognize and reject '%' in JSON strings.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-parser.c | 12 ++++++++++--
 tests/check-qjson.c   | 17 +++++++----------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 273f448a52..63e9229f1c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -144,7 +144,8 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
 
     while (*ptr != quote) {
         assert(*ptr);
-        if (*ptr == '\\') {
+        switch (*ptr) {
+        case '\\':
             beg = ptr++;
             switch (*ptr++) {
             case '"':
@@ -205,7 +206,14 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
                 parse_error(ctxt, token, "invalid escape sequence in string");
                 goto out;
             }
-        } else {
+            break;
+        case '%':
+            if (ctxt->ap) {
+                parse_error(ctxt, token, "can't interpolate into string");
+                goto out;
+            }
+            /* fall through */
+        default:
             cp = mod_utf8_codepoint(ptr, 6, &end);
             if (cp < 0) {
                 parse_error(ctxt, token, "invalid UTF-8 sequence in string");
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 936258ddd4..a1854573de 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1037,16 +1037,13 @@ static void interpolation_unknown(void)
 
 static void interpolation_string(void)
 {
-    QLitObject decoded = QLIT_QLIST(((QLitObject[]){
-            QLIT_QSTR("%s"),
-            QLIT_QSTR("eins"),
-            {}}));
-    QObject *qobj;
-
-    /* Dangerous misfeature: % is silently ignored in strings */
-    qobj = qobject_from_jsonf_nofail("['%s', %s]", "eins", "zwei");
-    g_assert(qlit_equal_qobject(&decoded, qobj));
-    qobject_unref(qobj);
+    if (g_test_subprocess()) {
+        qobject_from_jsonf_nofail("['%s', %s]", "eins", "zwei");
+    }
+    g_test_trap_subprocess(NULL, 0, 0);
+    g_test_trap_assert_failed();
+    g_test_trap_assert_stderr("*Unexpected error*"
+                              "can't interpolate into string*");
 }
 
 static void simple_dict(void)
-- 
2.17.1
