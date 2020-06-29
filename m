Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7459FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516FD20674
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516FD20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzsc-0007YM-Hw
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznV-00078z-Il; Mon, 29 Jun 2020 15:50:33 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznS-0005wy-MC; Mon, 29 Jun 2020 15:50:33 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C9774BF804;
 Mon, 29 Jun 2020 19:50:26 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 08/17] hw/block/nvme: verify validity of prp lists in the cmb
Date: Mon, 29 Jun 2020 21:50:08 +0200
Message-Id: <20200629195017.1217056-9-its@irrelevant.dk>
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
index d236a3cdee54..55b305458152 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -237,6 +237,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
     uint16_t status;
+    bool prp_list_in_cmb = false;
 
     trace_pci_nvme_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
                            num_prps);
@@ -264,11 +265,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
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
@@ -282,6 +288,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
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
@@ -301,6 +312,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
                 if (status) {
                     goto unmap;
                 }
+
                 len -= trans_len;
                 i++;
             }
@@ -2097,7 +2109,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
 
     NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-- 
2.27.0


