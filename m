Received: from eggs.gnu.org ([2001:4830:134:3::10]:41469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZvAW-0000Mo-34
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZvAV-0004hz-9K
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:58:32 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 12 Jan 2018 16:55:51 +0800
Message-Id: <20180112085555.14447-6-famz@redhat.com>
In-Reply-To: <20180112085555.14447-1-famz@redhat.com>
References: <20180112085555.14447-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/9] block/nvme: Implement
 .bdrv_(un)register_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, alex.williamson@redhat.com, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

Forward these two calls to the IOVA manager.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180110091846.10699-6-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nvme.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 97ab01686f..a786f9e094 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1128,6 +1128,27 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     }
 }
 
+static void nvme_register_buf(BlockDriverState *bs, void *host, size_t size)
+{
+    int ret;
+    BDRVNVMeState *s = bs->opaque;
+
+    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL);
+    if (ret) {
+        /* FIXME: we may run out of IOVA addresses after repeated
+         * bdrv_register_buf/bdrv_unregister_buf, because nvme_vfio_dma_unmap
+         * doesn't reclaim addresses for fixed mappings. */
+        error_report("nvme_register_buf failed: %s", strerror(-ret));
+    }
+}
+
+static void nvme_unregister_buf(BlockDriverState *bs, void *host)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    qemu_vfio_dma_unmap(s->vfio, host);
+}
+
 static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
@@ -1153,6 +1174,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_io_plug             = nvme_aio_plug,
     .bdrv_io_unplug           = nvme_aio_unplug,
+
+    .bdrv_register_buf        = nvme_register_buf,
+    .bdrv_unregister_buf      = nvme_unregister_buf,
 };
 
 static void bdrv_nvme_init(void)
-- 
2.14.3
