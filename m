Received: from eggs.gnu.org ([2001:4830:134:3::10]:33197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoi-0002HY-7d
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001e3-22
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHob-0001ZV-UZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26A204023827
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB7FE2026D6D
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:23 +0200
Message-Id: <20180824193206.25475-16-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/58] check-qjson qmp-test: Cover control
 characters more thoroughly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

RFC 8259 "The JavaScript Object Notation (JSON) Data Interchange
Format" requires control characters in strings to be escaped.
Demonstrate the JSON parser accepts U+0001 .. U+001F unescaped.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-16-armbru@redhat.com>
---
 tests/check-qjson.c | 36 ++++++++++++++++++++++++++++++------
 tests/qmp-test.c    | 14 ++++++++++++++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 40a573eb21..a586189d87 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -192,6 +192,26 @@ static void utf8_string(void)
          *   We may choose to define this as feature
          */
 
+        /* 0  Control characters */
+        {
+            /*
+             * Note: \x00 is impossible, other representations of
+             * U+0000 are covered under 4.3
+             */
+            "\x01\x02\x03\x04\x05\x06\x07"
+            "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+            "\x10\x11\x12\x13\x14\x15\x16\x17"
+            "\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F",
+            /* bug: not corrected (valid UTF-8, but invalid JSON) */
+            "\x01\x02\x03\x04\x05\x06\x07"
+            "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
+            "\x10\x11\x12\x13\x14\x15\x16\x17"
+            "\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F",
+            "\\u0001\\u0002\\u0003\\u0004\\u0005\\u0006\\u0007"
+            "\\b\\t\\n\\u000B\\f\\r\\u000E\\u000F"
+            "\\u0010\\u0011\\u0012\\u0013\\u0014\\u0015\\u0016\\u0017"
+            "\\u0018\\u0019\\u001A\\u001B\\u001C\\u001D\\u001E\\u001F",
+        },
         /* 1  Some correct UTF-8 text */
         {
             /* a bit of German */
@@ -211,14 +231,14 @@ static void utf8_string(void)
         /* 2  Boundary condition test cases */
         /* 2.1  First possible sequence of a certain length */
         /*
-         * 2.1.1  1 byte U+0001
-         * \x00 is impossible, test \x01 instead.  Other
-         * representations of U+0000 are covered under 4.3.
+         * 2.1.1 1 byte U+0020
+         * Control characters are already covered by their own test
+         * case under 0.  Test the first 1 byte non-control character
+         * here.
          */
         {
-            "\x01",
-            "\x01",
-            "\\u0001",
+            " ",
+            " ",
         },
         /* 2.1.2  2 bytes U+0080 */
         {
@@ -1333,6 +1353,10 @@ static void junk_input(void)
     g_assert(!err);             /* BUG */
     g_assert(obj == NULL);
 
+    obj = qobject_from_json("{\x01", &err);
+    g_assert(!err);             /* BUG */
+    g_assert(obj == NULL);
+
     obj = qobject_from_json("[0\xFF]", &err);
     error_free_or_abort(&err);
     g_assert(obj == NULL);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 17153192fe..5edc97f63f 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -71,6 +71,13 @@ static void test_malformed(QTestState *qts)
     qobject_unref(resp);
     g_assert(recovered(qts));
 
+    /* lexical error: funny control character outside string */
+    qtest_qmp_send_raw(qts, "{\x01");
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    qobject_unref(resp);
+    g_assert(recovered(qts));
+
     /* lexical error: impossible byte in string */
     qtest_qmp_send_raw(qts, "{'bad \xFF");
     resp = qtest_qmp_receive(qts);
@@ -78,6 +85,13 @@ static void test_malformed(QTestState *qts)
     qobject_unref(resp);
     g_assert(recovered(qts));
 
+    /* lexical error: control character in string */
+    qtest_qmp_send_raw(qts, "{'execute': 'nonexistent', 'id':'\n'}");
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound"); /* BUG */
+    qobject_unref(resp);
+    g_assert(recovered(qts));
+
     /* lexical error: interpolation */
     qtest_qmp_send_raw(qts, "%%p\n");
     resp = qtest_qmp_receive(qts);
-- 
2.17.1
