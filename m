Received: from eggs.gnu.org ([209.51.188.92]:48217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5o-0007Iy-2i
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5m-0000Lz-VH
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5m-0000Lf-MG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:18 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:46 +0200
Message-Id: <20190131130850.6850-7-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 06/10] hw/pvrdma: Dump device statistics
 counters to file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma.h      |  1 +
 hw/rdma/vmw/pvrdma_main.c | 72 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 167706ec2c..dc10f21ca0 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -133,5 +133,6 @@ static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
 }
 
 int pvrdma_exec_cmd(PVRDMADev *dev);
+void pvrdma_dump_statistics(FILE *f, fprintf_function fprintf_func);
 
 #endif
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index cf82e78f08..79900076ec 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
@@ -36,6 +37,8 @@
 #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
 #include "pvrdma_qp_ops.h"
 
+GSList *devices;
+
 static Property pvrdma_dev_properties[] = {
     DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name),
     DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
@@ -55,6 +58,72 @@ static Property pvrdma_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void pvrdma_dump_device_statistics(gpointer data, gpointer user_data)
+{
+    CPUListState *s = user_data;
+    PCIDevice *pdev = data;
+    PVRDMADev *dev = PVRDMA_DEV(pdev);
+
+    (*s->cpu_fprintf)(s->file, "%s_%x.%x\n", pdev->name,
+                 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+    (*s->cpu_fprintf)(s->file, "\tcommands         : %" PRId64 "\n",
+                      dev->stats.commands);
+    (*s->cpu_fprintf)(s->file, "\ttx               : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.tx);
+    (*s->cpu_fprintf)(s->file, "\ttx_len           : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.tx_len);
+    (*s->cpu_fprintf)(s->file, "\ttx_err           : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.tx_err);
+    (*s->cpu_fprintf)(s->file, "\trx_bufs          : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.rx_bufs);
+    (*s->cpu_fprintf)(s->file, "\trx_bufs_len      : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.rx_bufs_len);
+    (*s->cpu_fprintf)(s->file, "\trx_bufs_err      : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.rx_bufs_err);
+    (*s->cpu_fprintf)(s->file, "\tcompletions      : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.completions);
+    (*s->cpu_fprintf)(s->file, "\tpoll_cq (bk)     : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.poll_cq_from_bk);
+    (*s->cpu_fprintf)(s->file, "\tpoll_cq_ppoll_to : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.poll_cq_ppoll_to);
+    (*s->cpu_fprintf)(s->file, "\tpoll_cq (fe)     : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.poll_cq_from_guest);
+    (*s->cpu_fprintf)(s->file, "\tmad_tx           : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.mad_tx);
+    (*s->cpu_fprintf)(s->file, "\tmad_tx_err       : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.mad_tx_err);
+    (*s->cpu_fprintf)(s->file, "\tmad_rx           : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.mad_rx);
+    (*s->cpu_fprintf)(s->file, "\tmad_rx_err       : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.mad_rx_err);
+    (*s->cpu_fprintf)(s->file, "\tmad_rx_bufs      : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.mad_rx_bufs);
+    (*s->cpu_fprintf)(s->file, "\tmad_rx_bufs_err  : %" PRId64 "\n",
+                      dev->rdma_dev_res.stats.mad_rx_bufs_err);
+    (*s->cpu_fprintf)(s->file, "\tPDs              : %" PRId32 "\n",
+                      dev->rdma_dev_res.pd_tbl.used);
+    (*s->cpu_fprintf)(s->file, "\tMRs              : %" PRId32 "\n",
+                      dev->rdma_dev_res.mr_tbl.used);
+    (*s->cpu_fprintf)(s->file, "\tUCs              : %" PRId32 "\n",
+                      dev->rdma_dev_res.uc_tbl.used);
+    (*s->cpu_fprintf)(s->file, "\tQPs              : %" PRId32 "\n",
+                      dev->rdma_dev_res.qp_tbl.used);
+    (*s->cpu_fprintf)(s->file, "\tCQs              : %" PRId32 "\n",
+                      dev->rdma_dev_res.cq_tbl.used);
+    (*s->cpu_fprintf)(s->file, "\tCEQ_CTXs         : %" PRId32 "\n",
+                      dev->rdma_dev_res.cqe_ctx_tbl.used);
+}
+
+void pvrdma_dump_statistics(FILE *f, fprintf_function fprintf_func)
+{
+    CPUListState s = {
+        .file = f,
+        .cpu_fprintf = fprintf_func,
+    };
+
+    g_slist_foreach(devices, pvrdma_dump_device_statistics, &s);
+}
+
 static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
                           void *ring_state)
 {
@@ -618,6 +687,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
     qemu_register_shutdown_notifier(&dev->shutdown_notifier);
 
+    devices = g_slist_append(devices, pdev);
+
 out:
     if (rc) {
         pvrdma_fini(pdev);
@@ -627,6 +698,7 @@ out:
 
 static void pvrdma_exit(PCIDevice *pdev)
 {
+    devices = g_slist_remove(devices, pdev);
     pvrdma_fini(pdev);
 }
 
-- 
2.17.2
