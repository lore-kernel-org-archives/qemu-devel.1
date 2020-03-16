Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E54BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BEB2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BEB2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtBa-0003qm-0G
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlK-0000TV-Ll
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlH-0005C5-I4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:38 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDql9-0002BA-8L; Mon, 16 Mar 2020 10:30:27 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 431D2BFA0B;
 Mon, 16 Mar 2020 14:29:51 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 31/42] nvme: add check for prinfo
Date: Mon, 16 Mar 2020 07:29:17 -0700
Message-Id: <20200316142928.153431-32-its@irrelevant.dk>
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

Check the validity of the PRINFO field.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 50 ++++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |  1 +
 include/block/nvme.h  |  1 +
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7d5340c272c6..0d2b5b45b0c5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -505,6 +505,17 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, =
size_t len,
     return NVME_SUCCESS;
 }
=20
+static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
+                                         uint16_t ctrl, NvmeRequest *req=
)
+{
+    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK=
)) {
+        trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb,
                                          NvmeRequest *req)
@@ -564,11 +575,22 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeN=
amespace *ns, NvmeCmd *cmd,
     uint32_t nlb  =3D le16_to_cpu(rw->nlb) + 1;
     uint64_t offset =3D slba << data_shift;
     uint32_t count =3D nlb << data_shift;
+    uint16_t ctrl =3D le16_to_cpu(rw->control);
     uint16_t status;
=20
+    status =3D nvme_check_prinfo(n, ns, ctrl, req);
+    if (status) {
+        goto invalid;
+    }
+
+    if (ctrl & NVME_RW_PRINFO_PRCHK_MASK) {
+        status =3D NVME_INVALID_PROT_INFO | NVME_DNR;
+        goto invalid;
+    }
+
     status =3D nvme_check_bounds(n, ns, slba, nlb, req);
     if (status) {
-        return status;
+        goto invalid;
     }
=20
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
@@ -576,6 +598,10 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNa=
mespace *ns, NvmeCmd *cmd,
     req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
                                         BDRV_REQ_MAY_UNMAP, nvme_rw_cb, =
req);
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(n->conf.blk), BLOCK_ACCT_WRITE);
+    return status;
 }
=20
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
@@ -584,6 +610,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
     uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
     uint64_t slba =3D le64_to_cpu(rw->slba);
+    uint16_t ctrl =3D le16_to_cpu(rw->control);
=20
     uint8_t lba_index  =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
@@ -597,19 +624,22 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace =
*ns, NvmeCmd *cmd,
=20
     status =3D nvme_check_mdts(n, data_size, req);
     if (status) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
+    }
+
+    status =3D nvme_check_prinfo(n, ns, ctrl, req);
+    if (status) {
+        goto invalid;
     }
=20
     status =3D nvme_check_bounds(n, ns, slba, nlb, req);
     if (status) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
=20
-    if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status =3D nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req);
+    if (status) {
+        goto invalid;
     }
=20
     if (req->qsg.nsg > 0) {
@@ -633,6 +663,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *=
ns, NvmeCmd *cmd,
     }
=20
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    return status;
 }
=20
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 2df6aa38df1b..2aceb0537e05 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -80,6 +80,7 @@ nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_t=
ail) "cqid %"PRIu16" new_
=20
 # nvme traces for error conditions
 nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" =
mdts %"PRIu64" len %"PRIu64""
+nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"P=
RIu16""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index ecc02fbe8bb8..293d68553538 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -394,6 +394,7 @@ enum {
     NVME_RW_PRINFO_PRCHK_GUARD  =3D 1 << 12,
     NVME_RW_PRINFO_PRCHK_APP    =3D 1 << 11,
     NVME_RW_PRINFO_PRCHK_REF    =3D 1 << 10,
+    NVME_RW_PRINFO_PRCHK_MASK   =3D 7 << 10,
 };
=20
 typedef struct NvmeDsmCmd {
--=20
2.25.1


