Received: from eggs.gnu.org ([2001:4830:134:3::10]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhcwhu@gmail.com>) id 1esw8k-0004Q8-Mw
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhcwhu@gmail.com>) id 1esw8h-0005Bj-AJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:51:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhcwhu@gmail.com>) id 1esw8g-0005Ba-VG
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:51:15 -0500
Received: by mail-wm0-f66.google.com with SMTP id 188so17866242wme.1
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 11:51:14 -0800 (PST)
Date: Mon, 5 Mar 2018 13:49:10 -0600
From: Huaicheng Li <huaicheng@cs.uchicago.edu>
Message-ID: <20180305194906.GA3630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] hw/block/nvme: Add doorbell buffer config
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, keith.busch@intel.com

This patch adds Doorbell Buffer Config support (NVMe 1.3) to QEMU NVMe,
based on Mihai Rusu / Lin Ming's Google vendor extension patch [1]. The
basic idea of this optimization is to use a shared buffer between guest
OS and QEMU to reduce # of MMIO operations (doorbell writes). This patch
ports the original code to work under current QEMU and make it also
work with SPDK.

Unlike Linux kernel NVMe driver which builds the shadow buffer first and
then creates SQ/CQ, SPDK first creates SQ/CQ and then issues this command
to create shadow buffer. Thus, in this implementation, we also try to
associate shadow buffer entry with each SQ/CQ during queue initialization.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2015-11/msg04127.html

Peroformance results using a **ramdisk** backed virtual NVMe device in guest
Linux 4.14 is as below:

Note: "QEMU" represent stock QEMU and "+dbbuf" is QEMU with this patch.
For psync, QD represents # of threads being used.


IOPS (Linux kernel NVMe driver)
       psync                 libaio
QD QEMU  +dbbuf  QEMU +dbbuf
1      47k      50k      45k    47k
4      86k      107k     59k   143k
16    95k      198k     58k   185k
64    97k      259k     59k   216k


 IOPS (SPDK)
QD  QEMU  +dbbuf
1      62k     71k
4      61k     191k
16    60k     319k
64    62k     364k

We can see that this patch can greatly increase the IOPS (and lower the
latency, not shown) (2.7x for psync, 3.7x for libaio and 5.9x for SPDK).

==Setup==:

(1) VM script:
x86_64-softmmu/qemu-system-x86_64 \
-name "nvme-FEMU-test" \
-enable-kvm \
-cpu host \
-smp 4 \
-m 8G \
-drive file=$IMGDIR/u14s.qcow2,if=ide,aio=native,cache=none,format=qcow2,id=hd0 \
-drive file=/mnt/tmpfs/test1.raw,if=none,aio=threads,format=raw,id=id0 \
-device nvme,drive=id0,serial=serial0,id=nvme0 \
-net user,hostfwd=tcp::8080-:22 \
-net nic,model=virtio \
-nographic \

(2) FIO configuration:

[global]
ioengine=libaio
filename=/dev/nvme0n1
thread=1
group_reporting=1
direct=1
verify=0
time_based=1
ramp_time=0
runtime=30
;size=1G
iodepth=16
rw=randread
bs=4k

[test]
numjobs=1


Signed-off-by: Huaicheng Li <huaicheng@cs.uchicago.edu>
---
 hw/block/nvme.c      | 97 +++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h      |  7 ++++
 include/block/nvme.h |  2 ++
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 85d2406400..3882037e36 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.3, 1.2, 1.1, 1.0e
  *
  *  http://www.nvmexpress.org/resources/
  */
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/block-backend.h"
+#include "exec/memory.h"
 
 #include "qemu/log.h"
 #include "trace.h"
@@ -244,6 +245,14 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     return status;
 }
 
+static void nvme_update_cq_head(NvmeCQueue *cq)
+{
+    if (cq->db_addr) {
+        pci_dma_read(&cq->ctrl->parent_obj, cq->db_addr, &cq->head,
+                sizeof(cq->head));
+    }
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq = opaque;
@@ -254,6 +263,8 @@ static void nvme_post_cqes(void *opaque)
         NvmeSQueue *sq;
         hwaddr addr;
 
+        nvme_update_cq_head(cq);
+
         if (nvme_cq_full(cq)) {
             break;
         }
@@ -461,6 +472,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
 static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     uint16_t sqid, uint16_t cqid, uint16_t size)
 {
+    uint32_t stride = 4 << NVME_CAP_DSTRD(n->bar.cap);
     int i;
     NvmeCQueue *cq;
 
@@ -480,6 +492,11 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     }
     sq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
 
+    if (sqid && n->dbbuf_dbs && n->dbbuf_eis) {
+        sq->db_addr = n->dbbuf_dbs + 2 * sqid * stride;
+        sq->ei_addr = n->dbbuf_eis + 2 * sqid * stride;
+    }
+
     assert(n->cq[cqid]);
     cq = n->cq[cqid];
     QTAILQ_INSERT_TAIL(&(cq->sq_list), sq, entry);
@@ -559,6 +576,8 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
 static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     uint16_t cqid, uint16_t vector, uint16_t size, uint16_t irq_enabled)
 {
+    uint32_t stride = 4 << NVME_CAP_DSTRD(n->bar.cap);
+
     cq->ctrl = n;
     cq->cqid = cqid;
     cq->size = size;
@@ -569,11 +588,51 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     cq->head = cq->tail = 0;
     QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
+    if (cqid && n->dbbuf_dbs && n->dbbuf_eis) {
+        cq->db_addr = n->dbbuf_dbs + (2 * cqid + 1) * stride;
+        cq->ei_addr = n->dbbuf_eis + (2 * cqid + 1) * stride;
+    }
     msix_vector_use(&n->parent_obj, cq->vector);
     n->cq[cqid] = cq;
     cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
 }
 
+static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeCmd *cmd)
+{
+    uint32_t stride = 4 << NVME_CAP_DSTRD(n->bar.cap);
+    uint64_t dbs_addr = le64_to_cpu(cmd->prp1);
+    uint64_t eis_addr = le64_to_cpu(cmd->prp2);
+    int i;
+
+    /* Address should not be NULL and should be page aligned */
+    if (dbs_addr == 0 || dbs_addr & (n->page_size - 1) ||
+            eis_addr == 0 || eis_addr & (n->page_size - 1)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Save shadow buffer base addr for use during queue creation */
+    n->dbbuf_dbs = dbs_addr;
+    n->dbbuf_eis = eis_addr;
+
+    for (i = 1; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+        NvmeCQueue *cq = n->cq[i];
+
+        if (sq) {
+            /* Submission queue tail pointer location, 2 * QID * stride */
+            sq->db_addr = dbs_addr + 2 * i * stride;
+            sq->ei_addr = eis_addr + 2 * i * stride;
+        }
+
+        if (cq) {
+            /* Completion queue head pointer location, (2 * QID + 1) * stride */
+            cq->db_addr = dbs_addr + (2 * i + 1) * stride;
+            cq->ei_addr = eis_addr + (2 * i + 1) * stride;
+        }
+    }
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeCQueue *cq;
@@ -753,12 +812,30 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_DBBUF_CONFIG:
+        return nvme_dbbuf_config(n, cmd);
     default:
         trace_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
 
+static void nvme_update_sq_eventidx(const NvmeSQueue *sq)
+{
+    if (sq->ei_addr) {
+        pci_dma_write(&sq->ctrl->parent_obj, sq->ei_addr, &sq->tail,
+                sizeof(sq->tail));
+    }
+}
+
+static void nvme_update_sq_tail(NvmeSQueue *sq)
+{
+    if (sq->db_addr) {
+        pci_dma_read(&sq->ctrl->parent_obj, sq->db_addr, &sq->tail,
+                sizeof(sq->tail));
+    }
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq = opaque;
@@ -770,6 +847,8 @@ static void nvme_process_sq(void *opaque)
     NvmeCmd cmd;
     NvmeRequest *req;
 
+    nvme_update_sq_tail(sq);
+
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->dma_addr + sq->head * n->sqe_size;
         nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
@@ -787,6 +866,9 @@ static void nvme_process_sq(void *opaque)
             req->status = status;
             nvme_enqueue_req_completion(cq, req);
         }
+
+        nvme_update_sq_eventidx(sq);
+        nvme_update_sq_tail(sq);
     }
 }
 
@@ -1105,7 +1187,9 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         }
 
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
-        cq->head = new_head;
+        if (!cq->db_addr) {
+            cq->head = new_head;
+        }
         if (start_sqs) {
             NvmeSQueue *sq;
             QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
@@ -1142,7 +1226,9 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             return;
         }
 
-        sq->tail = new_tail;
+        if (!sq->db_addr) {
+            sq->tail = new_tail;
+        }
         timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
     }
 }
@@ -1256,7 +1342,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     id->ieee[0] = 0x00;
     id->ieee[1] = 0x02;
     id->ieee[2] = 0xb3;
-    id->oacs = cpu_to_le16(0);
+    id->oacs = cpu_to_le16(NVME_OACS_DBBUF);
     id->frmw = 7 << 1;
     id->lpa = 1 << 0;
     id->sqes = (0x6 << 4) | 0x6;
@@ -1320,6 +1406,9 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
             cpu_to_le64(n->ns_size >>
                 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
     }
+
+    n->dbbuf_dbs = 0;
+    n->dbbuf_eis = 0;
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8f3981121d..b532dbe160 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -33,6 +33,8 @@ typedef struct NvmeSQueue {
     QTAILQ_HEAD(sq_req_list, NvmeRequest) req_list;
     QTAILQ_HEAD(out_req_list, NvmeRequest) out_req_list;
     QTAILQ_ENTRY(NvmeSQueue) entry;
+    uint64_t    db_addr;
+    uint64_t    ei_addr;
 } NvmeSQueue;
 
 typedef struct NvmeCQueue {
@@ -48,6 +50,8 @@ typedef struct NvmeCQueue {
     QEMUTimer   *timer;
     QTAILQ_HEAD(sq_list, NvmeSQueue) sq_list;
     QTAILQ_HEAD(cq_req_list, NvmeRequest) req_list;
+    uint64_t    db_addr;
+    uint64_t    ei_addr;
 } NvmeCQueue;
 
 typedef struct NvmeNamespace {
@@ -88,6 +92,9 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+
+    uint64_t        dbbuf_dbs;
+    uint64_t        dbbuf_eis;
 } NvmeCtrl;
 
 #endif /* HW_NVME_H */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 849a6f3fa3..4890aaf491 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -235,6 +235,7 @@ enum NvmeAdminCommands {
     NVME_ADM_CMD_ASYNC_EV_REQ   = 0x0c,
     NVME_ADM_CMD_ACTIVATE_FW    = 0x10,
     NVME_ADM_CMD_DOWNLOAD_FW    = 0x11,
+    NVME_ADM_CMD_DBBUF_CONFIG   = 0x7c,
     NVME_ADM_CMD_FORMAT_NVM     = 0x80,
     NVME_ADM_CMD_SECURITY_SEND  = 0x81,
     NVME_ADM_CMD_SECURITY_RECV  = 0x82,
@@ -572,6 +573,7 @@ enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
     NVME_OACS_FW        = 1 << 2,
+    NVME_OACS_DBBUF     = 1 << 8,
 };
 
 enum NvmeIdCtrlOncs {
-- 
2.16.1
