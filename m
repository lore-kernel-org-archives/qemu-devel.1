Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2176BC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC74B20767
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC74B20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObFh-0000OO-5I
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz1-0002tQ-Rq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayz-0002qh-4a
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayv-0002Z4-2O; Wed, 15 Apr 2020 01:53:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D029BBFD63;
 Wed, 15 Apr 2020 05:52:26 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 24/48] nvme: add mapping helpers
Date: Wed, 15 Apr 2020 07:51:16 +0200
Message-Id: <20200415055140.466900-25-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
use them in nvme_map_prp.

This fixes a bug where in the case of a CMB transfer, the device would
map to the buffer with a wrong length.

Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in =
CMBs.")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 105 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   1 +
 2 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1d4705693287..b62b053d7c38 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -59,6 +59,11 @@
=20
 static void nvme_process_sq(void *opaque);
=20
+static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
+{
+    return &n->cmbuf[addr - n->ctrl_mem.addr];
+}
+
 static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low =3D n->ctrl_mem.addr;
@@ -70,7 +75,7 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr=
 addr)
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
 {
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return;
     }
=20
@@ -153,29 +158,87 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQue=
ue *cq)
     }
 }
=20
+static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr=
 addr,
+                                  size_t len)
+{
+    if (!len) {
+        return NVME_SUCCESS;
+    }
+
+    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - =
1)) {
+        return NVME_DATA_TRAS_ERROR;
+    }
+
+    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector=
 *iov,
+                              hwaddr addr, size_t len)
+{
+    if (!len) {
+        return NVME_SUCCESS;
+    }
+
+    if (nvme_addr_is_cmb(n, addr)) {
+        if (qsg && qsg->sg) {
+            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+        }
+
+        assert(iov);
+
+        if (!iov->iov) {
+            qemu_iovec_init(iov, 1);
+        }
+
+        return nvme_map_addr_cmb(n, iov, addr, len);
+    }
+
+    if (iov && iov->iov) {
+        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+    }
+
+    assert(qsg);
+
+    if (!qsg->sg) {
+        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
+    }
+
+    qemu_sglist_add(qsg, addr, len);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_=
t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
     hwaddr trans_len =3D n->page_size - (prp1 % n->page_size);
     trans_len =3D MIN(len, trans_len);
     int num_prps =3D (len >> n->page_bits) + 1;
+    uint16_t status;
=20
     if (unlikely(!prp1)) {
         trace_nvme_dev_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->bar.cmbsz && prp1 >=3D n->ctrl_mem.addr &&
-               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
-        qsg->nsg =3D 0;
+    }
+
+    if (nvme_addr_is_cmb(n, prp1)) {
         qemu_iovec_init(iov, num_prps);
-        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], =
trans_len);
     } else {
         pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
-        qemu_sglist_add(qsg, prp1, trans_len);
     }
+
+    status =3D nvme_map_addr(n, qsg, iov, prp1, trans_len);
+    if (status) {
+        goto unmap;
+    }
+
     len -=3D trans_len;
     if (len) {
         if (unlikely(!prp2)) {
             trace_nvme_dev_err_invalid_prp2_missing();
+            status =3D NVME_INVALID_FIELD | NVME_DNR;
             goto unmap;
         }
         if (len > n->page_size) {
@@ -192,6 +255,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
                 if (i =3D=3D n->max_prp_ents - 1 && len > n->page_size) =
{
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1=
))) {
                         trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
+                        status =3D NVME_INVALID_FIELD | NVME_DNR;
                         goto unmap;
                     }
=20
@@ -205,14 +269,14 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUI=
OVector *iov, uint64_t prp1,
=20
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) =
{
                     trace_nvme_dev_err_invalid_prplist_ent(prp_ent);
+                    status =3D NVME_INVALID_FIELD | NVME_DNR;
                     goto unmap;
                 }
=20
                 trans_len =3D MIN(len, n->page_size);
-                if (qsg->nsg){
-                    qemu_sglist_add(qsg, prp_ent, trans_len);
-                } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->c=
trl_mem.addr], trans_len);
+                status =3D nvme_map_addr(n, qsg, iov, prp_ent, trans_len=
);
+                if (status) {
+                    goto unmap;
                 }
                 len -=3D trans_len;
                 i++;
@@ -220,20 +284,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUI=
OVector *iov, uint64_t prp1,
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_nvme_dev_err_invalid_prp2_align(prp2);
+                status =3D NVME_INVALID_FIELD | NVME_DNR;
                 goto unmap;
             }
-            if (qsg->nsg) {
-                qemu_sglist_add(qsg, prp2, len);
-            } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem=
.addr], trans_len);
+            status =3D nvme_map_addr(n, qsg, iov, prp2, len);
+            if (status) {
+                goto unmap;
             }
         }
     }
     return NVME_SUCCESS;
=20
- unmap:
-    qemu_sglist_destroy(qsg);
-    return NVME_INVALID_FIELD | NVME_DNR;
+unmap:
+    if (iov && iov->iov) {
+        qemu_iovec_destroy(iov);
+    }
+
+    if (qsg && qsg->sg) {
+        qemu_sglist_destroy(qsg);
+    }
+
+    return status;
 }
=20
 static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 7ecd47131ac2..aff67b52d1e8 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -33,6 +33,7 @@ nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ v=
ector %u"
 nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
 nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
+nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t=
 len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"=
PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64=
" num_prps %d"
 nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opco=
de) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 nvme_dev_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"P=
RIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, u=
int64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
--=20
2.26.0


