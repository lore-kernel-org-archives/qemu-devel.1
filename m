Received: from eggs.gnu.org ([2001:4830:134:3::10]:52457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBn-0006gd-6S
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBj-0008Tx-Cj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008S8-64
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:39 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:02 +0200
Message-Id: <20180808120334.10970-25-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 24/56] json: Accept overlong \xC0\x80 as U+0000
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

This is consistent with qobject_to_json().  See commit e2ec3f97680.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
index b3a95be3c8..14225c3c09 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -199,7 +199,7 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
             }
         } else {
             cp = mod_utf8_codepoint(ptr, 6, &end);
-            if (cp <= 0) {
+            if (cp < 0) {
                 parse_error(ctxt, token, "invalid UTF-8 sequence in string");
                 goto out;
             }
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index e00be5b023..e5a7cb6bf6 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -121,12 +121,6 @@ static void escaped_string(void)
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
@@ -555,7 +549,7 @@ static void utf8_string(void)
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
