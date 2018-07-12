Received: from eggs.gnu.org ([2001:4830:134:3::10]:47843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWN-00077B-L0
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWK-0006nD-83
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWK-0006mG-2e
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54FF134667
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:04 +0200
Message-Id: <20180712111221.20326-4-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/20] libqtest: Clean up how we read
 device_del messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qtest_qmp_device_del() still uses the qmp("") hack to receive a
message, even though we have qmp_receive() since commit 66e0c7b187e.
Put it to use.

Bonus: gets rid of empty format strings.  A step towards compile-time
format string checking without triggering -Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 9cb4096639..071d7eb7b1 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1090,7 +1090,7 @@ void qtest_qmp_device_del(const char *id)
     g_assert(response1);
     g_assert(!qdict_haskey(response1, "error"));
 
-    response2 = qmp("");
+    response2 = qmp_receive();
     g_assert(response2);
     g_assert(!qdict_haskey(response2, "error"));
 
-- 
2.17.1
