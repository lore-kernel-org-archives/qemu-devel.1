Received: from eggs.gnu.org ([2001:4830:134:3::10]:52503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBo-0006hw-D9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBj-0008Ub-Jf
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008Sf-9c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:39 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:03 +0200
Message-Id: <20180808120334.10970-26-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 25/56] json: Leave rejecting invalid escape
 sequences to parser
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

Both lexer and parser reject invalid escape sequences in strings.  The
parser's check is useless.

The lexer ends the token right after the first non-well-formed byte.
This tends to lead to suboptimal error reporting.  For instance, input

    {"abc\@ijk": 1}

produces the tokens

    JSON_LCURLY   {
    JSON_ERROR    "abc\@
    JSON_KEYWORD  ijk
    JSON_ERROR   ": 1}\n

The parser then reports three errors

    Invalid JSON syntax
    JSON parse error, invalid keyword 'ijk'
    Invalid JSON syntax

before it recovers at the newline.

Drop the lexer's escape sequence checking, and make it accept the same
characters after '\' it accepts elsewhere in strings.  It now produces

    JSON_LCURLY   {
    JSON_STRING   "abc\@ijk"
    JSON_COLON    :
    JSON_INTEGER  1
    JSON_RCURLY

and the parser reports just

    JSON parse error, invalid escape sequence in string

While there, fix parse_string()'s inaccurate function comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c  | 72 +++----------------------------------------
 qobject/json-parser.c | 56 +++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 91 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 36fb665b12..af0a7fdb8a 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -80,6 +80,8 @@
  *    escape = %x5C              ; \
  *    quotation-mark = %x22      ; "
  *    unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
+ *    [This lexer accepts any non-control character after escape, and
+ *    leaves rejecting invalid ones to the parser.]
  *
  *
  * Extensions over RFC 7159:
@@ -99,16 +101,8 @@
 
 enum json_lexer_state {
     IN_ERROR = 0,               /* must really be 0, see json_lexer[] */
-    IN_DQ_UCODE3,
-    IN_DQ_UCODE2,
-    IN_DQ_UCODE1,
-    IN_DQ_UCODE0,
     IN_DQ_STRING_ESCAPE,
     IN_DQ_STRING,
-    IN_SQ_UCODE3,
-    IN_SQ_UCODE2,
-    IN_SQ_UCODE1,
-    IN_SQ_UCODE0,
     IN_SQ_STRING_ESCAPE,
     IN_SQ_STRING,
     IN_ZERO,
@@ -144,37 +138,8 @@ static const uint8_t json_lexer[][256] =  {
     /* Relies on default initialization to IN_ERROR! */
 
     /* double quote string */
-    [IN_DQ_UCODE3] = {
-        ['0' ... '9'] = IN_DQ_STRING,
-        ['a' ... 'f'] = IN_DQ_STRING,
-        ['A' ... 'F'] = IN_DQ_STRING,
-    },
-    [IN_DQ_UCODE2] = {
-        ['0' ... '9'] = IN_DQ_UCODE3,
-        ['a' ... 'f'] = IN_DQ_UCODE3,
-        ['A' ... 'F'] = IN_DQ_UCODE3,
-    },
-    [IN_DQ_UCODE1] = {
-        ['0' ... '9'] = IN_DQ_UCODE2,
-        ['a' ... 'f'] = IN_DQ_UCODE2,
-        ['A' ... 'F'] = IN_DQ_UCODE2,
-    },
-    [IN_DQ_UCODE0] = {
-        ['0' ... '9'] = IN_DQ_UCODE1,
-        ['a' ... 'f'] = IN_DQ_UCODE1,
-        ['A' ... 'F'] = IN_DQ_UCODE1,
-    },
     [IN_DQ_STRING_ESCAPE] = {
-        ['b'] = IN_DQ_STRING,
-        ['f'] =  IN_DQ_STRING,
-        ['n'] =  IN_DQ_STRING,
-        ['r'] =  IN_DQ_STRING,
-        ['t'] =  IN_DQ_STRING,
-        ['/'] = IN_DQ_STRING,
-        ['\\'] = IN_DQ_STRING,
-        ['\''] = IN_DQ_STRING,
-        ['\"'] = IN_DQ_STRING,
-        ['u'] = IN_DQ_UCODE0,
+        [0x20 ... 0xFD] = IN_DQ_STRING,
     },
     [IN_DQ_STRING] = {
         [0x20 ... 0xFD] = IN_DQ_STRING,
@@ -183,37 +148,8 @@ static const uint8_t json_lexer[][256] =  {
     },
 
     /* single quote string */
-    [IN_SQ_UCODE3] = {
-        ['0' ... '9'] = IN_SQ_STRING,
-        ['a' ... 'f'] = IN_SQ_STRING,
-        ['A' ... 'F'] = IN_SQ_STRING,
-    },
-    [IN_SQ_UCODE2] = {
-        ['0' ... '9'] = IN_SQ_UCODE3,
-        ['a' ... 'f'] = IN_SQ_UCODE3,
-        ['A' ... 'F'] = IN_SQ_UCODE3,
-    },
-    [IN_SQ_UCODE1] = {
-        ['0' ... '9'] = IN_SQ_UCODE2,
-        ['a' ... 'f'] = IN_SQ_UCODE2,
-        ['A' ... 'F'] = IN_SQ_UCODE2,
-    },
-    [IN_SQ_UCODE0] = {
-        ['0' ... '9'] = IN_SQ_UCODE1,
-        ['a' ... 'f'] = IN_SQ_UCODE1,
-        ['A' ... 'F'] = IN_SQ_UCODE1,
-    },
     [IN_SQ_STRING_ESCAPE] = {
-        ['b'] = IN_SQ_STRING,
-        ['f'] =  IN_SQ_STRING,
-        ['n'] =  IN_SQ_STRING,
-        ['r'] =  IN_SQ_STRING,
-        ['t'] =  IN_SQ_STRING,
-        ['/'] = IN_SQ_STRING,
-        ['\\'] = IN_SQ_STRING,
-        ['\''] = IN_SQ_STRING,
-        ['\"'] = IN_SQ_STRING,
-        ['u'] = IN_SQ_UCODE0,
+        [0x20 ... 0xFD] = IN_SQ_STRING,
     },
     [IN_SQ_STRING] = {
         [0x20 ... 0xFD] = IN_SQ_STRING,
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 14225c3c09..d469004616 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -106,30 +106,40 @@ static int hex2decimal(char ch)
 }
 
 /**
- * parse_string(): Parse a json string and return a QObject
+ * parse_string(): Parse a JSON string
  *
- *  string
- *      ""
- *      " chars "
- *  chars
- *      char
- *      char chars
- *  char
- *      any-Unicode-character-
- *          except-"-or-\-or-
- *          control-character
- *      \"
- *      \\
- *      \/
- *      \b
- *      \f
- *      \n
- *      \r
- *      \t
- *      \u four-hex-digits 
+ * From RFC 7159 "The JavaScript Object Notation (JSON) Data
+ * Interchange Format":
+ *
+ *    char = unescaped /
+ *        escape (
+ *            %x22 /          ; "    quotation mark  U+0022
+ *            %x5C /          ; \    reverse solidus U+005C
+ *            %x2F /          ; /    solidus         U+002F
+ *            %x62 /          ; b    backspace       U+0008
+ *            %x66 /          ; f    form feed       U+000C
+ *            %x6E /          ; n    line feed       U+000A
+ *            %x72 /          ; r    carriage return U+000D
+ *            %x74 /          ; t    tab             U+0009
+ *            %x75 4HEXDIG )  ; uXXXX                U+XXXX
+ *    escape = %x5C              ; \
+ *    quotation-mark = %x22      ; "
+ *    unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
+ *
+ * Extensions over RFC 7159:
+ * - Extra escape sequence in strings:
+ *   0x27 (apostrophe) is recognized after escape, too
+ * - Single-quoted strings:
+ *   Like double-quoted strings, except they're delimited by %x27
+ *   (apostrophe) instead of %x22 (quotation mark), and can't contain
+ *   unescaped apostrophe, but can contain unescaped quotation mark.
+ *
+ * Note:
+ * - Encoding is modified UTF-8.
+ * - Invalid Unicode characters are rejected.
+ * - Control characters are rejected by the lexer.
  */
-static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
-                                         JSONToken *token)
+static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
 {
     const char *ptr = token->str;
     QString *str;
@@ -494,7 +504,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
 
     switch (token->type) {
     case JSON_STRING:
-        return QOBJECT(qstring_from_escaped_str(ctxt, token));
+        return QOBJECT(parse_string(ctxt, token));
     case JSON_INTEGER: {
         /*
          * Represent JSON_INTEGER as QNUM_I64 if possible, else as
-- 
2.17.1
