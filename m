Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D6C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5195217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oFhb9uVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5195217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv0t-00040e-RG
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusy-0004y0-Bf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusu-0007uD-JZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusu-0007Uw-8q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095229euoutp01c3bb0ce44d26249d1963c546a428c20e~wKkYgMbI73117831178euoutp01Z
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095229euoutp01c3bb0ce44d26249d1963c546a428c20e~wKkYgMbI73117831178euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809949;
 bh=lOJe1WXretlq6dO3zraWj6ghpiQXCTtyWD9pgLJOH+U=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=oFhb9uVgjJ7HYqz7FRTy0EtrGhXkN5jLA1CA121Lh0ZzdPZgrdYkRCPqqRFKlUgSL
 RFVMF50Al1nsJn8Bwfp5AouuXvcNkRn6vPYxS7M927yaIkD4Iymra7PlN8SZvDyF8+
 NYkGc7KUVW5EMuBeRg7nwPNvOq2021Ld+pKCl9PA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095229eucas1p165d25b588d7db067e07c37cc022eb1da~wKkYQz4or0927009270eucas1p12;
 Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.EF.60698.DDE393E5; Tue,  4
 Feb 2020 09:52:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095229eucas1p2b290e3603d73c129a4f6149805273705~wKkX9ai091139911399eucas1p23;
 Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095229eusmtrp2b20372cca38a14af92d3dfd9d615cac2~wKkX8zVjn0489204892eusmtrp2Q;
 Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-10-5e393edd149a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.CC.08375.DDE393E5; Tue,  4
 Feb 2020 09:52:29 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095229eusmtip1c441d11bf98b23fe32fe6bce1eac2122~wKkXzbOn03064230642eusmtip11;
 Tue,  4 Feb 2020 09:52:29 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:28 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:28 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 21/26] nvme: add support for scatter gather lists
Date: Tue, 4 Feb 2020 10:52:03 +0100
Message-ID: <20200204095208.269131-22-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87p37SzjDI62Klhs7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujLNzTjAWHDjGWHHy9iOmBsb5kxi7GDk5JARMJM7d/QJkc3EICaxg
 lPh/dCUbhPOFUeLS9b9Qmc+MEnMbn7HAtLw/v40JIrGcUeLo2mkscFVPmlewQzinGSVWPmiC
 KtvJKNG0aTtYP5uApsT2P//BbBEBaYn2q5NYQYqYBX6DLJnIBpIQFnCRmDRrCdiNLAIqEr+e
 rGIFsXkFrCV+3z/DDHGIvMTsxtNg9ZxA8f2rTjBB1AhKnJz5BGwBM1BN89bZzBC2hMTBFy+Y
 QZZJCOxil1j48TUbxCAXia4r/VBDhSVeHd/CDmHLSPzfOZ8JoqGbUaLvw1eo7hmMEtOXfQfq
 5gByrCX6zuRANDhKrDu6DirMJ3HjrSDEYj6JSdumM0OEeSU62oQgqtUkdjRtZZzAqDwLydmz
 kJw9C8nZCxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmntP/jn/dwbjvT9IhRgEO
 RiUeXg1Hizgh1sSy4srcQ4wSHMxKIrzn9S3jhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZ
 KySQnliSmp2aWpBaBJNl4uCUamBcPnOWa4tfU8iGg58c70/9wSldmhoRP3vd/x+rZ3iwed4J
 b+k7ekVJ28ffvO/Lgbr3D3ZkSxedE+vo8Sn/6aDREm7OkHI69cY8FfPHq3IlDKujIz5Mm3sw
 YMHhNatN+nue1Sx890Y7gOfU6vU/5y17IVvPsbt9WafDDteD825eFmV5GqBxzs5EiaU4I9FQ
 i7moOBEAh6iezjgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7p37SzjDNom8lts7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jLNz
 TjAWHDjGWHHy9iOmBsb5kxi7GDk5JARMJN6f38bUxcjFISSwlFHi2fsN7BAJGYlPVz5C2cIS
 f651sUEUfWSUWPh0BTOEc5pRouH0dCaQKiGBnYwSv5+KgNhsApoS2//8ZwGxRQSkJdqvTmIF
 sZkFfjNK/OkLBLGFBVwkJs1aAnYGi4CKxK8nq8BqeAWsJX7fP8MMsVleYnbjaTYQmxMovn/V
 CaBdHEC7rCRaj3JDlAtKnJz5hAVivLxE89bZzBC2hMTBFy+YJzAKz0JSNgtJ2SwkZQsYmVcx
 iqSWFuem5xYb6hUn5haX5qXrJefnbmIExt22Yz8372C8tDH4EKMAB6MSD+8FO4s4IdbEsuLK
 3EOMEhzMSiK85/Ut44R4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5gS8kriDU0NzS0sDc2N
 zY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MM4qT62/pMutZqPfecAqdGbThLUC3o0r
 594P/Svm0szVvOLx0tPLZPUZqjdNfHbcT8vIqkbvrsD3f71M96vSbGpaFsxJmrzyqKOIioHM
 3n+Tcx2DZsmJVHvfj792wMffrLnIvsSo+tlyyyvHIisNIpbHT/9g9nDtnrwTb16LJGuHM3MJ
 v9SWVWIpzkg01GIuKk4EADqaSd7RAgAA
X-CMS-MailID: 20200204095229eucas1p2b290e3603d73c129a4f6149805273705
X-Msg-Generator: CA
X-RootMTR: 20200204095229eucas1p2b290e3603d73c129a4f6149805273705
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095229eucas1p2b290e3603d73c129a4f6149805273705
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095229eucas1p2b290e3603d73c129a4f6149805273705@eucas1p2.samsung.com>
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

For now, support the Data Block, Segment and Last Segment descriptor
types.

See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Acked-by: Fam Zheng <fam@euphon.net>
---
 block/nvme.c          |  18 +-
 hw/block/nvme.c       | 375 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   4 +
 include/block/nvme.h  |  62 ++++++-
 4 files changed, 389 insertions(+), 70 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index d41c4bda6e39..521f521054d5 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -446,7 +446,7 @@ static void nvme_identify(BlockDriverState *bs, int n=
amespace, Error **errp)
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
-    cmd.prp1 =3D cpu_to_le64(iova);
+    cmd.dptr.prp.prp1 =3D cpu_to_le64(iova);
=20
     if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
         error_setg(errp, "Failed to identify controller");
@@ -545,7 +545,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_CQ,
-        .prp1 =3D cpu_to_le64(q->cq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->cq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x3),
     };
@@ -556,7 +556,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_SQ,
-        .prp1 =3D cpu_to_le64(q->sq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->sq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x1 | (n << 16)),
     };
@@ -906,16 +906,16 @@ try_map:
     case 0:
         abort();
     case 1:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D 0;
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D 0;
         break;
     case 2:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D pagelist[1];
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D pagelist[1];
         break;
     default:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(uint64_t))=
;
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(u=
int64_t));
         break;
     }
     trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 204ae1d33234..a91c60fdc111 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -75,8 +75,10 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwadd=
r addr)
=20
 static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
-        memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
+    hwaddr hi =3D addr + size;
+
+    if (n->cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)=
) {
+        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return 0;
     }
=20
@@ -159,6 +161,48 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueu=
e *cq)
     }
 }
=20
+static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr=
 addr,
+    size_t len)
+{
+    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len)) =
{
+        return NVME_DATA_TRANSFER_ERROR;
+    }
+
+    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector=
 *iov,
+    hwaddr addr, size_t len)
+{
+    bool addr_is_cmb =3D nvme_addr_is_cmb(n, addr);
+
+    if (addr_is_cmb) {
+        if (qsg->sg) {
+            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+        }
+
+        if (!iov->iov) {
+            qemu_iovec_init(iov, 1);
+        }
+
+        return nvme_map_addr_cmb(n, iov, addr, len);
+    }
+
+    if (iov->iov) {
+        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+    }
+
+    if (!qsg->sg) {
+        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
+    }
+
+    qemu_sglist_add(qsg, addr, len);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector =
*iov,
     uint64_t prp1, uint64_t prp2, uint32_t len, NvmeRequest *req)
 {
@@ -307,15 +351,240 @@ unmap:
     return status;
 }
=20
-static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-    uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
+static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
+    QEMUIOVector *iov, NvmeSglDescriptor *segment, uint64_t nsgld,
+    uint32_t *len, NvmeRequest *req)
+{
+    dma_addr_t addr, trans_len;
+    uint32_t length;
+    uint16_t status;
+
+    for (int i =3D 0; i < nsgld; i++) {
+        uint8_t type =3D NVME_SGL_TYPE(segment[i].type);
+
+        if (type !=3D NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+            switch (type) {
+            case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
+            case NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK:
+                return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
+            default:
+                break;
+            }
+
+            return NVME_INVALID_NUM_SGL_DESCRIPTORS | NVME_DNR;
+        }
+
+        if (*len =3D=3D 0) {
+            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
+                trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(re=
q));
+                return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+            }
+
+            break;
+        }
+
+        addr =3D le64_to_cpu(segment[i].addr);
+        length =3D le32_to_cpu(segment[i].len);
+
+        if (!length) {
+            continue;
+        }
+
+        if (UINT64_MAX - addr < length) {
+            return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+        }
+
+        trans_len =3D MIN(*len, length);
+
+        status =3D nvme_map_addr(n, qsg, iov, addr, trans_len);
+        if (status) {
+            return status;
+        }
+
+        *len -=3D trans_len;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector =
*iov,
+    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
+{
+    const int MAX_NSGLD =3D 256;
+
+    NvmeSglDescriptor segment[MAX_NSGLD], *sgld, *last_sgld;
+    uint64_t nsgld;
+    uint32_t length;
+    uint16_t status;
+    bool sgl_in_cmb =3D false;
+    hwaddr addr;
+    int ret;
+
+    sgld =3D &sgl;
+    addr =3D le64_to_cpu(sgl.addr);
+
+    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->=
nlb,
+        len);
+
+    /*
+     * If the entire transfer can be described with a single data block =
it can
+     * be mapped directly.
+     */
+    if (NVME_SGL_TYPE(sgl.type) =3D=3D NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+        status =3D nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
+        if (status) {
+            goto unmap;
+        }
+
+        goto out;
+    }
+
+    /*
+     * If the segment is located in the CMB, the submission queue of the
+     * request must also reside there.
+     */
+    if (nvme_addr_is_cmb(n, addr)) {
+        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
+            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+        }
+
+        sgl_in_cmb =3D true;
+    }
+
+    for (;;) {
+        length =3D le32_to_cpu(sgld->len);
+
+        if (!length || length & 0xf) {
+            return NVME_INVALID_SGL_SEG_DESCRIPTOR | NVME_DNR;
+        }
+
+        if (UINT64_MAX - addr < length) {
+            return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+        }
+
+        nsgld =3D length / sizeof(NvmeSglDescriptor);
+
+        /* read the segment in chunks of 256 descriptors (4k) */
+        while (nsgld > MAX_NSGLD) {
+            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
+                trace_nvme_dev_err_addr_read(addr);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
+
+            status =3D nvme_map_sgl_data(n, qsg, iov, segment, MAX_NSGLD=
, &len,
+                req);
+            if (status) {
+                goto unmap;
+            }
+
+            nsgld -=3D MAX_NSGLD;
+            addr +=3D MAX_NSGLD * sizeof(NvmeSglDescriptor);
+        }
+
+        ret =3D nvme_addr_read(n, addr, segment, nsgld *
+            sizeof(NvmeSglDescriptor));
+        if (ret) {
+            trace_nvme_dev_err_addr_read(addr);
+            status =3D NVME_DATA_TRANSFER_ERROR;
+            goto unmap;
+        }
+
+        last_sgld =3D &segment[nsgld - 1];
+
+        /* if the segment ends with a Data Block, then we are done */
+        if (NVME_SGL_TYPE(last_sgld->type) =3D=3D NVME_SGL_DESCR_TYPE_DA=
TA_BLOCK) {
+            status =3D nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &l=
en, req);
+            if (status) {
+                goto unmap;
+            }
+
+            break;
+        }
+
+        /* a Last Segment must end with a Data Block descriptor */
+        if (NVME_SGL_TYPE(sgld->type) =3D=3D NVME_SGL_DESCR_TYPE_LAST_SE=
GMENT) {
+            status =3D NVME_INVALID_SGL_SEG_DESCRIPTOR | NVME_DNR;
+            goto unmap;
+        }
+
+        sgld =3D last_sgld;
+        addr =3D le64_to_cpu(sgld->addr);
+
+        /*
+         * Do not map the last descriptor; it will be a Segment or Last =
Segment
+         * descriptor instead and handled by the next iteration.
+         */
+        status =3D nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &l=
en, req);
+        if (status) {
+            goto unmap;
+        }
+
+        /*
+         * If the next segment is in the CMB, make sure that the sgl was
+         * already located there.
+         */
+        if (sgl_in_cmb !=3D nvme_addr_is_cmb(n, addr)) {
+            status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            goto unmap;
+        }
+    }
+
+out:
+    /* if there is any residual left in len, the SGL was too short */
+    if (len) {
+        status =3D NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+        goto unmap;
+    }
+
+    return NVME_SUCCESS;
+
+unmap:
+    if (iov->iov) {
+        qemu_iovec_destroy(iov);
+    }
+
+    if (qsg->sg) {
+        qemu_sglist_destroy(qsg);
+    }
+
+    return status;
+}
+
+static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    NvmeCmd *cmd, DMADirection dir, NvmeRequest *req)
 {
     uint16_t status =3D NVME_SUCCESS;
     size_t bytes;
=20
-    status =3D nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, re=
q);
-    if (status) {
-        return status;
+    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+    case PSDT_PRP:
+        status =3D nvme_map_prp(n, &req->qsg, &req->iov,
+            le64_to_cpu(cmd->dptr.prp.prp1), le64_to_cpu(cmd->dptr.prp.p=
rp2),
+            len, req);
+        if (status) {
+            return status;
+        }
+
+        break;
+
+    case PSDT_SGL_MPTR_CONTIGUOUS:
+    case PSDT_SGL_MPTR_SGL:
+        if (!req->sq->sqid) {
+            /* SGLs shall not be used for Admin commands in NVMe over PC=
Ie */
+            return NVME_INVALID_FIELD;
+        }
+
+        status =3D nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, =
len,
+            req);
+        if (status) {
+            return status;
+        }
+
+        break;
+
+    default:
+        return NVME_INVALID_FIELD;
     }
=20
     if (req->qsg.nsg > 0) {
@@ -351,13 +620,21 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *=
ptr, uint32_t len,
=20
 static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns =3D req->ns;
+    uint32_t len =3D req->nlb << nvme_ns_lbads(req->ns);
+    uint64_t prp1, prp2;
=20
-    uint32_t len =3D req->nlb << nvme_ns_lbads(ns);
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    switch (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+    case PSDT_PRP:
+        prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+        prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
=20
-    return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
+        return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, re=
q);
+    case PSDT_SGL_MPTR_CONTIGUOUS:
+    case PSDT_SGL_MPTR_SGL:
+        return nvme_map_sgl(n, &req->qsg, &req->iov, cmd->dptr.sgl, len,=
 req);
+    default:
+        return NVME_INVALID_FIELD;
+    }
 }
=20
 static void nvme_aio_destroy(NvmeAIO *aio)
@@ -972,8 +1249,6 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd =
*cmd)
 static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     uint32_t trans_len;
@@ -1023,16 +1298,14 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
-        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &smart + off, trans_len, cmd,
+        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
     uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
     NvmeFwSlotInfoLog fw_log;
=20
     if (off > sizeof(fw_log)) {
@@ -1043,8 +1316,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
-        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len, cmd,
+        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -1194,25 +1467,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeC=
md *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeReques=
t *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
-
     trace_nvme_dev_identify_ctrl();
=20
-    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
-        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl), cmd,
+        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     NvmeNamespace *ns;
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     trace_nvme_dev_identify_ns(nsid);
=20
@@ -1223,17 +1489,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eIdentify *c,
=20
     ns =3D &n->namespaces[nsid - 1];
=20
-    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
-        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
+        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
-    uint32_t min_nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t min_nsid =3D le32_to_cpu(cmd->nsid);
     uint32_t *list;
     uint16_t ret;
     int i, j =3D 0;
@@ -1250,13 +1514,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
, NvmeIdentify *c,
             break;
         }
     }
-    ret =3D nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+    ret =3D nvme_dma(n, (uint8_t *) list, data_len, cmd,
         DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     static const int len =3D 4096;
@@ -1268,9 +1532,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c,
         uint8_t nid[16];
     };
=20
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     struct ns_descr *list;
     uint16_t ret;
@@ -1293,8 +1555,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c,
     list->nidl =3D 0x10;
     *(uint32_t *) &list->nid[12] =3D cpu_to_be32(nsid);
=20
-    ret =3D nvme_dma_prp(n, (uint8_t *) list, len, prp1, prp2,
-        DMA_DIRECTION_FROM_DEVICE, req);
+    ret =3D nvme_dma(n, (uint8_t *) list, len, cmd, DMA_DIRECTION_FROM_D=
EVICE,
+        req);
     g_free(list);
     return ret;
 }
@@ -1305,13 +1567,13 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
=20
     switch (le32_to_cpu(c->cns)) {
     case 0x00:
-        return nvme_identify_ns(n, c, req);
+        return nvme_identify_ns(n, cmd, req);
     case 0x01:
-        return nvme_identify_ctrl(n, c, req);
+        return nvme_identify_ctrl(n, cmd, req);
     case 0x02:
-        return nvme_identify_ns_list(n, c, req);
+        return nvme_identify_ns_list(n, cmd, req);
     case 0x03:
-        return nvme_identify_ns_descr_list(n, c, req);
+        return nvme_identify_ns_descr_list(n, cmd, req);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1373,13 +1635,10 @@ static inline uint64_t nvme_get_timestamp(const N=
vmeCtrl *n)
 static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
-
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp),
-        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp), cmd,
+        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1462,11 +1721,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtr=
l *n, NvmeCmd *cmd,
 {
     uint16_t ret;
     uint64_t timestamp;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
-    ret =3D nvme_dma_prp(n, (uint8_t *) &timestamp, sizeof(timestamp),
-        prp1, prp2, DMA_DIRECTION_TO_DEVICE, req);
+    ret =3D nvme_dma(n, (uint8_t *) &timestamp, sizeof(timestamp), cmd,
+        DMA_DIRECTION_TO_DEVICE, req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
@@ -2232,6 +2489,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
         id->vwc =3D 1;
     }
=20
+    id->sgls =3D cpu_to_le32(0x1);
+
     strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
     pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 09bfb3782dd0..81d69e15fc32 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -34,6 +34,7 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
 nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
 nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t=
 len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"=
PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64=
" num_prps %d"
+nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) =
"cid %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
 nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, =
uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu1=
6" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
 nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t o=
ffset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offse=
t %"PRIu64" opc \"%s\" req %p"
 nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opco=
de) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
@@ -85,6 +86,9 @@ nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %=
"PRIu16" ctrl %"PRIu16""
 nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t =
offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %=
p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
 nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
+nvme_dev_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type=
 0x%"PRIx8""
+nvme_dev_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" =
type 0x%"PRIx8""
+nvme_dev_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a873776d98b8..dbdeecf82358 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -205,15 +205,53 @@ enum NvmeCmbszMask {
 #define NVME_CMBSZ_GETSIZE(cmbsz) \
     (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
=20
+enum NvmeSglDescriptorType {
+    NVME_SGL_DESCR_TYPE_DATA_BLOCK           =3D 0x0,
+    NVME_SGL_DESCR_TYPE_BIT_BUCKET           =3D 0x1,
+    NVME_SGL_DESCR_TYPE_SEGMENT              =3D 0x2,
+    NVME_SGL_DESCR_TYPE_LAST_SEGMENT         =3D 0x3,
+    NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK     =3D 0x4,
+
+    NVME_SGL_DESCR_TYPE_VENDOR_SPECIFIC      =3D 0xf,
+};
+
+enum NvmeSglDescriptorSubtype {
+    NVME_SGL_DESCR_SUBTYPE_ADDRESS =3D 0x0,
+};
+
+typedef struct NvmeSglDescriptor {
+    uint64_t addr;
+    uint32_t len;
+    uint8_t  rsvd[3];
+    uint8_t  type;
+} NvmeSglDescriptor;
+
+#define NVME_SGL_TYPE(type)     ((type >> 4) & 0xf)
+#define NVME_SGL_SUBTYPE(type)  (type & 0xf)
+
+typedef union NvmeCmdDptr {
+    struct {
+        uint64_t    prp1;
+        uint64_t    prp2;
+    } prp;
+
+    NvmeSglDescriptor sgl;
+} NvmeCmdDptr;
+
+enum NvmePsdt {
+    PSDT_PRP                 =3D 0x0,
+    PSDT_SGL_MPTR_CONTIGUOUS =3D 0x1,
+    PSDT_SGL_MPTR_SGL        =3D 0x2,
+};
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
-    uint8_t     fuse;
+    uint8_t     flags;
     uint16_t    cid;
     uint32_t    nsid;
     uint64_t    res1;
     uint64_t    mptr;
-    uint64_t    prp1;
-    uint64_t    prp2;
+    NvmeCmdDptr dptr;
     uint32_t    cdw10;
     uint32_t    cdw11;
     uint32_t    cdw12;
@@ -222,6 +260,9 @@ typedef struct NvmeCmd {
     uint32_t    cdw15;
 } NvmeCmd;
=20
+#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
+#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
+
 enum NvmeAdminCommands {
     NVME_ADM_CMD_DELETE_SQ      =3D 0x00,
     NVME_ADM_CMD_CREATE_SQ      =3D 0x01,
@@ -427,6 +468,11 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
     NVME_INVALID_NSID           =3D 0x000b,
     NVME_CMD_SEQ_ERROR          =3D 0x000c,
+    NVME_INVALID_SGL_SEG_DESCRIPTOR  =3D 0x000d,
+    NVME_INVALID_NUM_SGL_DESCRIPTORS =3D 0x000e,
+    NVME_DATA_SGL_LENGTH_INVALID     =3D 0x000f,
+    NVME_METADATA_SGL_LENGTH_INVALID =3D 0x0010,
+    NVME_SGL_DESCRIPTOR_TYPE_INVALID =3D 0x0011,
     NVME_INVALID_USE_OF_CMB     =3D 0x0012,
     NVME_LBA_RANGE              =3D 0x0080,
     NVME_CAP_EXCEEDED           =3D 0x0081,
@@ -623,6 +669,16 @@ enum NvmeIdCtrlOncs {
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
 #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
=20
+#define NVME_CTRL_SGLS_SUPPORTED(sgls)                 ((sgls) & 0x3)
+#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT(sgls)    ((sgls) & (0x1 <<=
  0))
+#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT(sgls) ((sgls) & (0x1 <<=
  1))
+#define NVME_CTRL_SGLS_KEYED(sgls)                     ((sgls) & (0x1 <<=
  2))
+#define NVME_CTRL_SGLS_BITBUCKET(sgls)                 ((sgls) & (0x1 <<=
 16))
+#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS(sgls)           ((sgls) & (0x1 <<=
 17))
+#define NVME_CTRL_SGLS_EXCESS_LENGTH(sgls)             ((sgls) & (0x1 <<=
 18))
+#define NVME_CTRL_SGLS_MPTR_SGL(sgls)                  ((sgls) & (0x1 <<=
 19))
+#define NVME_CTRL_SGLS_ADDR_OFFSET(sgls)               ((sgls) & (0x1 <<=
 20))
+
 typedef struct NvmeFeatureVal {
     uint32_t    arbitration;
     uint32_t    power_mgmt;
--=20
2.25.0


