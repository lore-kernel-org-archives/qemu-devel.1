Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F159C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EA22051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EA22051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtCB-00055c-6F
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlF-0000QO-RH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlC-0004Vp-AB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDql6-0001yV-S3; Mon, 16 Mar 2020 10:30:25 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id BFEB2BF96B;
 Mon, 16 Mar 2020 14:29:47 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 24/42] nvme: remove redundant has_sg member
Date: Mon, 16 Mar 2020 07:29:10 -0700
Message-Id: <20200316142928.153431-25-its@irrelevant.dk>
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

Remove the has_sg member from NvmeRequest since it's redundant.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 18 ++++++++++++------
 hw/block/nvme.h |  1 -
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 187c816eb6ad..e40c080c3b48 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -484,16 +484,20 @@ static void nvme_rw_cb(void *opaque, int ret)
         block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
         req->status =3D NVME_INTERNAL_DEV_ERROR;
     }
-    if (req->has_sg) {
+
+    if (req->qsg.nalloc) {
         qemu_sglist_destroy(&req->qsg);
     }
+    if (req->iov.nalloc) {
+        qemu_iovec_destroy(&req->iov);
+    }
+
     nvme_enqueue_req_completion(cq, req);
 }
=20
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
-    req->has_sg =3D false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
     req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
@@ -517,7 +521,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNam=
espace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    req->has_sg =3D false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
@@ -554,16 +557,19 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace =
*ns, NvmeCmd *cmd,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
     if (req->qsg.nsg > 0) {
-        req->has_sg =3D true;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qs=
g.size,
+                         acct);
+
         req->aiocb =3D is_write ?
             dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECT=
OR_SIZE,
                           nvme_rw_cb, req) :
             dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTO=
R_SIZE,
                          nvme_rw_cb, req);
     } else {
-        req->has_sg =3D false;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->io=
v.size,
+                         acct);
+
         req->aiocb =3D is_write ?
             blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme=
_rw_cb,
                             req) :
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index b4d1738a3d0a..442b17bf1701 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -29,7 +29,6 @@ typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
     BlockAIOCB              *aiocb;
     uint16_t                status;
-    bool                    has_sg;
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
--=20
2.25.1


