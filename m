Received: from eggs.gnu.org ([2001:4830:134:3::10]:45521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGE-0000yE-8B
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGB-0006O1-Lq
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:43 +0200
Message-Id: <1496070414-6744-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] nvme: Add support for Controller Memory
 Buffers
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

From: Stephen Bates <sbates@raithlin.com>

Implement NVMe Controller Memory Buffers (CMBs) which were added in
version 1.2 of the NVMe Specification. This patch adds an optional
argument (cmb_size_mb) which indicates the size of the CMB (in
MB). Currently only the Submission Queue Support (SQS) is enabled
which aligns with the current Linux driver for NVMe.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7428db9..381dc7c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
  *
  *  http://www.nvmexpress.org/resources/
  */
@@ -17,7 +17,11 @@
 /**
  * Usage: add options:
  *      -drive file=<file>,if=none,id=<drive_id>
- *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>
+ *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
+ *              cmb_size_mb=<cmb_size_mb[optional]>
+ *
+ * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
+ * offset 0 in BAR2 and supports SQS only for now.
  */
 
 #include "qemu/osdep.h"
@@ -34,6 +38,16 @@
 
 static void nvme_process_sq(void *opaque);
 
+static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
+{
+    if (n->cmbsz && addr >= n->ctrl_mem.addr &&
+                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))) {
+        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+    } else {
+        pci_dma_read(&n->parent_obj, addr, buf, size);
+    }
+}
+
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
     return sqid < n->num_queues && n->sq[sqid] != NULL ? 0 : -1;
@@ -637,7 +651,7 @@ static void nvme_process_sq(void *opaque)
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->dma_addr + sq->head * n->sqe_size;
-        pci_dma_read(&n->parent_obj, addr, (void *)&cmd, sizeof(cmd));
+        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
         nvme_inc_sq_head(sq);
 
         req = QTAILQ_FIRST(&sq->req_list);
@@ -852,6 +866,32 @@ static const MemoryRegionOps nvme_mmio_ops = {
     },
 };
 
+static void nvme_cmb_write(void *opaque, hwaddr addr, uint64_t data,
+    unsigned size)
+{
+    NvmeCtrl *n = (NvmeCtrl *)opaque;
+    memcpy(&n->cmbuf[addr], &data, size);
+}
+
+static uint64_t nvme_cmb_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+    NvmeCtrl *n = (NvmeCtrl *)opaque;
+
+    memcpy(&val, &n->cmbuf[addr], size);
+    return val;
+}
+
+static const MemoryRegionOps nvme_cmb_ops = {
+    .read = nvme_cmb_read,
+    .write = nvme_cmb_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 8,
+    },
+};
+
 static int nvme_init(PCIDevice *pci_dev)
 {
     NvmeCtrl *n = NVME(pci_dev);
@@ -936,9 +976,31 @@ static int nvme_init(PCIDevice *pci_dev)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
-    n->bar.vs = 0x00010100;
+    n->bar.vs = 0x00010200;
     n->bar.intmc = n->bar.intms = 0;
 
+    if (n->cmb_size_mb) {
+
+        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
+        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+
+        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
+
+        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+        pci_register_bar(&n->parent_obj, NVME_CMBLOC_BIR(n->bar.cmbloc),
+            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
+            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+
+    }
+
     for (i = 0; i < n->num_namespaces; i++) {
         NvmeNamespace *ns = &n->namespaces[i];
         NvmeIdNs *id_ns = &ns->id_ns;
@@ -964,12 +1026,17 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
+    if (n->cmbsz) {
+        memory_region_unref(&n->ctrl_mem);
+    }
+
     msix_uninit_exclusive_bar(pci_dev);
 }
 
 static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
     DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
+    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index a0d1564..b4961d2 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -14,6 +14,8 @@ typedef struct NvmeBar {
     uint32_t    aqa;
     uint64_t    asq;
     uint64_t    acq;
+    uint32_t    cmbloc;
+    uint32_t    cmbsz;
 } NvmeBar;
 
 enum NvmeCapShift {
@@ -138,6 +140,72 @@ enum NvmeAqaMask {
 #define NVME_AQA_ASQS(aqa) ((aqa >> AQA_ASQS_SHIFT) & AQA_ASQS_MASK)
 #define NVME_AQA_ACQS(aqa) ((aqa >> AQA_ACQS_SHIFT) & AQA_ACQS_MASK)
 
+enum NvmeCmblocShift {
+    CMBLOC_BIR_SHIFT  = 0,
+    CMBLOC_OFST_SHIFT = 12,
+};
+
+enum NvmeCmblocMask {
+    CMBLOC_BIR_MASK  = 0x7,
+    CMBLOC_OFST_MASK = 0xfffff,
+};
+
+#define NVME_CMBLOC_BIR(cmbloc) ((cmbloc >> CMBLOC_BIR_SHIFT)  & \
+                                 CMBLOC_BIR_MASK)
+#define NVME_CMBLOC_OFST(cmbloc)((cmbloc >> CMBLOC_OFST_SHIFT) & \
+                                 CMBLOC_OFST_MASK)
+
+#define NVME_CMBLOC_SET_BIR(cmbloc, val)  \
+    (cmbloc |= (uint64_t)(val & CMBLOC_BIR_MASK) << CMBLOC_BIR_SHIFT)
+#define NVME_CMBLOC_SET_OFST(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_OFST_MASK) << CMBLOC_OFST_SHIFT)
+
+enum NvmeCmbszShift {
+    CMBSZ_SQS_SHIFT   = 0,
+    CMBSZ_CQS_SHIFT   = 1,
+    CMBSZ_LISTS_SHIFT = 2,
+    CMBSZ_RDS_SHIFT   = 3,
+    CMBSZ_WDS_SHIFT   = 4,
+    CMBSZ_SZU_SHIFT   = 8,
+    CMBSZ_SZ_SHIFT    = 12,
+};
+
+enum NvmeCmbszMask {
+    CMBSZ_SQS_MASK   = 0x1,
+    CMBSZ_CQS_MASK   = 0x1,
+    CMBSZ_LISTS_MASK = 0x1,
+    CMBSZ_RDS_MASK   = 0x1,
+    CMBSZ_WDS_MASK   = 0x1,
+    CMBSZ_SZU_MASK   = 0xf,
+    CMBSZ_SZ_MASK    = 0xfffff,
+};
+
+#define NVME_CMBSZ_SQS(cmbsz)  ((cmbsz >> CMBSZ_SQS_SHIFT)   & CMBSZ_SQS_MASK)
+#define NVME_CMBSZ_CQS(cmbsz)  ((cmbsz >> CMBSZ_CQS_SHIFT)   & CMBSZ_CQS_MASK)
+#define NVME_CMBSZ_LISTS(cmbsz)((cmbsz >> CMBSZ_LISTS_SHIFT) & CMBSZ_LISTS_MASK)
+#define NVME_CMBSZ_RDS(cmbsz)  ((cmbsz >> CMBSZ_RDS_SHIFT)   & CMBSZ_RDS_MASK)
+#define NVME_CMBSZ_WDS(cmbsz)  ((cmbsz >> CMBSZ_WDS_SHIFT)   & CMBSZ_WDS_MASK)
+#define NVME_CMBSZ_SZU(cmbsz)  ((cmbsz >> CMBSZ_SZU_SHIFT)   & CMBSZ_SZU_MASK)
+#define NVME_CMBSZ_SZ(cmbsz)   ((cmbsz >> CMBSZ_SZ_SHIFT)    & CMBSZ_SZ_MASK)
+
+#define NVME_CMBSZ_SET_SQS(cmbsz, val)   \
+    (cmbsz |= (uint64_t)(val &  CMBSZ_SQS_MASK)  << CMBSZ_SQS_SHIFT)
+#define NVME_CMBSZ_SET_CQS(cmbsz, val)   \
+    (cmbsz |= (uint64_t)(val & CMBSZ_CQS_MASK) << CMBSZ_CQS_SHIFT)
+#define NVME_CMBSZ_SET_LISTS(cmbsz, val) \
+    (cmbsz |= (uint64_t)(val & CMBSZ_LISTS_MASK) << CMBSZ_LISTS_SHIFT)
+#define NVME_CMBSZ_SET_RDS(cmbsz, val)   \
+    (cmbsz |= (uint64_t)(val & CMBSZ_RDS_MASK) << CMBSZ_RDS_SHIFT)
+#define NVME_CMBSZ_SET_WDS(cmbsz, val)   \
+    (cmbsz |= (uint64_t)(val & CMBSZ_WDS_MASK) << CMBSZ_WDS_SHIFT)
+#define NVME_CMBSZ_SET_SZU(cmbsz, val)   \
+    (cmbsz |= (uint64_t)(val & CMBSZ_SZU_MASK) << CMBSZ_SZU_SHIFT)
+#define NVME_CMBSZ_SET_SZ(cmbsz, val)    \
+    (cmbsz |= (uint64_t)(val & CMBSZ_SZ_MASK) << CMBSZ_SZ_SHIFT)
+
+#define NVME_CMBSZ_GETSIZE(cmbsz) \
+    (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
     uint8_t     fuse;
@@ -688,6 +756,7 @@ typedef struct NvmeNamespace {
 typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
     MemoryRegion iomem;
+    MemoryRegion ctrl_mem;
     NvmeBar      bar;
     BlockConf    conf;
 
@@ -701,6 +770,10 @@ typedef struct NvmeCtrl {
     uint32_t    num_queues;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint32_t    cmb_size_mb;
+    uint32_t    cmbsz;
+    uint32_t    cmbloc;
+    uint8_t     *cmbuf;
 
     char            *serial;
     NvmeNamespace   *namespaces;
-- 
1.8.3.1
