Received: from eggs.gnu.org ([209.51.188.92]:36710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrd-0002ic-95
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001kU-DE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:45 +0300
Message-Id: <20190207102445.71998-18-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 17/17] hw/ide: drop iov field from IDEDMA
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
 hw/ide/atapi.c            | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1b02bb9151..8efd03132b 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -455,7 +455,6 @@ struct IDEDMAOps {
 
 struct IDEDMA {
     const struct IDEDMAOps *ops;
-    struct iovec iov;
     QEMUIOVector qiov;
     BlockAIOCB *aiocb;
 };
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 4de86555d9..1b0f66cc08 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -420,9 +420,8 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, int ret)
         data_offset = 0;
     }
     trace_ide_atapi_cmd_read_dma_cb_aio(s, s->lba, n);
-    s->bus->dma->iov.iov_base = (void *)(s->io_buffer + data_offset);
-    s->bus->dma->iov.iov_len = n * ATAPI_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->bus->dma->qiov, &s->bus->dma->iov, 1);
+    qemu_iovec_init_buf(&s->bus->dma->qiov, s->io_buffer + data_offset,
+                        n * ATAPI_SECTOR_SIZE);
 
     s->bus->dma->aiocb = ide_buffered_readv(s, (int64_t)s->lba << 2,
                                             &s->bus->dma->qiov, n * 4,
-- 
2.18.0
