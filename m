Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E45C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4AF207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+VphW8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4AF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZT8-0006KE-Go
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNi-000324-95
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNf-0001hO-W0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JsuWQNMLKUx5eCDIz6whYhj2Lt5qPIjmQPTK3i+YhE=;
 b=T+VphW8rdMrZpjVyZq7AKFR6kVk46pxG0rTPjRzV56SoZb+BRORmKBVvr5K0RDM9xSaf6O
 RErXPijRa/698ACn8Ke/OgmWQmxHuWOJ2At0diOwoYA2tHji0oh24r7CyiODtX1Rspw2e1
 OGuUpAcFan6EHreX7aJdf2Qe97TddyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-5b64oG_5PIeiz4ufTz0WsQ-1; Wed, 17 Jun 2020 10:49:33 -0400
X-MC-Unique: 5b64oG_5PIeiz4ufTz0WsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0474880F5F0;
 Wed, 17 Jun 2020 14:49:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08CD17CAB0;
 Wed, 17 Jun 2020 14:49:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/43] hw/block/nvme: add max_ioqpairs device parameter
Date: Wed, 17 Jun 2020 16:48:40 +0200
Message-Id: <20200617144909.192176-15-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Message-Id: <20200609190333.59390-9-its@irrelevant.dk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.h |  3 ++-
 hw/block/nvme.c | 51 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 91f16c8125..26c38bd913 100644
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
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ee514625ee..1c1d2f8b77 100644
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
 
-- 
2.25.4


