Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A72C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1BA217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YUgydX6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1BA217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv1d-0004um-KN
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusl-0004LL-DM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusj-0007UO-I8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusj-00077i-AL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095222euoutp0181c299b99a2474d695cfa42623e1ba21~wKkRoTreG3058130581euoutp01x
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095222euoutp0181c299b99a2474d695cfa42623e1ba21~wKkRoTreG3058130581euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809942;
 bh=EfcNMYX5C/qgESMq/YI9SZiziqWma7aZLb1HRt2jPyA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=YUgydX6wfAfhe35PnPHuyJcZHfKmvB3bypZKB3sUl6r4uIdRQHORj//vUfbP3Ofmd
 g38pzIs0yy/uL7CiVySsW4gw4qBD0hyAjB4sDT+JR1Lr/SUJm1qb8npYuY2xBUgGTV
 Q4bGKGUEiS+ojfIjr5Eh3zOX7rPI8K2yhbrz/nS4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095222eucas1p2927361d59c6b1081d522bc5681dbad4e~wKkRXj1qd0109901099eucas1p2w;
 Tue,  4 Feb 2020 09:52:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.EF.60698.6DE393E5; Tue,  4
 Feb 2020 09:52:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095221eucas1p216ca2452c4184eb06bff85cff3c6a82b~wKkRFEJzI2197821978eucas1p2F;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095221eusmtrp2b02b818dae53d24d16d248b4f69a71ca~wKkREcaaZ0485704857eusmtrp2o;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f3-5e393ed66b28
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.6A.07950.5DE393E5; Tue,  4
 Feb 2020 09:52:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095221eusmtip1e5d6be8521a3bfc0af189ac239472731~wKkQ6qbnf3070630706eusmtip17;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:21 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:20 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 10/26] nvme: add support for the get log page command
Date: Tue, 4 Feb 2020 10:51:52 +0100
Message-ID: <20200204095208.269131-11-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87rX7CzjDA7M4bTY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGfdXBRZMdK/4umcGUwPjbosuRg4OCQETiS+nwrsYuTiEBFYwSpxf
 N5UdwvnCKLFyzXwWCOczo8Tpl5MYuxg5wTr+TFrHDJFYzihx78kaVpAEWNXvbyUQidOMEru2
 nWWCcHYySuy5dZMNpIpNQFNi+5//LCC2iIC0RPvVSawgRcwCvxkl5jZOZAO5SljAQ6L9iBVI
 DYuAisTm6z1gG3gFrCV+z7zCCnGGvMTsxtNgMzmB4vtXnWCCqBGUODnzCdh8ZqCa5q2zmSFs
 CYmDL16AnS0hsItd4u3+rUwQg1wkrrztYoGwhSVeHd/CDmHLSPzfOZ8JoqGbUaLvw1eo7hmM
 EtOXfWeDhJ+1RN+ZHIgGR4nTmxazQIT5JG68FYRYzCcxadt0Zogwr0RHmxBEtZrEjqatjBMY
 lWchOXsWkrNnITl7ASPzKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMBkc/rf8a87GPf9
 STrEKMDBqMTDq+FoESfEmlhWXJl7iFGCg1lJhPe8vmWcEG9KYmVValF+fFFpTmrxIUZpDhYl
 cV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYyXXt6SUZx1K+3xyynW/ueelbC9XTN/ZrO2KcM7
 ma7vvTcn1jYmK+3X6OqMSuMJ+Rnz8KqHrpwq45sL35r2B/4551AofE3hUtGdY9n2Dcf0183q
 2/p6yp+PledeKLm4GT/OKD/ZfaU24PXKS4KcG/6/OrquMtz9h9SvWL1b/xde3V1ovmvC/BX+
 SizFGYmGWsxFxYkAGbySFTIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7pX7SzjDCa8NrLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GfdX
 BRZMdK/4umcGUwPjbosuRk4OCQETiT+T1jF3MXJxCAksZZR49uM0C0RCRuLTlY/sELawxJ9r
 XWwQRR8ZJTa93sAK4ZxmlPjy8DY7hLOTUeLY5d2MIC1sApoS2//8BxslIiAt0X51EiuIzSzw
 m1HiT19gFyMHh7CAh0T7ESuQMIuAisTm6z1gJbwC1hK/Z15hhdgsLzG78TQbiM0JFN+/6gQT
 SKuQgJVE61FuiHJBiZMzn7BATJeXaN46mxnClpA4+OIF8wRG4VlIymYhKZuFpGwBI/MqRpHU
 0uLc9NxiI73ixNzi0rx0veT83E2MwIjbduznlh2MXe+CDzEKcDAq8fBqOFrECbEmlhVX5h5i
 lOBgVhLhPa9vGSfEm5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cBkkFcSb2hqaG5haWhubG5s
 ZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVHO9X3B9T2z2NUTovc585UV7VgaHXacS3ph
 MHPEXidBjtJ6RiXuiPKPM+5OnJVxKaRZpsZPdR9XzaP9T1Ok08qmc8l57DzyYpXE9/k6e6JV
 Pz790/B89ZnqqLSj53hFMn7EPCj7nLBygtGaFXv/7D8jaFDaqHoyWcL+ZbX37rvZqhN9Awr+
 2SqxFGckGmoxFxUnAgAlKYFpzgIAAA==
X-CMS-MailID: 20200204095221eucas1p216ca2452c4184eb06bff85cff3c6a82b
X-Msg-Generator: CA
X-RootMTR: 20200204095221eucas1p216ca2452c4184eb06bff85cff3c6a82b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095221eucas1p216ca2452c4184eb06bff85cff3c6a82b
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095221eucas1p216ca2452c4184eb06bff85cff3c6a82b@eucas1p2.samsung.com>
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

Add support for the Get Log Page command and basic implementations of
the mandatory Error Information, SMART / Health Information and Firmware
Slot Information log pages.

In violation of the specification, the SMART / Health Information log
page does not persist information over the lifetime of the controller
because the device has no place to store such persistent state.

Note that the LPA field in the Identify Controller data structure
intentionally has bit 0 cleared because there is no namespace specific
information in the SMART / Health information log page.

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.10 ("Get Log Page command").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 122 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  10 ++++
 hw/block/trace-events |   2 +
 include/block/nvme.h  |   2 +-
 4 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f72348344832..468c36918042 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -569,6 +569,123 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+
+    uint32_t trans_len;
+    time_t current_ms;
+    uint64_t units_read =3D 0, units_written =3D 0, read_commands =3D 0,
+        write_commands =3D 0;
+    NvmeSmartLog smart;
+    BlockAcctStats *s;
+
+    if (nsid && nsid !=3D 0xffffffff) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    s =3D blk_get_stats(n->conf.blk);
+
+    units_read =3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
+    units_written =3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
+    read_commands =3D s->nr_ops[BLOCK_ACCT_READ];
+    write_commands =3D s->nr_ops[BLOCK_ACCT_WRITE];
+
+    if (off > sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(smart) - off, buf_len);
+
+    memset(&smart, 0x0, sizeof(smart));
+
+    smart.data_units_read[0] =3D cpu_to_le64(units_read / 1000);
+    smart.data_units_written[0] =3D cpu_to_le64(units_written / 1000);
+    smart.host_read_commands[0] =3D cpu_to_le64(read_commands);
+    smart.host_write_commands[0] =3D cpu_to_le64(write_commands);
+
+    smart.temperature[0] =3D n->temperature & 0xff;
+    smart.temperature[1] =3D (n->temperature >> 8) & 0xff;
+
+    if ((n->temperature > n->features.temp_thresh_hi) ||
+        (n->temperature < n->features.temp_thresh_low)) {
+        smart.critical_warning |=3D NVME_SMART_TEMPERATURE;
+    }
+
+    current_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    smart.power_on_hours[0] =3D cpu_to_le64(
+        (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
+        prp2);
+}
+
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    NvmeFwSlotInfoLog fw_log;
+
+    if (off > sizeof(fw_log)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    memset(&fw_log, 0, sizeof(NvmeFwSlotInfoLog));
+
+    trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
+        prp2);
+}
+
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
+    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  rae =3D (dw10 >> 15) & 0x1;
+    uint32_t numdl, numdu;
+    uint64_t off, lpol, lpou;
+    size_t   len;
+
+    numdl =3D (dw10 >> 16);
+    numdu =3D (dw11 & 0xffff);
+    lpol =3D dw12;
+    lpou =3D dw13;
+
+    len =3D (((numdu << 16) | numdl) + 1) << 2;
+    off =3D (lpou << 32ULL) | lpol;
+
+    if (off & 0x3) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
+
+    switch (lid) {
+    case NVME_LOG_ERROR_INFO:
+        if (off) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        return NVME_SUCCESS;
+    case NVME_LOG_SMART_INFO:
+        return nvme_smart_info(n, cmd, len, off, req);
+    case NVME_LOG_FW_SLOT_INFO:
+        return nvme_fw_log_info(n, cmd, len, off, req);
+    default:
+        trace_nvme_dev_err_invalid_log_page(nvme_cid(req), lid);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
 {
     n->cq[cq->cqid] =3D NULL;
@@ -914,6 +1031,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return nvme_del_sq(n, cmd);
     case NVME_ADM_CMD_CREATE_SQ:
         return nvme_create_sq(n, cmd);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log(n, cmd, req);
     case NVME_ADM_CMD_DELETE_CQ:
         return nvme_del_cq(n, cmd);
     case NVME_ADM_CMD_CREATE_CQ:
@@ -1411,6 +1530,7 @@ static void nvme_init_state(NvmeCtrl *n)
=20
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
+    n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1491,7 +1611,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
      */
     id->acl =3D 3;
     id->frmw =3D 7 << 1;
-    id->lpa =3D 1 << 0;
+    id->lpa =3D 1 << 2;
=20
     /* recommended default value (~70 C) */
     id->wctemp =3D cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1518f32557a3..89b0aafa02a2 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -109,6 +109,7 @@ typedef struct NvmeCtrl {
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
     uint16_t    temperature;
+    uint64_t    starttime_ms;
=20
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
@@ -124,4 +125,13 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, Nv=
meNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
=20
+static inline uint16_t nvme_cid(NvmeRequest *req)
+{
+    if (req) {
+        return le16_to_cpu(req->cqe.cid);
+    }
+
+    return 0xffff;
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index ade506ea2bb2..7da088479f39 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,7 @@ nvme_dev_getfeat_numq(int result) "get feature number o=
f queues, result=3D%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
 nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
+nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, u=
int64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" o=
ff %"PRIu64""
 nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D=
0x%"PRIx64""
@@ -85,6 +86,7 @@ nvme_dev_err_invalid_create_cq_qflags(uint16_t qflags) =
"failed creating completi
 nvme_dev_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D=
0x%"PRIx16""
 nvme_dev_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%=
"PRIx32""
 nvme_dev_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D=
0x%"PRIx32""
+nvme_dev_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16"=
 lid 0x%"PRIx16""
 nvme_dev_err_startfail_cq(void) "nvme_start_ctrl failed because there ar=
e non-admin completion queues"
 nvme_dev_err_startfail_sq(void) "nvme_start_ctrl failed because there ar=
e non-admin submission queues"
 nvme_dev_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the=
 admin submission queue address is null"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index ff31cb32117c..9a6055adeb61 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -515,7 +515,7 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  =3D 1 << 4,
 };
=20
-enum LogIdentifier {
+enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     =3D 0x01,
     NVME_LOG_SMART_INFO     =3D 0x02,
     NVME_LOG_FW_SLOT_INFO   =3D 0x03,
--=20
2.25.0


