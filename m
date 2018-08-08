Received: from eggs.gnu.org ([2001:4830:134:3::10]:52574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBq-0006js-2l
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-000070-9A
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBk-0008Vo-Ox
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:17 +0200
Message-Id: <20180808120334.10970-40-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 39/56] json: Leave rejecting invalid
 interpolation to parser
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

Both lexer and parser reject invalid interpolation specifications.
The parser's check is useless.

The lexer ends the token right after the first bad character.  This
tends to lead to suboptimal error reporting.  For instance, input

    [ %11d ]

produces the tokens

    JSON_LSQUARE  [
    JSON_ERROR    %1
    JSON_INTEGER  1
    JSON_KEYWORD  d
    JSON_RSQUARE  ]

The parser then yields an error, an object and two more errors:

    error: Invalid JSON syntax
    object: 1
    error: JSON parse error, invalid keyword
    error: JSON parse error, expecting value

Change the lexer to accept [A-Za-z0-9]*[duipsf].  It now produces

    JSON_LSQUARE  [
    JSON_INTERPOLATION %11d
    JSON_RSQUARE  ]

and the parser reports just

    JSON parse error, invalid interpolation '%11d'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c  | 52 +++++++++----------------------------------
 qobject/json-parser.c |  1 +
 2 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 0ea1eae4aa..7a82aab88b 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -93,7 +93,8 @@
  *   (apostrophe) instead of %x22 (quotation mark), and can't contain
  *   unescaped apostrophe, but can contain unescaped quotation mark.
  * - Interpolation:
- *   interpolation = %((l|ll|I64)[du]|[ipsf])
+ *   The lexer accepts [A-Za-z0-9]*, and leaves rejecting invalid ones
+ *   to the parser.
  *
  * Note:
  * - Input must be encoded in modified UTF-8.
@@ -116,11 +117,6 @@ enum json_lexer_state {
     IN_NEG_NONZERO_NUMBER,
     IN_KEYWORD,
     IN_INTERPOL,
-    IN_INTERPOL_L,
-    IN_INTERPOL_LL,
-    IN_INTERPOL_I,
-    IN_INTERPOL_I6,
-    IN_INTERPOL_I64,
     IN_WHITESPACE,
     IN_START_INTERPOL,
     IN_START,
@@ -222,42 +218,6 @@ static const uint8_t json_lexer[][256] =  {
         ['\n'] = IN_WHITESPACE,
     },
 
-    /* interpolation */
-    [IN_INTERPOL_LL] = {
-        ['d'] = JSON_INTERPOL,
-        ['u'] = JSON_INTERPOL,
-    },
-
-    [IN_INTERPOL_L] = {
-        ['d'] = JSON_INTERPOL,
-        ['l'] = IN_INTERPOL_LL,
-        ['u'] = JSON_INTERPOL,
-    },
-
-    [IN_INTERPOL_I64] = {
-        ['d'] = JSON_INTERPOL,
-        ['u'] = JSON_INTERPOL,
-    },
-
-    [IN_INTERPOL_I6] = {
-        ['4'] = IN_INTERPOL_I64,
-    },
-
-    [IN_INTERPOL_I] = {
-        ['6'] = IN_INTERPOL_I6,
-    },
-
-    [IN_INTERPOL] = {
-        ['d'] = JSON_INTERPOL,
-        ['i'] = JSON_INTERPOL,
-        ['p'] = JSON_INTERPOL,
-        ['s'] = JSON_INTERPOL,
-        ['u'] = JSON_INTERPOL,
-        ['f'] = JSON_INTERPOL,
-        ['l'] = IN_INTERPOL_L,
-        ['I'] = IN_INTERPOL_I,
-    },
-
     /* top level rule */
     [IN_START] = {
         ['"'] = IN_DQ_STRING,
@@ -278,6 +238,14 @@ static const uint8_t json_lexer[][256] =  {
         ['\n'] = IN_WHITESPACE,
     },
 
+    /* interpolation */
+    [IN_INTERPOL] = {
+        TERMINAL(JSON_INTERPOL),
+        ['A' ... 'Z'] = IN_INTERPOL,
+        ['a' ... 'z'] = IN_INTERPOL,
+        ['0' ... '9'] = IN_INTERPOL,
+    },
+
     [IN_START_INTERPOL] = {
         ['"'] = IN_DQ_STRING,
         ['\''] = IN_SQ_STRING,
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 848d469b2a..bd137399e5 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -448,6 +448,7 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
     } else if (!strcmp(token->str, "%f")) {
         return QOBJECT(qnum_from_double(va_arg(*ap, double)));
     }
+    parse_error(ctxt, token, "invalid interpolation '%s'", token->str);
     return NULL;
 }
 
-- 
2.17.1
