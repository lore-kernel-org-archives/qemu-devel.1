Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85116C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515092087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m0G1OeeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515092087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuvI-0001ga-Dh
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusZ-0003r7-O0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusX-00075s-PW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:23 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusX-00074N-IC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095220euoutp02d9c9a09e3d8346089d18a6174bc56617~wKkP0VfM52946329463euoutp02D
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095220euoutp02d9c9a09e3d8346089d18a6174bc56617~wKkP0VfM52946329463euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809940;
 bh=7yZas5RzK8Uy+NxblLe9jsv/kAw6Vm8LwrGEfjDZnxY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=m0G1OeeYU+DI5FYiUeg0YHJ4j0s4NesnXoc4jqxp+G01mIl7EJ8v+fO1hC3FL7iFw
 FB6p6fVOhQNCYom3QNxIj5ud8brM2g9gYH0phDYugv83cZSZOA2nVvYzq0UvcqkT70
 WX1ubYCX6rgK73hgGkEIxf89SabAI50DjEMWAewQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095220eucas1p1222a38d78879781ab9754461936f5ba6~wKkPfqCwk0927009270eucas1p1p;
 Tue,  4 Feb 2020 09:52:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 9F.8E.61286.4DE393E5; Tue,  4
 Feb 2020 09:52:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095219eucas1p1a7e88f8f4090988b3dee34d4d4bcc239~wKkPNq5KX0044100441eucas1p1B;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095219eusmtrp2887984df21cd42ef67445dc83e2a3aaf~wKkPNIkiI0487104871eusmtrp2Y;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-f1-5e393ed40e04
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.6A.07950.3DE393E5; Tue,  4
 Feb 2020 09:52:19 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095219eusmtip2b2039c83c13b7d3088616cbd2557018a~wKkPGcpbz2812328123eusmtip2Y;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:19 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:19 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 07/26] nvme: add support for the abort command
Date: Tue, 4 Feb 2020 10:51:49 +0100
Message-ID: <20200204095208.269131-8-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUYRzfc+/de6/LXa9j+UZlHcuyIqvZoYytdFuz5a+mRR3eMHfnuhcl
 rVHN6W5RtiZ3yWVFs0XhxGbMZfl1I0RmqiUr9OOMkJDcPWr++3y/nx/fz549FCE28TyoFFU6
 o1HJFRJSwG14tdS7/01YcNyBuQ9bpHWFWiRtbVvgSYssw0j6qJ+RPhj1lhp+aElpx61Gbjhf
 1tvYx5fVVt0kZWPDzaRsYriOI7O1DJEneacFhxMZRUomowkIOydI1lnnkXrO9dLM706Ug8q3
 6pATBfQhKDR2cXRIQInpJwgej9fw8fATgbXbiPAwh2C0z8bTIcphaX+5C+8rERhLqsn/oilL
 KWnPFdM9CJ69O4WJJgSWaoODIOm98GJljWvHbrQnaIeKeHYRQS8jKM294xC50hHw5SlO4tI+
 YM1vdxiEdAi0l3WTuLkXGHN7HNiJDoXWqk4O1rhAV8mEQ0+sa66bjQTGAG2Tk4T9GNAtfNAv
 2/g46Ch8GljlYewK0x31G/sdsNZUxsEGPYKCmfkN9z0ExRWLJH6NUCiwKjCMgFJTEIYiGPnu
 gu+KoKihmMBrIeTniXH6Hmi8Zka3kbdhU2vDptaGTa1NiKhC7kwGq0xi2EAVc9GflSvZDFWS
 f0Kashat/5uePx2zjWh+IN6CaApJnIWvw6RxYp48k81SWhBQhMRN2BcQHCcWJsqzLjOatLOa
 DAXDWpAnxZW4Cw+WT8WK6SR5OpPKMGpG84/lUE4eOei5ouLXlelvXZzo47N+Oi2Ti2yau5Lt
 2wLItNSphszdg5zmVrMobyl+KMS8SKR7jVQOvr//ObKlelyvju2P2sl+9Ynjn1C25S5md+nf
 nqlfWbhxv/tYYnFC9GrU+TFTWiTvSEx2uFqJomo+PszYV3FBdBV8g6DXmbMQHlPo6yvhssny
 QD9Cw8r/AuajyQEzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7qX7SzjDC58MLHY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GV1n
 vjIWfBau+PDrBGMD4yL+LkYODgkBE4kjh+W6GLk4hASWMkp0HL7C1MXICRSXkfh05SM7hC0s
 8edaFxtE0UdGiaZ/j1ggnNOMEof+r2IGqRIS2MkosfOfO4jNJqApsf3PfxYQW0RAWqL96iRW
 EJtZ4DejxJ++QBBbWMBR4vnauWwgNouAisSZjiNg9bwCVhJH5p9ig9gsLzG78TSYzSlgLbF/
 1QkmkKuFgGpaj3JDlAtKnJz5hAVivLxE89bZzBC2hMTBFy+YJzAKz0JSNgtJ2SwkZQsYmVcx
 iqSWFuem5xYb6RUn5haX5qXrJefnbmIERty2Yz+37GDsehd8iFGAg1GJh1fD0SJOiDWxrLgy
 9xCjBAezkgjveX3LOCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3OByaDvJJ4Q1NDcwtLQ3Nj
 c2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjHOnHteZ2vd5ud6c5Fs1yz7+0TkXydH5
 9dXy0vuy94Q9uxfL7BPxv8kicUj2q3XIC5FZdler8wy4bQKtTk8zl7aYvT/kXMObVNbLB7+c
 m/px2kM91+Ln84rXte7jCtpVP71uTSDPx3f6U+v/nDp4SF9KMMHh2MKDa/3ezb1xe/4x88uM
 CfdFWaYpsRRnJBpqMRcVJwIAShqCmc4CAAA=
X-CMS-MailID: 20200204095219eucas1p1a7e88f8f4090988b3dee34d4d4bcc239
X-Msg-Generator: CA
X-RootMTR: 20200204095219eucas1p1a7e88f8f4090988b3dee34d4d4bcc239
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095219eucas1p1a7e88f8f4090988b3dee34d4d4bcc239
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095219eucas1p1a7e88f8f4090988b3dee34d4d4bcc239@eucas1p1.samsung.com>
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

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.1 ("Abort command").

The Abort command is a best effort command; for now, the device always
fails to abort the given command.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ba5089df9ece..e1810260d40b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -731,6 +731,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *=
cmd)
     }
 }
=20
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    uint16_t sqid =3D le32_to_cpu(cmd->cdw10) & 0xffff;
+
+    req->cqe.result =3D 1;
+    if (nvme_check_sqid(n, sqid)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
 {
     trace_nvme_dev_setfeat_timestamp(ts);
@@ -848,6 +860,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+
     return NVME_SUCCESS;
 }
=20
@@ -864,6 +877,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
         return nvme_identify(n, cmd);
+    case NVME_ADM_CMD_ABORT:
+        return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
@@ -1377,6 +1392,19 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     id->ieee[2] =3D 0xb3;
     id->ver =3D cpu_to_le32(NVME_SPEC_VER);
     id->oacs =3D cpu_to_le16(0);
+
+    /*
+     * Because the controller always completes the Abort command immedia=
tely,
+     * there can never be more than one concurrently executing Abort com=
mand,
+     * so this value is never used for anything. Note that there can eas=
ily be
+     * many Abort commands in the queues, but they are not considered
+     * "executing" until processed by nvme_abort.
+     *
+     * The specification recommends a value of 3 for Abort Command Limit=
 (four
+     * concurrently outstanding Abort commands), so lets use that though=
 it is
+     * inconsequential.
+     */
+    id->acl =3D 3;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 0;
     id->sqes =3D (0x6 << 4) | 0x6;
--=20
2.25.0


