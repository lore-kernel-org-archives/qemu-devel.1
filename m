Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A4C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5871620737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5871620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObII-0005RY-Fd
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz2-0002u2-2r
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOaz0-0002ri-Fc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayw-0002bH-Ht; Wed, 15 Apr 2020 01:53:06 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 08180BFDDE;
 Wed, 15 Apr 2020 05:52:32 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 38/48] nvme: use preallocated qsg/iov in nvme_dma_prp
Date: Wed, 15 Apr 2020 07:51:30 +0200
Message-Id: <20200415055140.466900-39-its@irrelevant.dk>
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

Since clean up of the request qsg/iov has been moved to the common
nvme_enqueue_req_completion function, there is no need to use a stack
allocated qsg/iov in nvme_dma_prp.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ffc49985321b..eb15a0bd3cf9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -346,45 +346,39 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *=
ptr, uint32_t len,
                              uint64_t prp1, uint64_t prp2, DMADirection =
dir,
                              NvmeRequest *req)
 {
-    QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
-    status =3D nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
+    status =3D nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, re=
q);
     if (status) {
         return status;
     }
=20
-    if (qsg.nsg > 0) {
+    if (req->qsg.nsg > 0) {
         uint64_t residual;
=20
         if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
-            residual =3D dma_buf_write(ptr, len, &qsg);
+            residual =3D dma_buf_write(ptr, len, &req->qsg);
         } else {
-            residual =3D dma_buf_read(ptr, len, &qsg);
+            residual =3D dma_buf_read(ptr, len, &req->qsg);
         }
=20
         if (unlikely(residual)) {
             trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
-
-        qemu_sglist_destroy(&qsg);
     } else {
         size_t bytes;
=20
         if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
-            bytes =3D qemu_iovec_to_buf(&iov, 0, ptr, len);
+            bytes =3D qemu_iovec_to_buf(&req->iov, 0, ptr, len);
         } else {
-            bytes =3D qemu_iovec_from_buf(&iov, 0, ptr, len);
+            bytes =3D qemu_iovec_from_buf(&req->iov, 0, ptr, len);
         }
=20
         if (unlikely(bytes !=3D len)) {
             trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
-
-        qemu_iovec_destroy(&iov);
     }
=20
     return status;
--=20
2.26.0


