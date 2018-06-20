Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVUig-0001Q0-AB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVUif-0007MD-5F
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:46 -0400
From: Amol Surati <suratiamol@gmail.com>
Date: Wed, 20 Jun 2018 09:59:30 +0530
Message-Id: <20180620042930.24208-3-suratiamol@gmail.com>
In-Reply-To: <20180620042930.24208-1-suratiamol@gmail.com>
References: <20180620042930.24208-1-suratiamol@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] tests/ide-test: test case for crash when
 processing short PRDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Amol Surati <suratiamol@gmail.com>, "open list:IDE" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

Related Bug: https://bugs.launchpad.net/qemu/+bug/1777315

Signed-off-by: Amol Surati <suratiamol@gmail.com>
---
 tests/ide-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index f39431b1a9..382c29a174 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -473,6 +473,32 @@ static void test_bmdma_one_sector_short_prdt(void)
     free_pci_device(dev);
 }
 
+static void test_bmdma_partial_sector_short_prdt(void)
+{
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint8_t status;
+
+    /* Read 2 sectors but only give 1 sector in PRDT */
+    PrdtEntry prdt[] = {
+        {
+            .addr = 0,
+            .size = cpu_to_le32(0x200),
+        },
+        {
+            .addr = 512,
+            .size = cpu_to_le32(0x44 | PRDT_EOT),
+        }
+    };
+
+    dev = get_pci_device(&bmdma_bar, &ide_bar);
+    status = send_dma_request(CMD_READ_DMA, 0, 2,
+                              prdt, ARRAY_SIZE(prdt), NULL);
+    g_assert_cmphex(status, ==, 0);
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    free_pci_device(dev);
+}
+
 static void test_bmdma_long_prdt(void)
 {
     QPCIDevice *dev;
@@ -1037,6 +1063,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/bmdma/short_prdt", test_bmdma_short_prdt);
     qtest_add_func("/ide/bmdma/one_sector_short_prdt",
                    test_bmdma_one_sector_short_prdt);
+    qtest_add_func("/ide/bmdma/partial_sector_short_prdt",
+                   test_bmdma_partial_sector_short_prdt);
     qtest_add_func("/ide/bmdma/long_prdt", test_bmdma_long_prdt);
     qtest_add_func("/ide/bmdma/no_busmaster", test_bmdma_no_busmaster);
     qtest_add_func("/ide/bmdma/teardown", test_bmdma_teardown);
-- 
2.17.1
