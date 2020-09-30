Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE6C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394C5206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOuu6zcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394C5206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkGZ-0001EP-6m
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD4-0005NV-4p; Wed, 30 Sep 2020 18:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD1-0007vE-S5; Wed, 30 Sep 2020 18:04:25 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76D0820B1F;
 Wed, 30 Sep 2020 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503462;
 bh=nzDcSMA8Wx2eA5W3BAyp16BC/iZLIHF0pGIPsU0bzqs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tOuu6zcgI0xpb89bS20zWt809IWmFOczsBvEnnuW/iF3nj8T7EVkk4TTVGwIJxGce
 +uXy88FFIvltEGTogVg6ljhRtYQI9gdGRo5xsLCATsaTWSc+5LBGfsyRkhr3AQlnP0
 PgptzDgo4zVCzY1kLouVDMfQoBWTW0MI1/TBWdKk=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Date: Wed, 30 Sep 2020 15:04:06 -0700
Message-Id: <20200930220414.562527-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code switches on the opcode to invoke a function specific to that
opcode. There's no point in consolidating back to a common function that
just switches on that same opcode without any actual common code.
Restore the opcode specific behavior without going back through another
level of switches.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 91 ++++++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 62 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index da8344f196..db52ea0db9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -927,68 +927,12 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
-static uint16_t nvme_do_aio(BlockBackend *blk, int64_t offset, size_t len,
-                            NvmeRequest *req)
-{
-    BlockAcctCookie *acct = &req->acct;
-    BlockAcctStats *stats = blk_get_stats(blk);
-
-    bool is_write = false;
-
-    trace_pci_nvme_do_aio(nvme_cid(req), req->cmd.opcode,
-                          nvme_io_opc_str(req->cmd.opcode), blk_name(blk),
-                          offset, len);
-
-    switch (req->cmd.opcode) {
-    case NVME_CMD_FLUSH:
-        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
-        req->aiocb = blk_aio_flush(blk, nvme_rw_cb, req);
-        break;
-
-    case NVME_CMD_WRITE_ZEROES:
-        block_acct_start(stats, acct, len, BLOCK_ACCT_WRITE);
-        req->aiocb = blk_aio_pwrite_zeroes(blk, offset, len,
-                                           BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
-                                           req);
-        break;
-
-    case NVME_CMD_WRITE:
-        is_write = true;
-
-        /* fallthrough */
-
-    case NVME_CMD_READ:
-        block_acct_start(stats, acct, len,
-                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
-
-        if (req->qsg.sg) {
-            if (is_write) {
-                req->aiocb = dma_blk_write(blk, &req->qsg, offset,
-                                           BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-            } else {
-                req->aiocb = dma_blk_read(blk, &req->qsg, offset,
-                                          BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-            }
-        } else {
-            if (is_write) {
-                req->aiocb = blk_aio_pwritev(blk, offset, &req->iov, 0,
-                                             nvme_rw_cb, req);
-            } else {
-                req->aiocb = blk_aio_preadv(blk, offset, &req->iov, 0,
-                                            nvme_rw_cb, req);
-            }
-        }
-
-        break;
-    }
-
-    return NVME_NO_COMPLETE;
-}
-
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeNamespace *ns = req->ns;
-    return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
+    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
+                     BLOCK_ACCT_FLUSH);
+    req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
@@ -1009,7 +953,11 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
+    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
+                     BLOCK_ACCT_WRITE);
+    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
+                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
+    return NVME_NO_COMPLETE;
 }
 
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
@@ -1023,6 +971,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     uint64_t data_offset = nvme_l2b(ns, slba);
     enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
         BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
@@ -1045,7 +994,25 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
+    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
+    if (req->qsg.sg) {
+        if (acct == BLOCK_ACCT_WRITE) {
+            req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
+                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        } else {
+            req->aiocb = dma_blk_read(blk, &req->qsg, data_offset,
+                                      BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        }
+    } else {
+        if (acct == BLOCK_ACCT_WRITE) {
+            req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
+                                         nvme_rw_cb, req);
+        } else {
+            req->aiocb = blk_aio_preadv(blk, data_offset, &req->iov, 0,
+                                        nvme_rw_cb, req);
+        }
+    }
+    return NVME_NO_COMPLETE;
 
 invalid:
     block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
-- 
2.24.1


