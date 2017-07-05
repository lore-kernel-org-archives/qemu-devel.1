Received: from eggs.gnu.org ([2001:4830:134:3::10]:39065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUZ-0005Gc-2U
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUU-0004Na-GM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  5 Jul 2017 21:36:33 +0800
Message-Id: <20170705133635.11850-5-famz@redhat.com>
In-Reply-To: <20170705133635.11850-1-famz@redhat.com>
References: <20170705133635.11850-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/6] block/nvme: Implement .bdrv_dma_map and
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

Forward these two calls to the IOVA manager.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index eb999a1..7913017 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1056,6 +1056,20 @@ static void nvme_aio_unplug(BlockDriverState *bs)
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
@@ -1081,6 +1095,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_io_plug             = nvme_aio_plug,
     .bdrv_io_unplug           = nvme_aio_unplug,
+
+    .bdrv_dma_map             = nvme_dma_map,
+    .bdrv_dma_unmap           = nvme_dma_unmap,
 };
 
 static void bdrv_nvme_init(void)
-- 
2.9.4
