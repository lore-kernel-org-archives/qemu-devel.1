Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91285C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1D6206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="fse/9A+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1D6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEChx-0001z6-D3
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaO-0003RQ-AB; Fri, 04 Sep 2020 10:21:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaL-0002jo-Jw; Fri, 04 Sep 2020 10:21:03 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id E5B1CBFB14;
 Fri,  4 Sep 2020 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229236;
 bh=ULU7lIQRoJxUpQ9KR9VWBQNkz+YpY+nCXiz6yhnMBlE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fse/9A+x4vXrp9NLBj1ILzNtSI0I09r2RuXlGZ6WTVZ5+lQaKHxtYmjw7l0N6v21Y
 zL8TKvw3g2lGmR9ZmcQ6o8k9ssQBQ4TKPNAqnEn/OwtMZiAx40/t503ZtlPOoTGc+4
 /71JHWBgiDTSfYSw52K3bh4mDYAygDwBwl8REVTK42HoUGsIGJH+rMEw4ddh8FcUMt
 HKBM+wmxQ/9k+StUlFdZkkr0z8HLzTNS+oAH2By/2KV8lq7QHS+mFuXDiB32+101Vm
 pSMFNo9uCTn8oXdtIDb0aeH/9BVtE5gqjWLsQXNiT1Kbko4tgULpWmOtSACQAbQtyb
 Oc1agnwAfKgmQ==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/17] hw/block/nvme: add support for sgl bit bucket descriptor
Date: Fri,  4 Sep 2020 16:19:52 +0200
Message-Id: <20200904141956.576630-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

This adds support for SGL descriptor type 0x1 (bit bucket descriptor).
See the NVM Express v1.3d specification, Section 4.4 ("Scatter Gather
List (SGL)").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9bdcfeb901d9..6340af226341 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -431,6 +431,10 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         uint8_t type = NVME_SGL_TYPE(segment[i].type);
 
         switch (type) {
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
+            if (req->cmd.opcode == NVME_CMD_WRITE) {
+                continue;
+            }
         case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
             break;
         case NVME_SGL_DESCR_TYPE_SEGMENT:
@@ -441,6 +445,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         }
 
         dlen = le32_to_cpu(segment[i].len);
+
         if (!dlen) {
             continue;
         }
@@ -461,6 +466,11 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         }
 
         trans_len = MIN(*len, dlen);
+
+        if (type == NVME_SGL_DESCR_TYPE_BIT_BUCKET) {
+            goto next;
+        }
+
         addr = le64_to_cpu(segment[i].addr);
 
         if (UINT64_MAX - addr < dlen) {
@@ -472,6 +482,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
             return status;
         }
 
+next:
         *len -= trans_len;
     }
 
@@ -541,7 +552,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
         seg_len = le32_to_cpu(sgld->len);
 
         /* check the length of the (Last) Segment descriptor */
-        if (!seg_len || seg_len & 0xf) {
+        if ((!seg_len || seg_len & 0xf) &&
+            (NVME_SGL_TYPE(sgld->type) != NVME_SGL_DESCR_TYPE_BIT_BUCKET)) {
             return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
         }
 
@@ -578,19 +590,27 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
 
         last_sgld = &segment[nsgld - 1];
 
-        /* if the segment ends with a Data Block, then we are done */
-        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+        /*
+         * If the segment ends with a Data Block or Bit Bucket Descriptor Type,
+         * then we are done.
+         */
+        switch (NVME_SGL_TYPE(last_sgld->type)) {
+        case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
             status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
             if (status) {
                 goto unmap;
             }
 
             goto out;
+
+        default:
+            break;
         }
 
         /*
-         * If the last descriptor was not a Data Block, then the current
-         * segment must not be a Last Segment.
+         * If the last descriptor was not a Data Block or Bit Bucket, then the
+         * current segment must not be a Last Segment.
          */
         if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
             status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
@@ -2721,7 +2741,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
-    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
+    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
+                           NVME_CTRL_SGLS_BITBUCKET);
 
     subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
     strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
-- 
2.28.0


