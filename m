Received: from eggs.gnu.org ([2001:4830:134:3::10]:46262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKI-00035j-0p
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKE-0001l2-Oq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKE-0001iP-5p
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:23 +0200
Message-Id: <20180817150559.16243-25-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 24/60] json: Accept overlong \xC0\x80 as
 U+0000 ("modified UTF-8")
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

Since the JSON grammer doesn't accept U+0000 anywhere, this merely
exchanges one kind of parse error for another.  It's purely for
consistency with qobject_to_json(), which accepts \xC0\x80 (see commit
e2ec3f97680).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-lexer.c  | 2 +-
 qobject/json-parser.c | 2 +-
 tests/check-qjson.c   | 8 +-------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index ca1e0e2c03..36fb665b12 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -93,7 +93,7 @@
  *   interpolation = %((l|ll|I64)[du]|[ipsf])
  *
  * Note:
- * - Input must be encoded in UTF-8.
+ * - Input must be encoded in modified UTF-8.
  * - Decoding and validating is left to the parser.
  */
 
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index b77931614b..a9b227f56c 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -200,7 +200,7 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
             }
         } else {
             cp = mod_utf8_codepoint(ptr, 6, &end);
-            if (cp <= 0) {
+            if (cp < 0) {
                 parse_error(ctxt, token, "invalid UTF-8 sequence in string");
                 goto out;
             }
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 409a03fe24..61940d69c9 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -152,12 +152,6 @@ static void string_with_quotes(void)
 static void utf8_string(void)
 {
     /*
-     * Problem: we can't easily deal with embedded U+0000.  Parsing
-     * the JSON string "this \\u0000" is fun" yields "this \0 is fun",
-     * which gets misinterpreted as NUL-terminated "this ".  We should
-     * consider using overlong encoding \xC0\x80 for U+0000 ("modified
-     * UTF-8").
-     *
      * Most test cases are scraped from Markus Kuhn's UTF-8 decoder
      * capability and stress test at
      * http://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-test.txt
@@ -586,7 +580,7 @@ static void utf8_string(void)
         {
             /* \U+0000 */
             "\xC0\x80",
-            NULL,
+            "\xC0\x80",
             "\\u0000",
         },
         {
-- 
2.17.1
