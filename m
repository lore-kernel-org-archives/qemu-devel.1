Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29496C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A442051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A442051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtDH-0007UL-4y
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlZ-0000bc-Jl
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlX-0006lf-Qy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:53 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqlQ-0003s5-TX; Mon, 16 Mar 2020 10:30:45 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 3931BBFA61;
 Mon, 16 Mar 2020 14:29:53 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 35/42] nvme: handle dma errors
Date: Mon, 16 Mar 2020 07:29:21 -0700
Message-Id: <20200316142928.153431-36-its@irrelevant.dk>
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

Handling DMA errors gracefully is required for the device to pass the
block/011 test ("disable PCI device while doing I/O") in the blktests
suite.

With this patch the device passes the test by retrying "critical"
transfers (posting of completion entries and processing of submission
queue entries).

If DMA errors occur at any other point in the execution of the command
(say, while mapping the PRPs), the command is aborted with a Data
Transfer Error status code.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 45 ++++++++++++++++++++++++++++++++-----------
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  2 +-
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 15ca2417af04..49d323566393 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -74,14 +74,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwad=
dr addr)
     return addr >=3D low && addr < hi;
 }
=20
-static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
+static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
-        return;
+        return 0;
     }
=20
-    pci_dma_read(&n->parent_obj, addr, buf, size);
+    return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
@@ -164,7 +164,7 @@ static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIO=
Vector *iov, hwaddr addr,
                                   size_t len)
 {
     if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) =
{
-        return NVME_DATA_TRAS_ERROR;
+        return NVME_DATA_TRANSFER_ERROR;
     }
=20
     qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
@@ -213,6 +213,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, QEMUIOVector *iov,
     int num_prps =3D (len >> n->page_bits) + 1;
     uint16_t status;
     bool prp_list_in_cmb =3D false;
+    int ret;
=20
     trace_nvme_dev_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
                            num_prps);
@@ -252,7 +253,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
=20
             nents =3D (len + n->page_size - 1) >> n->page_bits;
             prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(uint64_t)=
;
-            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            ret =3D nvme_addr_read(n, prp2, (void *)prp_list, prp_trans)=
;
+            if (ret) {
+                trace_nvme_dev_err_addr_read(prp2);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
             while (len !=3D 0) {
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
=20
@@ -271,8 +277,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
-                    nvme_addr_read(n, prp_ent, (void *)prp_list,
-                        prp_trans);
+                    ret =3D nvme_addr_read(n, prp_ent, (void *)prp_list,
+                                         prp_trans);
+                    if (ret) {
+                        trace_nvme_dev_err_addr_read(prp_ent);
+                        status =3D NVME_DATA_TRANSFER_ERROR;
+                        goto unmap;
+                    }
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
@@ -466,6 +477,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq =3D opaque;
     NvmeCtrl *n =3D cq->ctrl;
     NvmeRequest *req, *next;
+    int ret;
=20
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -475,15 +487,21 @@ static void nvme_post_cqes(void *opaque)
             break;
         }
=20
-        QTAILQ_REMOVE(&cq->req_list, req, entry);
         sq =3D req->sq;
         req->cqe.status =3D cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
         req->cqe.sq_head =3D cpu_to_le16(sq->head);
         addr =3D cq->dma_addr + cq->tail * n->cqe_size;
+        ret =3D pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
+                            sizeof(req->cqe));
+        if (ret) {
+            trace_nvme_dev_err_addr_write(addr);
+            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      500 * SCALE_MS);
+            break;
+        }
+        QTAILQ_REMOVE(&cq->req_list, req, entry);
         nvme_inc_cq_tail(cq);
-        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
-            sizeof(req->cqe));
         nvme_req_clear(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
@@ -1650,7 +1668,12 @@ static void nvme_process_sq(void *opaque)
=20
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr =3D sq->dma_addr + sq->head * n->sqe_size;
-        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
+        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
+            trace_nvme_dev_err_addr_read(addr);
+            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      500 * SCALE_MS);
+            break;
+        }
         nvme_inc_sq_head(sq);
=20
         req =3D QTAILQ_FIRST(&sq->req_list);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index aa449e314818..d51c09a4e454 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -87,6 +87,8 @@ nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_t=
ail) "cqid %"PRIu16" new_
 nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" =
mdts %"PRIu64" len %"PRIu64""
 nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"P=
RIu16""
 nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t =
offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %=
p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
+nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
+nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 293d68553538..d1ccde4cda4b 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -458,7 +458,7 @@ enum NvmeStatusCodes {
     NVME_INVALID_OPCODE         =3D 0x0001,
     NVME_INVALID_FIELD          =3D 0x0002,
     NVME_CID_CONFLICT           =3D 0x0003,
-    NVME_DATA_TRAS_ERROR        =3D 0x0004,
+    NVME_DATA_TRANSFER_ERROR    =3D 0x0004,
     NVME_POWER_LOSS_ABORT       =3D 0x0005,
     NVME_INTERNAL_DEV_ERROR     =3D 0x0006,
     NVME_CMD_ABORT_REQ          =3D 0x0007,
--=20
2.25.1


