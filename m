Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8C92067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8C92067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jijaF-0000qx-OZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXJ-00061I-2x; Tue, 09 Jun 2020 15:03:49 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jijXG-0006he-QM; Tue, 09 Jun 2020 15:03:48 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DDA31BF533;
 Tue,  9 Jun 2020 19:03:44 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 08/22] hw/block/nvme: add max_ioqpairs device parameter
Date: Tue,  9 Jun 2020 21:03:19 +0200
Message-Id: <20200609190333.59390-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609190333.59390-1-its@irrelevant.dk>
References: <20200609190333.59390-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 14:38:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The num_queues device paramater has a slightly confusing meaning because
it accounts for the admin queue pair which is not really optional.
Secondly, it is really a maximum value of queues allowed.

Add a new max_ioqpairs parameter that only accounts for I/O queue pairs,
but keep num_queues for compatibility.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20200514044611.734782-10-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 51 ++++++++++++++++++++++++++++++-------------------
 hw/block/nvme.h |  3 ++-
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ee514625ee85..1c1d2f8b7768 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -20,7 +20,7 @@
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
  *              cmb_size_mb=<cmb_size_mb[optional]>, \
  *              [pmrdev=<mem_backend_file_id>,] \
- *              num_queues=<N[optional]>
+ *              max_ioqpairs=<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -36,6 +36,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/error-report.h"
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -85,12 +86,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->params.num_queues && n->sq[sqid] != NULL ? 0 : -1;
+    return sqid < n->params.max_ioqpairs + 1 && n->sq[sqid] != NULL ? 0 : -1;
 }
 
 static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
 {
-    return cqid < n->params.num_queues && n->cq[cqid] != NULL ? 0 : -1;
+    return cqid < n->params.max_ioqpairs + 1 && n->cq[cqid] != NULL ? 0 : -1;
 }
 
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -656,7 +657,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
-    if (unlikely(vector > n->params.num_queues)) {
+    if (unlikely(vector > n->params.max_ioqpairs)) {
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -808,8 +809,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result = cpu_to_le32((n->params.num_queues - 2) |
-                             ((n->params.num_queues - 2) << 16));
+        result = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                             ((n->params.max_ioqpairs - 1) << 16));
         trace_pci_nvme_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -853,10 +854,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_NUMBER_OF_QUEUES:
         trace_pci_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
                                     ((dw11 >> 16) & 0xFFFF) + 1,
-                                    n->params.num_queues - 1,
-                                    n->params.num_queues - 1);
-        req->cqe.result = cpu_to_le32((n->params.num_queues - 2) |
-                                      ((n->params.num_queues - 2) << 16));
+                                    n->params.max_ioqpairs,
+                                    n->params.max_ioqpairs);
+        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                      ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
@@ -927,12 +928,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
 
     blk_drain(n->conf.blk);
 
-    for (i = 0; i < n->params.num_queues; i++) {
+    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i = 0; i < n->params.num_queues; i++) {
+    for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->cq[i] != NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -1362,8 +1363,17 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     int64_t bs_size;
     uint8_t *pci_conf;
 
-    if (!n->params.num_queues) {
-        error_setg(errp, "num_queues can't be zero");
+    if (n->params.num_queues) {
+        warn_report("num_queues is deprecated; please use max_ioqpairs "
+                    "instead");
+
+        n->params.max_ioqpairs = n->params.num_queues - 1;
+    }
+
+    if (n->params.max_ioqpairs < 1 ||
+        n->params.max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
+        error_setg(errp, "max_ioqpairs must be between 1 and %d",
+                   PCI_MSIX_FLAGS_QSIZE);
         return;
     }
 
@@ -1413,21 +1423,21 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
     n->num_namespaces = 1;
 
-    /* num_queues is really number of pairs, so each has two doorbells */
+    /* add one to max_ioqpairs to account for the admin queue pair */
     n->reg_size = pow2ceil(NVME_REG_SIZE +
-                           2 * n->params.num_queues * NVME_DB_SIZE);
+                           2 * (n->params.max_ioqpairs + 1) * NVME_DB_SIZE);
     n->ns_size = bs_size / (uint64_t)n->num_namespaces;
 
     n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
-    n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
+    n->sq = g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
+    n->cq = g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
 
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL);
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -1573,7 +1583,8 @@ static Property nvme_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
-    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 64),
+    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
+    DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 91f16c812582..26c38bd913be 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -5,7 +5,8 @@
 
 typedef struct NvmeParams {
     char     *serial;
-    uint32_t num_queues;
+    uint32_t num_queues; /* deprecated since 5.1 */
+    uint32_t max_ioqpairs;
     uint32_t cmb_size_mb;
 } NvmeParams;
 
-- 
2.27.0


