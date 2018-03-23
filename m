Received: from eggs.gnu.org ([2001:4830:134:3::10]:36106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0X-0000Hj-Bi
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ezP0V-0007vS-Hu
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ezP0V-0007us-Bb
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:53:31 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Fri, 23 Mar 2018 18:53:06 +0300
Message-Id: <20180323155306.83812-9-marcel@redhat.com>
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [PATCH PULL 8/8] hw/rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com, mst@redhat.com, marcel@redhat.com, f4bug@amsat.org, eblake@redhat.com, berrange@redhat.com, stefanha@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

Use the correct printf formats, so that a 32-bit compile doesn't spit
out lots of warnings about %lx being incompatible with uint64_t.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180322095220.9976-4-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/rdma_backend.c        | 21 +++++++++++----------
 hw/rdma/rdma_rm.c             |  4 ++--
 hw/rdma/rdma_utils.c          |  6 +++---
 hw/rdma/vmw/pvrdma_cmd.c      |  8 ++++----
 hw/rdma/vmw/pvrdma_dev_ring.c |  6 +++---
 hw/rdma/vmw/pvrdma_dev_ring.h |  2 +-
 hw/rdma/vmw/pvrdma_main.c     | 25 +++++++++++++------------
 hw/rdma/vmw/pvrdma_qp_ops.c   |  6 +++---
 8 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 1dbb17bd2e..5c7b3d8949 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -62,12 +62,13 @@ static void poll_cq(RdmaDeviceResources *rdma_dev_res=
, struct ibv_cq *ibcq)
         pr_dbg("Got %d completion(s) from cq %p\n", ne, ibcq);
=20
         for (i =3D 0; i < ne; i++) {
-            pr_dbg("wr_id=3D0x%lx\n", wc[i].wr_id);
+            pr_dbg("wr_id=3D0x%" PRIx64 "\n", wc[i].wr_id);
             pr_dbg("status=3D%d\n", wc[i].status);
=20
             bctx =3D rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
             if (unlikely(!bctx)) {
-                pr_dbg("Error: Failed to find ctx for req %ld\n", wc[i].=
wr_id);
+                pr_dbg("Error: Failed to find ctx for req %" PRId64 "\n"=
,
+                       wc[i].wr_id);
                 continue;
             }
             pr_dbg("Processing %s CQE\n", bctx->is_tx_req ? "send" : "re=
cv");
@@ -176,7 +177,7 @@ static struct ibv_ah *create_ah(RdmaBackendDev *backe=
nd_dev, struct ibv_pd *pd,
             g_hash_table_insert(ah_hash, ah_key, ah);
         } else {
             g_bytes_unref(ah_key);
-            pr_dbg("ibv_create_ah failed for gid <%lx %lx>\n",
+            pr_dbg("Fail to create AH for gid <0x%" PRIx64 ", 0x%" PRIx6=
4 ">\n",
                     be64_to_cpu(dgid->global.subnet_prefix),
                     be64_to_cpu(dgid->global.interface_id));
         }
@@ -227,8 +228,8 @@ static int build_host_sge_array(RdmaDeviceResources *=
rdma_dev_res,
         dsge->length =3D ssge[ssge_idx].length;
         dsge->lkey =3D rdma_backend_mr_lkey(&mr->backend_mr);
=20
-        pr_dbg("ssge->addr=3D0x%lx\n", (uint64_t)ssge[ssge_idx].addr);
-        pr_dbg("dsge->addr=3D0x%lx\n", dsge->addr);
+        pr_dbg("ssge->addr=3D0x%" PRIx64 "\n", ssge[ssge_idx].addr);
+        pr_dbg("dsge->addr=3D0x%" PRIx64 "\n", dsge->addr);
         pr_dbg("dsge->length=3D%d\n", dsge->length);
         pr_dbg("dsge->lkey=3D0x%x\n", dsge->lkey);
=20
@@ -405,7 +406,7 @@ int rdma_backend_create_mr(RdmaBackendMR *mr, RdmaBac=
kendPD *pd, void *addr,
                            size_t length, int access)
 {
     pr_dbg("addr=3D0x%p\n", addr);
-    pr_dbg("len=3D%ld\n", length);
+    pr_dbg("len=3D%zu\n", length);
     mr->ibmr =3D ibv_reg_mr(pd->ibpd, addr, length, access);
     if (mr->ibmr) {
         pr_dbg("lkey=3D0x%x\n", mr->ibmr->lkey);
@@ -562,7 +563,7 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend=
_dev, RdmaBackendQP *qp,
=20
     switch (qp_type) {
     case IBV_QPT_RC:
-        pr_dbg("dgid=3D0x%lx,%lx\n",
+        pr_dbg("dgid=3D0x%" PRIx64 ",%" PRIx64 "\n",
                be64_to_cpu(ibv_gid.global.subnet_prefix),
                be64_to_cpu(ibv_gid.global.interface_id));
         pr_dbg("dqpn=3D0x%x\n", dqpn);
@@ -681,7 +682,7 @@ static int init_device_caps(RdmaBackendDev *backend_d=
ev,
         return -EIO;
     }
=20
-    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%ld");
+    CHK_ATTR(dev_attr, backend_dev->dev_attr, max_mr_size, "%" PRId64);
     CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp, "%d");
     CHK_ATTR(dev_attr, backend_dev->dev_attr, max_sge, "%d");
     CHK_ATTR(dev_attr, backend_dev->dev_attr, max_qp_wr, "%d");
@@ -794,9 +795,9 @@ int rdma_backend_init(RdmaBackendDev *backend_dev,
         ret =3D -EIO;
         goto out_destroy_comm_channel;
     }
-    pr_dbg("subnet_prefix=3D0x%lx\n",
+    pr_dbg("subnet_prefix=3D0x%" PRIx64 "\n",
            be64_to_cpu(backend_dev->gid.global.subnet_prefix));
-    pr_dbg("interface_id=3D0x%lx\n",
+    pr_dbg("interface_id=3D0x%" PRIx64 "\n",
            be64_to_cpu(backend_dev->gid.global.interface_id));
=20
     snprintf(thread_name, sizeof(thread_name), "rdma_comp_%s",
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index b4938169b6..51a47d7292 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -170,9 +170,9 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, ui=
nt32_t pd_handle,
         mr->user_mr.host_virt =3D host_virt;
         pr_dbg("host_virt=3D0x%p\n", mr->user_mr.host_virt);
         mr->user_mr.length =3D guest_length;
-        pr_dbg("length=3D0x%lx\n", guest_length);
+        pr_dbg("length=3D%zu\n", guest_length);
         mr->user_mr.guest_start =3D guest_start;
-        pr_dbg("guest_start=3D0x%lx\n", mr->user_mr.guest_start);
+        pr_dbg("guest_start=3D0x%" PRIx64 "\n", mr->user_mr.guest_start)=
;
=20
         length =3D mr->user_mr.length;
         addr =3D mr->user_mr.host_virt;
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index 0e5caffd40..d713f635f1 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -27,8 +27,8 @@ void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr,=
 dma_addr_t plen)
=20
     p =3D pci_dma_map(dev, addr, &len, DMA_DIRECTION_TO_DEVICE);
     if (!p) {
-        pr_dbg("Fail in pci_dma_map, addr=3D0x%llx, len=3D%ld\n",
-               (long long unsigned int)addr, len);
+        pr_dbg("Fail in pci_dma_map, addr=3D0x%" PRIx64 ", len=3D%" PRId=
64 "\n",
+               addr, len);
         return NULL;
     }
=20
@@ -37,7 +37,7 @@ void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr,=
 dma_addr_t plen)
         return NULL;
     }
=20
-    pr_dbg("0x%llx -> %p (len=3D%ld)\n", (long long unsigned int)addr, p=
, len);
+    pr_dbg("0x%" PRIx64 " -> %p (len=3D% " PRId64 ")\n", addr, p, len);
=20
     return p;
 }
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 5bd4643f2d..99019d8741 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -85,7 +85,7 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64=
_t pdir_dma,
             }
         }
=20
-        pr_dbg("guest_dma[%d]=3D0x%lx\n", addr_idx, tbl[tbl_idx]);
+        pr_dbg("guest_dma[%d]=3D0x%" PRIx64 "\n", addr_idx, tbl[tbl_idx]=
);
=20
         curr_page =3D rdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
                                      TARGET_PAGE_SIZE);
@@ -285,7 +285,7 @@ static int create_cq_ring(PCIDevice *pci_dev , Pvrdma=
Ring **ring,
         goto out_free_ring;
     }
=20
-    sprintf(ring_name, "cq_ring_%lx", pdir_dma);
+    sprintf(ring_name, "cq_ring_%" PRIx64, pdir_dma);
     rc =3D pvrdma_ring_init(r, ring_name, pci_dev, &r->ring_state[1],
                           cqe, sizeof(struct pvrdma_cqe),
                           /* first page is ring state */
@@ -415,7 +415,7 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64=
_t pdir_dma,
     wqe_sz =3D pow2ceil(sizeof(struct pvrdma_sq_wqe_hdr) +
                       sizeof(struct pvrdma_sge) * smax_sge - 1);
=20
-    sprintf(ring_name, "qp_sring_%lx", pdir_dma);
+    sprintf(ring_name, "qp_sring_%" PRIx64, pdir_dma);
     rc =3D pvrdma_ring_init(sr, ring_name, pci_dev, sr->ring_state,
                           scqe, wqe_sz, (dma_addr_t *)&tbl[1], spages);
     if (rc) {
@@ -426,7 +426,7 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64=
_t pdir_dma,
     rr->ring_state =3D &sr->ring_state[1];
     wqe_sz =3D pow2ceil(sizeof(struct pvrdma_rq_wqe_hdr) +
                       sizeof(struct pvrdma_sge) * rmax_sge - 1);
-    sprintf(ring_name, "qp_rring_%lx", pdir_dma);
+    sprintf(ring_name, "qp_rring_%" PRIx64, pdir_dma);
     rc =3D pvrdma_ring_init(rr, ring_name, pci_dev, rr->ring_state,
                           rcqe, wqe_sz, (dma_addr_t *)&tbl[1 + spages], =
rpages);
     if (rc) {
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.=
c
index ff19a9ea16..01247fc041 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -23,7 +23,7 @@
=20
 int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
                      struct pvrdma_ring *ring_state, uint32_t max_elems,
-                     size_t elem_sz, dma_addr_t *tbl, dma_addr_t npages)
+                     size_t elem_sz, dma_addr_t *tbl, uint32_t npages)
 {
     int i;
     int rc =3D 0;
@@ -35,8 +35,8 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name=
, PCIDevice *dev,
     ring->ring_state =3D ring_state;
     ring->max_elems =3D max_elems;
     ring->elem_sz =3D elem_sz;
-    pr_dbg("ring->elem_sz=3D%ld\n", ring->elem_sz);
-    pr_dbg("npages=3D%ld\n", npages);
+    pr_dbg("ring->elem_sz=3D%zu\n", ring->elem_sz);
+    pr_dbg("npages=3D%d\n", npages);
     /* TODO: Give a moment to think if we want to redo driver settings
     atomic_set(&ring->ring_state->prod_tail, 0);
     atomic_set(&ring->ring_state->cons_head, 0);
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.=
h
index 2d0461f367..411d244603 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.h
+++ b/hw/rdma/vmw/pvrdma_dev_ring.h
@@ -32,7 +32,7 @@ typedef struct PvrdmaRing {
=20
 int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
                      struct pvrdma_ring *ring_state, uint32_t max_elems,
-                     size_t elem_sz, dma_addr_t *tbl, dma_addr_t npages)=
;
+                     size_t elem_sz, dma_addr_t *tbl, uint32_t npages);
 void *pvrdma_ring_next_elem_read(PvrdmaRing *ring);
 void pvrdma_ring_read_inc(PvrdmaRing *ring);
 void *pvrdma_ring_next_elem_write(PvrdmaRing *ring);
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 44de6a4a29..c552248c90 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -236,7 +236,7 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     dsr =3D dev->dsr_info.dsr;
=20
     dsr->caps.fw_ver =3D PVRDMA_FW_VERSION;
-    pr_dbg("fw_ver=3D0x%lx\n", dsr->caps.fw_ver);
+    pr_dbg("fw_ver=3D0x%" PRIx64 "\n", dsr->caps.fw_ver);
=20
     dsr->caps.mode =3D PVRDMA_DEVICE_MODE_ROCE;
     pr_dbg("mode=3D%d\n", dsr->caps.mode);
@@ -261,11 +261,10 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     pr_dbg("gid_tbl_len=3D%d\n", dsr->caps.gid_tbl_len);
=20
     dsr->caps.sys_image_guid =3D 0;
-    pr_dbg("sys_image_guid=3D%lx\n", dsr->caps.sys_image_guid);
+    pr_dbg("sys_image_guid=3D%" PRIx64 "\n", dsr->caps.sys_image_guid);
=20
     dsr->caps.node_guid =3D cpu_to_be64(dev->node_guid);
-    pr_dbg("node_guid=3D%llx\n",
-           (long long unsigned int)be64_to_cpu(dsr->caps.node_guid));
+    pr_dbg("node_guid=3D%" PRIx64 "\n", be64_to_cpu(dsr->caps.node_guid)=
);
=20
     dsr->caps.phys_port_cnt =3D MAX_PORTS;
     pr_dbg("phys_port_cnt=3D%d\n", dsr->caps.phys_port_cnt);
@@ -343,8 +342,8 @@ static void regs_write(void *opaque, hwaddr addr, uin=
t64_t val, unsigned size)
     /* pr_dbg("addr=3D0x%lx, val=3D0x%x, size=3D%d\n", addr, (uint32_t)v=
al, size); */
=20
     if (set_reg_val(dev, addr, val)) {
-        pr_err("Error trying to set REG value, addr=3D0x%lx, val=3D0x%lx=
\n",
-               (uint64_t)addr, val);
+        pr_err("Fail to set REG value, addr=3D0x%" PRIx64 ", val=3D0x%" =
PRIx64 "\n",
+               addr, val);
         return;
     }
=20
@@ -373,7 +372,7 @@ static void regs_write(void *opaque, hwaddr addr, uin=
t64_t val, unsigned size)
         }
     break;
     case PVRDMA_REG_IMR:
-        pr_dbg("Interrupt mask=3D0x%lx\n", val);
+        pr_dbg("Interrupt mask=3D0x%" PRIx64 "\n", val);
         dev->interrupt_mask =3D val;
         break;
     case PVRDMA_REG_REQUEST:
@@ -404,7 +403,8 @@ static void uar_write(void *opaque, hwaddr addr, uint=
64_t val, unsigned size)
=20
     switch (addr & 0xFFF) { /* Mask with 0xFFF as each UC gets page */
     case PVRDMA_UAR_QP_OFFSET:
-        pr_dbg("UAR QP command, addr=3D0x%x, val=3D0x%lx\n", (uint32_t)a=
ddr, val);
+        pr_dbg("UAR QP command, addr=3D0x%" PRIx64 ", val=3D0x%" PRIx64 =
"\n",
+               (uint64_t)addr, val);
         if (val & PVRDMA_UAR_QP_SEND) {
             pvrdma_qp_send(dev, val & PVRDMA_UAR_HANDLE_MASK);
         }
@@ -420,16 +420,17 @@ static void uar_write(void *opaque, hwaddr addr, ui=
nt64_t val, unsigned size)
                                   !!(val & PVRDMA_UAR_CQ_ARM_SOL));
         }
         if (val & PVRDMA_UAR_CQ_ARM_SOL) {
-            pr_dbg("UAR_CQ_ARM_SOL (%ld)\n", val & PVRDMA_UAR_HANDLE_MAS=
K);
+            pr_dbg("UAR_CQ_ARM_SOL (%" PRIx64 ")\n",
+                   val & PVRDMA_UAR_HANDLE_MASK);
         }
         if (val & PVRDMA_UAR_CQ_POLL) {
-            pr_dbg("UAR_CQ_POLL (%ld)\n", val & PVRDMA_UAR_HANDLE_MASK);
+            pr_dbg("UAR_CQ_POLL (%" PRIx64 ")\n", val & PVRDMA_UAR_HANDL=
E_MASK);
             pvrdma_cq_poll(&dev->rdma_dev_res, val & PVRDMA_UAR_HANDLE_M=
ASK);
         }
         break;
     default:
-        pr_err("Unsupported command, addr=3D0x%lx, val=3D0x%lx\n",
-               (uint64_t)addr, val);
+        pr_err("Unsupported command, addr=3D0x%" PRIx64 ", val=3D0x%" PR=
Ix64 "\n",
+               addr, val);
         break;
     }
 }
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index a693c06a11..750ade6c31 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -102,7 +102,7 @@ static void pvrdma_qp_ops_comp_handler(int status, un=
signed int vendor_err,
     CompHandlerCtx *comp_ctx =3D (CompHandlerCtx *)ctx;
=20
     pr_dbg("cq_handle=3D%d\n", comp_ctx->cq_handle);
-    pr_dbg("wr_id=3D%ld\n", comp_ctx->cqe.wr_id);
+    pr_dbg("wr_id=3D%" PRIx64 "\n", comp_ctx->cqe.wr_id);
     pr_dbg("status=3D%d\n", status);
     pr_dbg("vendor_err=3D0x%x\n", vendor_err);
     comp_ctx->cqe.status =3D status;
@@ -143,7 +143,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle=
)
     while (wqe) {
         CompHandlerCtx *comp_ctx;
=20
-        pr_dbg("wr_id=3D%ld\n", wqe->hdr.wr_id);
+        pr_dbg("wr_id=3D%" PRIx64 "\n", wqe->hdr.wr_id);
=20
         /* Prepare CQE */
         comp_ctx =3D g_malloc(sizeof(CompHandlerCtx));
@@ -187,7 +187,7 @@ int pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle=
)
     while (wqe) {
         CompHandlerCtx *comp_ctx;
=20
-        pr_dbg("wr_id=3D%ld\n", wqe->hdr.wr_id);
+        pr_dbg("wr_id=3D%" PRIx64 "\n", wqe->hdr.wr_id);
=20
         /* Prepare CQE */
         comp_ctx =3D g_malloc(sizeof(CompHandlerCtx));
--=20
2.13.5
