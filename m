Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A956C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BBC2192A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kt76E1fH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BBC2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv34-0007V5-Ei
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusw-0004ph-5U
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusu-0007tn-F6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusu-0007V1-9e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095229euoutp0196134d115964356a2e46b504a5772045~wKkXynfQ73058130581euoutp018
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095229euoutp0196134d115964356a2e46b504a5772045~wKkXynfQ73058130581euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809949;
 bh=0KcinR+iyMvgGfNh06dyhM/PTx5OKou+X1kwk4kqwVk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Kt76E1fHyvE3sH/DY0/gvcD51N8MiePHKbE8W25/EDR7SIBg/WpP1N9xzUK2HtRTk
 xYJrwD3EIlLHuaRGv2ndYjEnvYVWERs37TsqS3C6Jv6prEJkXMXY25NSIMqFMoUkvh
 8cGnwDnZoB4egkP2KXBF4X4CQAquzjOIoDZgWlxc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095228eucas1p2a17909b4d410210e44e8393bb9581eff~wKkXnEWdS1139911399eucas1p21;
 Tue,  4 Feb 2020 09:52:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.EF.60698.CDE393E5; Tue,  4
 Feb 2020 09:52:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf~wKkXPUDux2201922019eucas1p2J;
 Tue,  4 Feb 2020 09:52:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095228eusmtrp22d5a9b165ea90ebf293550ef81ac069b~wKkXOp_GM0487104871eusmtrp2t;
 Tue,  4 Feb 2020 09:52:28 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-0b-5e393edce655
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.6A.07950.CDE393E5; Tue,  4
 Feb 2020 09:52:28 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095228eusmtip1868b4308b3109cd07a4abf8739bc26eb~wKkXIYra93064230642eusmtip10;
 Tue,  4 Feb 2020 09:52:28 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:27 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:27 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 20/26] nvme: handle dma errors
Date: Tue, 4 Feb 2020 10:52:02 +0100
Message-ID: <20200204095208.269131-21-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7p37CzjDLafNLHY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGe19PUwFB0wqns98y9jAuEeti5GTQ0LARGL62qNsXYxcHEICKxgl
 vj56zQzhfGGUmHz7AxOE85lR4vi8r0wwLfPf9zNCJJYzSnza/oQVrmrDoeVQ/acZJe6saWYD
 aRES2MkocXoa2EY2AU2J7X/+s4DYIgLSEu1XJ4F1Mwv8ZpSY2zgRrEFYwFDi9LK57CA2i4CK
 xJtpp4FsDg5eAWuJ/mO5EGfIS8xuPA1WzgkU3r/qBNh5vAKCEidnPgGbzwxU07x1NjOELSFx
 8MULsOMkBHaxS9xv38UIMlNCwEVi6dVwiJnCEq+Ob2GHsGUk/u+czwRR380o0ffhK1TzDEaJ
 6cu+s0E0W0v0ncmBaHCUOPfjPjNEmE/ixltBiL18EpO2TYcK80p0tAlBVKtJ7GjayjiBUXkW
 kqtnIbl6FpKrFzAyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMN6f/Hf+6g3Hfn6RD
 jAIcjEo8vBqOFnFCrIllxZW5hxglOJiVRHjP61vGCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1
 XvQyVkggPbEkNTs1tSC1CCbLxMEpBUws5fnzMpgTJVu6P7h6nvlSl77n6aWFGh5uri9NmEMe
 TopRTjg7zat8XmJ72FebrisdEf4+l1L/vT/95MHRyT6mYoVV+16dWNuu9Fsg7+DMk3UaCQa5
 82W5ay+1XTrvW1pp2iOg+vOHPkv9Qj9DFsttnO8eNXyVO3WTi+/xfM6sMOmY2Zf11iuxFGck
 GmoxFxUnAgAvpNZiMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7p37CzjDCaflrPY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Ge19
 PUwFB0wqns98y9jAuEeti5GTQ0LARGL++37GLkYuDiGBpYwSz6ceY4RIyEh8uvKRHcIWlvhz
 rYsNougjo0THiXdMEM5pRomXX84zQzg7GSVmfN/GAtLCJqApsf3PfzBbREBaov3qJFYQm1ng
 N6PEn75AEFtYwFDi9LK5YCtYBFQk3kw7DWRzcPAKWEv0H8uF2CwvMbvxNBuIzQkU3r/qBBNI
 iZCAlUTrUW6QMK+AoMTJmU9YIKbLSzRvnc0MYUtIHHzxgnkCo/AsJGWzkJTNQlK2gJF5FaNI
 amlxbnpusZFecWJucWleul5yfu4mRmDMbTv2c8sOxq53wYcYBTgYlXh4NRwt4oRYE8uKK3MP
 MUpwMCuJ8J7Xt4wT4k1JrKxKLcqPLyrNSS0+xGgK9NpEZinR5HxgOsgriTc0NTS3sDQ0NzY3
 NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cB4ZIea27xbO/4fuJGXZhww/evbGM/3bHY3
 8rcpxr0QZ7oWb3n9erDT52mLir/YXZ17OmO5+TZWjqPLuL18t55Wq3kV3KjgocTY25fs/5Vt
 drKh4KT6dEvDzc0Z+St8lx6+mvpK4cCTjp/vM/4wloiG+R7xL1W6G9unbPWloVZulaS/rrwy
 z0wlluKMREMt5qLiRACNpBQzzwIAAA==
X-CMS-MailID: 20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf
X-Msg-Generator: CA
X-RootMTR: 20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095228eucas1p2878eb150a933bb196fe5ca10a0b76eaf@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 hw/block/nvme.c       | 42 +++++++++++++++++++++++++++++++++---------
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  2 +-
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f8c81b9e2202..204ae1d33234 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -73,14 +73,14 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwad=
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
@@ -168,6 +168,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, QEMUIOVector *iov,
     uint16_t status =3D NVME_SUCCESS;
     bool is_cmb =3D false;
     bool prp_list_in_cmb =3D false;
+    int ret;
=20
     trace_nvme_dev_map_prp(nvme_cid(req), req->cmd.opcode, trans_len, le=
n,
         prp1, prp2, num_prps);
@@ -218,7 +219,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
=20
             nents =3D (len + n->page_size - 1) >> n->page_bits;
             prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(uint64_t)=
;
-            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
+            ret =3D nvme_addr_read(n, prp2, (void *) prp_list, prp_trans=
);
+            if (ret) {
+                trace_nvme_dev_err_addr_read(prp2);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
             while (len !=3D 0) {
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
=20
@@ -237,7 +243,13 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList=
 *qsg, QEMUIOVector *iov,
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
-                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_tr=
ans);
+                    ret =3D nvme_addr_read(n, prp_ent, (void *) prp_list=
,
+                        prp_trans);
+                    if (ret) {
+                        trace_nvme_dev_err_addr_read(prp_ent);
+                        status =3D NVME_DATA_TRANSFER_ERROR;
+                        goto unmap;
+                    }
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
@@ -443,6 +455,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq =3D opaque;
     NvmeCtrl *n =3D cq->ctrl;
     NvmeRequest *req, *next;
+    int ret;
=20
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -452,15 +465,21 @@ static void nvme_post_cqes(void *opaque)
             break;
         }
=20
-        QTAILQ_REMOVE(&cq->req_list, req, entry);
         sq =3D req->sq;
         req->cqe.status =3D cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id =3D cpu_to_le16(sq->sqid);
         req->cqe.sq_head =3D cpu_to_le16(sq->head);
         addr =3D cq->dma_addr + cq->tail * n->cqe_size;
-        nvme_inc_cq_tail(cq);
-        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
+        ret =3D pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
             sizeof(req->cqe));
+        if (ret) {
+            trace_nvme_dev_err_addr_write(addr);
+            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                100 * SCALE_MS);
+            break;
+        }
+        QTAILQ_REMOVE(&cq->req_list, req, entry);
+        nvme_inc_cq_tail(cq);
         nvme_req_clear(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
@@ -1588,7 +1607,12 @@ static void nvme_process_sq(void *opaque)
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
2.25.0


