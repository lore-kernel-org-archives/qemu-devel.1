Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D072C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18515206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VDKTptXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18515206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwT4-00025Q-Sa
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZA-0001th-Rv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ6-0007Js-Mx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvZ4-0006d8-Ut
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130947euoutp02e3aa583cee7b9a214c7d0923ba16f985~hx8OubyVs0729207292euoutp022
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130947euoutp02e3aa583cee7b9a214c7d0923ba16f985~hx8OubyVs0729207292euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760987;
 bh=J52Ee8yLVwFFWFbwVb/4hamNSwJ9OrM7CimFMdsvtE4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=VDKTptXYr39pTQt7S1+qLyxrK27N431mr7pXGS5GIrLs/OZdOL3EatEiMt8wKWCxi
 J6f7RJ/MeRmFBr54MwU3Z31GmNRX/9sTMGnkCFZmyit5zxszbBQtHOiSssueiKNeBL
 zAEl8TwF9GYTcX6Vmin1QwTYz2G5ROnG31Latv2s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130947eucas1p21f710fe384e7474038daa513cd31d056~hx8OjyWYC0340903409eucas1p2R;
 Thu, 19 Dec 2019 13:09:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.05.60679.B967BFD5; Thu, 19
 Dec 2019 13:09:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8~hx8OS3ZT30340903409eucas1p2Q;
 Thu, 19 Dec 2019 13:09:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130947eusmtrp24a4e05405dde87c05fa03375162911aa~hx8OSVQYV3120131201eusmtrp2M;
 Thu, 19 Dec 2019 13:09:47 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ef-5dfb769bc9c1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.4D.08375.B967BFD5; Thu, 19
 Dec 2019 13:09:47 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130947eusmtip250e71a982efa454b5556bf7f7797212c~hx8OJR6K30178401784eusmtip2B;
 Thu, 19 Dec 2019 13:09:47 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:46 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:46 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 19/24] nvme: handle dma errors
Date: Thu, 19 Dec 2019 14:09:16 +0100
Message-ID: <20191219130921.309264-20-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87qzy37HGjSfU7HY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBEcdmkpOZklqUW
 6dslcGVse3uIveCDfsWRW8+YGxj3KHcxcnJICJhINF7dydbFyMUhJLCCUeLp7sWMEM4XRomX
 55vYIZzPjBI3p7WwdjFygLVMm+AEEV/OKPFl0TaEoh9/bzBBOGcYJU51fYOatYtRYu+zaSwg
 G9kENCW2//kPZosISEu0X53EClLELHCdUeLQ74vsIDuEBQwlfm+IAalhEVCVeHBtNhuIzStg
 LXHlymNmiMvlJbZ++8QKYnMCxbf03maEqBGUODnzCdh8ZqCa5q2zmSFsCYmDL14wg+ySEFjH
 LnH+9WcmiEEuEtt+d7FD2MISr45vgbJlJP7vnM8E0dDNKNH34StU9wxGienLvrNBQsNaou9M
 DkSDo8TPiQ+hgcQnceOtIMRiPolJ26YzQ4R5JTrahCCq1SR2NG1lnMCoPAvJ2bOQnD0LydkL
 GJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaX0/+Of9nBuOtP0iFGAQ5GJR7eF8m/
 Y4VYE8uKK3MPMUpwMCuJ8N7u+BkrxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU
 7NTUgtQimCwTB6dUAyOTo1edXxWzUzkbq8ie+YpP/YROnlstbmN2y8X2p/1Sd7umv6veGnKf
 6A9nXTuj2yy+TmjFLjaz1UzGb1VCwr2Odt7fLnW+Jsl57vYrG87Pk4p/YG8npbhk9bnt1RdC
 9gpUfSu5Y+V7xGKSYNvLaSYs16c+qiw8nrIjaqI1m/vB5bONC/+9X6bEUpyRaKjFXFScCAA5
 eNQ5KgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7qzy37HGvz4IGCxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY9vYQe8EH/Yojt54x
 NzDuUe5i5OCQEDCRmDbBqYuRi0NIYCmjxMeZb9i7GDmB4jISn658hLKFJf5c62KDKPrIKHGh
 aycTSEJI4AyjxLZPkRD2LkaJF6vKQGw2AU2J7X/+s4DYIgLSEu1XJ7GCNDMLXGeUOPT7IjvI
 ZmEBQ4nfG2JAalgEVCUeXJvNBmLzClhLXLnymBlisbzE1m+fWEFsTqD4lt7bjBC7rCQe//zI
 AlEvKHFy5hMwmxmovnnrbGYIW0Li4IsXzBMYhWchKZuFpGwWkrIFjMyrGEVSS4tz03OLDfWK
 E3OLS/PS9ZLzczcxAqNr27Gfm3cwXtoYfIhRgINRiYf3ZfLvWCHWxLLiytxDjBIczEoivLc7
 fsYK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w8vNK4g1NDc0tLA3Njc2NzSyUxHk7BA7G
 CAmkJ5akZqemFqQWwfQxcXBKNTBOMuip+RKf3c3Q9sg/wsR4gf791iRNoz6V/1c3fN+5VzhT
 r7xp0+FTrfGPCyf/5p6Ud/vSIlvOkw/2zBLf+bBf7EtkR+PGZ+/n2W/tvcH03ZOVa1/KhUX3
 OowOuVW6O5Zv3CeyUNBwG9f39T3rD7ZMfsJ3xWlvlamn4p3IAxsPTV1eMePZ+7ZVSizFGYmG
 WsxFxYkA3WRMUcQCAAA=
X-CMS-MailID: 20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8
X-Msg-Generator: CA
X-RootMTR: 20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130947eucas1p21cf4cec3d0b63850ab0e35aa5fab62b8@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handling DMA errors gracefully is required for the device to pass the
block/011 test ("disable PCI device while doing I/O") in the blktests
suite.

With this patch the device passes the test by retrying "critical"
transfers (posting of completion entries and processing of submission
queue entries).

If DMA errors occur at any other point in the execution of the command
(say, while mapping the PRPs), the command is aborted with a Data
Transfer Error status code.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 37 +++++++++++++++++++++++++++++--------
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  2 +-
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 56659bbe263a..f6591285b504 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -71,14 +71,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwad=
dr addr)
     return addr >=3D low && addr < hi;
 }
=20
-static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
+static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
-        return;
+        return 0;
     }
=20
-    pci_dma_read(&n->parent_obj, addr, buf, size);
+    return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
@@ -216,7 +216,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
=20
             nents =3D (len + n->page_size - 1) >> n->page_bits;
             prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(uint64_t)=
;
-            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
+            if (nvme_addr_read(n, prp2, (void *) prp_list, prp_trans)) {
+                trace_nvme_dev_err_addr_read(prp2);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
             while (len !=3D 0) {
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
=20
@@ -235,7 +239,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
-                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_tr=
ans);
+                    if (nvme_addr_read(n, prp_ent, (void *) prp_list, pr=
p_trans)) {
+                        trace_nvme_dev_err_addr_read(prp_ent);
+                        status =3D NVME_DATA_TRANSFER_ERROR;
+                        goto unmap;
+                    }
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
@@ -456,6 +464,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq =3D opaque;
     NvmeCtrl *n =3D cq->ctrl;
     NvmeRequest *req, *next;
+    int ret;
=20
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -471,9 +480,16 @@ static void nvme_post_cqes(void *opaque)
         req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
         req->cqe.sq_head =3D cpu_to_le16(sq->head);
         addr =3D cq->dma_addr + cq->tail * n->cqe_size;
-        nvme_inc_cq_tail(cq);
-        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
+        ret =3D pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
             sizeof(req->cqe));
+        if (ret) {
+            trace_nvme_dev_err_addr_write(addr);
+            QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
+            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                100 * SCALE_MS);
+            break;
+        }
+        nvme_inc_cq_tail(cq);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail !=3D cq->head) {
@@ -1595,7 +1611,12 @@ static void nvme_process_sq(void *opaque)
=20
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr =3D sq->dma_addr + sq->head * n->sqe_size;
-        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
+        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
+            trace_nvme_dev_err_addr_read(addr);
+            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                100 * SCALE_MS);
+            break;
+        }
         nvme_inc_sq_head(sq);
=20
         req =3D QTAILQ_FIRST(&sq->req_list);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 90a57fb6099a..09bfb3782dd0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -83,6 +83,8 @@ nvme_dev_mmio_shutdown_cleared(void) "shutdown bit clea=
red"
 nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" =
mdts %"PRIu64" len %"PRIu64""
 nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"P=
RIu16""
 nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t =
offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %=
p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
+nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
+nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index c1de92179596..a873776d98b8 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -418,7 +418,7 @@ enum NvmeStatusCodes {
     NVME_INVALID_OPCODE         =3D 0x0001,
     NVME_INVALID_FIELD          =3D 0x0002,
     NVME_CID_CONFLICT           =3D 0x0003,
-    NVME_DATA_TRAS_ERROR        =3D 0x0004,
+    NVME_DATA_TRANSFER_ERROR    =3D 0x0004,
     NVME_POWER_LOSS_ABORT       =3D 0x0005,
     NVME_INTERNAL_DEV_ERROR     =3D 0x0006,
     NVME_CMD_ABORT_REQ          =3D 0x0007,
--=20
2.24.1


