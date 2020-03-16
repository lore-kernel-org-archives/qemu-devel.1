Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF96C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139A920679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139A920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsxm-0003gc-83
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqkx-0000DH-0H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqkr-0002ZP-0C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqkm-0007ls-Gp; Mon, 16 Mar 2020 10:30:04 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 21409BF8F5;
 Mon, 16 Mar 2020 14:29:43 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 15/42] nvme: additional tracing
Date: Mon, 16 Mar 2020 07:29:01 -0700
Message-Id: <20200316142928.153431-16-its@irrelevant.dk>
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

Add additional trace calls for nvme_enqueue_req_completion, mmio and
doorbell writes.

Also, streamline nvme_identify_ns and nvme_identify_ns_list. They do not
need to repeat the command, it is already in the trace name.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 10 ++++++++++
 hw/block/trace-events |  9 +++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index eb9c722df968..85c7c86b35f0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -320,6 +320,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
+    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
+                                          req->status);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -1527,6 +1529,8 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr=
 addr, unsigned size)
     uint8_t *ptr =3D (uint8_t *)&n->bar;
     uint64_t val =3D 0;
=20
+    trace_nvme_dev_mmio_read(addr);
+
     if (unlikely(addr & (sizeof(uint32_t) - 1))) {
         NVME_GUEST_ERR(nvme_dev_ub_mmiord_misaligned32,
                        "MMIO read not 32-bit aligned,"
@@ -1601,6 +1605,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
             return;
         }
=20
+        trace_nvme_dev_mmio_doorbell_cq(cq->cqid, new_head);
+
         start_sqs =3D nvme_cq_full(cq) ? 1 : 0;
         cq->head =3D new_head;
         if (start_sqs) {
@@ -1653,6 +1659,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
             return;
         }
=20
+        trace_nvme_dev_mmio_doorbell_sq(sq->sqid, new_tail);
+
         sq->tail =3D new_tail;
         timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500=
);
     }
@@ -1661,6 +1669,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
 static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
     unsigned size)
 {
+    trace_nvme_dev_mmio_write(addr, data);
+
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
     if (addr < sizeof(n->bar)) {
         nvme_write_bar(n, addr, data, size);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 4cf39961989d..dde1d22bc39a 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -39,8 +39,8 @@ nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16=
_t vector, uint16_t size,
 nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16=
""
 nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu1=
6""
 nvme_dev_identify_ctrl(void) "identify controller"
-nvme_dev_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
-nvme_dev_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%=
"PRIu16""
+nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
+nvme_dev_identify_nslist(uint32_t ns) "nsid %"PRIu32""
 nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx=
32""
 nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16=
" fid 0x%"PRIx32" val 0x%"PRIx32""
 nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
@@ -54,10 +54,13 @@ nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
 nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
 nvme_dev_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x=
%"PRIx8""
 nvme_dev_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type=
 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_dev_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t st=
atus) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
 nvme_dev_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "typ=
e 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 nvme_dev_enqueue_event_noqueue(int queued) "queued %d"
 nvme_dev_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
 nvme_dev_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
+nvme_dev_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
+nvme_dev_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data=
 0x%"PRIx64""
 nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D=
0x%"PRIx64""
@@ -70,6 +73,8 @@ nvme_dev_mmio_start_success(void) "setting controller e=
nable bit succeeded"
 nvme_dev_mmio_stopped(void) "cleared controller enable bit"
 nvme_dev_mmio_shutdown_set(void) "shutdown bit set"
 nvme_dev_mmio_shutdown_cleared(void) "shutdown bit cleared"
+nvme_dev_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu=
16" new_head %"PRIu16""
+nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu=
16" new_tail %"PRIu16""
=20
 # nvme traces for error conditions
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
--=20
2.25.1


