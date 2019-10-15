Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC5C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534442089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534442089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKWI-0002cx-CB
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKFI-0008N7-Cy
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKFG-0006tZ-N7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:40:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:55022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKFD-0006Tq-6J; Tue, 15 Oct 2019 06:39:59 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 649CDBF80B;
 Tue, 15 Oct 2019 10:39:19 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 20/20] nvme: handle dma errors
Date: Tue, 15 Oct 2019 12:39:00 +0200
Message-Id: <20191015103900.313928-21-its@irrelevant.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015103900.313928-1-its@irrelevant.dk>
References: <20191015103900.313928-1-its@irrelevant.dk>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handling DMA errors gracefully is required for the device to pass the
block/011 test ("disable PCI device while doing I/O") in the blktests
suite.

With this patch the device passes the test by retrying "critical"
transfers (posting of completion entries and processing of submission
queue entries).

If DMA errors occur at any other point in the execution of the command
(say, while mapping the PRPs or SGLs), the command is aborted with a
Data Transfer Error status code.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 63 +++++++++++++++++++++++++++++++++----------
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  2 +-
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d0103c16cfe9..00c5b843295b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -71,26 +71,26 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwad=
dr addr)
     return addr >=3D low && addr < hi;
 }
=20
-static inline void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf,
+static inline int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf,
     int size)
 {
     if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
-        return;
+        return 0;
     }
=20
-    pci_dma_read(&n->parent_obj, addr, buf, size);
+    return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
=20
-static inline void nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf,
+static inline int nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf,
     int size)
 {
     if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy((void *) &n->cmbuf[addr - n->ctrl_mem.addr], buf, size);
-        return;
+        return 0;
     }
=20
-    pci_dma_write(&n->parent_obj, addr, buf, size);
+    return pci_dma_write(&n->parent_obj, addr, buf, size);
 }
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
@@ -228,7 +228,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, uint64_t prp1,
=20
             nents =3D (len + n->page_size - 1) >> n->page_bits;
             prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(uint64_t)=
;
-            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
+            if (nvme_addr_read(n, prp2, (void *) prp_list, prp_trans)) {
+                trace_nvme_err_addr_read((void *) prp2);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
             while (len !=3D 0) {
                 bool addr_is_cmb;
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
@@ -250,7 +254,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, uint64_t prp1,
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
-                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_tr=
ans);
+                    if (nvme_addr_read(n, prp_ent, (void *) prp_list, pr=
p_trans)) {
+                        trace_nvme_err_addr_read((void *) prp_ent);
+                        status =3D NVME_DATA_TRANSFER_ERROR;
+                        goto unmap;
+                    }
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
@@ -402,7 +410,11 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList=
 *qsg,
=20
         /* read the segment in chunks of 256 descriptors (4k) */
         while (nsgld > MAX_NSGLD) {
-            nvme_addr_read(n, addr, segment, sizeof(segment));
+            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
+                trace_nvme_err_addr_read((void *) addr);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
=20
             status =3D nvme_map_sgl_data(n, qsg, segment, MAX_NSGLD, &le=
n, req);
             if (status) {
@@ -413,7 +425,11 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList=
 *qsg,
             addr +=3D MAX_NSGLD * sizeof(NvmeSglDescriptor);
         }
=20
-        nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescripto=
r));
+        if (nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescr=
iptor))) {
+            trace_nvme_err_addr_read((void *) addr);
+            status =3D NVME_DATA_TRANSFER_ERROR;
+            goto unmap;
+        }
=20
         sgl =3D segment[nsgld - 1];
         addr =3D le64_to_cpu(sgl.addr);
@@ -458,7 +474,11 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList=
 *qsg,
     nsgld =3D le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
=20
     while (nsgld > MAX_NSGLD) {
-        nvme_addr_read(n, addr, segment, sizeof(segment));
+        if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
+            trace_nvme_err_addr_read((void *) addr);
+            status =3D NVME_DATA_TRANSFER_ERROR;
+            goto unmap;
+        }
=20
         status =3D nvme_map_sgl_data(n, qsg, segment, MAX_NSGLD, &len, r=
eq);
         if (status) {
@@ -469,7 +489,11 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList=
 *qsg,
         addr +=3D MAX_NSGLD * sizeof(NvmeSglDescriptor);
     }
=20
-    nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescriptor));
+    if (nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescripto=
r))) {
+        trace_nvme_err_addr_read((void *) addr);
+        status =3D NVME_DATA_TRANSFER_ERROR;
+        goto unmap;
+    }
=20
     status =3D nvme_map_sgl_data(n, qsg, segment, nsgld, &len, req);
     if (status) {
@@ -819,8 +843,14 @@ static void nvme_post_cqes(void *opaque)
         req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
         req->cqe.sq_head =3D cpu_to_le16(sq->head);
         addr =3D cq->dma_addr + cq->tail * n->cqe_size;
+        if (nvme_addr_write(n, addr, (void *) cqe, sizeof(*cqe))) {
+            trace_nvme_err_addr_write((void *) addr);
+            QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
+            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                100 * SCALE_MS);
+            break;
+        }
         nvme_inc_cq_tail(cq);
-        nvme_addr_write(n, addr, (void *) cqe, sizeof(*cqe));
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail !=3D cq->head) {
@@ -1937,7 +1967,12 @@ static void nvme_process_sq(void *opaque)
=20
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr =3D sq->dma_addr + sq->head * n->sqe_size;
-        nvme_addr_read(n, addr, (void *)&cmd, sizeof(NvmeCmd));
+        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(NvmeCmd))) {
+            trace_nvme_err_addr_read((void *) addr);
+            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                100 * SCALE_MS);
+            break;
+        }
         nvme_inc_sq_head(sq);
=20
         req =3D QTAILQ_FIRST(&sq->req_list);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 95c24f514754..54aa001bf52d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -84,6 +84,8 @@ nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 nvme_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts=
 %"PRIu64" len %"PRIu64""
 nvme_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu1=
6""
 nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offs=
et, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p bl=
k \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
+nvme_err_addr_read(void *addr) "addr %p"
+nvme_err_addr_write(void *addr) "addr %p"
 nvme_err_invalid_sgl_descriptor(uint16_t cid, uint8_t typ) "cid %"PRIu16=
" type 0x%"PRIx8""
 nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index ba0a9d4e328f..5a2075e739ee 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -459,7 +459,7 @@ enum NvmeStatusCodes {
     NVME_INVALID_OPCODE         =3D 0x0001,
     NVME_INVALID_FIELD          =3D 0x0002,
     NVME_CID_CONFLICT           =3D 0x0003,
-    NVME_DATA_TRAS_ERROR        =3D 0x0004,
+    NVME_DATA_TRANSFER_ERROR    =3D 0x0004,
     NVME_POWER_LOSS_ABORT       =3D 0x0005,
     NVME_INTERNAL_DEV_ERROR     =3D 0x0006,
     NVME_CMD_ABORT_REQ          =3D 0x0007,
--=20
2.23.0


