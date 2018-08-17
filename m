Received: from eggs.gnu.org ([2001:4830:134:3::10]:46227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-00034f-RP
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKE-0001kc-Ku
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKD-0001hz-V0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:16 +0200
Message-Id: <20180817150559.16243-18-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/60] json: Reject unescaped control
 characters
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

Fix the lexer to reject unescaped control characters in JSON strings,
in accordance with RFC 7159.

Bonus: we now recover more nicely from unclosed strings.  E.g.

    {"one: 1}\n{"two": 2}

now recovers cleanly after the newline, where before the lexer
remained confused until the next unpaired double quote or lexical
error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/json-lexer.c | 4 ++--
 tests/check-qjson.c  | 6 +-----
 tests/qmp-test.c     | 4 ++--
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 7c0875d225..e85e9a78ff 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -115,7 +115,7 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = IN_DQ_UCODE0,
     },
     [IN_DQ_STRING] = {
-        [1 ... 0xBF] = IN_DQ_STRING,
+        [0x20 ... 0xBF] = IN_DQ_STRING,
         [0xC2 ... 0xF4] = IN_DQ_STRING,
         ['\\'] = IN_DQ_STRING_ESCAPE,
         ['"'] = JSON_STRING,
@@ -155,7 +155,7 @@ static const uint8_t json_lexer[][256] =  {
         ['u'] = IN_SQ_UCODE0,
     },
     [IN_SQ_STRING] = {
-        [1 ... 0xBF] = IN_SQ_STRING,
+        [0x20 ... 0xBF] = IN_SQ_STRING,
         [0xC2 ... 0xF4] = IN_SQ_STRING,
         ['\\'] = IN_SQ_STRING_ESCAPE,
         ['\''] = JSON_STRING,
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 4fb43e4d5d..dd6bb76ec5 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -202,11 +202,7 @@ static void utf8_string(void)
             "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
             "\x10\x11\x12\x13\x14\x15\x16\x17"
             "\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F",
-            /* bug: not corrected (valid UTF-8, but invalid JSON) */
-            "\x01\x02\x03\x04\x05\x06\x07"
-            "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F"
-            "\x10\x11\x12\x13\x14\x15\x16\x17"
-            "\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F",
+            NULL,
             "\\u0001\\u0002\\u0003\\u0004\\u0005\\u0006\\u0007"
             "\\b\\t\\n\\u000B\\f\\r\\u000E\\u000F"
             "\\u0010\\u0011\\u0012\\u0013\\u0014\\u0015\\u0016\\u0017"
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5edc97f63f..7b3ba17c4a 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -86,9 +86,9 @@ static void test_malformed(QTestState *qts)
     g_assert(recovered(qts));
 
     /* lexical error: control character in string */
-    qtest_qmp_send_raw(qts, "{'execute': 'nonexistent', 'id':'\n'}");
+    qtest_qmp_send_raw(qts, "{'execute': 'nonexistent', 'id':'\n");
     resp = qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound"); /* BUG */
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     qobject_unref(resp);
     g_assert(recovered(qts));
 
-- 
2.17.1
