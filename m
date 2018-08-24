Received: from eggs.gnu.org ([2001:4830:134:3::10]:33177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoi-0002HU-0F
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001ex-Fc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001Zg-4k
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37EB440201C9
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1400B2156714
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:33 +0200
Message-Id: <20180824193206.25475-26-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 25/58] json: Accept overlong \xC0\x80 as U+0000
 ("modified UTF-8")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since the JSON grammer doesn't accept U+0000 anywhere, this merely
exchanges one kind of parse error for another.  It's purely for
consistency with qobject_to_json(), which accepts \xC0\x80 (see commit
e2ec3f97680).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-26-armbru@redhat.com>
---
 qobject/json-lexer.c  | 2 +-
 qobject/json-parser.c | 2 +-
 tests/check-qjson.c   | 8 +-------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 93fa2737e6..4c402f62d3 100644
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
index 71c77d2f70..3abf12b4d2 100644
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
