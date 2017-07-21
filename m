Received: from eggs.gnu.org ([2001:4830:134:3::10]:38045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYf8l-0004GE-Ty
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYf8h-0005kg-RD
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYf8h-0005kJ-I6
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AFA820272
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 21:07:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 21 Jul 2017 16:07:07 -0500
Message-Id: <20170721210707.21805-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] qobject: Accept "%"PRId64 in
 qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Commit 1792d7d0 was written because PRId64 expands to non-portable
crap for some libc, and we had testsuite failures on Mac OS as a
result.  This in turn makes it difficult to rely on the obvious
conversions of 64-bit values into JSON, requiring things such as
casting int64_t to long long so we can use a reliable %lld and
still keep -Wformat happy.  So now it's time to fix that.

We are already lexing %I64d (hello mingw); now expand the lexer
to parse %qd (hello Mac OS). In the process, we can drop one
state: IN_ESCAPE_I64 is redundant with IN_ESCAPE_LL.  And fix a
comment that mistakenly omitted %u as a supported escape.

Next, tweak the parser to accept the exact spelling of PRId64
regardless of what it expands to (note that there are are now dead
branches in the 'if' chain for some platforms, like glibc; but all
branches are necessary on other platforms).  We are at least safe
in that we are parsing the correct size 32-bit or a 64-bit quantity
on whatever branch we end up in.  And of course, update the
testsuite for coverage of the feature.

Finally, update configure to barf on any libc that uses yet
another form of PRId64 that we have not yet coded for, so that we
can once again update json-lexer.c to cater to those quirks (my
guess? we might see %jd next).  Yes, the only way I could find
to quickly do and still work when cross-compiling is to grep a
compiled binary; C does not make it easy to turn a string constant
into an integer constant, let along make preprocessor decisions;
and even parsing '$CC -E' output is fragile, since 64-bit glibc
pre-processes as "l" "d" rather than "ld".  I'm assuming that
'strings' is portable enough during configure.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 configure             | 21 +++++++++++++++++++++
 qobject/json-lexer.c  | 11 +++--------
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   |  7 +++++++
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 6b52e19ee3..b810ff970d 100755
--- a/configure
+++ b/configure
@@ -3239,6 +3239,27 @@ for i in $glib_modules; do
     fi
 done

+# Sanity check that we can parse PRId64 and friends in json-lexer.c
+# (Sadly, the "easiest" way to do this is to grep the compiled binary)
+cat > $TMPC <<EOF
+#include <inttypes.h>
+int main(void) {
+    static const char findme[] = "UnLiKeLyToClAsH_" PRId64;
+    return !findme[0];
+}
+EOF
+if ! compile_prog "$CFLAGS" "$LIBS" ; then
+    error_exit "can't determine value of PRId64"
+fi
+nl='
+'
+case $(strings $TMPE | grep ^UnLiKeLyToClAsH) in
+    '' | *"$nl"* ) error_exit "can't determine value of PRId64" ;;
+    *_ld | *_lld | *_I64d | *_qd) ;;
+    *) error_exit "unexepected value of PRId64, please add %$(strings $TMPE |
+       sed -n s/^UnLiKeLyToClAsH_//p) support to json-lexer.c" ;;
+esac
+
 # Sanity check that the current size_t matches the
 # size that glib thinks it should be. This catches
 # problems on multi-arch where people try to build
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 980ba159d6..98b1ec8e35 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -31,7 +31,7 @@
  *
  * Extension for vararg handling in JSON construction:
  *
- * %((l|ll|I64)?d|[ipsf])
+ * %(PRI[du]64|(l|ll)?[ud]|[ipsf])
  *
  */

@@ -63,7 +63,6 @@ enum json_lexer_state {
     IN_ESCAPE_LL,
     IN_ESCAPE_I,
     IN_ESCAPE_I6,
-    IN_ESCAPE_I64,
     IN_WHITESPACE,
     IN_START,
 };
@@ -236,13 +235,8 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = JSON_ESCAPE,
     },

-    [IN_ESCAPE_I64] = {
-        ['d'] = JSON_ESCAPE,
-        ['u'] = JSON_ESCAPE,
-    },
-
     [IN_ESCAPE_I6] = {
-        ['4'] = IN_ESCAPE_I64,
+        ['4'] = IN_ESCAPE_LL,
     },

     [IN_ESCAPE_I] = {
@@ -257,6 +251,7 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = JSON_ESCAPE,
         ['f'] = JSON_ESCAPE,
         ['l'] = IN_ESCAPE_L,
+        ['q'] = IN_ESCAPE_LL,
         ['I'] = IN_ESCAPE_I,
     },

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 7a417f20cd..f01e97fc6b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -470,15 +470,17 @@ static QObject *parse_escape(JSONParserContext *ctxt, va_list *ap)
         return QOBJECT(qnum_from_int(va_arg(*ap, int)));
     } else if (!strcmp(token->str, "%ld")) {
         return QOBJECT(qnum_from_int(va_arg(*ap, long)));
-    } else if (!strcmp(token->str, "%lld") ||
-               !strcmp(token->str, "%I64d")) {
+    } else if (!strcmp(token->str, "%" PRId64)) {
+        return QOBJECT(qnum_from_int(va_arg(*ap, int64_t)));
+    } else if (!strcmp(token->str, "%lld")) {
         return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
     } else if (!strcmp(token->str, "%u")) {
         return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned int)));
     } else if (!strcmp(token->str, "%lu")) {
         return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long)));
-    } else if (!strcmp(token->str, "%llu") ||
-               !strcmp(token->str, "%I64u")) {
+    } else if (!strcmp(token->str, "%" PRIu64)) {
+        return QOBJECT(qnum_from_uint(va_arg(*ap, uint64_t)));
+    } else if (!strcmp(token->str, "%llu")) {
         return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long long)));
     } else if (!strcmp(token->str, "%s")) {
         return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 53f2275b9b..d55d6d9ed1 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -990,8 +990,10 @@ static void vararg_number(void)
     QNum *qnum;
     int value = 0x2342;
     long long value_ll = 0x2342342343LL;
+    uint64_t value_u = UINT64_C(0x2342342343);
     double valuef = 2.323423423;
     int64_t val;
+    uint64_t uval;

     qnum = qobject_to_qnum(qobject_from_jsonf("%d", value));
     g_assert(qnum_get_try_int(qnum, &val));
@@ -1003,6 +1005,11 @@ static void vararg_number(void)
     g_assert_cmpint(val, ==, value_ll);
     QDECREF(qnum);

+    qnum = qobject_to_qnum(qobject_from_jsonf("%" PRIu64, value_u));
+    g_assert(qnum_get_try_uint(qnum, &uval));
+    g_assert_cmpint(uval, ==, value_u);
+    QDECREF(qnum);
+
     qnum = qobject_to_qnum(qobject_from_jsonf("%f", valuef));
     g_assert(qnum_get_double(qnum) == valuef);
     QDECREF(qnum);
-- 
2.13.3
