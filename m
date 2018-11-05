Received: from eggs.gnu.org ([2001:4830:134:3::10]:35904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHO-0007fD-FM
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHJ-0003Ld-Jh
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeHJ-00038E-0G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:49 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:52 +0200
Message-Id: <20181105124559.21561-12-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 11/18] hw/pvrdma: Add support to allow guest to
 configure GID table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

The control over the RDMA device's GID table is done by updating the
device's Ethernet function addresses.
Usually the first GID entry is determine by the MAC address, the second
by the first IPv6 address and the third by the IPv4 address. Other
entries can be added by adding more IP addresses. The opposite is the
same, i.e. whenever an address is removed, the corresponding GID entry
is removed.

The process is done by the network and RDMA stacks. Whenever an address
is added the ib_core driver is notified and calls the device driver
add_gid function which in turn update the device.

To support this in pvrdma device we need to hook into the create_bind
and destroy_bind HW commands triggered by pvrdma driver in guest.
Whenever a changed is made to the pvrdma device's GID table a special
QMP messages is sent to be processed by libvirt to update the address of
the backend Ethernet device.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c      | 221 ++++++++++++++++++++++--------------
 hw/rdma/rdma_backend.h      |  22 ++--
 hw/rdma/rdma_backend_defs.h |   3 +-
 hw/rdma/rdma_rm.c           | 101 +++++++++++++++-
 hw/rdma/rdma_rm.h           |  17 ++-
 hw/rdma/rdma_rm_defs.h      |   9 +-
 hw/rdma/rdma_utils.h        |  15 +++
 hw/rdma/vmw/pvrdma.h        |   2 +-
 hw/rdma/vmw/pvrdma_cmd.c    |  48 ++++----
 hw/rdma/vmw/pvrdma_main.c   |  25 +---
 hw/rdma/vmw/pvrdma_qp_ops.c |  20 ++++
 11 files changed, 338 insertions(+), 145 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 3eb0099f8d..3f60c3cd6a 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -18,12 +18,14 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qapi-events-rdma.h"
 
 #include <infiniband/verbs.h>
 #include <infiniband/umad_types.h>
 #include <infiniband/umad.h>
 #include <rdma/rdma_user_cm.h>
 
+#include "contrib/rdmacm-mux/rdmacm-mux.h"
 #include "trace.h"
 #include "rdma_utils.h"
 #include "rdma_rm.h"
@@ -300,11 +302,11 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
     return 0;
 }
 
-static int mad_send(RdmaBackendDev *backend_dev, struct ibv_sge *sge,
-                    uint32_t num_sge)
+static int mad_send(RdmaBackendDev *backend_dev, uint8_t sgid_idx,
+                    union ibv_gid *sgid, struct ibv_sge *sge, uint32_t num_sge)
 {
-    struct backend_umad umad = {0};
-    char *hdr, *msg;
+    RdmaCmMuxMsg msg = {0};
+    char *hdr, *data;
     int ret;
 
     pr_dbg("num_sge=%d\n", num_sge);
@@ -313,41 +315,50 @@ static int mad_send(RdmaBackendDev *backend_dev, struct ibv_sge *sge,
         return -EINVAL;
     }
 
-    umad.hdr.length = sge[0].length + sge[1].length;
-    pr_dbg("msg_len=%d\n", umad.hdr.length);
+    msg.hdr.msg_type = RDMACM_MUX_MSG_TYPE_MAD;
+    memcpy(msg.hdr.sgid.raw, sgid->raw, sizeof(msg.hdr.sgid));
 
-    if (umad.hdr.length > sizeof(umad.mad)) {
+    msg.umad_len = sge[0].length + sge[1].length;
+    pr_dbg("umad_len=%d\n", msg.umad_len);
+
+    if (msg.umad_len > sizeof(msg.umad.mad)) {
         return -ENOMEM;
     }
 
-    umad.hdr.addr.qpn = htobe32(1);
-    umad.hdr.addr.grh_present = 1;
-    umad.hdr.addr.gid_index = backend_dev->backend_gid_idx;
-    memcpy(umad.hdr.addr.gid, backend_dev->gid.raw, sizeof(umad.hdr.addr.gid));
-    umad.hdr.addr.hop_limit = 1;
+    msg.umad.hdr.addr.qpn = htobe32(1);
+    msg.umad.hdr.addr.grh_present = 1;
+    pr_dbg("sgid_idx=%d\n", sgid_idx);
+    pr_dbg("sgid=0x%llx\n", sgid->global.interface_id);
+    msg.umad.hdr.addr.gid_index = sgid_idx;
+    memcpy(msg.umad.hdr.addr.gid, sgid->raw, sizeof(msg.umad.hdr.addr.gid));
+    msg.umad.hdr.addr.hop_limit = 1;
 
     hdr = rdma_pci_dma_map(backend_dev->dev, sge[0].addr, sge[0].length);
-    msg = rdma_pci_dma_map(backend_dev->dev, sge[1].addr, sge[1].length);
+    data = rdma_pci_dma_map(backend_dev->dev, sge[1].addr, sge[1].length);
+
+    pr_dbg_buf("mad_hdr", hdr, sge[0].length);
+    pr_dbg_buf("mad_data", data, sge[1].length);
 
-    memcpy(&umad.mad[0], hdr, sge[0].length);
-    memcpy(&umad.mad[sge[0].length], msg, sge[1].length);
+    memcpy(&msg.umad.mad[0], hdr, sge[0].length);
+    memcpy(&msg.umad.mad[sge[0].length], data, sge[1].length);
 
-    rdma_pci_dma_unmap(backend_dev->dev, msg, sge[1].length);
+    rdma_pci_dma_unmap(backend_dev->dev, data, sge[1].length);
     rdma_pci_dma_unmap(backend_dev->dev, hdr, sge[0].length);
 
-    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&umad,
-                            sizeof(umad));
+    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&msg,
+                            sizeof(msg));
 
     pr_dbg("qemu_chr_fe_write=%d\n", ret);
 
-    return (ret != sizeof(umad));
+    return (ret != sizeof(msg));
 }
 
 void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge,
-                            union ibv_gid *dgid, uint32_t dqpn,
-                            uint32_t dqkey, void *ctx)
+                            uint8_t sgid_idx, union ibv_gid *sgid,
+                            union ibv_gid *dgid, uint32_t dqpn, uint32_t dqkey,
+                            void *ctx)
 {
     BackendCtx *bctx;
     struct ibv_sge new_sge[MAX_SGE];
@@ -361,7 +372,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
             comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
         } else if (qp_type == IBV_QPT_GSI) {
             pr_dbg("QP1\n");
-            rc = mad_send(backend_dev, sge, num_sge);
+            rc = mad_send(backend_dev, sgid_idx, sgid, sge, num_sge);
             if (rc) {
                 comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
             } else {
@@ -397,8 +408,7 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
     }
 
     if (qp_type == IBV_QPT_UD) {
-        wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
-                                backend_dev->backend_gid_idx, dgid);
+        wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd, sgid_idx, dgid);
         if (!wr.wr.ud.ah) {
             comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
             goto out_dealloc_cqe_ctx;
@@ -703,9 +713,9 @@ int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
 }
 
 int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
-                              uint8_t qp_type, union ibv_gid *dgid,
-                              uint32_t dqpn, uint32_t rq_psn, uint32_t qkey,
-                              bool use_qkey)
+                              uint8_t qp_type, uint8_t sgid_idx,
+                              union ibv_gid *dgid, uint32_t dqpn,
+                              uint32_t rq_psn, uint32_t qkey, bool use_qkey)
 {
     struct ibv_qp_attr attr = {0};
     union ibv_gid ibv_gid = {
@@ -717,13 +727,15 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
     attr.qp_state = IBV_QPS_RTR;
     attr_mask = IBV_QP_STATE;
 
+    qp->sgid_idx = sgid_idx;
+
     switch (qp_type) {
     case IBV_QPT_RC:
         pr_dbg("dgid=0x%" PRIx64 ",%" PRIx64 "\n",
                be64_to_cpu(ibv_gid.global.subnet_prefix),
                be64_to_cpu(ibv_gid.global.interface_id));
         pr_dbg("dqpn=0x%x\n", dqpn);
-        pr_dbg("sgid_idx=%d\n", backend_dev->backend_gid_idx);
+        pr_dbg("sgid_idx=%d\n", qp->sgid_idx);
         pr_dbg("sport_num=%d\n", backend_dev->port_num);
         pr_dbg("rq_psn=0x%x\n", rq_psn);
 
@@ -735,7 +747,7 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
         attr.ah_attr.is_global      = 1;
         attr.ah_attr.grh.hop_limit  = 1;
         attr.ah_attr.grh.dgid       = ibv_gid;
-        attr.ah_attr.grh.sgid_index = backend_dev->backend_gid_idx;
+        attr.ah_attr.grh.sgid_index = qp->sgid_idx;
         attr.rq_psn                 = rq_psn;
 
         attr_mask |= IBV_QP_AV | IBV_QP_PATH_MTU | IBV_QP_DEST_QPN |
@@ -744,8 +756,8 @@ int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
         break;
 
     case IBV_QPT_UD:
+        pr_dbg("qkey=0x%x\n", qkey);
         if (use_qkey) {
-            pr_dbg("qkey=0x%x\n", qkey);
             attr.qkey = qkey;
             attr_mask |= IBV_QP_QKEY;
         }
@@ -861,13 +873,13 @@ static inline void build_mad_hdr(struct ibv_grh *grh, union ibv_gid *sgid,
     grh->dgid = *my_gid;
 
     pr_dbg("paylen=%d (net=0x%x)\n", paylen, grh->paylen);
-    pr_dbg("my_gid=0x%llx\n", my_gid->global.interface_id);
-    pr_dbg("gid=0x%llx\n", sgid->global.interface_id);
+    pr_dbg("dgid=0x%llx\n", my_gid->global.interface_id);
+    pr_dbg("sgid=0x%llx\n", sgid->global.interface_id);
 }
 
 static inline int mad_can_receieve(void *opaque)
 {
-    return sizeof(struct backend_umad);
+    return sizeof(RdmaCmMuxMsg);
 }
 
 static void mad_read(void *opaque, const uint8_t *buf, int size)
@@ -877,13 +889,13 @@ static void mad_read(void *opaque, const uint8_t *buf, int size)
     unsigned long cqe_ctx_id;
     BackendCtx *bctx;
     char *mad;
-    struct backend_umad *umad;
+    RdmaCmMuxMsg *msg;
 
-    assert(size != sizeof(umad));
-    umad = (struct backend_umad *)buf;
+    assert(size != sizeof(msg));
+    msg = (RdmaCmMuxMsg *)buf;
 
     pr_dbg("Got %d bytes\n", size);
-    pr_dbg("umad->hdr.length=%d\n", umad->hdr.length);
+    pr_dbg("umad_len=%d\n", msg->umad_len);
 
 #ifdef PVRDMA_DEBUG
     struct umad_hdr *hdr = (struct umad_hdr *)&msg->umad.mad;
@@ -913,15 +925,16 @@ static void mad_read(void *opaque, const uint8_t *buf, int size)
 
     mad = rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
                            bctx->sge.length);
-    if (!mad || bctx->sge.length < umad->hdr.length + MAD_HDR_SIZE) {
+    if (!mad || bctx->sge.length < msg->umad_len + MAD_HDR_SIZE) {
         comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
                      bctx->up_ctx);
     } else {
+        pr_dbg_buf("mad", msg->umad.mad, msg->umad_len);
         memset(mad, 0, bctx->sge.length);
         build_mad_hdr((struct ibv_grh *)mad,
-                      (union ibv_gid *)&umad->hdr.addr.gid,
-                      &backend_dev->gid, umad->hdr.length);
-        memcpy(&mad[MAD_HDR_SIZE], umad->mad, umad->hdr.length);
+                      (union ibv_gid *)&msg->umad.hdr.addr.gid, &msg->hdr.sgid,
+                      msg->umad_len);
+        memcpy(&mad[MAD_HDR_SIZE], msg->umad.mad, msg->umad_len);
         rdma_pci_dma_unmap(backend_dev->dev, mad, bctx->sge.length);
 
         comp_handler(IBV_WC_SUCCESS, 0, bctx->up_ctx);
@@ -933,10 +946,10 @@ static void mad_read(void *opaque, const uint8_t *buf, int size)
 
 static int mad_init(RdmaBackendDev *backend_dev)
 {
-    struct backend_umad umad = {0};
     int ret;
 
-    if (!qemu_chr_fe_backend_connected(backend_dev->mad_chr_be)) {
+    ret = qemu_chr_fe_backend_connected(backend_dev->mad_chr_be);
+    if (!ret) {
         pr_dbg("Missing chardev for MAD multiplexer\n");
         return -EIO;
     }
@@ -944,14 +957,6 @@ static int mad_init(RdmaBackendDev *backend_dev)
     qemu_chr_fe_set_handlers(backend_dev->mad_chr_be, mad_can_receieve,
                              mad_read, NULL, NULL, backend_dev, NULL, true);
 
-    /* Register ourself */
-    memcpy(umad.hdr.addr.gid, backend_dev->gid.raw, sizeof(umad.hdr.addr.gid));
-    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&umad,
-                            sizeof(umad.hdr));
-    if (ret != sizeof(umad.hdr)) {
-        pr_dbg("Fail to register to rdma_umadmux (%d)\n", ret);
-    }
-
     qemu_mutex_init(&backend_dev->recv_mads_list.lock);
     backend_dev->recv_mads_list.list = qlist_new();
 
@@ -988,23 +993,98 @@ static void mad_fini(RdmaBackendDev *backend_dev)
     qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
 }
 
+int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
+                               union ibv_gid *gid)
+{
+    union ibv_gid sgid;
+    int ret;
+    int i = 0;
+
+    pr_dbg("0x%llx, 0x%llx\n",
+           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
+           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
+
+    do {
+        ret = ibv_query_gid(backend_dev->context, backend_dev->port_num, i,
+                            &sgid);
+        i++;
+    } while (!ret && (memcmp(&sgid, gid, sizeof(*gid))));
+
+    pr_dbg("gid_index=%d\n", i - 1);
+
+    return ret ? ret : i - 1;
+}
+
+int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
+                         union ibv_gid *gid)
+{
+    RdmaCmMuxMsg msg = {0};
+    int ret;
+
+    pr_dbg("0x%llx, 0x%llx\n",
+           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
+           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
+
+    msg.hdr.msg_type = RDMACM_MUX_MSG_TYPE_REG;
+    strcpy(msg.hdr.ifname, ifname);
+    memcpy(msg.hdr.sgid.raw, gid->raw, sizeof(msg.hdr.sgid));
+    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&msg,
+                            sizeof(msg));
+    if (ret != sizeof(msg)) {
+        pr_dbg("Fail to register to rdma_umadmux (%d)\n", ret);
+        return -EIO;
+    }
+
+    qapi_event_send_rdma_gid_status_changed(ifname, true,
+                                            gid->global.subnet_prefix,
+                                            gid->global.interface_id);
+
+    return ret;
+}
+
+int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
+                         union ibv_gid *gid)
+{
+    RdmaCmMuxMsg msg = {0};
+    int ret;
+
+    pr_dbg("0x%llx, 0x%llx\n",
+           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
+           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
+
+    qapi_event_send_rdma_gid_status_changed(ifname, false,
+                                            gid->global.subnet_prefix,
+                                            gid->global.interface_id);
+
+    msg.hdr.msg_type = RDMACM_MUX_MSG_TYPE_UNREG;
+    strcpy(msg.hdr.ifname, ifname);
+    memcpy(msg.hdr.sgid.raw, gid->raw, sizeof(msg.hdr.sgid));
+    ret = qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_t *)&msg,
+                            sizeof(msg));
+    if (ret != sizeof(msg)) {
+        pr_dbg("Fail to register to rdma_umadmux (%d)\n", ret);
+        return -EIO;
+    }
+    pr_dbg("qemu_chr_fe_write=%d\n", ret);
+
+    return 0;
+}
+
 int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
                       RdmaDeviceResources *rdma_dev_res,
                       const char *backend_device_name, uint8_t port_num,
-                      uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
-                      CharBackend *mad_chr_be, Error **errp)
+                      struct ibv_device_attr *dev_attr, CharBackend *mad_chr_be,
+                      Error **errp)
 {
     int i;
     int ret = 0;
     int num_ibv_devices;
     struct ibv_device **dev_list;
-    struct ibv_port_attr port_attr;
 
     memset(backend_dev, 0, sizeof(*backend_dev));
 
     backend_dev->dev = pdev;
     backend_dev->mad_chr_be = mad_chr_be;
-    backend_dev->backend_gid_idx = backend_gid_idx;
     backend_dev->port_num = port_num;
     backend_dev->rdma_dev_res = rdma_dev_res;
 
@@ -1041,9 +1121,8 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
         backend_dev->ib_dev = *dev_list;
     }
 
-    pr_dbg("Using backend device %s, port %d, gid_idx %d\n",
-           ibv_get_device_name(backend_dev->ib_dev),
-           backend_dev->port_num, backend_dev->backend_gid_idx);
+    pr_dbg("Using backend device %s, port %d\n",
+           ibv_get_device_name(backend_dev->ib_dev), backend_dev->port_num);
 
     backend_dev->context = ibv_open_device(backend_dev->ib_dev);
     if (!backend_dev->context) {
@@ -1060,20 +1139,6 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
     }
     pr_dbg("dev->backend_dev.channel=%p\n", backend_dev->channel);
 
-    ret = ibv_query_port(backend_dev->context, backend_dev->port_num,
-                         &port_attr);
-    if (ret) {
-        error_setg(errp, "Error %d from ibv_query_port", ret);
-        ret = -EIO;
-        goto out_destroy_comm_channel;
-    }
-
-    if (backend_dev->backend_gid_idx >= port_attr.gid_tbl_len) {
-        error_setg(errp, "Invalid backend_gid_idx, should be less than %d",
-                   port_attr.gid_tbl_len);
-        goto out_destroy_comm_channel;
-    }
-
     ret = init_device_caps(backend_dev, dev_attr);
     if (ret) {
         error_setg(errp, "Failed to initialize device capabilities");
@@ -1081,18 +1146,6 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
         goto out_destroy_comm_channel;
     }
 
-    ret = ibv_query_gid(backend_dev->context, backend_dev->port_num,
-                         backend_dev->backend_gid_idx, &backend_dev->gid);
-    if (ret) {
-        error_setg(errp, "Failed to query gid %d",
-                   backend_dev->backend_gid_idx);
-        ret = -EIO;
-        goto out_destroy_comm_channel;
-    }
-    pr_dbg("subnet_prefix=0x%" PRIx64 "\n",
-           be64_to_cpu(backend_dev->gid.global.subnet_prefix));
-    pr_dbg("interface_id=0x%" PRIx64 "\n",
-           be64_to_cpu(backend_dev->gid.global.interface_id));
 
     ret = mad_init(backend_dev);
     if (ret) {
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index fc83330251..59ad2b874b 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -28,11 +28,6 @@ enum ibv_special_qp_type {
     IBV_QPT_GSI = 1,
 };
 
-static inline union ibv_gid *rdma_backend_gid(RdmaBackendDev *dev)
-{
-    return &dev->gid;
-}
-
 static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)
 {
     return qp->ibqp ? qp->ibqp->qp_num : 1;
@@ -51,9 +46,15 @@ static inline uint32_t rdma_backend_mr_rkey(const RdmaBackendMR *mr)
 int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
                       RdmaDeviceResources *rdma_dev_res,
                       const char *backend_device_name, uint8_t port_num,
-                      uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
-                      CharBackend *mad_chr_be, Error **errp);
+                      struct ibv_device_attr *dev_attr, CharBackend *mad_chr_be,
+                      Error **errp);
 void rdma_backend_fini(RdmaBackendDev *backend_dev);
+int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
+                         union ibv_gid *gid);
+int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
+                         union ibv_gid *gid);
+int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
+                               union ibv_gid *gid);
 void rdma_backend_start(RdmaBackendDev *backend_dev);
 void rdma_backend_stop(RdmaBackendDev *backend_dev);
 void rdma_backend_register_comp_handler(void (*handler)(int status,
@@ -82,9 +83,9 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
 int rdma_backend_qp_state_init(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
                                uint8_t qp_type, uint32_t qkey);
 int rdma_backend_qp_state_rtr(RdmaBackendDev *backend_dev, RdmaBackendQP *qp,
-                              uint8_t qp_type, union ibv_gid *dgid,
-                              uint32_t dqpn, uint32_t rq_psn, uint32_t qkey,
-                              bool use_qkey);
+                              uint8_t qp_type, uint8_t sgid_idx,
+                              union ibv_gid *dgid, uint32_t dqpn,
+                              uint32_t rq_psn, uint32_t qkey, bool use_qkey);
 int rdma_backend_qp_state_rts(RdmaBackendQP *qp, uint8_t qp_type,
                               uint32_t sq_psn, uint32_t qkey, bool use_qkey);
 int rdma_backend_query_qp(RdmaBackendQP *qp, struct ibv_qp_attr *attr,
@@ -94,6 +95,7 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp);
 void rdma_backend_post_send(RdmaBackendDev *backend_dev,
                             RdmaBackendQP *qp, uint8_t qp_type,
                             struct ibv_sge *sge, uint32_t num_sge,
+                            uint8_t sgid_idx, union ibv_gid *sgid,
                             union ibv_gid *dgid, uint32_t dqpn, uint32_t dqkey,
                             void *ctx);
 void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 2a7e667075..ff8b2426a0 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -37,14 +37,12 @@ typedef struct RecvMadList {
 typedef struct RdmaBackendDev {
     struct ibv_device_attr dev_attr;
     RdmaBackendThread comp_thread;
-    union ibv_gid gid;
     PCIDevice *dev;
     RdmaDeviceResources *rdma_dev_res;
     struct ibv_device *ib_dev;
     struct ibv_context *context;
     struct ibv_comp_channel *channel;
     uint8_t port_num;
-    uint8_t backend_gid_idx;
     RecvMadList recv_mads_list;
     CharBackend *mad_chr_be;
 } RdmaBackendDev;
@@ -66,6 +64,7 @@ typedef struct RdmaBackendCQ {
 typedef struct RdmaBackendQP {
     struct ibv_pd *ibpd;
     struct ibv_qp *ibqp;
+    uint8_t sgid_idx;
 } RdmaBackendQP;
 
 #endif
diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 4f10fcabcc..04f88139c2 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -391,7 +391,7 @@ out_dealloc_qp:
 }
 
 int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
-                      uint32_t qp_handle, uint32_t attr_mask,
+                      uint32_t qp_handle, uint32_t attr_mask, uint8_t sgid_idx,
                       union ibv_gid *dgid, uint32_t dqpn,
                       enum ibv_qp_state qp_state, uint32_t qkey,
                       uint32_t rq_psn, uint32_t sq_psn)
@@ -400,6 +400,7 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
     int ret;
 
     pr_dbg("qpn=0x%x\n", qp_handle);
+    pr_dbg("qkey=0x%x\n", qkey);
 
     qp = rdma_rm_get_qp(dev_res, qp_handle);
     if (!qp) {
@@ -430,9 +431,19 @@ int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
         }
 
         if (qp->qp_state == IBV_QPS_RTR) {
+            /* Get backend gid index */
+            pr_dbg("Guest sgid_idx=%d\n", sgid_idx);
+            sgid_idx = rdma_rm_get_backend_gid_index(dev_res, backend_dev,
+                                                     sgid_idx);
+            if (sgid_idx <= 0) { /* TODO check also less than bk.max_sgid */
+                pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n", sgid_idx);
+                return -EIO;
+            }
+
             ret = rdma_backend_qp_state_rtr(backend_dev, &qp->backend_qp,
-                                            qp->qp_type, dgid, dqpn, rq_psn,
-                                            qkey, attr_mask & IBV_QP_QKEY);
+                                            qp->qp_type, sgid_idx, dgid, dqpn,
+                                            rq_psn, qkey,
+                                            attr_mask & IBV_QP_QKEY);
             if (ret) {
                 return -EIO;
             }
@@ -523,11 +534,88 @@ void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id)
     res_tbl_dealloc(&dev_res->cqe_ctx_tbl, cqe_ctx_id);
 }
 
+int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                    const char *ifname, union ibv_gid *gid, int gid_idx)
+{
+    int rc;
+
+    rc = rdma_backend_add_gid(backend_dev, ifname, gid);
+    if (rc <= 0) {
+        pr_dbg("Fail to add gid\n");
+        return -EINVAL;
+    }
+
+    memcpy(&dev_res->ports[0].gid_tbl[gid_idx].gid, gid, sizeof(*gid));
+
+    return 0;
+}
+
+void rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     const char *ifname, int gid_idx)
+{
+    int rc;
+
+    rc = rdma_backend_del_gid(backend_dev, ifname,
+                              &dev_res->ports[0].gid_tbl[gid_idx].gid);
+    if (rc < 0) {
+        pr_dbg("Fail to delete gid\n");
+    }
+
+    memset(dev_res->ports[0].gid_tbl[gid_idx].gid.raw, 0,
+           sizeof(dev_res->ports[0].gid_tbl[gid_idx].gid));
+    dev_res->ports[0].gid_tbl[gid_idx].backend_gid_index = -1;
+}
+
+int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
+                                  RdmaBackendDev *backend_dev, int sgid_idx)
+{
+    if (unlikely(sgid_idx < 0 || sgid_idx > MAX_PORT_GIDS)) {
+        pr_dbg("Got invalid sgid_idx %d\n", sgid_idx);
+        return -EINVAL;
+    }
+
+    if (unlikely(dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index == -1)) {
+        dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index =
+        rdma_backend_get_gid_index(backend_dev,
+                                       &dev_res->ports[0].gid_tbl[sgid_idx].gid);
+    }
+
+    pr_dbg("backend_gid_index=%d\n",
+           dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index);
+
+    return dev_res->ports[0].gid_tbl[sgid_idx].backend_gid_index;
+}
+
 static void destroy_qp_hash_key(gpointer data)
 {
     g_bytes_unref(data);
 }
 
+static void init_ports(RdmaDeviceResources *dev_res)
+{
+    int i, j;
+
+    memset(dev_res->ports, 0, sizeof(dev_res->ports));
+
+    for (i = 0; i < MAX_PORTS; i++) {
+        dev_res->ports[i].state = IBV_PORT_DOWN;
+        for (j = 0; j < MAX_PORT_GIDS; j++) {
+            dev_res->ports[i].gid_tbl[j].backend_gid_index = -1;
+        }
+    }
+}
+
+static void fini_ports(RdmaDeviceResources *dev_res,
+                       RdmaBackendDev *backend_dev, const char *ifname)
+{
+    int i;
+
+    dev_res->ports[0].state = IBV_PORT_DOWN;
+    for (i = 0; i < MAX_PORT_GIDS; i++) {
+        rdma_rm_del_gid(dev_res, backend_dev, ifname, i);
+    }
+}
+
 int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
                  Error **errp)
 {
@@ -545,11 +633,16 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
                        dev_attr->max_qp_wr, sizeof(void *));
     res_tbl_init("UC", &dev_res->uc_tbl, MAX_UCS, sizeof(RdmaRmUC));
 
+    init_ports(dev_res);
+
     return 0;
 }
 
-void rdma_rm_fini(RdmaDeviceResources *dev_res)
+void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                  const char *ifname)
 {
+    fini_ports(dev_res, backend_dev, ifname);
+
     res_tbl_free(&dev_res->uc_tbl);
     res_tbl_free(&dev_res->cqe_ctx_tbl);
     res_tbl_free(&dev_res->qp_tbl);
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index b4e04cc7b4..89596f4de1 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -22,7 +22,8 @@
 
 int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
                  Error **errp);
-void rdma_rm_fini(RdmaDeviceResources *dev_res);
+void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                  const char *ifname);
 
 int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
                      uint32_t *pd_handle, uint32_t ctx_handle);
@@ -55,7 +56,7 @@ int rdma_rm_alloc_qp(RdmaDeviceResources *dev_res, uint32_t pd_handle,
                      uint32_t recv_cq_handle, void *opaque, uint32_t *qpn);
 RdmaRmQP *rdma_rm_get_qp(RdmaDeviceResources *dev_res, uint32_t qpn);
 int rdma_rm_modify_qp(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
-                      uint32_t qp_handle, uint32_t attr_mask,
+                      uint32_t qp_handle, uint32_t attr_mask, uint8_t sgid_idx,
                       union ibv_gid *dgid, uint32_t dqpn,
                       enum ibv_qp_state qp_state, uint32_t qkey,
                       uint32_t rq_psn, uint32_t sq_psn);
@@ -69,4 +70,16 @@ int rdma_rm_alloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t *cqe_ctx_id,
 void *rdma_rm_get_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id);
 void rdma_rm_dealloc_cqe_ctx(RdmaDeviceResources *dev_res, uint32_t cqe_ctx_id);
 
+int rdma_rm_add_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                    const char *ifname, union ibv_gid *gid, int gid_idx);
+void rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
+                     const char *ifname, int gid_idx);
+int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
+                                  RdmaBackendDev *backend_dev, int sgid_idx);
+static inline union ibv_gid *rdma_rm_get_gid(RdmaDeviceResources *dev_res,
+                                             int sgid_idx)
+{
+    return &dev_res->ports[0].gid_tbl[sgid_idx].gid;
+}
+
 #endif
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 9b399063d3..7b3435f991 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -19,7 +19,7 @@
 #include "rdma_backend_defs.h"
 
 #define MAX_PORTS             1
-#define MAX_PORT_GIDS         1
+#define MAX_PORT_GIDS         255
 #define MAX_GIDS              MAX_PORT_GIDS
 #define MAX_PORT_PKEYS        1
 #define MAX_PKEYS             MAX_PORT_PKEYS
@@ -86,8 +86,13 @@ typedef struct RdmaRmQP {
     enum ibv_qp_state qp_state;
 } RdmaRmQP;
 
+typedef struct RdmaRmGid {
+    union ibv_gid gid;
+    int backend_gid_index;
+} RdmaRmGid;
+
 typedef struct RdmaRmPort {
-    union ibv_gid gid_tbl[MAX_PORT_GIDS];
+    RdmaRmGid gid_tbl[MAX_PORT_GIDS];
     enum ibv_port_state state;
 } RdmaRmPort;
 
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 04c7c2ef5b..989db249ef 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
+#include "stdio.h"
 
 #define pr_info(fmt, ...) \
     fprintf(stdout, "%s: %-20s (%3d): " fmt, "rdma",  __func__, __LINE__,\
@@ -40,9 +41,23 @@ extern unsigned long pr_dbg_cnt;
 #define pr_dbg(fmt, ...) \
     fprintf(stdout, "%lx %ld: %-20s (%3d): " fmt, pthread_self(), pr_dbg_cnt++, \
             __func__, __LINE__, ## __VA_ARGS__)
+
+#define pr_dbg_buf(title, buf, len) \
+{ \
+    char *b = g_malloc0(len * 3 + 1); \
+    char b1[4]; \
+    for (int i = 0; i < len; i++) { \
+        sprintf(b1, "%.2X ", buf[i] & 0x000000FF); \
+        strcat(b, b1); \
+    } \
+    pr_dbg("%s (%d): %s\n", title, len, b); \
+    g_free(b); \
+}
+
 #else
 #define init_pr_dbg(void)
 #define pr_dbg(fmt, ...)
+#define pr_dbg_buf(title, buf, len)
 #endif
 
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 15c3f28b86..b019cb843a 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -79,8 +79,8 @@ typedef struct PVRDMADev {
     int interrupt_mask;
     struct ibv_device_attr dev_attr;
     uint64_t node_guid;
+    char *backend_eth_device_name;
     char *backend_device_name;
-    uint8_t backend_gid_idx;
     uint8_t backend_port_num;
     RdmaBackendDev backend_dev;
     RdmaDeviceResources rdma_dev_res;
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 57d6f41ae6..5aa745edb3 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -504,13 +504,16 @@ static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
     rsp->hdr.response = cmd->hdr.response;
     rsp->hdr.ack = PVRDMA_CMD_MODIFY_QP_RESP;
 
-    rsp->hdr.err = rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev,
-                                 cmd->qp_handle, cmd->attr_mask,
-                                 (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
-                                 cmd->attrs.dest_qp_num,
-                                 (enum ibv_qp_state)cmd->attrs.qp_state,
-                                 cmd->attrs.qkey, cmd->attrs.rq_psn,
-                                 cmd->attrs.sq_psn);
+    /* No need to verify sgid_index since it is u8 */
+
+    rsp->hdr.err =
+        rdma_rm_modify_qp(&dev->rdma_dev_res, &dev->backend_dev, cmd->qp_handle,
+                          cmd->attr_mask, cmd->attrs.ah_attr.grh.sgid_index,
+                          (union ibv_gid *)&cmd->attrs.ah_attr.grh.dgid,
+                          cmd->attrs.dest_qp_num,
+                          (enum ibv_qp_state)cmd->attrs.qp_state,
+                          cmd->attrs.qkey, cmd->attrs.rq_psn,
+                          cmd->attrs.sq_psn);
 
     pr_dbg("ret=%d\n", rsp->hdr.err);
     return rsp->hdr.err;
@@ -570,10 +573,8 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
                        union pvrdma_cmd_resp *rsp)
 {
     struct pvrdma_cmd_create_bind *cmd = &req->create_bind;
-#ifdef PVRDMA_DEBUG
-    __be64 *subnet = (__be64 *)&cmd->new_gid[0];
-    __be64 *if_id = (__be64 *)&cmd->new_gid[8];
-#endif
+    int rc;
+    union ibv_gid *gid = (union ibv_gid *)&cmd->new_gid;
 
     pr_dbg("index=%d\n", cmd->index);
 
@@ -582,19 +583,24 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
     }
 
     pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
-           (long long unsigned int)be64_to_cpu(*subnet),
-           (long long unsigned int)be64_to_cpu(*if_id));
+           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
+           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
 
-    /* Driver forces to one port only */
-    memcpy(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, &cmd->new_gid,
-           sizeof(cmd->new_gid));
+    rc = rdma_rm_add_gid(&dev->rdma_dev_res, &dev->backend_dev,
+                         dev->backend_eth_device_name, gid, cmd->index);
+    if (rc < 0) {
+        return -EINVAL;
+    }
 
     /* TODO: Since drivers stores node_guid at load_dsr phase then this
      * assignment is not relevant, i need to figure out a way how to
      * retrieve MAC of our netdev */
-    dev->node_guid = dev->rdma_dev_res.ports[0].gid_tbl[0].global.interface_id;
-    pr_dbg("dev->node_guid=0x%llx\n",
-           (long long unsigned int)be64_to_cpu(dev->node_guid));
+    if (!cmd->index) {
+        dev->node_guid =
+            dev->rdma_dev_res.ports[0].gid_tbl[0].gid.global.interface_id;
+        pr_dbg("dev->node_guid=0x%llx\n",
+               (long long unsigned int)be64_to_cpu(dev->node_guid));
+    }
 
     return 0;
 }
@@ -610,8 +616,8 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
         return -EINVAL;
     }
 
-    memset(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, 0,
-           sizeof(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw));
+    rdma_rm_del_gid(&dev->rdma_dev_res, &dev->backend_dev,
+                    dev->backend_eth_device_name, cmd->index);
 
     return 0;
 }
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index fc2abd34af..f9784d1bd7 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -36,9 +36,9 @@
 #include "pvrdma_qp_ops.h"
 
 static Property pvrdma_dev_properties[] = {
-    DEFINE_PROP_STRING("backend-dev", PVRDMADev, backend_device_name),
-    DEFINE_PROP_UINT8("backend-port", PVRDMADev, backend_port_num, 1),
-    DEFINE_PROP_UINT8("backend-gid-idx", PVRDMADev, backend_gid_idx, 0),
+    DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name),
+    DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
+    DEFINE_PROP_UINT8("ibport", PVRDMADev, backend_port_num, 1),
     DEFINE_PROP_UINT64("dev-caps-max-mr-size", PVRDMADev, dev_attr.max_mr_size,
                        MAX_MR_SIZE),
     DEFINE_PROP_INT32("dev-caps-max-qp", PVRDMADev, dev_attr.max_qp, MAX_QP),
@@ -276,17 +276,6 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
     pr_dbg("Initialized\n");
 }
 
-static void init_ports(PVRDMADev *dev, Error **errp)
-{
-    int i;
-
-    memset(dev->rdma_dev_res.ports, 0, sizeof(dev->rdma_dev_res.ports));
-
-    for (i = 0; i < MAX_PORTS; i++) {
-        dev->rdma_dev_res.ports[i].state = IBV_PORT_DOWN;
-    }
-}
-
 static void uninit_msix(PCIDevice *pdev, int used_vectors)
 {
     PVRDMADev *dev = PVRDMA_DEV(pdev);
@@ -335,7 +324,8 @@ static void pvrdma_fini(PCIDevice *pdev)
 
     pvrdma_qp_ops_fini();
 
-    rdma_rm_fini(&dev->rdma_dev_res);
+    rdma_rm_fini(&dev->rdma_dev_res, &dev->backend_dev,
+                 dev->backend_device_name);
 
     rdma_backend_fini(&dev->backend_dev);
 
@@ -612,8 +602,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 
     rc = rdma_backend_init(&dev->backend_dev, pdev, &dev->rdma_dev_res,
                            dev->backend_device_name, dev->backend_port_num,
-                           dev->backend_gid_idx, &dev->dev_attr, &dev->mad_chr,
-                           errp);
+                           &dev->dev_attr, &dev->mad_chr, errp);
     if (rc) {
         goto out;
     }
@@ -623,8 +612,6 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         goto out;
     }
 
-    init_ports(dev, errp);
-
     rc = pvrdma_qp_ops_init();
     if (rc) {
         goto out;
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 3388be1926..2130824098 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -131,6 +131,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
     RdmaRmQP *qp;
     PvrdmaSqWqe *wqe;
     PvrdmaRing *ring;
+    int sgid_idx;
+    union ibv_gid *sgid;
 
     pr_dbg("qp_handle=0x%x\n", qp_handle);
 
@@ -156,8 +158,26 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         comp_ctx->cqe.qp = qp_handle;
         comp_ctx->cqe.opcode = IBV_WC_SEND;
 
+        sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
+        if (!sgid) {
+            pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
+            return -EIO;
+        }
+        pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
+               sgid->global.interface_id);
+
+        sgid_idx = rdma_rm_get_backend_gid_index(&dev->rdma_dev_res,
+                                                 &dev->backend_dev,
+                                                 wqe->hdr.wr.ud.av.gid_index);
+        if (sgid_idx <= 0) {
+            pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
+                   wqe->hdr.wr.ud.av.gid_index);
+            return -EIO;
+        }
+
         rdma_backend_post_send(&dev->backend_dev, &qp->backend_qp, qp->qp_type,
                                (struct ibv_sge *)&wqe->sge[0], wqe->hdr.num_sge,
+                               sgid_idx, sgid,
                                (union ibv_gid *)wqe->hdr.wr.ud.av.dgid,
                                wqe->hdr.wr.ud.remote_qpn,
                                wqe->hdr.wr.ud.remote_qkey, comp_ctx);
-- 
2.17.2
