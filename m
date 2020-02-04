Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A7C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0278B2192A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CTCRBqrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0278B2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv5K-0003fC-49
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusp-0004XU-TE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyuso-0007if-KX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyuso-0007HQ-Du
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095227euoutp020e88a43c95263cc632a600792f1de3eb~wKkWYTLc02939629396euoutp02V
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095227euoutp020e88a43c95263cc632a600792f1de3eb~wKkWYTLc02939629396euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809947;
 bh=ngZmAEle7Rl4AlNKbikHFaebBO01MamT0DYTVMAtk3k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=CTCRBqrIoLcR1XHlWLsroCrhQwY/PR+vE+WV0ZDj5yYonp1xUrLkXgKAKjhhIoRgD
 tZt1YbF+lxqou4rqVxfwlAOhV7MEsbZMMLyk/S8rHF9MyV3D4kws4UrMwRwSocqkCL
 MpMbeKTVWRw+CDs1agc0bEZ12SNCRZ/qX+yUIXOA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095227eucas1p2838d8c122e00aa6c843e8fc43ec9991a~wKkWNmb4R2200522005eucas1p2H;
 Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.EF.60698.BDE393E5; Tue,  4
 Feb 2020 09:52:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095227eucas1p2f23061d391e67f4d3bde8bab74d1e44b~wKkV7dOmt2198521985eucas1p2E;
 Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095227eusmtrp2bafbc92f87c8bbd0f649df7b2dc4f20f~wKkV64rBa0487104871eusmtrp2p;
 Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-02-5e393edbc585
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.6A.07950.BDE393E5; Tue,  4
 Feb 2020 09:52:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095226eusmtip24de5e465024b0db952e79b7a1a808112~wKkVzSwb62798927989eusmtip2i;
 Tue,  4 Feb 2020 09:52:26 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:26 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:26 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 18/26] nvme: use preallocated qsg/iov in nvme_dma_prp
Date: Tue, 4 Feb 2020 10:52:00 +0100
Message-ID: <20200204095208.269131-19-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7q37SzjDHqnCVls7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujL/3zrEUTBGsOPbvLFsD4xaeLkZODgkBE4n+c/PYuhi5OIQEVjBK
 zDncwgjhfGGUaJ+8hQXC+cwoseX0BhaYlmmLZrBCJJYzSjQvuswMV7X993Go/tOMEi+n7oTq
 38kosef/O1aQfjYBTYntf/6DzRIRkJZovzoJbBazwG9GibmNE9lAEsICHhLXWo+wg9gsAioS
 7St3MoHYvALWEgsnb2aEOEReYnbjabB6TqD4/lUnoGoEJU7OfAK2gBmopnnrbGYIW0Li4IsX
 YLdKCGxjl3g//yIrxCAXiePzlzJD2MISr45vYYewZST+75zPBNHQzSjR9+ErVPcMRonpy74D
 reYAcqwl+s7kQJiOEjfv1kCYfBI33gpC7OWTmLRtOjNEmFeio00IYrqaxI6mrYwTGJVnIbl6
 FpKrZyG5egEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAlHP63/GvOxj3/Uk6xCjA
 wajEw6vhaBEnxJpYVlyZe4hRgoNZSYT3vL5lnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40Uv
 Y4UE0hNLUrNTUwtSi2CyTBycUg2Mcya5MrvbTxBTjmgI27Njdfyao/8tVS4Es66R2WPxQevG
 +vwJkmK34hkNa2ael8rn19RdwbPpzdawoGXXOO5f3r6U1bxT8KL/cfE5JYWzkp/l/Fz74FyP
 +1vG8g19BYsvWQpOmDBdX6+rMPVAVtZ5/U8ZcbK3tKKEG/5V3EuSPfCO8zDbuvB0JZbijERD
 Leai4kQA1XQ8CDUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7q37SzjDH48Y7bY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX/v
 nWMpmCJYcezfWbYGxi08XYycHBICJhLTFs1gBbGFBJYySpzp94SIy0h8uvKRHcIWlvhzrYut
 i5ELqOYjo8TVlplsEA2nGSXuf/OCSOxklDjxbBsLSIJNQFNi+5//YLaIgLRE+9VJYBuYBX4z
 SvzpCwSxhQU8JK61HgHbwCKgItG+cicTiM0rYC2xcPJmRojN8hKzG0+DLeMEiu9fdQKohgNo
 mZVE61FuiHJBiZMzn7BAjJeXaN46mxnClpA4+OIF8wRG4VlIymYhKZuFpGwBI/MqRpHU0uLc
 9NxiI73ixNzi0rx0veT83E2MwIjbduznlh2MXe+CDzEKcDAq8fBqOFrECbEmlhVX5h5ilOBg
 VhLhPa9vGSfEm5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cBkkFcSb2hqaG5haWhubG5sZqEk
 ztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbHcYZmInd5Rp3lfY7987rh75LhVnEH4K9l5D8/u
 j4sy+nSsOHJqbu2cYkXja5M0NyzKj21wmaXlLyBqXbjX8erjroA3aw2MNCwrAxyXvhJw+Hbm
 xMPkDfPWibWeehcStvqEeemqaeJTmP8wzN7z+3HDXKEfZm9PlfzsWXtIPTFY9GGJZqhKY7kS
 S3FGoqEWc1FxIgDyRJuCzgIAAA==
X-CMS-MailID: 20200204095227eucas1p2f23061d391e67f4d3bde8bab74d1e44b
X-Msg-Generator: CA
X-RootMTR: 20200204095227eucas1p2f23061d391e67f4d3bde8bab74d1e44b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095227eucas1p2f23061d391e67f4d3bde8bab74d1e44b
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095227eucas1p2f23061d391e67f4d3bde8bab74d1e44b@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since clean up of the request qsg/iov has been moved to the common
nvme_enqueue_req_completion function, there is no need to use a
stack allocated qsg/iov in nvme_dma_prp.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e97da35c4ca1..f8c81b9e2202 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -298,23 +298,21 @@ unmap:
 static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
 {
-    QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
     size_t bytes;
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
@@ -322,15 +320,13 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *=
ptr, uint32_t len,
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
=20
-        qemu_sglist_destroy(&qsg);
-
         return status;
     }
=20
     if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
-        bytes =3D qemu_iovec_to_buf(&iov, 0, ptr, len);
+        bytes =3D qemu_iovec_to_buf(&req->iov, 0, ptr, len);
     } else {
-        bytes =3D qemu_iovec_from_buf(&iov, 0, ptr, len);
+        bytes =3D qemu_iovec_from_buf(&req->iov, 0, ptr, len);
     }
=20
     if (unlikely(bytes !=3D len)) {
@@ -338,8 +334,6 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *pt=
r, uint32_t len,
         status =3D NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    qemu_iovec_destroy(&iov);
-
     return status;
 }
=20
--=20
2.25.0


