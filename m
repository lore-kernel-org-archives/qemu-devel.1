Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54821C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309A720674
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309A720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzql-0004X7-CZ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznV-00079L-Qx; Mon, 29 Jun 2020 15:50:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznS-0005xP-Ub; Mon, 29 Jun 2020 15:50:33 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 718EFBF80D;
 Mon, 29 Jun 2020 19:50:27 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 10/17] hw/block/nvme: add check for mdts
Date: Mon, 29 Jun 2020 21:50:10 +0200
Message-Id: <20200629195017.1217056-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629195017.1217056-1-its@irrelevant.dk>
References: <20200629195017.1217056-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add 'mdts' device parameter to control the Maximum Data Transfer Size of
the controller and check that it is respected.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 32 ++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |  1 +
 hw/block/trace-events |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7cd37ec91823..d5dff6869b69 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -18,9 +18,10 @@
  * Usage: add options:
  *      -drive file=<file>,if=none,id=<drive_id>
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
- *              cmb_size_mb=<cmb_size_mb[optional]>, \
+ *              [cmb_size_mb=<cmb_size_mb>,] \
  *              [pmrdev=<mem_backend_file_id>,] \
- *              max_ioqpairs=<N[optional]>
+ *              [max_ioqpairs=<N>,] \
+ *              [mdts=<N>]
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -518,6 +519,17 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
     }
 }
 
+static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
+{
+    uint8_t mdts = n->params.mdts;
+
+    if (mdts && len > n->page_size << mdts) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb)
 {
@@ -611,6 +623,13 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
 
     trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
 
+    status = nvme_check_mdts(n, data_size);
+    if (status) {
+        trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
+        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        return status;
+    }
+
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
@@ -904,6 +923,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
+    uint16_t status;
 
     numdl = (dw10 >> 16);
     numdu = (dw11 & 0xffff);
@@ -919,6 +939,12 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 
     trace_pci_nvme_get_log(nvme_cid(req), lid, lsp, rae, len, off);
 
+    status = nvme_check_mdts(n, len);
+    if (status) {
+        trace_pci_nvme_err_mdts(nvme_cid(req), len);
+        return status;
+    }
+
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
         return nvme_error_info(n, cmd, rae, len, off, req);
@@ -2227,6 +2253,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->ieee[0] = 0x00;
     id->ieee[1] = 0x02;
     id->ieee[2] = 0xb3;
+    id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
     id->oacs = cpu_to_le16(0);
 
@@ -2345,6 +2372,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
+    DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 0169e1736f0c..b5ce51c6e84b 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -11,6 +11,7 @@ typedef struct NvmeParams {
     uint32_t cmb_size_mb;
     uint8_t  aerl;
     uint32_t aer_max_queued;
+    uint8_t  mdts;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 6d0cd588c786..5d7d4679650b 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -85,6 +85,7 @@ pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
+pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %"PRIu64""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.27.0


