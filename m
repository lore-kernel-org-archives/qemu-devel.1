Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJf-0000vp-7S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJe-000667-AW
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJe-00065w-7C
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C93ED814F0D2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:24 -0500
Message-Id: <20180312183628.394722-34-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 33/36] tests: qmp-test: verify command batching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

OOB introduced DROP event for flow control.  This should not affect old
QMP clients.  Add a command batching check to make sure of it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-23-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index a8384bdda3b..fd4033a13fd 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -82,6 +82,7 @@ static void test_qmp_protocol(void)
     QTestState *qts;
     const QListEntry *entry;
     QString *qstr;
+    int i;

     qts = qtest_init_without_qmp_handshake(common_args);

@@ -139,6 +140,27 @@ static void test_qmp_protocol(void)
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
     QDECREF(resp);

+    /*
+     * Test command batching.  In current test OOB is not enabled, we
+     * should be able to run as many commands in batch as we like.
+     * Using 16 (>8, which is OOB queue length) to make sure OOB won't
+     * break existing clients.  Note: this test does not control the
+     * scheduling of QEMU's QMP command processing threads so it may
+     * not really trigger batching inside QEMU.  This is just a
+     * best-effort test.
+     */
+    for (i = 0; i < 16; i++) {
+        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");
+    }
+    /* Verify the replies to make sure no command is dropped. */
+    for (i = 0; i < 16; i++) {
+        resp = qtest_qmp_receive(qts);
+        /* It should never be dropped.  Each of them should be a reply. */
+        g_assert(qdict_haskey(resp, "return"));
+        g_assert(!qdict_haskey(resp, "event"));
+        QDECREF(resp);
+    }
+
     qtest_quit(qts);
 }

-- 
2.14.3
