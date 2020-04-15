Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFC620767
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFC620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOb7u-0002F1-Jz
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOayg-0001rU-VN
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayf-0002eK-Qo
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayd-0002S9-FS; Wed, 15 Apr 2020 01:52:47 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B777BBFB38;
 Wed, 15 Apr 2020 05:52:24 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 20/48] nvme: enforce valid queue creation sequence
Date: Wed, 15 Apr 2020 07:51:12 +0200
Message-Id: <20200415055140.466900-21-its@irrelevant.dk>
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

Support returning Command Sequence Error if Set Features on Number of
Queues is called after queues have been created.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 12 ++++++++++++
 hw/block/nvme.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f40bc861facc..d88e21a14b77 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -888,6 +888,13 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd =
*cmd)
     cq =3D g_malloc0(sizeof(*cq));
     nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
         NVME_CQ_FLAGS_IEN(qflags));
+
+    /*
+     * It is only required to set qs_created when creating a completion =
queue;
+     * creating a submission queue without a matching completion queue w=
ill
+     * fail.
+     */
+    n->qs_created =3D true;
     return NVME_SUCCESS;
 }
=20
@@ -1202,6 +1209,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        if (n->qs_created) {
+            return NVME_CMD_SEQ_ERROR | NVME_DNR;
+        }
+
         /*
          * NVMe v1.3, Section 5.21.1.7: 0xffff is not an allowed value f=
or NCQR
          * and NSQR.
@@ -1343,6 +1354,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
=20
     n->aer_queued =3D 0;
     n->outstanding_aers =3D 0;
+    n->qs_created =3D false;
=20
     blk_flush(n->conf.blk);
     n->bar.cc =3D 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 321d37aeaca4..f72ffddae160 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -99,6 +99,7 @@ typedef struct NvmeCtrl {
     BlockConf    conf;
     NvmeParams   params;
=20
+    bool        qs_created;
     uint32_t    page_size;
     uint16_t    page_bits;
     uint16_t    max_prp_ents;
--=20
2.26.0


