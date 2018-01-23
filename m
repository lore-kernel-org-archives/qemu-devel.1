Received: from eggs.gnu.org ([2001:4830:134:3::10]:57594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9e-0003NQ-MF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9Y-0005k6-Jb
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:34 +0100
Message-Id: <20180123140201.31163-3-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/29] hw/block: Fix pin-based interrupt
 behaviour of NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Hikaru Nishida <hikarupsp@gmail.com>

Pin-based interrupt of NVMe controller did not work properly
because using an obsolated function pci_irq_pulse().
To fix this, change to use pci_irq_assert() / pci_irq_deassert()
instead of pci_irq_pulse().

Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.h |  1 +
 hw/block/nvme.c | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 6aab338ff5..7b62dad072 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -775,6 +775,7 @@ typedef struct NvmeCtrl {
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
+    uint64_t    irq_status;
 
     char            *serial;
     NvmeNamespace   *namespaces;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1ac356d3a5..51a58fefba 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -91,7 +91,19 @@ static uint8_t nvme_sq_empty(NvmeSQueue *sq)
     return sq->head == sq->tail;
 }
 
-static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
+static void nvme_irq_check(NvmeCtrl *n)
+{
+    if (msix_enabled(&(n->parent_obj))) {
+        return;
+    }
+    if (~n->bar.intms & n->irq_status) {
+        pci_irq_assert(&n->parent_obj);
+    } else {
+        pci_irq_deassert(&n->parent_obj);
+    }
+}
+
+static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue *cq)
 {
     if (cq->irq_enabled) {
         if (msix_enabled(&(n->parent_obj))) {
@@ -99,13 +111,28 @@ static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
             trace_nvme_irq_pin();
-            pci_irq_pulse(&n->parent_obj);
+            assert(cq->cqid < 64);
+            n->irq_status |= 1 << cq->cqid;
+            nvme_irq_check(n);
         }
     } else {
         trace_nvme_irq_masked();
     }
 }
 
+static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
+{
+    if (cq->irq_enabled) {
+        if (msix_enabled(&(n->parent_obj))) {
+            return;
+        } else {
+            assert(cq->cqid < 64);
+            n->irq_status &= ~(1 << cq->cqid);
+            nvme_irq_check(n);
+        }
+    }
+}
+
 static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
@@ -242,7 +269,7 @@ static void nvme_post_cqes(void *opaque)
             sizeof(req->cqe));
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
-    nvme_isr_notify(n, cq);
+    nvme_irq_assert(n, cq);
 }
 
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
@@ -905,6 +932,7 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         n->bar.intmc = n->bar.intms;
         trace_nvme_mmio_intm_set(data & 0xffffffff,
                                  n->bar.intmc);
+        nvme_irq_check(n);
         break;
     case 0x10:  /* INTMC */
         if (unlikely(msix_enabled(&(n->parent_obj)))) {
@@ -917,6 +945,7 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         n->bar.intmc = n->bar.intms;
         trace_nvme_mmio_intm_clr(data & 0xffffffff,
                                  n->bar.intmc);
+        nvme_irq_check(n);
         break;
     case 0x14:  /* CC */
         trace_nvme_mmio_cfg(data & 0xffffffff);
@@ -1085,8 +1114,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
         }
 
-        if (cq->tail != cq->head) {
-            nvme_isr_notify(n, cq);
+        if (cq->tail == cq->head) {
+            nvme_irq_deassert(n, cq);
         }
     } else {
         /* Submission queue doorbell write */
-- 
2.13.6
