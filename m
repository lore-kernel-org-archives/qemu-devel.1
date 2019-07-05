Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F8C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B25721738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B25721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIq1-0006pa-PV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZc-0005Hh-9i
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZZ-0005lc-Km
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:23:59 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZV-0005fq-3D; Fri, 05 Jul 2019 03:23:53 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 26C99BF69F;
 Fri,  5 Jul 2019 07:23:51 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:19 +0200
Message-Id: <20190705072333.17171-3-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 02/16] nvme: move device parameters to separate
 struct
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
Cc: kwolf@redhat.com, matt.fitzpatrick@oakgatetech.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move device configuration parameters to separate struct to make it
explicit what is configurable and what is set internally.

Also, clean up some includes.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 54 +++++++++++++++++++++++--------------------------
 hw/block/nvme.h | 16 ++++++++++++---
 2 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 28ebaf1368b1..a3f83f3c2135 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -27,18 +27,14 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
 #include "hw/block/block.h"
-#include "hw/hw.h"
 #include "hw/pci/msix.h"
-#include "hw/pci/pci.h"
 #include "sysemu/sysemu.h"
-#include "qapi/error.h"
-#include "qapi/visitor.h"
 #include "sysemu/block-backend.h"
+#include "qapi/error.h"
=20
-#include "qemu/log.h"
-#include "qemu/module.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 #include "nvme.h"
=20
@@ -63,12 +59,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->num_queues && n->sq[sqid] !=3D NULL ? 0 : -1;
+    return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
 }
=20
 static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
 {
-    return cqid < n->num_queues && n->cq[cqid] !=3D NULL ? 0 : -1;
+    return cqid < n->params.num_queues && n->cq[cqid] !=3D NULL ? 0 : -1=
;
 }
=20
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -630,7 +626,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
         trace_nvme_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (unlikely(vector > n->num_queues)) {
+    if (unlikely(vector > n->params.num_queues)) {
         trace_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -782,7 +778,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
+        result =3D cpu_to_le32((n->params.num_queues - 2) |
+            ((n->params.num_queues - 2) << 16));
         trace_nvme_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -827,9 +824,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     case NVME_NUMBER_OF_QUEUES:
         trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
                                 ((dw11 >> 16) & 0xFFFF) + 1,
-                                n->num_queues - 1, n->num_queues - 1);
-        req->cqe.result =3D
-            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
+                                n->params.num_queues - 1,
+                                n->params.num_queues - 1);
+        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
+            ((n->params.num_queues - 2) << 16));
         break;
=20
     case NVME_TIMESTAMP:
@@ -903,12 +901,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
=20
     blk_drain(n->conf.blk);
=20
-    for (i =3D 0; i < n->num_queues; i++) {
+    for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->sq[i] !=3D NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i =3D 0; i < n->num_queues; i++) {
+    for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->cq[i] !=3D NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -1311,7 +1309,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     int64_t bs_size;
     uint8_t *pci_conf;
=20
-    if (!n->num_queues) {
+    if (!n->params.num_queues) {
         error_setg(errp, "num_queues can't be zero");
         return;
     }
@@ -1327,7 +1325,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         return;
     }
=20
-    if (!n->serial) {
+    if (!n->params.serial) {
         error_setg(errp, "serial property not set");
         return;
     }
@@ -1344,24 +1342,24 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
     n->num_namespaces =3D 1;
-    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
+    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
     n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
-    n->sq =3D g_new0(NvmeSQueue *, n->num_queues);
-    n->cq =3D g_new0(NvmeCQueue *, n->num_queues);
+    n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
+    n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
=20
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
=20
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
     id->rab =3D 6;
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
@@ -1390,7 +1388,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     n->bar.vs =3D 0x00010200;
     n->bar.intmc =3D n->bar.intms =3D 0;
=20
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
=20
         NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
         NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
@@ -1401,7 +1399,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
=20
         n->cmbloc =3D n->bar.cmbloc;
         n->cmbsz =3D n->bar.cmbsz;
@@ -1429,7 +1427,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
=20
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
     }
     msix_uninit_exclusive_bar(pci_dev);
@@ -1437,9 +1435,7 @@ static void nvme_exit(PCIDevice *pci_dev)
=20
 static Property nvme_props[] =3D {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
-    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
-    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
-    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
+    DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 40cedb1ec932..77fe6fb46b71 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,7 +1,19 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
+
 #include "block/nvme.h"
=20
+#define DEFINE_NVME_PROPERTIES(_state, _props) \
+    DEFINE_PROP_STRING("serial", _state, _props.serial), \
+    DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+
+typedef struct NvmeParams {
+    char     *serial;
+    uint32_t num_queues;
+    uint32_t cmb_size_mb;
+} NvmeParams;
+
 typedef struct NvmeAsyncEvent {
     QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
@@ -63,6 +75,7 @@ typedef struct NvmeCtrl {
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
     BlockConf    conf;
+    NvmeParams   params;
=20
     uint32_t    page_size;
     uint16_t    page_bits;
@@ -71,10 +84,8 @@ typedef struct NvmeCtrl {
     uint16_t    sqe_size;
     uint32_t    reg_size;
     uint32_t    num_namespaces;
-    uint32_t    num_queues;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
-    uint32_t    cmb_size_mb;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
@@ -82,7 +93,6 @@ typedef struct NvmeCtrl {
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
=20
-    char            *serial;
     NvmeNamespace   namespace;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
--=20
2.20.1


