Received: from eggs.gnu.org ([2001:4830:134:3::10]:59215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1elIWy-0008HF-M7
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1elIWw-0002bN-GD
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:08:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1elIWw-0002b3-9t
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:08:42 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 12 Feb 2018 20:08:15 +0200
Message-Id: <20180212180819.82556-6-marcel@redhat.com>
In-Reply-To: <20180212180819.82556-1-marcel@redhat.com>
References: <20180212180819.82556-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V10 5/9] hw/rdma: Definitions for rdma device
 and rdma resource manager
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com

From: Yuval Shaia <yuval.shaia@oracle.com>

Definition of various structures and constants used in backend and
resource manager modules.

Reviewed-by: Dotan Barak <dotanb@mellanox.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/rdma/rdma_backend_defs.h |  62 ++++++++++++++++++++++++++
 hw/rdma/rdma_rm_defs.h      | 104 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 hw/rdma/rdma_backend_defs.h
 create mode 100644 hw/rdma/rdma_rm_defs.h

diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
new file mode 100644
index 0000000000..837e32419c
--- /dev/null
+++ b/hw/rdma/rdma_backend_defs.h
@@ -0,0 +1,62 @@
+/*
+ *  RDMA device: Definitions of Backend Device structures
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_BACKEND_DEFS_H
+#define RDMA_BACKEND_DEFS_H
+
+#include <infiniband/verbs.h>
+#include <qemu/thread.h>
+
+typedef struct RdmaDeviceResources RdmaDeviceResources;
+
+typedef struct RdmaBackendThread {
+    QemuThread thread;
+    QemuMutex mutex;
+    bool run;
+} RdmaBackendThread;
+
+typedef struct RdmaBackendDev {
+    struct ibv_device_attr dev_attr;
+    RdmaBackendThread comp_thread;
+    union ibv_gid gid;
+    PCIDevice *dev;
+    RdmaDeviceResources *rdma_dev_res;
+    struct ibv_device *ib_dev;
+    struct ibv_context *context;
+    struct ibv_comp_channel *channel;
+    uint8_t port_num;
+    uint8_t backend_gid_idx;
+} RdmaBackendDev;
+
+typedef struct RdmaBackendPD {
+    struct ibv_pd *ibpd;
+} RdmaBackendPD;
+
+typedef struct RdmaBackendMR {
+    struct ibv_pd *ibpd;
+    struct ibv_mr *ibmr;
+} RdmaBackendMR;
+
+typedef struct RdmaBackendCQ {
+    RdmaBackendDev *backend_dev;
+    struct ibv_cq *ibcq;
+} RdmaBackendCQ;
+
+typedef struct RdmaBackendQP {
+    struct ibv_pd *ibpd;
+    struct ibv_qp *ibqp;
+} RdmaBackendQP;
+
+#endif
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
new file mode 100644
index 0000000000..6522dca68f
--- /dev/null
+++ b/hw/rdma/rdma_rm_defs.h
@@ -0,0 +1,104 @@
+/*
+ * RDMA device: Definitions of Resource Manager structures
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMA_RM_DEFS_H
+#define RDMA_RM_DEFS_H
+
+#include "rdma_backend_defs.h"
+
+#define MAX_PORTS             1
+#define MAX_PORT_GIDS         1
+#define MAX_PORT_PKEYS        1
+#define MAX_PKEYS             1
+#define MAX_GIDS              2048
+#define MAX_UCS               512
+#define MAX_MR_SIZE           (1UL << 27)
+#define MAX_QP                1024
+#define MAX_SGE               4
+#define MAX_CQ                2048
+#define MAX_MR                1024
+#define MAX_PD                1024
+#define MAX_QP_RD_ATOM        16
+#define MAX_QP_INIT_RD_ATOM   16
+#define MAX_AH                64
+
+#define MAX_RMRESTBL_NAME_SZ 16
+typedef struct RdmaRmResTbl {
+    char name[MAX_RMRESTBL_NAME_SZ];
+    QemuMutex lock;
+    unsigned long *bitmap;
+    size_t tbl_sz;
+    size_t res_sz;
+    void *tbl;
+} RdmaRmResTbl;
+
+typedef struct RdmaRmPD {
+    RdmaBackendPD backend_pd;
+    uint32_t ctx_handle;
+} RdmaRmPD;
+
+typedef struct RdmaRmCQ {
+    RdmaBackendCQ backend_cq;
+    void *opaque;
+    bool notify;
+} RdmaRmCQ;
+
+typedef struct RdmaRmUserMR {
+    uint64_t host_virt;
+    uint64_t guest_start;
+    size_t length;
+} RdmaRmUserMR;
+
+/* MR (DMA region) */
+typedef struct RdmaRmMR {
+    RdmaBackendMR backend_mr;
+    RdmaRmUserMR user_mr;
+    uint32_t pd_handle;
+    uint32_t lkey;
+    uint32_t rkey;
+} RdmaRmMR;
+
+typedef struct RdmaRmUC {
+    uint64_t uc_handle;
+} RdmaRmUC;
+
+typedef struct RdmaRmQP {
+    RdmaBackendQP backend_qp;
+    void *opaque;
+    uint32_t qp_type;
+    uint32_t qpn;
+    uint32_t send_cq_handle;
+    uint32_t recv_cq_handle;
+    enum ibv_qp_state qp_state;
+} RdmaRmQP;
+
+typedef struct RdmaRmPort {
+    union ibv_gid gid_tbl[MAX_PORT_GIDS];
+    enum ibv_port_state state;
+    int *pkey_tbl; /* TODO: Not yet supported */
+} RdmaRmPort;
+
+typedef struct RdmaDeviceResources {
+    RdmaRmPort ports[MAX_PORTS];
+    RdmaRmResTbl pd_tbl;
+    RdmaRmResTbl mr_tbl;
+    RdmaRmResTbl uc_tbl;
+    RdmaRmResTbl qp_tbl;
+    RdmaRmResTbl cq_tbl;
+    RdmaRmResTbl cqe_ctx_tbl;
+    GHashTable *qp_hash; /* Keeps mapping between real and emulated */
+} RdmaDeviceResources;
+
+#endif
-- 
2.13.5
