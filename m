Received: from eggs.gnu.org ([2001:4830:134:3::10]:33136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoh-0002GP-2j
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001fT-Dz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001ZS-5Z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2592D40216FA
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 017FE10073B5
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:28 +0200
Message-Id: <20180824193206.25475-21-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 20/58] json: Tighten and simplify
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

Simplify loop control, and assert that the string ends with the
appropriate quote (the lexer ensures it does).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-21-armbru@redhat.com>
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
