Received: from eggs.gnu.org ([2001:4830:134:3::10]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSI-00052a-8O
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgSF-0008R2-Rt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgSF-0008Nz-Bg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:14:23 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:38 +0200
Message-Id: <20180817150559.16243-40-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 39/60] json: Leave rejecting invalid
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

    [ %04d ]

produces the tokens

    JSON_LSQUARE  [
    JSON_ERROR    %0
    JSON_INTEGER  4
    JSON_KEYWORD  d
    JSON_RSQUARE  ]

The parser then yields an error, an object and two more errors:

    error: Invalid JSON syntax
    object: 4
    error: JSON parse error, invalid keyword
    error: JSON parse error, expecting value

Dumb down the lexer to accept [A-Za-z0-9]*.  The parser's check is now
used.  Emit a proper error there.

The lexer now produces

    JSON_LSQUARE  [
    JSON_INTERPOLATION %04d
    JSON_RSQUARE  ]

and the parser reports just

    JSON parse error, invalid interpolation '%04d'

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-lexer.c  | 44 ++++++-------------------------------------
 qobject/json-parser.c |  1 +
 tests/check-qjson.c   |  3 ++-
 3 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index cf15266cbe..ab2453a1e1 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -93,7 +93,8 @@
  *   (apostrophe) instead of %x22 (quotation mark), and can't contain
  *   unescaped apostrophe, but can contain unescaped quotation mark.
  * - Interpolation, if enabled:
- *   interpolation = %((l|ll|I64)[du]|[ipsf])
+ *   The lexer accepts %[A-Za-z0-9]*, and leaves rejecting invalid
+ *   ones to the parser.
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
     IN_START,
     IN_START_INTERPOL,          /* must be IN_START + 1 */
@@ -224,39 +220,11 @@ static const uint8_t json_lexer[][256] =  {
     },
 
     /* interpolation */
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
     [IN_INTERPOL] = {
-        ['d'] = JSON_INTERPOL,
-        ['i'] = JSON_INTERPOL,
-        ['p'] = JSON_INTERPOL,
-        ['s'] = JSON_INTERPOL,
-        ['u'] = JSON_INTERPOL,
-        ['f'] = JSON_INTERPOL,
-        ['l'] = IN_INTERPOL_L,
-        ['I'] = IN_INTERPOL_I,
+        TERMINAL(JSON_INTERPOL),
+        ['A' ... 'Z'] = IN_INTERPOL,
+        ['a' ... 'z'] = IN_INTERPOL,
+        ['0' ... '9'] = IN_INTERPOL,
     },
 
     /*
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 56bbfe6810..32131c08d5 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -453,6 +453,7 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
     } else if (!strcmp(token->str, "%f")) {
         return QOBJECT(qnum_from_double(va_arg(*ap, double)));
     }
+    parse_error(ctxt, token, "invalid interpolation '%s'", token->str);
     return NULL;
 }
 
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 3bd216f357..6a1dbbae43 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1021,7 +1021,8 @@ static void interpolation_unknown(void)
     }
     g_test_trap_subprocess(NULL, 0, 0);
     g_test_trap_assert_failed();
-    g_test_trap_assert_stderr("*Unexpected error*stray '%x'*");
+    g_test_trap_assert_stderr("*Unexpected error*"
+                              "invalid interpolation '%x'*");
 }
 
 static void interpolation_string(void)
-- 
2.17.1
