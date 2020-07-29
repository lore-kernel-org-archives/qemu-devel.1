Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F5D2075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="SgGvhYa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F5D2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uHl-0004PC-Dl
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDs-0006uT-7c; Wed, 29 Jul 2020 18:06:52 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDp-00005Y-UI; Wed, 29 Jul 2020 18:06:51 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DE033BFD37;
 Wed, 29 Jul 2020 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060407;
 bh=VBVSWdNuq1ew5Oc+LN2Suo2nEIIo0N+RFktzz/ZMpwQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SgGvhYa2ozTb3gVzQxuHrrzSiVodw2ldCtP/gsB/Pa2LnMHFR+fzzvbevzSt1gEoE
 HyrB/57AmZTgUNYJA/Q6yDoa7gv6XfVOZlPA5EYXWDpD6aBz0RexyhwNNZEwknhg2w
 JuFOsxctirc/6ERPOkiyHlD5mn/qBQujeANAuVCPJTJZdSC9u8XwguVcIKeEJmlUqY
 ymj7J2HC/rZAqH9y7IQhzoPFI9mdhvBYuCqkbw09JWxwpImfU/u8eM8Vf8J/ly4RgE
 yXHh+H1kibXDk5fpUhe1vap4Ik08fGO+gp0SCtQ9KOS1HUWmGdmAxaA3H9Ca59VFkw
 ecP1S+hvJwyQw==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/16] hw/block/nvme: refactor request bounds checking
Date: Thu, 30 Jul 2020 00:06:32 +0200
Message-Id: <20200729220638.344477-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729220638.344477-1-its@irrelevant.dk>
References: <20200729220638.344477-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Hoist bounds checking into its own function and check for wrap-around.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 hw/block/nvme.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 45e4060d52d9..c35b35ed41c4 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -555,6 +555,18 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
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
@@ -602,12 +614,14 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
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
@@ -630,13 +644,15 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
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
 
     if (nvme_map_dptr(n, cmd, data_size, req)) {
-- 
2.27.0


