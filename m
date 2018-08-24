Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHol-0002Iw-0P
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHof-0001ij-NJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoe-0001ep-Ud
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 429E740216FC
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D73D2156715
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:35 +0200
Message-Id: <20180824193206.25475-28-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 27/58] json: Simplify parse_string()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-28-armbru@redhat.com>
---
 qobject/json-parser.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7437827c24..9cb363f7e1 100644
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
