Received: from eggs.gnu.org ([2001:4830:134:3::10]:59485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNH-0008E9-KD
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNE-0003hk-ML
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNE-0003go-E1
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B80937EE9
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:25:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:30 -0500
Message-Id: <20170804012551.2714-2-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/22] qobject: Accept "%"PRId64 in
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
state: IN_ESCAPE_I64 is redundant with IN_ESCAPE_LL, and reused
again by %qd, so rename it to IN_ESCAPE_64.  And fix a comment
that mistakenly omitted %u as a supported escape.

Next, tweak the parser to accept the exact spelling of PRId64
regardless of what it expands to (note that there are are now dead
branches in the 'if' chain for some platforms, like glibc; but
there are other platforms where all branches are necessary).  We
are at least safe in that we are parsing the correct size 32-bit or
a 64-bit quantity on whatever branch we end up in.  This also means
that we no longer parse everything that the lexer will consume (no
more %I64d on glibc), but that is intentional.  And of course,
update the testsuite for coverage of the feature.

Finally, update configure to barf on any libc that uses yet
another form of PRId64 that we have not yet coded for, so that we
can once again update json-lexer.c to cater to those quirks (my
guess? we might see %jd next) (on the bright side, json-parser.c
should no longer need updates).  Yes, the only way I could find
to quickly learn what spelling is preferred when cross-compiling
is to grep a compiled binary; C does not make it easy to turn a
string constant into an integer constant, let alone make
preprocessor decisions; and even parsing '$CC -E' output is
fragile, since 64-bit glibc pre-processes as "l" "d" rather than
"ld", and newer gcc splits macro expansions across multiple lines.

I'm assuming that 'strings' is portable enough during configure;
if that assumption fails in some constrained docker environment,
we can make a followup patch to configure along these lines:
  strings () { tr -d '\0' < "$1"; }
Either way, it's better to avoid worrying about whether grep will
portably handle a file still containing NUL bytes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>

---
v4: compile_object instead of compile_prog; another comment tweak
v3: incorporate review comments from Markus
---
 configure             | 24 ++++++++++++++++++++++++
 qobject/json-lexer.c  | 22 ++++++++++------------
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   |  7 +++++++
 4 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/configure b/configure
index 987f59ba88..6e0e433cc4 100755
--- a/configure
+++ b/configure
@@ -3222,6 +3222,30 @@ for i in $glib_modules; do
     fi
 done

+# Sanity check that we can parse PRId64 and friends in json-lexer.c
+# (Sadly, the "easiest" way to do this is to grep the compiled binary,
+# since we can't control whether the preprocessor would output "ld" vs.
+# "l" "d", nor even portably ensure it fits output on the same line as
+# a witness marker.)
+cat > $TMPC <<EOF
+#include <inttypes.h>
+int main(void) {
+    static const char findme[] = "\nUnLiKeLyToClAsH_" PRId64 "\n";
+    return !findme[0];
+}
+EOF
+if ! compile_object "$CFLAGS" "$LIBS" ; then
+    error_exit "can't determine value of PRId64"
+fi
+nl='
+'
+case $(strings $TMPO | grep ^UnLiKeLyToClAsH) in
+    '' | *"$nl"* ) error_exit "can't determine value of PRId64" ;;
+    *_ld | *_lld | *_I64d | *_qd) ;;
+    *) error_exit "unexepected value of PRId64, please add %$(strings $TMPO |
+       sed -n s/^UnLiKeLyToClAsH_//p) support to json-lexer.c" ;;
+esac
+
 # Sanity check that the current size_t matches the
 # size that glib thinks it should be. This catches
 # problems on multi-arch where people try to build
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 980ba159d6..b846d2852d 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -29,9 +29,12 @@
  *
  * '([^\\']|\\[\"'\\/bfnrt]|\\u[0-9a-fA-F]{4})*'
  *
- * Extension for vararg handling in JSON construction:
+ * Extension for vararg handling in JSON construction, when using
+ * qobject_from_jsonf() instead of qobject_from_json() (this lexer
+ * actually accepts multiple forms of PRId64, but parse_escape() later
+ * filters to only parse the current platform's spelling):
  *
- * %((l|ll|I64)?d|[ipsf])
+ * %(PRI[du]64|(l|ll)?[ud]|[ipsf])
  *
  */

@@ -60,10 +63,9 @@ enum json_lexer_state {
     IN_KEYWORD,
     IN_ESCAPE,
     IN_ESCAPE_L,
-    IN_ESCAPE_LL,
+    IN_ESCAPE_64,
     IN_ESCAPE_I,
     IN_ESCAPE_I6,
-    IN_ESCAPE_I64,
     IN_WHITESPACE,
     IN_START,
 };
@@ -225,24 +227,19 @@ static const uint8_t json_lexer[][256] =  {
     },

     /* escape */
-    [IN_ESCAPE_LL] = {
+    [IN_ESCAPE_64] = {
         ['d'] = JSON_ESCAPE,
         ['u'] = JSON_ESCAPE,
     },

     [IN_ESCAPE_L] = {
         ['d'] = JSON_ESCAPE,
-        ['l'] = IN_ESCAPE_LL,
-        ['u'] = JSON_ESCAPE,
-    },
-
-    [IN_ESCAPE_I64] = {
-        ['d'] = JSON_ESCAPE,
+        ['l'] = IN_ESCAPE_64,
         ['u'] = JSON_ESCAPE,
     },

     [IN_ESCAPE_I6] = {
-        ['4'] = IN_ESCAPE_I64,
+        ['4'] = IN_ESCAPE_64,
     },

     [IN_ESCAPE_I] = {
@@ -257,6 +254,7 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = JSON_ESCAPE,
         ['f'] = JSON_ESCAPE,
         ['l'] = IN_ESCAPE_L,
+        ['q'] = IN_ESCAPE_64,
         ['I'] = IN_ESCAPE_I,
     },

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 724ca240e4..388aa7a386 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -470,16 +470,18 @@ static QObject *parse_escape(JSONParserContext *ctxt, va_list *ap)
         return QOBJECT(qnum_from_int(va_arg(*ap, int)));
     } else if (!strcmp(token->str, "%ld")) {
         return QOBJECT(qnum_from_int(va_arg(*ap, long)));
-    } else if (!strcmp(token->str, "%lld") ||
-               !strcmp(token->str, "%I64d")) {
+    } else if (!strcmp(token->str, "%lld")) {
         return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
+    } else if (!strcmp(token->str, "%" PRId64)) {
+        return QOBJECT(qnum_from_int(va_arg(*ap, int64_t)));
     } else if (!strcmp(token->str, "%u")) {
         return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned int)));
     } else if (!strcmp(token->str, "%lu")) {
         return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long)));
-    } else if (!strcmp(token->str, "%llu") ||
-               !strcmp(token->str, "%I64u")) {
+    } else if (!strcmp(token->str, "%llu")) {
         return QOBJECT(qnum_from_uint(va_arg(*ap, unsigned long long)));
+    } else if (!strcmp(token->str, "%" PRIu64)) {
+        return QOBJECT(qnum_from_uint(va_arg(*ap, uint64_t)));
     } else if (!strcmp(token->str, "%s")) {
         return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
     } else if (!strcmp(token->str, "%f")) {
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index a3a97b0d99..1ad1f41a52 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -990,8 +990,10 @@ static void vararg_number(void)
     QNum *qnum;
     int value = 0x2342;
     long long value_ll = 0x2342342343LL;
+    uint64_t value_u64 = 0x2342342343ULL;
     double valuef = 2.323423423;
     int64_t val;
+    uint64_t uval;

     qnum = qobject_to_qnum(qobject_from_jsonf("%d", value));
     g_assert(qnum_get_try_int(qnum, &val));
@@ -1003,6 +1005,11 @@ static void vararg_number(void)
     g_assert_cmpint(val, ==, value_ll);
     QDECREF(qnum);

+    qnum = qobject_to_qnum(qobject_from_jsonf("%" PRIu64, value_u64));
+    g_assert(qnum_get_try_uint(qnum, &uval));
+    g_assert_cmpint(uval, ==, value_u64);
+    QDECREF(qnum);
+
     qnum = qobject_to_qnum(qobject_from_jsonf("%f", valuef));
     g_assert(qnum_get_double(qnum) == valuef);
     QDECREF(qnum);
-- 
2.13.3
