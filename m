Received: from eggs.gnu.org ([2001:4830:134:3::10]:52566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBp-0006jd-Sq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBj-0008TM-6k
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBi-0008Rc-SR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:39 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:02:57 +0200
Message-Id: <20180808120334.10970-20-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 19/56] json: Tighten and simplify
 qstring_from_escaped_str()'s loop
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

Simplify loop control, and assert that the string ends with the
appropriate quote (the lexer ensures it does).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index a5aa790d62..e00405745f 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -132,66 +132,50 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
 {
     const char *ptr = token->str;
     QString *str;
-    int double_quote = 1;
-
-    if (*ptr == '"') {
-        double_quote = 1;
-    } else {
-        double_quote = 0;
-    }
-    ptr++;
+    char quote;
 
+    assert(*ptr == '"' || *ptr == '\'');
+    quote = *ptr;
     str = qstring_new();
-    while (*ptr && 
-           ((double_quote && *ptr != '"') || (!double_quote && *ptr != '\''))) {
+
+    while (*++ptr != quote) {
+        assert(*ptr);
         if (*ptr == '\\') {
-            ptr++;
-
-            switch (*ptr) {
+            switch (*++ptr) {
             case '"':
                 qstring_append(str, "\"");
-                ptr++;
                 break;
             case '\'':
                 qstring_append(str, "'");
-                ptr++;
                 break;
             case '\\':
                 qstring_append(str, "\\");
-                ptr++;
                 break;
             case '/':
                 qstring_append(str, "/");
-                ptr++;
                 break;
             case 'b':
                 qstring_append(str, "\b");
-                ptr++;
                 break;
             case 'f':
                 qstring_append(str, "\f");
-                ptr++;
                 break;
             case 'n':
                 qstring_append(str, "\n");
-                ptr++;
                 break;
             case 'r':
                 qstring_append(str, "\r");
-                ptr++;
                 break;
             case 't':
                 qstring_append(str, "\t");
-                ptr++;
                 break;
             case 'u': {
                 uint16_t unicode_char = 0;
                 char utf8_char[4];
                 int i = 0;
 
-                ptr++;
-
                 for (i = 0; i < 4; i++) {
+                    ptr++;
                     if (qemu_isxdigit(*ptr)) {
                         unicode_char |= hex2decimal(*ptr) << ((3 - i) * 4);
                     } else {
@@ -199,7 +183,6 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
                                     "invalid hex escape sequence in string");
                         goto out;
                     }
-                    ptr++;
                 }
 
                 wchar_to_utf8(unicode_char, utf8_char, sizeof(utf8_char));
@@ -212,7 +195,7 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
         } else {
             char dummy[2];
 
-            dummy[0] = *ptr++;
+            dummy[0] = *ptr;
             dummy[1] = 0;
 
             qstring_append(str, dummy);
-- 
2.17.1
