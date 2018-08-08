Received: from eggs.gnu.org ([2001:4830:134:3::10]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBn-0006hS-V6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0008Vg-87
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47718 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008UJ-Rn
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:05 +0200
Message-Id: <20180808120334.10970-28-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 27/56] json: Reject invalid \uXXXX, fix \u0000
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

The JSON parser translates invalid \uXXXX to garbage instead of
rejecting it, and swallows \u0000.

Fix by using mod_utf8_encode() instead of flawed wchar_to_utf8().

Valid surrogate pairs are now differently broken: they're rejected
instead of translated to garbage.  The next commit will fix them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 35 ++++++-----------------------------
 tests/check-qjson.c   | 32 +++++++++-----------------------
 2 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index f26e5b7511..bb54886809 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -64,34 +64,6 @@ static void GCC_FMT_ATTR(3, 4) parse_error(JSONParserContext *ctxt,
     error_setg(&ctxt->err, "JSON parse error, %s", message);
 }
 
-/**
- * String helpers
- *
- * These helpers are used to unescape strings.
- */
-static void wchar_to_utf8(uint16_t wchar, char *buffer, size_t buffer_length)
-{
-    if (wchar <= 0x007F) {
-        BUG_ON(buffer_length < 2);
-
-        buffer[0] = wchar & 0x7F;
-        buffer[1] = 0;
-    } else if (wchar <= 0x07FF) {
-        BUG_ON(buffer_length < 3);
-
-        buffer[0] = 0xC0 | ((wchar >> 6) & 0x1F);
-        buffer[1] = 0x80 | (wchar & 0x3F);
-        buffer[2] = 0;
-    } else {
-        BUG_ON(buffer_length < 4);
-
-        buffer[0] = 0xE0 | ((wchar >> 12) & 0x0F);
-        buffer[1] = 0x80 | ((wchar >> 6) & 0x3F);
-        buffer[2] = 0x80 | (wchar & 0x3F);
-        buffer[3] = 0;
-    }
-}
-
 static int hex2decimal(char ch)
 {
     if (ch >= '0' && ch <= '9') {
@@ -196,7 +168,12 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
                     cp |= hex2decimal(*ptr);
                 }
 
-                wchar_to_utf8(cp, utf8_buf, sizeof(utf8_buf));
+                if (mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp) < 0) {
+                    parse_error(ctxt, token,
+                                "\\u%.4s is not a valid Unicode character",
+                                ptr - 3);
+                    goto out;
+                }
                 qstring_append(str, utf8_buf);
                 break;
             default:
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index e5a7cb6bf6..422697459f 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -62,7 +62,7 @@ static void escaped_string(void)
         { "triple byte utf-8 \\u20AC", "triple byte utf-8 \xe2\x82\xac" },
         { "quadruple byte utf-8 \\uD834\\uDD1E", /* U+1D11E */
           /* bug: want \xF0\x9D\x84\x9E */
-          "quadruple byte utf-8 \xED\xA0\xB4\xED\xB4\x9E", .skip = 1 },
+          NULL },
         { "\\z", NULL },
         { "\\ux", NULL },
         { "\\u1x", NULL },
@@ -70,28 +70,14 @@ static void escaped_string(void)
         { "\\u123x", NULL },
         { "\\u12345", "\341\210\2645" },
         { "\\u12345", "\341\210\2645" },
-        { "\\u0000x", "x", .skip = 1}, /* bug: want \xC0\x80x */
-        { "unpaired leading surrogate \\uD800\\uD800",
-          /* bug: not rejected */
-          "unpaired leading surrogate \355\240\200\355\240\200", .skip = 1 },
-        { "unpaired trailing surrogate \\uDC00\\uDC00",
-          /* bug: not rejected */
-          "unpaired trailing surrogate \355\260\200\355\260\200", .skip = 1},
-        { "backward surrogate pair \\uDC00\\uD800",
-          /* bug: not rejected */
-          "backward surrogate pair \355\260\200\355\240\200", .skip = 1},
-        { "noncharacter U+FDD0 \\uFDD0",
-          /* bug: not rejected */
-          "noncharacter U+FDD0 \xEF\xB7\x90", .skip = 1},
-        { "noncharacter U+FDEF \\uFDEF",
-          /* bug: not rejected */
-          "noncharacter U+FDEF \xEF\xB7\xAF", .skip = 1},
-        { "noncharacter U+1FFFE \\uD87F\\uDFFE",
-          /* bug: not rejected */
-          "noncharacter U+1FFFE \xED\xA1\xBF\xED\xBF\xBE", .skip = 1},
-        { "noncharacter U+10FFFF \\uDC3F\\uDFFF",
-          /* bug: not rejected */
-          "noncharacter U+10FFFF \xED\xB0\xBF\xED\xBF\xBF", .skip = 1},
+        { "\\u0000x", "\xC0\x80x" },
+        { "unpaired leading surrogate \\uD800\\uD800", NULL },
+        { "unpaired trailing surrogate \\uDC00\\uDC00", NULL },
+        { "backward surrogate pair \\uDC00\\uD800", NULL },
+        { "noncharacter U+FDD0 \\uFDD0", NULL },
+        { "noncharacter U+FDEF \\uFDEF", NULL },
+        { "noncharacter U+1FFFE \\uD87F\\uDFFE", NULL },
+        { "noncharacter U+10FFFF \\uDC3F\\uDFFF", NULL },
         {}
     };
     int i, j;
-- 
2.17.1
