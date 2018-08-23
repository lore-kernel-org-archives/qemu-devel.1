Received: from eggs.gnu.org ([2001:4830:134:3::10]:35588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskU-0000Y3-EC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsskN-0006Nl-0O
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsskM-0006MM-Ar
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:46:10 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:40:07 +0200
Message-Id: <20180823164025.12553-41-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 40/58] json: Leave rejecting invalid
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
    JSON_INTERP   %04d
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
index 7c31c2c8ff..f1a4b5a430 100644
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
     IN_INTERP,
-    IN_INTERP_L,
-    IN_INTERP_LL,
-    IN_INTERP_I,
-    IN_INTERP_I6,
-    IN_INTERP_I64,
     IN_WHITESPACE,
     IN_START,
     IN_START_INTERP,            /* must be IN_START + 1 */
@@ -224,39 +220,11 @@ static const uint8_t json_lexer[][256] =  {
     },
 
     /* interpolation */
-    [IN_INTERP_LL] = {
-        ['d'] = JSON_INTERP,
-        ['u'] = JSON_INTERP,
-    },
-
-    [IN_INTERP_L] = {
-        ['d'] = JSON_INTERP,
-        ['l'] = IN_INTERP_LL,
-        ['u'] = JSON_INTERP,
-    },
-
-    [IN_INTERP_I64] = {
-        ['d'] = JSON_INTERP,
-        ['u'] = JSON_INTERP,
-    },
-
-    [IN_INTERP_I6] = {
-        ['4'] = IN_INTERP_I64,
-    },
-
-    [IN_INTERP_I] = {
-        ['6'] = IN_INTERP_I6,
-    },
-
     [IN_INTERP] = {
-        ['d'] = JSON_INTERP,
-        ['i'] = JSON_INTERP,
-        ['p'] = JSON_INTERP,
-        ['s'] = JSON_INTERP,
-        ['u'] = JSON_INTERP,
-        ['f'] = JSON_INTERP,
-        ['l'] = IN_INTERP_L,
-        ['I'] = IN_INTERP_I,
+        TERMINAL(JSON_INTERP),
+        ['A' ... 'Z'] = IN_INTERP,
+        ['a' ... 'z'] = IN_INTERP,
+        ['0' ... '9'] = IN_INTERP,
     },
 
     /*
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 2855eaaeca..e61cee9e8a 100644
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
index d6fda0786f..83f8a0e6e3 100644
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
