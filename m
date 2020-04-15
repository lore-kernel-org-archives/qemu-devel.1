Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A13C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4F020737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4F020737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObCA-0002bj-Eq
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOayy-0002jv-DL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayw-0002nN-LJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:08 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayu-0002ZE-AL; Wed, 15 Apr 2020 01:53:04 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 33034BFD68;
 Wed, 15 Apr 2020 05:52:27 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 25/48] nvme: replace dma_acct with blk_acct equivalent
Date: Wed, 15 Apr 2020 07:51:17 +0200
Message-Id: <20200415055140.466900-26-its@irrelevant.dk>
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

The QSG isn't always initialized, so accounting could be wrong. Issue a
call to blk_acct_start instead with the size taken from the QSG or IOV
depending on the kind of I/O.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b62b053d7c38..c9f7badd5a15 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -566,9 +566,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *=
ns, NvmeCmd *cmd,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
     if (req->qsg.nsg > 0) {
         req->has_sg =3D true;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qs=
g.size,
+                         acct);
         req->aiocb =3D is_write ?
             dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECT=
OR_SIZE,
                           nvme_rw_cb, req) :
@@ -576,6 +577,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
                          nvme_rw_cb, req);
     } else {
         req->has_sg =3D false;
+        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->io=
v.size,
+                         acct);
         req->aiocb =3D is_write ?
             blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme=
_rw_cb,
                             req) :
--=20
2.26.0


