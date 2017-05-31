Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dG9IS-0001BV-6e
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dG9IN-0000Bv-8y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:28:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 31 May 2017 15:28:36 -0400
Message-Id: <20170531192836.7187-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] ide-test: check return of fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

To quiet patchew, add an assert for fwrite's return value.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/ide-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 139ebc0..bfd79dd 100644
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
2.9.4
