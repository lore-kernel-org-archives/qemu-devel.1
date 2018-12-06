Received: from eggs.gnu.org ([2001:4830:134:3::10]:49093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqv-0005IX-I0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqu-0007fT-O7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUwqu-0007ez-H3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF0B12D7E4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:50:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  6 Dec 2018 17:49:58 +0100
Message-Id: <1544114998-1513-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1544114998-1513-1-git-send-email-thuth@redhat.com>
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 5/5] tests/pxe: Make test independent
 from global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, eblake@redhat.com

global_qtest is not really required here, since boot_sector_test()
is already independent from that global variable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pxe-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 6e36796..73ac1d1 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -61,6 +61,7 @@ static testdef_t s390x_tests[] = {
 
 static void test_pxe_one(const testdef_t *test, bool ipv6)
 {
+    QTestState *qts;
     char *args;
 
     args = g_strdup_printf(
@@ -70,9 +71,9 @@ static void test_pxe_one(const testdef_t *test, bool ipv6)
         test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off",
         test->model);
 
-    qtest_start(args);
-    boot_sector_test(global_qtest);
-    qtest_quit(global_qtest);
+    qts = qtest_init(args);
+    boot_sector_test(qts);
+    qtest_quit(qts);
     g_free(args);
 }
 
-- 
1.8.3.1
