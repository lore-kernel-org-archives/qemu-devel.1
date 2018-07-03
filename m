Received: from eggs.gnu.org ([2001:4830:134:3::10]:53011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4Y-0001Ri-5V
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4T-0007Bz-T7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4T-0007Bd-P7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:32 +0200
Message-Id: <20180703085358.13941-7-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/32] tests/qmp-test: Test in-band command
 doesn't overtake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 6dd331fcdd..d73730945a 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -239,10 +239,12 @@ static void test_qmp_oob(void)
     /* OOB command overtakes slow in-band command */
     setup_blocking_cmd();
     send_cmd_that_blocks(qts, "ib-blocks-1");
+    qtest_async_qmp(qts, "{ 'execute': 'query-name', 'id': 'ib-quick-1' }");
     send_oob_cmd_that_fails(qts, "oob-1");
     recv_cmd_id(qts, "oob-1");
     unblock_blocked_cmd();
     recv_cmd_id(qts, "ib-blocks-1");
+    recv_cmd_id(qts, "ib-quick-1");
     cleanup_blocking_cmd();
 
     qtest_quit(qts);
-- 
2.17.1
