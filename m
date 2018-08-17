Received: from eggs.gnu.org ([2001:4830:134:3::10]:46630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKc-0003O9-7n
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001oj-KR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001jN-Vz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:25 +0200
Message-Id: <20180817150559.16243-27-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 26/60] json: Simplify parse_string()
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-parser.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index fa8d0fe416..8bb278bc7d 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -101,8 +101,7 @@ static int hex2decimal(char ch)
     } else if (ch >= 'A' && ch <= 'F') {
         return 10 + (ch - 'A');
     }
-
-    return -1;
+    abort();
 }
 
 /**
@@ -144,7 +143,7 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
     const char *ptr = token->str;
     QString *str;
     char quote;
-    int cp;
+    int cp, i;
     char *end;
     ssize_t len;
     char utf8_buf[5];
@@ -159,51 +158,48 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
             ptr++;
             switch (*ptr++) {
             case '"':
-                qstring_append(str, "\"");
+                qstring_append_chr(str, '"');
                 break;
             case '\'':
-                qstring_append(str, "'");
+                qstring_append_chr(str, '\'');
                 break;
             case '\\':
-                qstring_append(str, "\\");
+                qstring_append_chr(str, '\\');
                 break;
             case '/':
-                qstring_append(str, "/");
+                qstring_append_chr(str, '/');
                 break;
             case 'b':
-                qstring_append(str, "\b");
+                qstring_append_chr(str, '\b');
                 break;
             case 'f':
-                qstring_append(str, "\f");
+                qstring_append_chr(str, '\f');
                 break;
             case 'n':
-                qstring_append(str, "\n");
+                qstring_append_chr(str, '\n');
                 break;
             case 'r':
-                qstring_append(str, "\r");
+                qstring_append_chr(str, '\r');
                 break;
             case 't':
-                qstring_append(str, "\t");
+                qstring_append_chr(str, '\t');
                 break;
-            case 'u': {
-                uint16_t unicode_char = 0;
-                char utf8_char[4];
-                int i = 0;
-
+            case 'u':
+                cp = 0;
                 for (i = 0; i < 4; i++) {
-                    if (qemu_isxdigit(*ptr)) {
-                        unicode_char |= hex2decimal(*ptr) << ((3 - i) * 4);
-                    } else {
+                    if (!qemu_isxdigit(*ptr)) {
                         parse_error(ctxt, token,
                                     "invalid hex escape sequence in string");
                         goto out;
                     }
+                    cp <<= 4;
+                    cp |= hex2decimal(*ptr);
                     ptr++;
                 }
 
-                wchar_to_utf8(unicode_char, utf8_char, sizeof(utf8_char));
-                qstring_append(str, utf8_char);
-            }   break;
+                wchar_to_utf8(cp, utf8_buf, sizeof(utf8_buf));
+                qstring_append(str, utf8_buf);
+                break;
             default:
                 parse_error(ctxt, token, "invalid escape sequence in string");
                 goto out;
-- 
2.17.1
