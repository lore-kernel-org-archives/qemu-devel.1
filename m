Received: from eggs.gnu.org ([209.51.188.92]:46112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsJ-000323-FD
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghbsG-0007O9-Fd
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:04:03 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 10 Jan 2019 17:03:38 +0200
Message-Id: <9741b3d123b583ce0abc9f29c9c0abcc89a6aa79.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
References: <cover.1547132561.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 4/6] block: Acquire the AioContext in
 nvme_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7c8c63e8f5..72e94aff86 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1203,6 +1203,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
     NvmeIdCtrl *id = &n->id_ctrl;
+    AioContext *ctx;
 
     int i;
     int64_t bs_size;
@@ -1213,20 +1214,23 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
+    ctx = blk_get_aio_context(n->conf.blk);
+    aio_context_acquire(ctx);
+
     bs_size = blk_getlength(n->conf.blk);
     if (bs_size < 0) {
         error_setg(errp, "could not get backing file size");
-        return;
+        goto out;
     }
 
     if (!n->serial) {
         error_setg(errp, "serial property not set");
-        return;
+        goto out;
     }
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                        false, errp)) {
-        return;
+        goto out;
     }
 
     pci_conf = pci_dev->config;
@@ -1323,6 +1327,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
             cpu_to_le64(n->ns_size >>
                 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
     }
+
+out:
+    aio_context_release(ctx);
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
-- 
2.11.0
