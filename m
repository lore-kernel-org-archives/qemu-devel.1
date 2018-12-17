Received: from eggs.gnu.org ([2001:4830:134:3::10]:35073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvj-00062r-LI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvg-0002UA-7Y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvf-0002T9-Tw
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:48 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:34 +0200
Message-Id: <20181217184540.4571-18-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 17/23] hw/pvrdma: Fill error code in
 command's response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Driver checks error code let's set it.
In addition, for code simplification purposes, set response's fields
ack, response and err outside of the scope of command handlers.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_cmd.c | 199 ++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 108 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 0d3c818c20..3b94545761 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -128,6 +128,9 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_port_attr attrs = {0};
 
     pr_dbg("port=%d\n", cmd->port_num);
+    if (cmd->port_num > MAX_PORTS) {
+        return -EINVAL;
+    }
 
     if (rdma_backend_query_port(&dev->backend_dev,
                                 (struct ibv_port_attr *)&attrs)) {
@@ -135,9 +138,6 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
     }
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_QUERY_PORT_RESP;
-    resp->hdr.err = 0;
 
     resp->attrs.state = dev->func0->device_active ? attrs.state :
                                                     PVRDMA_PORT_DOWN;
@@ -160,12 +160,16 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_query_pkey_resp *resp = &rsp->query_pkey_resp;
 
     pr_dbg("port=%d\n", cmd->port_num);
+    if (cmd->port_num > MAX_PORTS) {
+        return -EINVAL;
+    }
+
     pr_dbg("index=%d\n", cmd->index);
+    if (cmd->index > MAX_PKEYS) {
+        return -EINVAL;
+    }
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_QUERY_PKEY_RESP;
-    resp->hdr.err = 0;
 
     resp->pkey = PVRDMA_PKEY;
     pr_dbg("pkey=0x%x\n", resp->pkey);
@@ -178,17 +182,15 @@ static int create_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_create_pd *cmd = &req->create_pd;
     struct pvrdma_cmd_create_pd_resp *resp = &rsp->create_pd_resp;
+    int rc;
 
     pr_dbg("context=0x%x\n", cmd->ctx_handle ? cmd->ctx_handle : 0);
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_CREATE_PD_RESP;
-    resp->hdr.err = rdma_rm_alloc_pd(&dev->rdma_dev_res, &dev->backend_dev,
-                                     &resp->pd_handle, cmd->ctx_handle);
+    rc = rdma_rm_alloc_pd(&dev->rdma_dev_res, &dev->backend_dev,
+                          &resp->pd_handle, cmd->ctx_handle);
 
-    pr_dbg("ret=%d\n", resp->hdr.err);
-    return resp->hdr.err;
+    return rc;
 }
 
 static int destroy_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -210,10 +212,9 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_create_mr_resp *resp = &rsp->create_mr_resp;
     PCIDevice *pci_dev = PCI_DEVICE(dev);
     void *host_virt = NULL;
+    int rc = 0;
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_CREATE_MR_RESP;
 
     pr_dbg("pd_handle=%d\n", cmd->pd_handle);
     pr_dbg("access_flags=0x%x\n", cmd->access_flags);
@@ -224,22 +225,18 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
                                        cmd->length);
         if (!host_virt) {
             pr_dbg("Failed to map to pdir\n");
-            resp->hdr.err = -EINVAL;
-            goto out;
+            return -EINVAL;
         }
     }
 
-    resp->hdr.err = rdma_rm_alloc_mr(&dev->rdma_dev_res, cmd->pd_handle,
-                                     cmd->start, cmd->length, host_virt,
-                                     cmd->access_flags, &resp->mr_handle,
-                                     &resp->lkey, &resp->rkey);
-    if (resp->hdr.err && host_virt) {
+    rc = rdma_rm_alloc_mr(&dev->rdma_dev_res, cmd->pd_handle, cmd->start,
+                          cmd->length, host_virt, cmd->access_flags,
+                          &resp->mr_handle, &resp->lkey, &resp->rkey);
+    if (rc && host_virt) {
         munmap(host_virt, cmd->length);
     }
 
-out:
-    pr_dbg("ret=%d\n", resp->hdr.err);
-    return resp->hdr.err;
+    return rc;
 }
 
 static int destroy_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -317,28 +314,25 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_create_cq *cmd = &req->create_cq;
     struct pvrdma_cmd_create_cq_resp *resp = &rsp->create_cq_resp;
     PvrdmaRing *ring = NULL;
+    int rc;
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_CREATE_CQ_RESP;
 
     resp->cqe = cmd->cqe;
 
-    resp->hdr.err = create_cq_ring(PCI_DEVICE(dev), &ring, cmd->pdir_dma,
-                                   cmd->nchunks, cmd->cqe);
-    if (resp->hdr.err) {
-        goto out;
+    rc = create_cq_ring(PCI_DEVICE(dev), &ring, cmd->pdir_dma, cmd->nchunks,
+                        cmd->cqe);
+    if (rc) {
+        return rc;
     }
 
     pr_dbg("ring=%p\n", ring);
 
-    resp->hdr.err = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev,
-                                     cmd->cqe, &resp->cq_handle, ring);
+    rc = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev, cmd->cqe,
+                          &resp->cq_handle, ring);
     resp->cqe = cmd->cqe;
 
-out:
-    pr_dbg("ret=%d\n", resp->hdr.err);
-    return resp->hdr.err;
+    return rc;
 }
 
 static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -458,30 +452,31 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_create_qp *cmd = &req->create_qp;
     struct pvrdma_cmd_create_qp_resp *resp = &rsp->create_qp_resp;
     PvrdmaRing *rings = NULL;
+    int rc;
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_CREATE_QP_RESP;
 
     pr_dbg("total_chunks=%d\n", cmd->total_chunks);
     pr_dbg("send_chunks=%d\n", cmd->send_chunks);
 
-    resp->hdr.err = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
-                                    cmd->max_send_wr, cmd->max_send_sge,
-                                    cmd->send_chunks, cmd->max_recv_wr,
-                                    cmd->max_recv_sge, cmd->total_chunks -
-                                    cmd->send_chunks - 1);
-    if (resp->hdr.err) {
-        goto out;
+    rc = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
+                         cmd->max_send_wr, cmd->max_send_sge, cmd->send_chunks,
+                         cmd->max_recv_wr, cmd->max_recv_sge,
+                         cmd->total_chunks - cmd->send_chunks - 1);
+    if (rc) {
+        return rc;
     }
 
     pr_dbg("rings=%p\n", rings);
 
-    resp->hdr.err = rdma_rm_alloc_qp(&dev->rdma_dev_res, cmd->pd_handle,
-                                     cmd->qp_type, cmd->max_send_wr,
-                                     cmd->max_send_sge, cmd->send_cq_handle,
-                                     cmd->max_recv_wr, cmd->max_recv_sge,
-                                     cmd->recv_cq_handle, rings, &resp->qpn);
+    rc = rdma_rm_alloc_qp(&dev->rdma_dev_res, cmd->pd_handle, cmd->qp_type,
+                          cmd->max_send_wr, cmd->max_send_sge,
+                          cmd->send_cq_handle, cmd->max_recv_wr,
+                          cmd->max_recv_sge, cmd->recv_cq_handle, rings,
+                          &resp->qpn);
+    if (rc) {
+        return rc;
+    }
 
     resp->max_send_wr = cmd->max_send_wr;
     resp->max_recv_wr = cmd->max_recv_wr;
@@ -489,35 +484,31 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     resp->max_recv_sge = cmd->max_recv_sge;
     resp->max_inline_data = cmd->max_inline_data;
 
-out:
-    pr_dbg("ret=%d\n", resp->hdr.err);
-    return resp->hdr.err;
+    return 0;
 }
 
 static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
                      union pvrdma_cmd_resp *rsp)
 {
     struct pvrdma_cmd_modify_qp *cmd = &req->modify_qp;
+    int rc;
 
     pr_dbg("qp_handle=%d\n", cmd->qp_handle);
 
     memset(rsp, 0, sizeof(*rsp));
-    rsp->hdr.response = cmd->hdr.response;
-    rsp->hdr.ack = PVRDMA_CMD_MODIFY_QP_RESP;
 
     /* No need to verify sgid_index since it is u8 */
 
-    rsp->hdr.err =
-        rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev, cmd->qp_handle,
-                          cmd->attr_mask, cmd->attrs.ah_attr.grh.sgid_index,
-                          (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
-                          cmd->attrs.dest_qp_num,
-                          (enum ibv_qp_state)cmd->attrs.qp_state,
-                          cmd->attrs.qkey, cmd->attrs.rq_psn,
-                          cmd->attrs.sq_psn);
-
-    pr_dbg("ret=%d\n", rsp->hdr.err);
-    return rsp->hdr.err;
+    rc = rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev,
+                           cmd->qp_handle, cmd->attr_mask,
+                           cmd->attrs.ah_attr.grh.sgid_index,
+                           (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
+                           cmd->attrs.dest_qp_num,
+                           (enum ibv_qp_state)cmd->attrs.qp_state,
+                           cmd->attrs.qkey, cmd->attrs.rq_psn,
+                           cmd->attrs.sq_psn);
+
+    return rc;
 }
 
 static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -526,21 +517,18 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     struct pvrdma_cmd_query_qp *cmd = &req->query_qp;
     struct pvrdma_cmd_query_qp_resp *resp = &rsp->query_qp_resp;
     struct ibv_qp_init_attr init_attr;
+    int rc;
 
     pr_dbg("qp_handle=%d\n", cmd->qp_handle);
     pr_dbg("attr_mask=0x%x\n", cmd->attr_mask);
 
     memset(rsp, 0, sizeof(*rsp));
-    rsp->hdr.response = cmd->hdr.response;
-    rsp->hdr.ack = PVRDMA_CMD_QUERY_QP_RESP;
 
-    rsp->hdr.err = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev,
-                                    cmd->qp_handle,
-                                    (struct ibv_qp_attr *)&resp->attrs,
-                                    cmd->attr_mask, &init_attr);
+    rc = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev, cmd->qp_handle,
+                          (struct ibv_qp_attr *)&resp->attrs, cmd->attr_mask,
+                          &init_attr);
 
-    pr_dbg("ret=%d\n", rsp->hdr.err);
-    return rsp->hdr.err;
+    return rc;
 }
 
 static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -589,11 +577,8 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     rc = rdma_rm_add_gid(&dev->rdma_dev_res, &dev->backend_dev,
                          dev->backend_eth_device_name, gid, cmd->index);
-    if (rc < 0) {
-        return -EINVAL;
-    }
 
-    return 0;
+    return rc;
 }
 
 static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -612,12 +597,7 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
     rc = rdma_rm_del_gid(&dev->rdma_dev_res, &dev->backend_dev,
                         dev->backend_eth_device_name, cmd->index);
 
-    if (rc < 0) {
-        rsp->hdr.err = rc;
-        goto out;
-    }
-
-    return 0;
+    return rc;
 }
 
 static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -625,18 +605,14 @@ static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_create_uc *cmd = &req->create_uc;
     struct pvrdma_cmd_create_uc_resp *resp = &rsp->create_uc_resp;
+    int rc;
 
     pr_dbg("pfn=%d\n", cmd->pfn);
 
     memset(resp, 0, sizeof(*resp));
-    resp->hdr.response = cmd->hdr.response;
-    resp->hdr.ack = PVRDMA_CMD_CREATE_UC_RESP;
-    resp->hdr.err = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn,
-                                     &resp->ctx_handle);
+    rc = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn, &resp->ctx_handle);
 
-    pr_dbg("ret=%d\n", resp->hdr.err);
-
-    return 0;
+    return rc;
 }
 
 static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
@@ -650,30 +626,32 @@ static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
 
     return 0;
 }
+
 struct cmd_handler {
     uint32_t cmd;
+    uint32_t ack;
     int (*exec)(PVRDMADev *dev, union pvrdma_cmd_req *req,
             union pvrdma_cmd_resp *rsp);
 };
 
 static struct cmd_handler cmd_handlers[] = {
-    {PVRDMA_CMD_QUERY_PORT, query_port},
-    {PVRDMA_CMD_QUERY_PKEY, query_pkey},
-    {PVRDMA_CMD_CREATE_PD, create_pd},
-    {PVRDMA_CMD_DESTROY_PD, destroy_pd},
-    {PVRDMA_CMD_CREATE_MR, create_mr},
-    {PVRDMA_CMD_DESTROY_MR, destroy_mr},
-    {PVRDMA_CMD_CREATE_CQ, create_cq},
-    {PVRDMA_CMD_RESIZE_CQ, NULL},
-    {PVRDMA_CMD_DESTROY_CQ, destroy_cq},
-    {PVRDMA_CMD_CREATE_QP, create_qp},
-    {PVRDMA_CMD_MODIFY_QP, modify_qp},
-    {PVRDMA_CMD_QUERY_QP, query_qp},
-    {PVRDMA_CMD_DESTROY_QP, destroy_qp},
-    {PVRDMA_CMD_CREATE_UC, create_uc},
-    {PVRDMA_CMD_DESTROY_UC, destroy_uc},
-    {PVRDMA_CMD_CREATE_BIND, create_bind},
-    {PVRDMA_CMD_DESTROY_BIND, destroy_bind},
+    {PVRDMA_CMD_QUERY_PORT,   PVRDMA_CMD_QUERY_PORT_RESP,        query_port},
+    {PVRDMA_CMD_QUERY_PKEY,   PVRDMA_CMD_QUERY_PKEY_RESP,        query_pkey},
+    {PVRDMA_CMD_CREATE_PD,    PVRDMA_CMD_CREATE_PD_RESP,         create_pd},
+    {PVRDMA_CMD_DESTROY_PD,   PVRDMA_CMD_DESTROY_PD_RESP_NOOP,   destroy_pd},
+    {PVRDMA_CMD_CREATE_MR,    PVRDMA_CMD_CREATE_MR_RESP,         create_mr},
+    {PVRDMA_CMD_DESTROY_MR,   PVRDMA_CMD_DESTROY_MR_RESP_NOOP,   destroy_mr},
+    {PVRDMA_CMD_CREATE_CQ,    PVRDMA_CMD_CREATE_CQ_RESP,         create_cq},
+    {PVRDMA_CMD_RESIZE_CQ,    PVRDMA_CMD_RESIZE_CQ_RESP,         NULL},
+    {PVRDMA_CMD_DESTROY_CQ,   PVRDMA_CMD_DESTROY_CQ_RESP_NOOP,   destroy_cq},
+    {PVRDMA_CMD_CREATE_QP,    PVRDMA_CMD_CREATE_QP_RESP,         create_qp},
+    {PVRDMA_CMD_MODIFY_QP,    PVRDMA_CMD_MODIFY_QP_RESP,         modify_qp},
+    {PVRDMA_CMD_QUERY_QP,     PVRDMA_CMD_QUERY_QP_RESP,          query_qp},
+    {PVRDMA_CMD_DESTROY_QP,   PVRDMA_CMD_DESTROY_QP_RESP,        destroy_qp},
+    {PVRDMA_CMD_CREATE_UC,    PVRDMA_CMD_CREATE_UC_RESP,         create_uc},
+    {PVRDMA_CMD_DESTROY_UC,   PVRDMA_CMD_DESTROY_UC_RESP_NOOP,   destroy_uc},
+    {PVRDMA_CMD_CREATE_BIND,  PVRDMA_CMD_CREATE_BIND_RESP_NOOP,  create_bind},
+    {PVRDMA_CMD_DESTROY_BIND, PVRDMA_CMD_DESTROY_BIND_RESP_NOOP, destroy_bind},
 };
 
 int execute_command(PVRDMADev *dev)
@@ -696,7 +674,12 @@ int execute_command(PVRDMADev *dev)
     }
 
     err = cmd_handlers[dsr_info->req->hdr.cmd].exec(dev, dsr_info->req,
-                            dsr_info->rsp);
+                                                    dsr_info->rsp);
+    dsr_info->rsp->hdr.response = dsr_info->req->hdr.response;
+    dsr_info->rsp->hdr.ack = cmd_handlers[dsr_info->req->hdr.cmd].ack;
+    dsr_info->rsp->hdr.err = err < 0 ? -err : 0;
+    pr_dbg("rsp->hdr.err=%d\n", dsr_info->rsp->hdr.err);
+
 out:
     set_reg_val(dev, PVRDMA_REG_ERR, err);
     post_interrupt(dev, INTR_VEC_CMD_RING);
-- 
2.17.2
