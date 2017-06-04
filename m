Received: from eggs.gnu.org ([2001:4830:134:3::10]:60924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpW-0006qh-95
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpS-0004yy-BP
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:23 +0300
Message-Id: <543f8f13e256a081dd820375e9575439b659ccd8.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 19/22] ide-test: check return of fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: John Snow <jsnow@redhat.com>

To quiet patchew, add an assert for fwrite's return value.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/ide-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 139ebc0ec6..bfd79ddbdc 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -796,11 +796,13 @@ static void cdrom_pio_impl(int nblocks)
     int i, j;
     uint8_t data;
     uint16_t limit;
+    size_t ret;
 
     /* Prepopulate the CDROM with an interesting pattern */
     generate_pattern(pattern, patt_len, ATAPI_BLOCK_SIZE);
     fh = fopen(tmp_path, "w+");
-    fwrite(pattern, ATAPI_BLOCK_SIZE, patt_blocks, fh);
+    ret = fwrite(pattern, ATAPI_BLOCK_SIZE, patt_blocks, fh);
+    g_assert_cmpint(ret, ==, patt_blocks);
     fclose(fh);
 
     ide_test_start("-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
@@ -880,6 +882,7 @@ static void test_cdrom_pio_large(void)
 static void test_cdrom_dma(void)
 {
     static const size_t len = ATAPI_BLOCK_SIZE;
+    size_t ret;
     char *pattern = g_malloc(ATAPI_BLOCK_SIZE * 16);
     char *rx = g_malloc0(len);
     uintptr_t guest_buf;
@@ -896,7 +899,8 @@ static void test_cdrom_dma(void)
 
     generate_pattern(pattern, ATAPI_BLOCK_SIZE * 16, ATAPI_BLOCK_SIZE);
     fh = fopen(tmp_path, "w+");
-    fwrite(pattern, ATAPI_BLOCK_SIZE, 16, fh);
+    ret = fwrite(pattern, ATAPI_BLOCK_SIZE, 16, fh);
+    g_assert_cmpint(ret, ==, 16);
     fclose(fh);
 
     send_dma_request(CMD_PACKET, 0, 1, prdt, 1, send_scsi_cdb_read10);
-- 
2.11.0
