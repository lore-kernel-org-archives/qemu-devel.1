Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3278C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D06521582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iLAOfCs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuwt-0004cP-LL
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusn-0004Po-1r
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusm-0007b0-3G
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusl-0007Cd-Uc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:36 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095225euoutp01d493ef57e18e1e9686dab3385de18523~wKkUCISlE3027830278euoutp01U
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095225euoutp01d493ef57e18e1e9686dab3385de18523~wKkUCISlE3027830278euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809945;
 bh=7e13WBYjkn8zgZbJgvkir7srv9SoHD+RPtgVKZ1sfiQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=iLAOfCs93KXVzO/s6aBLl2s1OAjRsJza+Kc+Ya+fvek2eymBzES2AQfAxKKB65sBf
 6zuk8vOogmma5uRLphsDWx6K/pN5aoOvnJKPVpuvzziJciLyO5fH1eACnTQutHWoie
 yAOo3Fjunx1H8yS6wPa6fbl4+7yyCnyFXCQm8SkA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095224eucas1p12c983dfcfd9f2f24e134ed8ad079f8e3~wKkTxOD000921609216eucas1p1D;
 Tue,  4 Feb 2020 09:52:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.9E.61286.8DE393E5; Tue,  4
 Feb 2020 09:52:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095224eucas1p10807239f5dc4aa809650c85186c426a8~wKkTe2juS0927009270eucas1p1w;
 Tue,  4 Feb 2020 09:52:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095224eusmtrp2955325b299aab734fc044add89969ada~wKkTdr-Jo0489204892eusmtrp2F;
 Tue,  4 Feb 2020 09:52:24 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-02-5e393ed8571d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 7B.6A.07950.8DE393E5; Tue,  4
 Feb 2020 09:52:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095224eusmtip14b09717fd48870cfa88bf54e3d973bc3~wKkTWByK73103231032eusmtip1j;
 Tue,  4 Feb 2020 09:52:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:23 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:23 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 14/26] nvme: make sure ncqr and nsqr is valid
Date: Tue, 4 Feb 2020 10:51:56 +0100
Message-ID: <20200204095208.269131-15-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7o37CzjDBZ06Fls7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujF+f9zAV/GKr2P0xsIFxHmsXIyeHhICJxI+XZ5m7GLk4hARWMEo8
 +/+fCcL5wijx68N9FgjnM6PE3Y0LGLsYOcBaNt3wgYgvZ5S43TQHoWj3tjdsEM5pRolH73dD
 Dd7JKHFo7VE2kI1sApoS2//8ZwGxRQSkJdqvTmIFKWIW+M0oMbdxIliRsICDxJXJM5hAbBYB
 FYnXf1pYQXbzClhL/HqWDXG5vMTsxtNg5ZxA4f2rToCV8woISpyc+QRsPjNQTfPW2cwQtoTE
 wRcvwA6SENjFLjHz/3kWiEEuEgu73rNB2MISr45vYYewZST+75zPBNHQzSjR9+ErVPcMRonp
 y76zQULDWqLvTA5Eg6PEucMbWCDCfBI33gpCLOaTmLRtOjNEmFeio00IolpNYkfTVsYJjMqz
 kJw9C8nZs5CcvYCReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgujn97/inHYxfLyUd
 YhTgYFTi4b1gZxEnxJpYVlyZe4hRgoNZSYT3vL5lnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
 40UvY4UE0hNLUrNTUwtSi2CyTBycUg2M7J8nubWlJXM+c5oqf8l74dMn1qXzd21+FmX0cX3d
 9kzbwLbnRhvVJ6fP32p54XSWfv8R055XuiekT0af32DcbfaB7b1/jHDYhvc2C5daro6wWs6S
 2jv5+jbXmZM+XRFcdXf6wxu/PrUcOuZpoSEvnFOjeUojWPek9ufj4d8EKo+91JdWfvE1VYml
 OCPRUIu5qDgRAH1Z2VszAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7o37CzjDFbNkLTY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb8+
 72Eq+MVWsftjYAPjPNYuRg4OCQETiU03fLoYuTiEBJYySuzYOYOti5ETKC4j8enKR3YIW1ji
 z7UuNoiij4wS2yceYYJwTjNKXFu2Hiqzk1Fi4oxdYO1sApoS2//8ZwGxRQSkJdqvTmIFsZkF
 fjNK/OkLBLGFBRwkrkyewQRiswioSLz+0wJ2Eq+AtcSvZ9kQm+UlZjeeBhvJCRTev+oEE0iJ
 kICVROtRbpAwr4CgxMmZT1ggpstLNG+dzQxhS0gcfPGCeQKj8CwkZbOQlM1CUraAkXkVo0hq
 aXFuem6xkV5xYm5xaV66XnJ+7iZGYLxtO/Zzyw7GrnfBhxgFOBiVeHg1HC3ihFgTy4orcw8x
 SnAwK4nwnte3jBPiTUmsrEotyo8vKs1JLT7EaAr02kRmKdHkfGAqyCuJNzQ1NLewNDQ3Njc2
 s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKil8+bCi7SDtlM8hE+fMOySfe+6YOOrUyb+
 4pdahZlU7vIzvK/sPxN++A7fJSWFDSuMfbcG/lgTlBqb132vvCJi9geGj2tVrCQ+HRNvtFRZ
 FFO4IP3Cbzml5Jm/f1x5uNbmSIjJmi9fWjnaozrmr/1xbsHJtp+8X3Z9eS6590y6b5B6250u
 KyYlluKMREMt5qLiRACZDtbczQIAAA==
X-CMS-MailID: 20200204095224eucas1p10807239f5dc4aa809650c85186c426a8
X-Msg-Generator: CA
X-RootMTR: 20200204095224eucas1p10807239f5dc4aa809650c85186c426a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095224eucas1p10807239f5dc4aa809650c85186c426a8
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095224eucas1p10807239f5dc4aa809650c85186c426a8@eucas1p1.samsung.com>
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

0xffff is not an allowed value for NCQR and NSQR in Set Features on
Number of Queues.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 30c5b3e7a67d..900732bb2f38 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1133,6 +1133,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        if ((dw11 & 0xffff) =3D=3D 0xffff || ((dw11 >> 16) & 0xffff) =3D=
=3D 0xffff) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
         trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
             ((dw11 >> 16) & 0xFFFF) + 1, n->params.num_queues - 1,
             n->params.num_queues - 1);
--=20
2.25.0


