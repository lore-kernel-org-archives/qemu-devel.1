Received: from eggs.gnu.org ([2001:4830:134:3::10]:51491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpYL-0005fs-CK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgpYK-0003DI-M0
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:09 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 23 Feb 2017 17:18:44 +0800
Message-Id: <20170223091845.18523-6-famz@redhat.com>
In-Reply-To: <20170223091845.18523-1-famz@redhat.com>
References: <20170223091845.18523-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] block/nvme: Implement .bdrv_dma_map and
 .bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Forward these two calls to the IOVA manager.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index f38b5e1..cfb93ce 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1021,6 +1021,20 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     }
 }
 
+static void nvme_dma_map(BlockDriverState *bs, void *host, size_t size)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    nvme_vfio_dma_map(s->vfio, host, size, false, NULL);
+}
+
+static void nvme_dma_unmap(BlockDriverState *bs, void *host)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    nvme_vfio_dma_unmap(s->vfio, host);
+}
+
 static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
@@ -1046,6 +1060,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_io_plug             = nvme_aio_plug,
     .bdrv_io_unplug           = nvme_aio_unplug,
+
+    .bdrv_dma_map             = nvme_dma_map,
+    .bdrv_dma_unmap           = nvme_dma_unmap,
 };
 
 static void bdrv_nvme_init(void)
-- 
2.9.3
