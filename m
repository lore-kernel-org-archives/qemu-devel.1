Received: from eggs.gnu.org ([209.51.188.92]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBW4-00036V-KA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVs-0002cw-Lp
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:09:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:46 +0000
Message-Id: <20190222140756.29834-18-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/27] hw/ide: drop iov field from IDEDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

@iov is used only to initialize @qiov. Let's use new
qemu_iovec_init_buf() instead, which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-18-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-18-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/ide/internal.h | 1 -
 hw/ide/atapi.c            | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1b02bb9151..8efd03132b 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -455,7 +455,6 @@ struct IDEDMAOps {
=20
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
@@ -420,9 +420,8 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, i=
nt ret)
         data_offset =3D 0;
     }
     trace_ide_atapi_cmd_read_dma_cb_aio(s, s->lba, n);
-    s->bus->dma->iov.iov_base =3D (void *)(s->io_buffer + data_offset);
-    s->bus->dma->iov.iov_len =3D n * ATAPI_SECTOR_SIZE;
-    qemu_iovec_init_external(&s->bus->dma->qiov, &s->bus->dma->iov, 1);
+    qemu_iovec_init_buf(&s->bus->dma->qiov, s->io_buffer + data_offset,
+                        n * ATAPI_SECTOR_SIZE);
=20
     s->bus->dma->aiocb =3D ide_buffered_readv(s, (int64_t)s->lba << 2,
                                             &s->bus->dma->qiov, n * 4,
--=20
2.20.1
