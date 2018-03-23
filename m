Received: from eggs.gnu.org ([2001:4830:134:3::10]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNn-0007YB-1D
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNj-0005Jp-SN
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezNNj-0005Im-PG
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:23 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Mar 2018 22:08:20 +0800
Message-Id: <20180323140821.28957-4-peterx@redhat.com>
In-Reply-To: <20180323140821.28957-1-peterx@redhat.com>
References: <20180323140821.28957-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 3/4] Revert "tests: qmp-test: verify
 command batching"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This reverts commit 91ad45061af0fe44ac5dadb5bedaf4d7a08077c8.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 2e4b599a4c..d1fa1cb217 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -82,7 +82,6 @@ static void test_qmp_protocol(void)
     QTestState *qts;
     const QListEntry *entry;
     QString *qstr;
-    int i;
 
     qts = qtest_init_without_qmp_handshake(common_args);
 
@@ -140,27 +139,6 @@ static void test_qmp_protocol(void)
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
     QDECREF(resp);
 
-    /*
-     * Test command batching.  In current test OOB is not enabled, we
-     * should be able to run as many commands in batch as we like.
-     * Using 16 (>8, which is OOB queue length) to make sure OOB won't
-     * break existing clients.  Note: this test does not control the
-     * scheduling of QEMU's QMP command processing threads so it may
-     * not really trigger batching inside QEMU.  This is just a
-     * best-effort test.
-     */
-    for (i = 0; i < 16; i++) {
-        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");
-    }
-    /* Verify the replies to make sure no command is dropped. */
-    for (i = 0; i < 16; i++) {
-        resp = qtest_qmp_receive(qts);
-        /* It should never be dropped.  Each of them should be a reply. */
-        g_assert(qdict_haskey(resp, "return"));
-        g_assert(!qdict_haskey(resp, "event"));
-        QDECREF(resp);
-    }
-
     qtest_quit(qts);
 }
 
-- 
2.14.3
