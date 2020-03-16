Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06CBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C597820409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C597820409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsoH-000460-0h
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkZ-0008TB-5g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkX-0008PU-L9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:29:51 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkP-0007OB-9U; Mon, 16 Mar 2020 10:29:41 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id E2FDBBF5E1;
 Mon, 16 Mar 2020 14:29:39 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 09/42] nvme: add max_ioqpairs device parameter
Date: Mon, 16 Mar 2020 07:28:55 -0700
Message-Id: <20200316142928.153431-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
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
---
 hw/block/nvme.c | 45 ++++++++++++++++++++++++++-------------------
 hw/block/nvme.h |  4 +++-
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7cf7cf55143e..7dfd8a1a392d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -19,7 +19,7 @@
  *      -drive file=3D<file>,if=3Dnone,id=3D<drive_id>
  *      -device nvme,drive=3D<drive_id>,serial=3D<serial>,id=3D<id[optio=
nal]>, \
  *              cmb_size_mb=3D<cmb_size_mb[optional]>, \
- *              num_queues=3D<N[optional]>
+ *              max_ioqpairs=3D<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/error-report.h"
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -72,12 +73,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
+    return sqid < n->params.max_ioqpairs + 1 && n->sq[sqid] !=3D NULL ? =
0 : -1;
 }
=20
 static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
 {
-    return cqid < n->params.num_queues && n->cq[cqid] !=3D NULL ? 0 : -1=
;
+    return cqid < n->params.max_ioqpairs + 1 && n->cq[cqid] !=3D NULL ? =
0 : -1;
 }
=20
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -639,7 +640,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
         trace_nvme_dev_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (unlikely(vector > n->params.num_queues)) {
+    if (unlikely(vector > n->params.max_ioqpairs + 1)) {
         trace_nvme_dev_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -803,8 +804,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result =3D cpu_to_le32((n->params.num_queues - 2) |
-                             ((n->params.num_queues - 2) << 16));
+        result =3D cpu_to_le32((n->params.max_ioqpairs - 1) |
+                             ((n->params.max_ioqpairs - 1) << 16));
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -848,10 +849,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     case NVME_NUMBER_OF_QUEUES:
         trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
                                     ((dw11 >> 16) & 0xFFFF) + 1,
-                                    n->params.num_queues - 1,
-                                    n->params.num_queues - 1);
-        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
-                                      ((n->params.num_queues - 2) << 16)=
);
+                                    n->params.max_ioqpairs,
+                                    n->params.max_ioqpairs);
+        req->cqe.result =3D cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                      ((n->params.max_ioqpairs - 1) << 1=
6));
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
@@ -924,12 +925,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
=20
     blk_drain(n->conf.blk);
=20
-    for (i =3D 0; i < n->params.num_queues; i++) {
+    for (i =3D 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->sq[i] !=3D NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i =3D 0; i < n->params.num_queues; i++) {
+    for (i =3D 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->cq[i] !=3D NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -1332,9 +1333,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     int64_t bs_size;
     uint8_t *pci_conf;
=20
-    if (!n->params.num_queues) {
-        error_setg(errp, "num_queues can't be zero");
-        return;
+    if (n->params.num_queues) {
+        warn_report("nvme: num_queues is deprecated; please use max_ioqp=
airs "
+                    "instead");
+
+        n->params.max_ioqpairs =3D n->params.num_queues - 1;
+    }
+
+    if (!n->params.max_ioqpairs) {
+        error_setg(errp, "max_ioqpairs can't be less than 1");
     }
=20
     if (!n->conf.blk) {
@@ -1365,19 +1372,19 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
     n->num_namespaces =3D 1;
-    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
+    n->reg_size =3D pow2ceil(0x1008 + 2 * (n->params.max_ioqpairs) * 4);
     n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
-    n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+    n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
+    n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
=20
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.max_ioqpairs + 1, 4, NULL=
);
=20
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 9957c4a200e2..98f5b9479244 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,11 +6,13 @@
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
-    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
+    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
+    uint32_t max_ioqpairs;
     uint32_t cmb_size_mb;
 } NvmeParams;
=20
--=20
2.25.1


