Received: from eggs.gnu.org ([2001:4830:134:3::10]:33641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdW-0005Yj-3Q
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdV-0002Im-7n
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezQdV-0002Ib-43
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B507B722DE
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:37:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 23 Mar 2018 12:37:39 -0500
Message-Id: <20180323173741.1445744-3-eblake@redhat.com>
In-Reply-To: <20180323173741.1445744-1-eblake@redhat.com>
References: <20180323173741.1445744-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] Revert "tests: qmp-test: verify command
 batching"
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

This reverts commit 91ad45061af0fe44ac5dadb5bedaf4d7a08077c8.

Enabling OOB caused several iotests failures; due to the imminent
2.12 release, the safest action is to disable OOB, but first we
have to revert tests that rely on OOB.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180323140821.28957-4-peterx@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
[eblake: reorder commits, enhance commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 2e4b599a4c8..d1fa1cb2177 100644
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
