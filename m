Received: from eggs.gnu.org ([2001:4830:134:3::10]:38321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyl0w-0005y6-B2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyl0v-000253-Af
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:11:18 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 21 Mar 2018 23:10:54 +0200
Message-Id: <20180321211056.3339-2-yuval.shaia@oracle.com>
In-Reply-To: <20180321211056.3339-1-yuval.shaia@oracle.com>
References: <20180321211056.3339-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 1/3] hw/rdma: Change host_virt to void *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

To avoid compilation warnings on 32-bit machines:
rdma_backend.c: In function 'rdma_backend_create_mr':
rdma_backend.c:409:37: error: cast to pointer from integer of different
size [-Werror=int-to-pointer-cast]
	mr->ibmr = ibv_reg_mr(pd->ibpd, (void *)addr, length, access);

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c |  8 ++++----
 hw/rdma/rdma_backend.h |  2 +-
 hw/rdma/rdma_rm.c      | 10 +++++-----
 hw/rdma/rdma_rm_defs.h |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index e306fba534..f1a37ba4a2 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -222,7 +222,7 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
             return VENDOR_ERR_INVLKEY | ssge[ssge_idx].lkey;
         }
 
-        dsge->addr = mr->user_mr.host_virt + ssge[ssge_idx].addr -
+        dsge->addr = (uintptr_t)mr->user_mr.host_virt + ssge[ssge_idx].addr -
                      mr->user_mr.guest_start;
         dsge->length = ssge[ssge_idx].length;
         dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
@@ -401,12 +401,12 @@ void rdma_backend_destroy_pd(RdmaBackendPD *pd)
     }
 }
 
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, uint64_t addr,
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access)
 {
-    pr_dbg("addr=0x%lx\n", addr);
+    pr_dbg("addr=0x%p\n", addr);
     pr_dbg("len=%ld\n", length);
-    mr->ibmr = ibv_reg_mr(pd->ibpd, (void *)addr, length, access);
+    mr->ibmr = ibv_reg_mr(pd->ibpd, addr, length, access);
     if (mr->ibmr) {
         pr_dbg("lkey=0x%x\n", mr->ibmr->lkey);
         pr_dbg("rkey=0x%x\n", mr->ibmr->rkey);
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 68f2b05ca7..07f6fed768 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -61,7 +61,7 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
 int rdma_backend_create_pd(RdmaBackendDev *backend_dev, RdmaBackendPD *pd);
 void rdma_backend_destroy_pd(RdmaBackendPD *pd);
 
-int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, uint64_t addr,
+int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBackendPD *pd, void *addr,
                            size_t length, int access);
 void rdma_backend_destroy_mr(RdmaBackendMR *mr);
 
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index b5fc45ddab..296e40518e 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -146,7 +146,7 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
     RdmaRmMR *mr;
     int ret = 0;
     RdmaRmPD *pd;
-    uint64_t addr;
+    void *addr;
     size_t length;
 
     pd = rdma_rm_get_pd(dev_res, pd_handle);
@@ -165,10 +165,10 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
         /* TODO: This is my guess but not so sure that this needs to be
          * done */
         length = TARGET_PAGE_SIZE;
-        addr = (uint64_t)g_malloc(length);
+        addr = g_malloc(length);
     } else {
-        mr->user_mr.host_virt = (uint64_t) host_virt;
-        pr_dbg("host_virt=0x%lx\n", mr->user_mr.host_virt);
+        mr->user_mr.host_virt = host_virt;
+        pr_dbg("host_virt=0x%p\n", mr->user_mr.host_virt);
         mr->user_mr.length = guest_length;
         pr_dbg("length=0x%lx\n", guest_length);
         mr->user_mr.guest_start = guest_start;
@@ -216,7 +216,7 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
 
     if (mr) {
         rdma_backend_destroy_mr(&mr->backend_mr);
-        munmap((void *)mr->user_mr.host_virt, mr->user_mr.length);
+        munmap(mr->user_mr.host_virt, mr->user_mr.length);
         res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
     }
 }
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 6522dca68f..fc646da61f 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -56,7 +56,7 @@ typedef struct RdmaRmCQ {
 } RdmaRmCQ;
 
 typedef struct RdmaRmUserMR {
-    uint64_t host_virt;
+    void *host_virt;
     uint64_t guest_start;
     size_t length;
 } RdmaRmUserMR;
-- 
2.13.6
