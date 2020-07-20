Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A72C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5EE2176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="wC7e/eEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5EE2176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUDi-0000LD-MB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7k-00081h-VQ; Mon, 20 Jul 2020 07:38:24 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7j-0005BC-5T; Mon, 20 Jul 2020 07:38:24 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1F09CBF5F1;
 Mon, 20 Jul 2020 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245080;
 bh=X/wsVqfw1/FsdcK8SaPGwwSq1tr6rlWBwc4HMvRFUpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wC7e/eEfv5NsnWKeaqFgCptVe1SS8lOsWWtM+Jd2+EB+P+kkD7iEW5VGU1j8AJ1Gk
 WIuFlqyTXRmC6TmF2PkXxxbf/DCWqw5DrdX2OQwD+6j08eHEFssiUjbRlGFspMjSvx
 ZTcajR6auyADJtsPAkwvpVaqjIi8H/6En5gJG+TpR9bIoVqjvuX5PE0btSPpFnHUZo
 GSfCsi59kCfgHmMYgmH2+KqYpLNNbgM4cMDtOPE0KGA2KLaWB2K0dBXcFgnl/WgWaO
 dbJmCLX9ja/R++ej3KFV9+3Zw+BMeWmQkBG1k4Hrh5PMObn7beBXJKnkyPbFZle7aV
 hOPZblzkI7knw==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/16] hw/block/nvme: refactor request bounds checking
Date: Mon, 20 Jul 2020 13:37:41 +0200
Message-Id: <20200720113748.322965-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720113748.322965-1-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 07:37:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Hoist bounds checking into its own function and check for wrap-around.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 530f5155eac0..35bc1a7b7e21 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -553,6 +553,18 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
     }
 }
 
+static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
+                                         uint64_t slba, uint32_t nlb)
+{
+    uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
+
+    if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
+        return NVME_LBA_RANGE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -600,12 +612,14 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
     uint64_t offset = slba << data_shift;
     uint32_t count = nlb << data_shift;
+    uint16_t status;
 
     trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
 
-    if (unlikely(slba + nlb > ns->id_ns.nsze)) {
+    status = nvme_check_bounds(n, ns, slba, nlb);
+    if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        return NVME_LBA_RANGE | NVME_DNR;
+        return status;
     }
 
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
@@ -628,13 +642,15 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     uint64_t data_offset = slba << data_shift;
     int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    uint16_t status;
 
     trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
 
-    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    status = nvme_check_bounds(n, ns, slba, nlb);
+    if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        return NVME_LBA_RANGE | NVME_DNR;
+        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        return status;
     }
 
     if (nvme_map(n, cmd, data_size, req)) {
-- 
2.27.0


