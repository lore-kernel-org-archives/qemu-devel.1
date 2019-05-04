Received: from eggs.gnu.org ([209.51.188.92]:44018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuz0-00023S-4L
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hMuyy-0002Mf-Jz
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hMuyy-0002ML-BY
	for qemu-devel@nongnu.org; Sat, 04 May 2019 09:45:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id o4so11331166wra.3
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 06:45:40 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat,  4 May 2019 16:45:29 +0300
Message-Id: <20190504134529.4755-5-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
References: <20190504134529.4755-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 4/4] hw/pvrdma: Add support for SRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com

From: Kamal Heib <kamalheib1@gmail.com>

Implement the pvrdma device commands for supporting SRQ

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Message-Id: <20190403113343.26384-5-kamalheib1@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c    | 147 ++++++++++++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_main.c   |  16 ++++
 hw/rdma/vmw/pvrdma_qp_ops.c |  46 ++++++++++-
 hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
 4 files changed, 209 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index b931bb6dc9..8d70c0d23d 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -609,6 +609,149 @@ static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
     return 0;
 }
 
+static int create_srq_ring(PCIDevice *pci_dev, PvrdmaRing **ring,
+                           uint64_t pdir_dma, uint32_t max_wr,
+                           uint32_t max_sge, uint32_t nchunks)
+{
+    uint64_t *dir = NULL, *tbl = NULL;
+    PvrdmaRing *r;
+    int rc = -EINVAL;
+    char ring_name[MAX_RING_NAME_SZ];
+    uint32_t wqe_sz;
+
+    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
+        rdma_error_report("Got invalid page count for SRQ ring: %d",
+                          nchunks);
+        return rc;
+    }
+
+    dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
+    if (!dir) {
+        rdma_error_report("Failed to map to SRQ page directory");
+        goto out;
+    }
+
+    tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
+    if (!tbl) {
+        rdma_error_report("Failed to map to SRQ page table");
+        goto out;
+    }
+
+    r = g_malloc(sizeof(*r));
+    *ring = r;
+
+    r->ring_state = (struct pvrdma_ring *)
+            rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
+    if (!r->ring_state) {
+        rdma_error_report("Failed to map tp SRQ ring state");
+        goto out_free_ring_mem;
+    }
+
+    wqe_sz = pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
+                      sizeof(struct pvrdma_sge) * max_sge - 1);
+    sprintf(ring_name, "srq_ring_%" PRIx64, pdir_dma);
+    rc = pvrdma_ring_init(r, ring_name, pci_dev, &r->ring_state[1], max_wr,
+                          wqe_sz, (dma_addr_t *)&tbl[1], nchunks - 1);
+    if (rc) {
+        goto out_unmap_ring_state;
+    }
+
+    goto out;
+
+out_unmap_ring_state:
+    rdma_pci_dma_unmap(pci_dev, r->ring_state, TARGET_PAGE_SIZE);
+
+out_free_ring_mem:
+    g_free(r);
+
+out:
+    rdma_pci_dma_unmap(pci_dev, tbl, TARGET_PAGE_SIZE);
+    rdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
+
+    return rc;
+}
+
+static void destroy_srq_ring(PvrdmaRing *ring)
+{
+    pvrdma_ring_free(ring);
+    rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
+    g_free(ring);
+}
+
+static int create_srq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_create_srq *cmd = &req->create_srq;
+    struct pvrdma_cmd_create_srq_resp *resp = &rsp->create_srq_resp;
+    PvrdmaRing *ring = NULL;
+    int rc;
+
+    memset(resp, 0, sizeof(*resp));
+
+    rc = create_srq_ring(PCI_DEVICE(dev), &ring, cmd->pdir_dma,
+                         cmd->attrs.max_wr, cmd->attrs.max_sge,
+                         cmd->nchunks);
+    if (rc) {
+        return rc;
+    }
+
+    rc = rdma_rm_alloc_srq(&dev->rdma_dev_res, cmd->pd_handle,
+                           cmd->attrs.max_wr, cmd->attrs.max_sge,
+                           cmd->attrs.srq_limit, &resp->srqn, ring);
+    if (rc) {
+        destroy_srq_ring(ring);
+        return rc;
+    }
+
+    return 0;
+}
+
+static int query_srq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                     union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_query_srq *cmd = &req->query_srq;
+    struct pvrdma_cmd_query_srq_resp *resp = &rsp->query_srq_resp;
+
+    memset(resp, 0, sizeof(*resp));
+
+    return rdma_rm_query_srq(&dev->rdma_dev_res, cmd->srq_handle,
+                             (struct ibv_srq_attr *)&resp->attrs);
+}
+
+static int modify_srq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                      union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_modify_srq *cmd = &req->modify_srq;
+
+    /* Only support SRQ limit */
+    if (!(cmd->attr_mask & IBV_SRQ_LIMIT) ||
+        (cmd->attr_mask & IBV_SRQ_MAX_WR))
+            return -EINVAL;
+
+    return rdma_rm_modify_srq(&dev->rdma_dev_res, cmd->srq_handle,
+                              (struct ibv_srq_attr *)&cmd->attrs,
+                              cmd->attr_mask);
+}
+
+static int destroy_srq(PVRDMADev *dev, union pvrdma_cmd_req *req,
+                       union pvrdma_cmd_resp *rsp)
+{
+    struct pvrdma_cmd_destroy_srq *cmd = &req->destroy_srq;
+    RdmaRmSRQ *srq;
+    PvrdmaRing *ring;
+
+    srq = rdma_rm_get_srq(&dev->rdma_dev_res, cmd->srq_handle);
+    if (!srq) {
+        return -EINVAL;
+    }
+
+    ring = (PvrdmaRing *)srq->opaque;
+    destroy_srq_ring(ring);
+    rdma_rm_dealloc_srq(&dev->rdma_dev_res, cmd->srq_handle);
+
+    return 0;
+}
+
 struct cmd_handler {
     uint32_t cmd;
     uint32_t ack;
@@ -634,6 +777,10 @@ static struct cmd_handler cmd_handlers[] = {
     {PVRDMA_CMD_DESTROY_UC,   PVRDMA_CMD_DESTROY_UC_RESP_NOOP,   destroy_uc},
     {PVRDMA_CMD_CREATE_BIND,  PVRDMA_CMD_CREATE_BIND_RESP_NOOP,  create_bind},
     {PVRDMA_CMD_DESTROY_BIND, PVRDMA_CMD_DESTROY_BIND_RESP_NOOP, destroy_bind},
+    {PVRDMA_CMD_CREATE_SRQ,   PVRDMA_CMD_CREATE_SRQ_RESP,        create_srq},
+    {PVRDMA_CMD_QUERY_SRQ,    PVRDMA_CMD_QUERY_SRQ_RESP,         query_srq},
+    {PVRDMA_CMD_MODIFY_SRQ,   PVRDMA_CMD_MODIFY_SRQ_RESP,        modify_srq},
+    {PVRDMA_CMD_DESTROY_SRQ,  PVRDMA_CMD_DESTROY_SRQ_RESP,       destroy_srq},
 };
 
 int pvrdma_exec_cmd(PVRDMADev *dev)
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 0b46561bad..769f7990f8 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -53,6 +53,7 @@ static Property pvrdma_dev_properties[] = {
     DEFINE_PROP_INT32("dev-caps-max-qp-init-rd-atom", PVRDMADev,
                       dev_attr.max_qp_init_rd_atom, MAX_QP_INIT_RD_ATOM),
     DEFINE_PROP_INT32("dev-caps-max-ah", PVRDMADev, dev_attr.max_ah, MAX_AH),
+    DEFINE_PROP_INT32("dev-caps-max-srq", PVRDMADev, dev_attr.max_srq, MAX_SRQ),
     DEFINE_PROP_CHR("mad-chardev", PVRDMADev, mad_chr),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -261,6 +262,9 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     dsr->caps.max_mr = dev->dev_attr.max_mr;
     dsr->caps.max_pd = dev->dev_attr.max_pd;
     dsr->caps.max_ah = dev->dev_attr.max_ah;
+    dsr->caps.max_srq = dev->dev_attr.max_srq;
+    dsr->caps.max_srq_wr = dev->dev_attr.max_srq_wr;
+    dsr->caps.max_srq_sge = dev->dev_attr.max_srq_sge;
     dsr->caps.gid_tbl_len = MAX_GIDS;
     dsr->caps.sys_image_guid = 0;
     dsr->caps.node_guid = dev->node_guid;
@@ -485,6 +489,13 @@ static void pvrdma_uar_write(void *opaque, hwaddr addr, uint64_t val,
             pvrdma_cq_poll(&dev->rdma_dev_res, val & PVRDMA_UAR_HANDLE_MASK);
         }
         break;
+    case PVRDMA_UAR_SRQ_OFFSET:
+        if (val & PVRDMA_UAR_SRQ_RECV) {
+            trace_pvrdma_uar_write(addr, val, "QP", "SRQ",
+                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
+            pvrdma_srq_recv(dev, val & PVRDMA_UAR_HANDLE_MASK);
+        }
+        break;
     default:
         rdma_error_report("Unsupported command, addr=0x%"PRIx64", val=0x%"PRIx64,
                           addr, val);
@@ -554,6 +565,11 @@ static void init_dev_caps(PVRDMADev *dev)
 
     dev->dev_attr.max_cqe = pg_tbl_bytes / sizeof(struct pvrdma_cqe) -
                             TARGET_PAGE_SIZE; /* First page is ring state */
+
+    dev->dev_attr.max_srq_wr = pg_tbl_bytes /
+                                ((sizeof(struct pvrdma_rq_wqe_hdr) +
+                                sizeof(struct pvrdma_sge)) *
+                                dev->dev_attr.max_sge) - TARGET_PAGE_SIZE;
 }
 
 static int pvrdma_check_ram_shared(Object *obj, void *opaque)
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 5b9786efbe..bd6db858de 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -70,7 +70,7 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
 
     memset(cqe1, 0, sizeof(*cqe1));
     cqe1->wr_id = cqe->wr_id;
-    cqe1->qp = cqe->qp;
+    cqe1->qp = cqe->qp ? cqe->qp : wc->qp_num;
     cqe1->opcode = cqe->opcode;
     cqe1->status = wc->status;
     cqe1->byte_len = wc->byte_len;
@@ -241,6 +241,50 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
     }
 }
 
+void pvrdma_srq_recv(PVRDMADev *dev, uint32_t srq_handle)
+{
+    RdmaRmSRQ *srq;
+    PvrdmaRqWqe *wqe;
+    PvrdmaRing *ring;
+
+    srq = rdma_rm_get_srq(&dev->rdma_dev_res, srq_handle);
+    if (unlikely(!srq)) {
+        return;
+    }
+
+    ring = (PvrdmaRing *)srq->opaque;
+
+    wqe = (struct PvrdmaRqWqe *)pvrdma_ring_next_elem_read(ring);
+    while (wqe) {
+        CompHandlerCtx *comp_ctx;
+
+        /* Prepare CQE */
+        comp_ctx = g_malloc(sizeof(CompHandlerCtx));
+        comp_ctx->dev = dev;
+        comp_ctx->cq_handle = srq->recv_cq_handle;
+        comp_ctx->cqe.wr_id = wqe->hdr.wr_id;
+        comp_ctx->cqe.qp = 0;
+        comp_ctx->cqe.opcode = IBV_WC_RECV;
+
+        if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
+            rdma_error_report("Invalid num_sge=%d (max %d)", wqe->hdr.num_sge,
+                              dev->dev_attr.max_sge);
+            complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
+            continue;
+        }
+
+        rdma_backend_post_srq_recv(&dev->backend_dev, &srq->backend_srq,
+                                   (struct ibv_sge *)&wqe->sge[0],
+                                   wqe->hdr.num_sge,
+                                   comp_ctx);
+
+        pvrdma_ring_read_inc(ring);
+
+        wqe = pvrdma_ring_next_elem_read(ring);
+    }
+
+}
+
 void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
 {
     RdmaRmCQ *cq;
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
index 31cb48ba29..82e720a76f 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.h
+++ b/hw/rdma/vmw/pvrdma_qp_ops.h
@@ -22,6 +22,7 @@ int pvrdma_qp_ops_init(void);
 void pvrdma_qp_ops_fini(void);
 void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle);
 void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle);
+void pvrdma_srq_recv(PVRDMADev *dev, uint32_t srq_handle);
 void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle);
 
 #endif
-- 
2.17.1
