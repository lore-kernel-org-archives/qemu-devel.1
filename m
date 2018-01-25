Received: from eggs.gnu.org ([2001:4830:134:3::10]:59378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNZ-0006tb-4a
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNY-0007fo-7Q
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eeaNY-0007dw-2n
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:16 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 25 Jan 2018 13:46:44 +0800
Message-Id: <20180125054648.18747-11-famz@redhat.com>
In-Reply-To: <20180125054648.18747-1-famz@redhat.com>
References: <20180125054648.18747-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] block/nvme: Implement
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
Cc: Peter Maydell <peter.maydell@linaro.org>

Forward these two calls to the IOVA manager.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180110091846.10699-6-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180116060901.17413-6-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 99cc7702ad..30616f50c7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1145,6 +1145,27 @@ static void nvme_aio_unplug(BlockDriverState *bs)
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
@@ -1170,6 +1191,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_io_plug             = nvme_aio_plug,
     .bdrv_io_unplug           = nvme_aio_unplug,
+
+    .bdrv_register_buf        = nvme_register_buf,
+    .bdrv_unregister_buf      = nvme_unregister_buf,
 };
 
 static void bdrv_nvme_init(void)
-- 
2.14.3
