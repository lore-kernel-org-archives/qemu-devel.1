Received: from eggs.gnu.org ([2001:4830:134:3::10]:41742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbp5-0006G8-Ci
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbp4-0004UW-FT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejbp4-0004UI-Aq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:26 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  8 Feb 2018 10:19:48 +0800
Message-Id: <20180208021953.7354-12-famz@redhat.com>
In-Reply-To: <20180208021953.7354-1-famz@redhat.com>
References: <20180208021953.7354-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 11/16] block/nvme: Implement
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180116060901.17413-6-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 0bae185b88..a487b4d381 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1147,6 +1147,27 @@ static void nvme_aio_unplug(BlockDriverState *bs)
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
@@ -1172,6 +1193,9 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_io_plug             = nvme_aio_plug,
     .bdrv_io_unplug           = nvme_aio_unplug,
+
+    .bdrv_register_buf        = nvme_register_buf,
+    .bdrv_unregister_buf      = nvme_unregister_buf,
 };
 
 static void bdrv_nvme_init(void)
-- 
2.14.3
