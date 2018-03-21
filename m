Received: from eggs.gnu.org ([2001:4830:134:3::10]:58150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXee-00073V-0Q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXed-0005il-1A
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyXec-0005iS-P9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:22 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 21 Mar 2018 14:55:06 +0800
Message-Id: <20180321065506.21091-4-peterx@redhat.com>
In-Reply-To: <20180321065506.21091-1-peterx@redhat.com>
References: <20180321065506.21091-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] tests: more strict command batching test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>

Add "id" fields to the commands, and check that the command returns are
in order.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 07c0b87e27..c861c3b550 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -83,6 +83,7 @@ static void test_qmp_protocol(void)
     const QListEntry *entry;
     QString *qstr;
     int i;
+    char buf[128];
 
     qts = qtest_init_without_qmp_handshake(common_args);
 
@@ -150,7 +151,10 @@ static void test_qmp_protocol(void)
      * best-effort test.
      */
     for (i = 0; i < 16; i++) {
-        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");
+        snprintf(buf, sizeof(buf) - 1, "{ 'execute': 'query-version', "
+                 "'id': %d }", i);
+        buf[sizeof(buf) - 1] = '\0';
+        qtest_async_qmp(qts, buf);
     }
     /* Verify the replies to make sure no command is dropped. */
     for (i = 0; i < 16; i++) {
@@ -158,6 +162,8 @@ static void test_qmp_protocol(void)
         /* It should never be dropped.  Each of them should be a reply. */
         g_assert(qdict_haskey(resp, "return"));
         g_assert(!qdict_haskey(resp, "event"));
+        g_assert(qdict_haskey(resp, "id"));
+        g_assert(qdict_get_int(resp, "id") == i);
         QDECREF(resp);
     }
 
-- 
2.14.3
