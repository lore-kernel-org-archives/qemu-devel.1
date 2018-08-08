Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBs-0006ny-2H
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0008VN-1K
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008U1-O0
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:39 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:06 +0200
Message-Id: <20180808120334.10970-29-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 28/56] json: Fix \uXXXX for surrogate pairs
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

The JSON parser treats each half of a surrogate pair as unpaired
surrogate.  Fix it to recognize surrogate pairs.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 16 +++++++++++++++-
 tests/check-qjson.c   |  3 +--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index bb54886809..703065fa2b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -115,7 +115,7 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
     const char *ptr = token->str;
     QString *str;
     char quote;
-    int cp, i;
+    int cp, i, leading_surrogate;
     char *end;
     ssize_t len;
     char utf8_buf[5];
@@ -156,6 +156,8 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
                 qstring_append_chr(str, '\t');
                 break;
             case 'u':
+                leading_surrogate = 0;
+            hex:
                 cp = 0;
                 for (i = 0; i < 4; i++) {
                     ptr++;
@@ -168,6 +170,18 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
                     cp |= hex2decimal(*ptr);
                 }
 
+                if (cp >= 0xD800 && cp <= 0xDBFF && !leading_surrogate
+                    && ptr[1] == '\\' && ptr[2] == 'u') {
+                    ptr += 2;
+                    leading_surrogate = cp;
+                    goto hex;
+                }
+                if (cp >= 0xDC00 && cp <= 0xDFFF && leading_surrogate) {
+                    cp &= 0x3FF;
+                    cp |= (leading_surrogate & 0x3FF) << 10;
+                    cp += 0x010000;
+                }
+
                 if (mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp) < 0) {
                     parse_error(ctxt, token,
                                 "\\u%.4s is not a valid Unicode character",
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 422697459f..3d3a3f105f 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -61,8 +61,7 @@ static void escaped_string(void)
         { "double byte utf-8 \\u00A2", "double byte utf-8 \xc2\xa2" },
         { "triple byte utf-8 \\u20AC", "triple byte utf-8 \xe2\x82\xac" },
         { "quadruple byte utf-8 \\uD834\\uDD1E", /* U+1D11E */
-          /* bug: want \xF0\x9D\x84\x9E */
-          NULL },
+          "quadruple byte utf-8 \xF0\x9D\x84\x9E" },
         { "\\z", NULL },
         { "\\ux", NULL },
         { "\\u1x", NULL },
-- 
2.17.1
