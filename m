Received: from eggs.gnu.org ([2001:4830:134:3::10]:39112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mj-7Z
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxM-00019r-0j
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxL-000199-Nj
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C74040216ED
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC25910EE95F
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:49 +0200
Message-Id: <20180824193206.25475-42-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 41/58] json: Replace %I64d, %I64u by %PRId64,
 %PRIu64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Support for %I64d got added in commit 2c0d4b36e7f "json: fix PRId64 on
Win32".  We had to hard-code I64d because we used the lexer's finite
state machine to check interpolations.  No more, so clean this up.

Additional conversion specifications would be easy enough to implement
when needed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-42-armbru@redhat.com>
---
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   | 10 ++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index e61cee9e8a..27e873ad3b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -438,16 +438,18 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
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
index 83f8a0e6e3..f344ad921c 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -945,9 +945,11 @@ static void keyword_literal(void)
 static void interpolation_valid(void)
 {
     long long value_lld = 0x123456789abcdefLL;
+    int64_t value_d64 = value_lld;
     long value_ld = (long)value_lld;
     int value_d = (int)value_lld;
     unsigned long long value_llu = 0xfedcba9876543210ULL;
+    uint64_t value_u64 = value_llu;
     unsigned long value_lu = (unsigned long)value_llu;
     unsigned value_u = (unsigned)value_llu;
     double value_f = 2.323423423;
@@ -985,6 +987,10 @@ static void interpolation_valid(void)
     g_assert_cmpint(qnum_get_int(qnum), ==, value_lld);
     qobject_unref(qnum);
 
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%" PRId64, value_d64));
+    g_assert_cmpint(qnum_get_int(qnum), ==, value_lld);
+    qobject_unref(qnum);
+
     qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%u", value_u));
     g_assert_cmpuint(qnum_get_uint(qnum), ==, value_u);
     qobject_unref(qnum);
@@ -997,6 +1003,10 @@ static void interpolation_valid(void)
     g_assert_cmpuint(qnum_get_uint(qnum), ==, value_llu);
     qobject_unref(qnum);
 
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%" PRIu64, value_u64));
+    g_assert_cmpuint(qnum_get_uint(qnum), ==, value_llu);
+    qobject_unref(qnum);
+
     qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%f", value_f));
     g_assert(qnum_get_double(qnum) == value_f);
     qobject_unref(qnum);
-- 
2.17.1
