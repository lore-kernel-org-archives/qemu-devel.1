Received: from eggs.gnu.org ([209.51.188.92]:36634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrb-0002iR-2p
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrZ-0001j5-Tm
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:24:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:43 +0300
Message-Id: <20190207102445.71998-16-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 15/17] hw/ide: drop iov field from IDEState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

@iov is used only to initialize @qiov. Let's use new
qemu_iovec_init_buf() instead, which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/hw/ide/internal.h | 1 -
 hw/ide/atapi.c            | 9 ++++-----
 hw/ide/core.c             | 8 ++------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 880413ddc7..fa99486d7a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -405,7 +405,6 @@ struct IDEState {
     int atapi_dma; /* true if dma is requested for the packet cmd */
     BlockAcctCookie acct;
     BlockAIOCB *pio_aiocb;
-    struct iovec iov;
     QEMUIOVector qiov;
     QLIST_HEAD(, IDEBufferedRequest) buffered_requests;
     /* ATA DMA state */
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 39e473f9c2..4de86555d9 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -174,16 +174,15 @@ static void cd_read_sector_cb(void *opaque, int ret)
 
 static int cd_read_sector(IDEState *s)
 {
+    void *buf;
+
     if (s->cd_sector_size != 2048 && s->cd_sector_size != 2352) {
         block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_READ);
         return -EINVAL;
     }
 
-    s->iov.iov_base = (s->cd_sector_size == 2352) ?
-                      s->io_buffer + 16 : s->io_buffer;
-
-    s->iov.iov_len = ATAPI_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->qiov, &s->iov, 1);
+    buf = (s->cd_sector_size == 2352) ? s->io_buffer + 16 : s->io_buffer;
+    qemu_iovec_init_buf(&s->qiov, buf, ATAPI_SECTOR_SIZE);
 
     trace_cd_read_sector(s->lba);
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index c3d779db6e..e94ba8c488 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -774,9 +774,7 @@ static void ide_sector_read(IDEState *s)
         return;
     }
 
-    s->iov.iov_base = s->io_buffer;
-    s->iov.iov_len  = n * BDRV_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->qiov, &s->iov, 1);
+    qemu_iovec_init_buf(&s->qiov, s->io_buffer, n * BDRV_SECTOR_SIZE);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      n * BDRV_SECTOR_SIZE, BLOCK_ACCT_READ);
@@ -1045,9 +1043,7 @@ static void ide_sector_write(IDEState *s)
         return;
     }
 
-    s->iov.iov_base = s->io_buffer;
-    s->iov.iov_len  = n * BDRV_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->qiov, &s->iov, 1);
+    qemu_iovec_init_buf(&s->qiov, s->io_buffer, n * BDRV_SECTOR_SIZE);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      n * BDRV_SECTOR_SIZE, BLOCK_ACCT_WRITE);
-- 
2.18.0
