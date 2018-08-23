Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgR-0003W0-DJ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsseu-0003ao-Mn
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsseu-0003Zl-CX
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:47 +0200
Message-Id: <20180823164025.12553-21-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 20/58] json: Tighten and simplify
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-parser.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index a5aa790d62..164b86769b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -132,65 +132,49 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
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
+    quote = *ptr++;
     str = qstring_new();
-    while (*ptr && 
-           ((double_quote && *ptr != '"') || (!double_quote && *ptr != '\''))) {
+
+    while (*ptr != quote) {
+        assert(*ptr);
         if (*ptr == '\\') {
             ptr++;
-
-            switch (*ptr) {
+            switch (*ptr++) {
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
                     if (qemu_isxdigit(*ptr)) {
                         unicode_char |= hex2decimal(*ptr) << ((3 - i) * 4);
-- 
2.17.1
