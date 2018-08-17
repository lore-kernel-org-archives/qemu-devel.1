Received: from eggs.gnu.org ([2001:4830:134:3::10]:46377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKL-00038i-4c
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001nN-7m
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001j3-CQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:27 +0200
Message-Id: <20180817150559.16243-29-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/60] json: Fix \uXXXX for surrogate pairs
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-parser.c | 60 ++++++++++++++++++++++++++++---------------
 tests/check-qjson.c   |  3 +--
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 9985d9929b..35c201c53f 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -64,16 +64,27 @@ static void GCC_FMT_ATTR(3, 4) parse_error(JSONParserContext *ctxt,
     error_setg(&ctxt->err, "JSON parse error, %s", message);
 }
 
-static int hex2decimal(char ch)
+static int cvt4hex(const char *s)
 {
-    if (ch >= '0' && ch <= '9') {
-        return (ch - '0');
-    } else if (ch >= 'a' && ch <= 'f') {
-        return 10 + (ch - 'a');
-    } else if (ch >= 'A' && ch <= 'F') {
-        return 10 + (ch - 'A');
+    int cp, i;
+
+    cp = 0;
+    for (i = 0; i < 4; i++) {
+        if (!qemu_isxdigit(s[i])) {
+            return -1;
+        }
+        cp <<= 4;
+        if (s[i] >= '0' && s[i] <= '9') {
+            cp |= s[i] - '0';
+        } else if (s[i] >= 'a' && s[i] <= 'f') {
+            cp |= 10 + s[i] - 'a';
+        } else if (s[i] >= 'A' && s[i] <= 'F') {
+            cp |= 10 + s[i] - 'A';
+        } else {
+            return -1;
+        }
     }
-    abort();
+    return cp;
 }
 
 /**
@@ -115,7 +126,8 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
     const char *ptr = token->str;
     QString *str;
     char quote;
-    int cp, i;
+    const char *beg;
+    int cp, trailing;
     char *end;
     ssize_t len;
     char utf8_buf[5];
@@ -127,7 +139,7 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
     while (*ptr != quote) {
         assert(*ptr);
         if (*ptr == '\\') {
-            ptr++;
+            beg = ptr++;
             switch (*ptr++) {
             case '"':
                 qstring_append_chr(str, '"');
@@ -157,22 +169,28 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
                 qstring_append_chr(str, '\t');
                 break;
             case 'u':
-                cp = 0;
-                for (i = 0; i < 4; i++) {
-                    if (!qemu_isxdigit(*ptr)) {
-                        parse_error(ctxt, token,
-                                    "invalid hex escape sequence in string");
-                        goto out;
+                cp = cvt4hex(ptr);
+                ptr += 4;
+
+                /* handle surrogate pairs */
+                if (cp >= 0xD800 && cp <= 0xDBFF
+                    && ptr[0] == '\\' && ptr[1] == 'u') {
+                    /* leading surrogate followed by \u */
+                    cp = 0x10000 + ((cp & 0x3FF) << 10);
+                    trailing = cvt4hex(ptr + 2);
+                    if (trailing >= 0xDC00 && trailing <= 0xDFFF) {
+                        /* followed by trailing surrogate */
+                        cp |= trailing & 0x3FF;
+                        ptr += 6;
+                    } else {
+                        cp = -1; /* invalid */
                     }
-                    cp <<= 4;
-                    cp |= hex2decimal(*ptr);
-                    ptr++;
                 }
 
                 if (mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp) < 0) {
                     parse_error(ctxt, token,
-                                "\\u%.4s is not a valid Unicode character",
-                                ptr - 3);
+                                "%.*s is not a valid Unicode character",
+                                (int)(ptr - beg), beg);
                     goto out;
                 }
                 qstring_append(str, utf8_buf);
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 5c94c80241..3be32f3fcb 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -63,8 +63,7 @@ static void escaped_string(void)
         { "double byte utf-8 \\u00A2", "double byte utf-8 \xc2\xa2" },
         { "triple byte utf-8 \\u20AC", "triple byte utf-8 \xe2\x82\xac" },
         { "quadruple byte utf-8 \\uD834\\uDD1E", /* U+1D11E */
-          /* bug: want \xF0\x9D\x84\x9E */
-          NULL },
+          "quadruple byte utf-8 \xF0\x9D\x84\x9E" },
         { "\\", NULL },
         { "\\z", NULL },
         { "\\ux", NULL },
-- 
2.17.1
