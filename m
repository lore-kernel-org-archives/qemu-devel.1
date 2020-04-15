Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BFC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8A220737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8A220737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObGQ-0001su-HU
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz1-0002r9-03
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayy-0002qY-Uk
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:10 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayv-0002Zr-18; Wed, 15 Apr 2020 01:53:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id A1791BFD94;
 Wed, 15 Apr 2020 05:52:28 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 29/48] nvme: add request mapping helper
Date: Wed, 15 Apr 2020 07:51:21 +0200
Message-Id: <20200415055140.466900-30-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Introduce the nvme_map helper to remove some noise in the main nvme_rw
function.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 66f92f6f6f2d..1f4ce48b9cbb 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -359,6 +359,15 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *p=
tr, uint32_t len,
     return status;
 }
=20
+static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
+                         QEMUIOVector *iov, size_t len, NvmeRequest *req=
)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
+
+    return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq =3D opaque;
@@ -546,8 +555,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
     uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
     uint64_t slba =3D le64_to_cpu(rw->slba);
-    uint64_t prp1 =3D le64_to_cpu(rw->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(rw->dptr.prp2);
=20
     uint8_t lba_index  =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
@@ -564,7 +571,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req=
)) {
+    if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
--=20
2.26.0


