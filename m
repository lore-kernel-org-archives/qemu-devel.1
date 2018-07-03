Received: from eggs.gnu.org ([2001:4830:134:3::10]:50284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxt-00083U-WB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxr-00068q-CG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxr-00068O-5W
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB5324027E0B
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98D5B1C5B9
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:30 +0200
Message-Id: <20180703213556.20619-7-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/32] tests/qmp-test: Test in-band command
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-7-armbru@redhat.com>
---
 tests/qmp-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 467b694aa2..c9d01b87ca 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -238,10 +238,12 @@ static void test_qmp_oob(void)
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
