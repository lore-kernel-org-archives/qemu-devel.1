Received: from eggs.gnu.org ([2001:4830:134:3::10]:52667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBt-0006on-T7
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBm-000097-3U
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBl-00006d-Jr
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:18 +0200
Message-Id: <20180808120334.10970-41-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 40/56] json: Replace %I64d, %I64u by %PRId64,
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Support for %I64d got addded in commit 2c0d4b36e7f "json: fix PRId64
on Win32".  We had to hard-code I64d because we used the lexer's
finite state machine to check interpolations.  No more, so clean this
up.

Additional conversion specifications would be easy enough to implement
when needed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 10 ++++++----
 tests/check-qjson.c   | 10 ++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index bd137399e5..350a9d267b 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -433,16 +433,18 @@ static QObject *parse_interpolation(JSONParserContext *ctxt, va_list *ap)
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
index 895be489b3..fbb607c227 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -919,9 +919,11 @@ static void keyword_literal(void)
 static void interpolation(void)
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
@@ -959,6 +961,10 @@ static void interpolation(void)
     g_assert_cmpint(qnum_get_int(qnum), ==, value_lld);
     qobject_unref(qnum);
 
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%" PRId64, value_d64));
+    g_assert_cmpint(qnum_get_int(qnum), ==, value_lld);
+    qobject_unref(qnum);
+
     qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%u", value_u));
     g_assert_cmpuint(qnum_get_uint(qnum), ==, value_u);
     qobject_unref(qnum);
@@ -971,6 +977,10 @@ static void interpolation(void)
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
