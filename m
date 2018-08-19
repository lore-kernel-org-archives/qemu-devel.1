Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYr-0000Cv-45
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYp-0000jm-Bx
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:33 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYl-0000h8-Ns
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:29 -0400
Received: by mail-wm0-x243.google.com with SMTP id o11-v6so14084851wmh.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:25 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:57 +0300
Message-Id: <20180819202300.10590-13-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 12/15] hw/rdma: Bugfix - Support
 non-aligned buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

From: Yuval Shaia <yuval.shaia@oracle.com>

RDMA application can provide non-aligned buffers to be registered. In
such case the DMA address passed by driver is pointing to the beginning
of the physical address of the mapped page so we can't distinguish
between two addresses from the same page.

Fix it by keeping the offset of the virtual address in mr->virt.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-13-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c        | 2 ++
 hw/rdma/vmw/pvrdma_cmd.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 859c900003..8d59a42cd1 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -166,6 +166,7 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         mr->virt = host_virt;
         mr->start = guest_start;
         mr->length = guest_length;
+        mr->virt += (mr->start & (TARGET_PAGE_SIZE - 1));
 
         ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
                                      mr->length, access_flags);
@@ -203,6 +204,7 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
         rdma_backend_destroy_mr(&mr->backend_mr);
         pr_dbg("start=0x%" PRIx64 "\n", mr->start);
         if (mr->start) {
+            mr->virt -= (mr->start & (TARGET_PAGE_SIZE - 1));
             munmap(mr->virt, mr->length);
         }
         res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 4f74b29936..b74b0b48d0 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -59,6 +59,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
     }
 
     host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
+    pr_dbg("mremap %p -> %p\n", curr_page, host_virt);
     if (host_virt == MAP_FAILED) {
         host_virt = NULL;
         error_report("PVRDMA: Failed to remap memory for host_virt");
-- 
2.17.1
