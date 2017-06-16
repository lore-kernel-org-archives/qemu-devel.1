Received: from eggs.gnu.org ([2001:4830:134:3::10]:48264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLpKP-0004Yq-Re
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLpKN-0003WN-2W
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dLpKM-0003Vj-S4
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 07:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2C4EC04B93D
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 11:22:09 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 16 Jun 2017 13:22:00 +0200
Message-Id: <20170616112201.24512-2-lersek@redhat.com>
In-Reply-To: <20170616112201.24512-1-lersek@redhat.com>
References: <20170616112201.24512-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] tests/q35-test: push down qtest_start /
 qtest_end to test case(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

A test program can start up QEMU several times, with different command
lines. For such cases, qtest_start() and qtest_end() are called from
within the individual test functions. Examples: "virtio-console-test.c",
"numa-test.c", and many others.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 tests/q35-test.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index cc58f3ecf491..6c21b402a76c 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -42,6 +42,8 @@ static void test_smram_lock(void)
     QPCIDevice *pcidev;
     QDict *response;
 
+    qtest_start("-M q35");
+
     pcibus = qpci_init_pc(NULL);
     g_assert(pcibus != NULL);
 
@@ -74,19 +76,15 @@ static void test_smram_lock(void)
 
     g_free(pcidev);
     qpci_free_pc(pcibus);
+
+    qtest_end();
 }
 
 int main(int argc, char **argv)
 {
-    int ret;
-
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/q35/smram/lock", test_smram_lock);
 
-    qtest_start("-M q35");
-    ret = g_test_run();
-    qtest_end();
-
-    return ret;
+    return g_test_run();
 }
-- 
2.9.3
