Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB00BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C512166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eh/bHDa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C512166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfqD-0001AV-LW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhc-0003aJ-HV; Wed, 17 Jun 2020 17:34:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfha-0005DU-GZ; Wed, 17 Jun 2020 17:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429674; x=1623965674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HX0mScZJawcN1wtB9oGEysO0x6z2NlfQ4Kuhi3c7Lc4=;
 b=Eh/bHDa9a6NU+Sel6hOZrVl4mBqP/W5eHA3oC9SzH3/Y86QDK/4eK4SR
 qyY/tOAVEtlZbcDyPdDyaOztkM2+rppgD4ljrY8hXaQwQZoJwWJbKMBrE
 rAsvmRhDuuXNFvIiQXEMoKG9n4gcoYIFLrpYv3Jd46lZbA15DaRpvvsNn
 KSYouSAr0PTNEoauXjPNH1T6mbYG65NRF7lM22zfaLLrO65/TOPA1gjTu
 o/7zWReE+d0BLkrYeMG07yKAuHvgNnauCopQsGa/c8RJNt8/isaW8fDgS
 hoHCgkw/qvGA4LykNopc2EV/4AzFQYNhrARTPY75/roNFau7mx8+6SQFk w==;
IronPort-SDR: BrP0Rqx8XR2iFlC8/uM/E7C63R9Pdbsz1J12hQJ7mFys7H5/267NCnj3dovbF40pWnjKFyce68
 GaF3cdFiU8W+ZFp3NFDfRHFh4K5hgBEpRPWSqj0T89ZC7vrRkiZR7/tP/JBUC5ab/EvmxLHGil
 SxzQULDpn5jxLXEjH9VR/tLiiyay21OOnNX0dqiP8n3MN87o3GNArq/CCLePuprzLa6xxNT+mw
 elhsbHwSjq21bbH/ob0VtUFXBlobUciql7oDw7LFs1IdoTKaJ888dK+xmfqdHEHQDYJn94ZV5D
 wC8=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439785"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:29 +0800
IronPort-SDR: /D740RNZ+/o95QDVBz+NtJBapa9cOrsKn3ALo0NI+Dd8rm9BriWq0fY1xkOTiXDOeg1/mVS7b8
 ql4I0V9/Goufphq3dzQhbc+5jvQazQu0A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:10 -0700
IronPort-SDR: J6Yy+/u7Zf4QYayjkB5TSGeNs1zv8i7x01rSLal/98U2I8r9u1wifM1L/2YRCvuLVQhRPFsK72
 ZVz+W+yinV6A==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:28 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 01/18] hw/block/nvme: Move NvmeRequest has_sg field to a
 bit flag
Date: Thu, 18 Jun 2020 06:33:58 +0900
Message-Id: <20200617213415.22417-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In addition to the existing has_sg flag, a few more Boolean
NvmeRequest flags are going to be introduced in subsequent patches.
Convert "has_sg" variable to "flags" and define NvmeRequestFlags
enum for individual flag values.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 8 +++-----
 hw/block/nvme.h | 6 +++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1aee042d4c..3ed9f3d321 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -350,7 +350,7 @@ static void nvme_rw_cb(void *opaque, int ret)
         block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
         req->status = NVME_INTERNAL_DEV_ERROR;
     }
-    if (req->has_sg) {
+    if (req->flags & NVME_REQ_FLG_HAS_SG) {
         qemu_sglist_destroy(&req->qsg);
     }
     nvme_enqueue_req_completion(cq, req);
@@ -359,7 +359,6 @@ static void nvme_rw_cb(void *opaque, int ret)
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
-    req->has_sg = false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
     req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
@@ -383,7 +382,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
 
-    req->has_sg = false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
@@ -422,14 +420,13 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
 
     dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
     if (req->qsg.nsg > 0) {
-        req->has_sg = true;
+        req->flags |= NVME_REQ_FLG_HAS_SG;
         req->aiocb = is_write ?
             dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
                           nvme_rw_cb, req) :
             dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
                          nvme_rw_cb, req);
     } else {
-        req->has_sg = false;
         req->aiocb = is_write ?
             blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
                             req) :
@@ -917,6 +914,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         memset(&req->cqe, 0, sizeof(req->cqe));
+        req->flags = 0;
         req->cqe.cid = cmd.cid;
 
         status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1d30c0bca2..0460cc0e62 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -16,11 +16,15 @@ typedef struct NvmeAsyncEvent {
     NvmeAerResult result;
 } NvmeAsyncEvent;
 
+enum NvmeRequestFlags {
+    NVME_REQ_FLG_HAS_SG   = 1 << 0,
+};
+
 typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
     BlockAIOCB              *aiocb;
     uint16_t                status;
-    bool                    has_sg;
+    uint16_t                flags;
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
-- 
2.21.0


