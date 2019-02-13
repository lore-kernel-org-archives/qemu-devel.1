Received: from eggs.gnu.org ([209.51.188.92]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtodU-0003Ky-68
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtoQw-0003ua-TM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gtoQw-0003ti-Kt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:54:14 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 13 Feb 2019 08:53:50 +0200
Message-Id: <20190213065357.16076-4-yuval.shaia@oracle.com>
In-Reply-To: <20190213065357.16076-1-yuval.shaia@oracle.com>
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 2/9] hw/rdma: Introduce protected qlist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

To make code more readable move handling of protected list to a
rdma_utils

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c      | 20 +++++--------------
 hw/rdma/rdma_backend_defs.h |  8 ++------
 hw/rdma/rdma_utils.c        | 39 +++++++++++++++++++++++++++++++++++++
 hw/rdma/rdma_utils.h        |  9 +++++++++
 4 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 5f60856d19..6e9c4617da 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -527,9 +527,7 @@ static unsigned int save_mad_recv_buffer(RdmaBackendDev *backend_dev,
     bctx->up_ctx = ctx;
     bctx->sge = *sge;
 
-    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
-    qlist_append_int(backend_dev->recv_mads_list.list, bctx_id);
-    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
+    rdma_protected_qlist_append_int64(&backend_dev->recv_mads_list, bctx_id);
 
     return 0;
 }
@@ -913,23 +911,19 @@ static inline void build_mad_hdr(struct ibv_grh *grh, union ibv_gid *sgid,
 static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
                                      RdmaCmMuxMsg *msg)
 {
-    QObject *o_ctx_id;
     unsigned long cqe_ctx_id;
     BackendCtx *bctx;
     char *mad;
 
     trace_mad_message("recv", msg->umad.mad, msg->umad_len);
 
-    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
-    o_ctx_id = qlist_pop(backend_dev->recv_mads_list.list);
-    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
-    if (!o_ctx_id) {
+    cqe_ctx_id = rdma_protected_qlist_pop_int64(&backend_dev->recv_mads_list);
+    if (cqe_ctx_id == -ENOENT) {
         rdma_warn_report("No more free MADs buffers, waiting for a while");
         sleep(THR_POLL_TO);
         return;
     }
 
-    cqe_ctx_id = qnum_get_uint(qobject_to(QNum, o_ctx_id));
     bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
     if (unlikely(!bctx)) {
         rdma_error_report("No matching ctx for req %ld", cqe_ctx_id);
@@ -994,8 +988,7 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
         return -EIO;
     }
 
-    qemu_mutex_init(&backend_dev->recv_mads_list.lock);
-    backend_dev->recv_mads_list.list = qlist_new();
+    rdma_protected_qlist_init(&backend_dev->recv_mads_list);
 
     enable_rdmacm_mux_async(backend_dev);
 
@@ -1010,10 +1003,7 @@ static void mad_fini(RdmaBackendDev *backend_dev)
 {
     disable_rdmacm_mux_async(backend_dev);
     qemu_chr_fe_disconnect(backend_dev->rdmacm_mux.chr_be);
-    if (backend_dev->recv_mads_list.list) {
-        qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
-        qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
-    }
+    rdma_protected_qlist_destroy(&backend_dev->recv_mads_list);
 }
 
 int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 15ae8b970e..a8c15b09ab 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -20,6 +20,7 @@
 #include "chardev/char-fe.h"
 #include <infiniband/verbs.h>
 #include "contrib/rdmacm-mux/rdmacm-mux.h"
+#include "rdma_utils.h"
 
 typedef struct RdmaDeviceResources RdmaDeviceResources;
 
@@ -30,11 +31,6 @@ typedef struct RdmaBackendThread {
     bool is_running; /* Set by the thread to report its status */
 } RdmaBackendThread;
 
-typedef struct RecvMadList {
-    QemuMutex lock;
-    QList *list;
-} RecvMadList;
-
 typedef struct RdmaCmMux {
     CharBackend *chr_be;
     int can_receive;
@@ -48,7 +44,7 @@ typedef struct RdmaBackendDev {
     struct ibv_context *context;
     struct ibv_comp_channel *channel;
     uint8_t port_num;
-    RecvMadList recv_mads_list;
+    RdmaProtectedQList recv_mads_list;
     RdmaCmMux rdmacm_mux;
 } RdmaBackendDev;
 
diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index f1c980c6be..672a09079a 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -14,6 +14,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnum.h"
 #include "trace.h"
 #include "rdma_utils.h"
 
@@ -55,3 +57,40 @@ void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
         pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
     }
 }
+
+void rdma_protected_qlist_init(RdmaProtectedQList *list)
+{
+    qemu_mutex_init(&list->lock);
+    list->list = qlist_new();
+}
+
+void rdma_protected_qlist_destroy(RdmaProtectedQList *list)
+{
+    if (list->list) {
+        qlist_destroy_obj(QOBJECT(list->list));
+        qemu_mutex_destroy(&list->lock);
+        list->list = NULL;
+    }
+}
+
+void rdma_protected_qlist_append_int64(RdmaProtectedQList *list, int64_t value)
+{
+    qemu_mutex_lock(&list->lock);
+    qlist_append_int(list->list, value);
+    qemu_mutex_unlock(&list->lock);
+}
+
+int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list)
+{
+    QObject *obj;
+
+    qemu_mutex_lock(&list->lock);
+    obj = qlist_pop(list->list);
+    qemu_mutex_unlock(&list->lock);
+
+    if (!obj) {
+        return -ENOENT;
+    }
+
+    return qnum_get_uint(qobject_to(QNum, obj));
+}
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index acd148837f..a8bf1d4fec 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -29,8 +29,17 @@
 #define rdma_info_report(fmt, ...) \
     info_report("%s: " fmt, "rdma", ## __VA_ARGS__)
 
+typedef struct RdmaProtectedQList {
+    QemuMutex lock;
+    QList *list;
+} RdmaProtectedQList;
+
 void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
 void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
+void rdma_protected_qlist_init(RdmaProtectedQList *list);
+void rdma_protected_qlist_destroy(RdmaProtectedQList *list);
+void rdma_protected_qlist_append_int64(RdmaProtectedQList *list, int64_t value);
+int64_t rdma_protected_qlist_pop_int64(RdmaProtectedQList *list);
 
 static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)
 {
-- 
2.17.2
