Received: from eggs.gnu.org ([2001:4830:134:3::10]:45274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVU-0002ql-91
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVR-0002rS-5b
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLtVQ-0002r7-V7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:53 -0400
Date: Fri, 16 Jun 2017 18:49:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1497628168-30489-3-git-send-email-mst@redhat.com>
References: <1497628168-30489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497628168-30489-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] tests/q35-test: push down qtest_start /
 qtest_end to test case(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

A test program can start up QEMU several times, with different command
lines. For such cases, qtest_start() and qtest_end() are called from
within the individual test functions. Examples: "virtio-console-test.c",
"numa-test.c", and many others.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/q35-test.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index cc58f3e..6c21b40 100644
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
MST
