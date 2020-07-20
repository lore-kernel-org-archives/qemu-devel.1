Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06759C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E3620702
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="iguoU6nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E3620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUEk-0001WE-TI
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7Q-0007Kc-E9; Mon, 20 Jul 2020 07:38:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7O-0005Ag-8c; Mon, 20 Jul 2020 07:38:04 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B27ABBFB1A;
 Mon, 20 Jul 2020 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245080;
 bh=pxIkRiutpkpL1qsTAc8+arXC4N/2rlSIcHTc3apDWyo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iguoU6nd0rv0akTxBKu1qWvd51UkxwZPOACRDlUK/24aDohspBTN/c/hHOHuYsCBw
 Wjp2hxo/6Ts5bSS1zwzo2psDCsDG2bryMyhnMpkQCtxJu4H2TyvwAgYU4zjmXR4HQg
 eAh1uMkrbZ+SHz9KQFxhB076dnLVF0UBuHwakxzMcf3f63S+Spqo5GQ8YhIr3f1k3/
 IsAdPuFs2RnydevMpQRfmnS3va2aRLf1167t+FLN5W0hXK2C2mKJv/vVkQ1xFj7skC
 KY45FBM21EI/tBQpiKs+HqM0oFgfnSHqTkUJ71AwZkor4jsJLRv35/vLzFJqeGUP6+
 5M5vMLyOsfovA==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] hw/block/nvme: verify validity of prp lists in the cmb
Date: Mon, 20 Jul 2020 13:37:40 +0200
Message-Id: <20200720113748.322965-9-its@irrelevant.dk>
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

Before this patch the device already supported PRP lists in the CMB, but
it did not check for the validity of it nor announced the support in the
Identify Controller data structure LISTS field.

If some of the PRPs in a PRP list are in the CMB, then ALL entries must
be there. This patch makes sure that requirement is verified as well as
properly announcing support for PRP lists in the CMB.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 68c33a11c144..530f5155eac0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -272,6 +272,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
     uint16_t status;
+    bool prp_list_in_cmb = false;
 
     trace_pci_nvme_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
                            num_prps);
@@ -299,11 +300,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
             status = NVME_INVALID_FIELD | NVME_DNR;
             goto unmap;
         }
+
         if (len > n->page_size) {
             uint64_t prp_list[n->max_prp_ents];
             uint32_t nents, prp_trans;
             int i = 0;
 
+            if (nvme_addr_is_cmb(n, prp2)) {
+                prp_list_in_cmb = true;
+            }
+
             nents = (len + n->page_size - 1) >> n->page_bits;
             prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
             nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
@@ -317,6 +323,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
                         goto unmap;
                     }
 
+                    if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
+                        status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
+                        goto unmap;
+                    }
+
                     i = 0;
                     nents = (len + n->page_size - 1) >> n->page_bits;
                     prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
@@ -336,6 +347,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
                 if (status) {
                     goto unmap;
                 }
+
                 len -= trans_len;
                 i++;
             }
@@ -2144,7 +2156,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
 
     NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-- 
2.27.0


