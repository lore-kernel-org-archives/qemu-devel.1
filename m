Received: from eggs.gnu.org ([2001:4830:134:3::10]:33985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUcUV-0002ob-Lw
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUcUU-00075S-Pq
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 14:33:31 -0400
From: Amol Surati <suratiamol@gmail.com>
Date: Mon, 18 Jun 2018 00:05:15 +0530
Message-Id: <20180617183515.3982-2-suratiamol@gmail.com>
In-Reply-To: <20180617183515.3982-1-suratiamol@gmail.com>
References: <20180617183515.3982-1-suratiamol@gmail.com>
Subject: [Qemu-devel] [RFC 1/1] ide: bug #1777315: io_buffer_size and
 sg.size can represent partial sector sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amol Surati <suratiamol@gmail.com>, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

This patch fixes the assumption that io_buffer_size is always a perfect
multiple of the sector size. The assumption is the cause of the firing
of 'assert(n * 512 == s->sg.size);'.

Signed-off-by: Amol Surati <suratiamol@gmail.com>
---
 hw/ide/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 2c62efc536..53a7c68196 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -835,7 +835,7 @@ int ide_handle_rw_error(IDEState *s, int error, int op)
 static void ide_dma_cb(void *opaque, int ret)
 {
     IDEState *s = opaque;
-    int n;
+    int m, n;
     int64_t sector_num;
     uint64_t offset;
     bool stay_active = false;
@@ -858,6 +858,10 @@ static void ide_dma_cb(void *opaque, int ret)
     }
 
     n = s->io_buffer_size >> 9;
+    if (s->io_buffer_size & (~BDRV_SECTOR_MASK)) {
+        n++;
+    }
+
     if (n > s->nsector) {
         /* The PRDs were longer than needed for this request. Shorten them so
          * we don't get a negative remainder. The Active bit must remain set
@@ -868,7 +872,11 @@ static void ide_dma_cb(void *opaque, int ret)
 
     sector_num = ide_get_sector(s);
     if (n > 0) {
-        assert(n * 512 == s->sg.size);
+        m = s->sg.size >> 9;
+        if (s->sg.size & (~BDRV_SECTOR_MASK)) {
+            m++;
+        }
+        assert(n == m);
         dma_buf_commit(s, s->sg.size);
         sector_num += n;
         ide_set_sector(s, sector_num);
-- 
2.17.1
