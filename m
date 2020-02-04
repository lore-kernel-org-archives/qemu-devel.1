Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7560C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8512087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EUnlK+rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8512087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyutW-0005k7-LM
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusX-0003qc-NN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusW-00073Z-KT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusW-00071X-Ev
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:20 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095217euoutp02c71a4be20890e0f994189a1fd1188ef3~wKkM8rbYA2939629396euoutp02E
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095217euoutp02c71a4be20890e0f994189a1fd1188ef3~wKkM8rbYA2939629396euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809937;
 bh=qur1/wxHi89jgIWIuUfEaU8RtctvCWpuyGwgQk8l8EA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=EUnlK+rS2p7YczuOUakGUKpj5evsfcELbY6TtF0tRbS4icO9D9BVhQlLiZ7ZLuBxn
 uWGuBD3YWoHdTK6U1GjYgRpAC0BrBmLzmA8dAQ+RinCjHGE7NfQ/BmUcl8EZVQn1sK
 rkTZ9ifNLA1XnvAQbZqCzIhS/x+Y6rUPRgYUKODk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095217eucas1p15a71e60b5803523029c1012b26003e84~wKkMxPVlD0253302533eucas1p1K;
 Tue,  4 Feb 2020 09:52:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.DF.60698.1DE393E5; Tue,  4
 Feb 2020 09:52:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095216eucas1p137a2adf666e82d490aefca96a269acd9~wKkMdDCrx0923009230eucas1p13;
 Tue,  4 Feb 2020 09:52:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095216eusmtrp2f664638c3d547f8f38667f543841205c~wKkMce1WS0485704857eusmtrp2R;
 Tue,  4 Feb 2020 09:52:16 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-da-5e393ed19081
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.BC.08375.0DE393E5; Tue,  4
 Feb 2020 09:52:16 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095216eusmtip1b3653d43b1789955b9ac41022ff0006b~wKkMWkAsx3064230642eusmtip1s;
 Tue,  4 Feb 2020 09:52:16 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:16 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:15 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 02/26] nvme: remove superfluous breaks
Date: Tue, 4 Feb 2020 10:51:44 +0100
Message-ID: <20200204095208.269131-3-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7oX7SzjDFZv57XY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGccOTmAt6OGs+LXuMnMD4ze2LkZODgkBE4mWhRNZuhi5OIQEVjBK
 rLmxjhnC+cIocej5JUYI5zOjxM/9V1hgWn4s3ssKkVjOKPH9zQUmuKoJq1oYQaqEBE4zSux6
 5w2R2MkoMbNpP9hGNgFNie1//oONEhGQlmi/OglsFLPAb0aJuY0TwYqEBSwlzn/8xQRiswio
 SCw6tQgszitgJfFsyXqo0+UlZjeeBrM5Bawl9q86wQRRIyhxcuYTsAXMQDXNW2czQ9gSEgdf
 vAD7TkJgG7vE9xfPmCEGuUh8mH+YHcIWlnh1fAuULSPxf+d8JoiGbkaJvg9fobpnMEpMX/Yd
 aDUHkGMt0XcmB6LBUeLG1AvMEGE+iRtvBSEW80lM2jYdKswr0dEmBFGtJrGjaSvjBEblWUjO
 noXk7FlIzl7AyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMOWc/nf86w7GfX+SDjEK
 cDAq8fBqOFrECbEmlhVX5h5ilOBgVhLhPa9vGSfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jR
 y1ghgfTEktTs1NSC1CKYLBMHp1QDo5HAQiaODW/ebRSuP3z97pOdcndWeViy/lvRftWpf3tQ
 is7rrth17yL7Js6e8/Ov3mTnIwesWKeWPs9pmugYEyDqd7t72qq3H//mvK/6lh44NTGo7/G6
 HuXN0jP+3a3W9YvifyQrvqzKlPFw4pPAGDs+R6vvsfOXGDTnhCZrzGn+36kbEfeQWYmlOCPR
 UIu5qDgRAHJXiPM1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7oX7CzjDCatNrfY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GccO
 TmAt6OGs+LXuMnMD4ze2LkZODgkBE4kfi/eygthCAksZJVo6VSHiMhKfrnxkh7CFJf5c6wKq
 5wKq+cgo8eTwKRYI5zSjxI/XExkhnJ2MEnOmtzCDtLAJaEps//OfBcQWEZCWaL86CWwFs8Bv
 Rok/fYEgtrCApcT5j7+YQGwWARWJRacWgZ3EK2Al8WzJeqjz5CVmN54GszkFrCX2rzoBVM8B
 tMxKovUoN0S5oMTJmU9YIMbLSzRvnc0MYUtIHHzxgnkCo/AsJGWzkJTNQlK2gJF5FaNIamlx
 bnpusaFecWJucWleul5yfu4mRmDMbTv2c/MOxksbgw8xCnAwKvHwXrCziBNiTSwrrsw9xCjB
 wawkwnte3zJOiDclsbIqtSg/vqg0J7X4EKMp0G8TmaVEk/OB6SCvJN7Q1NDcwtLQ3Njc2MxC
 SZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANj+L7ZB4METm0Pky27/6R28d/pB+vtZ1RVdR6R
 iXJa0s8/q7//n7Kd0Q5zG2knnT99jq8/SH+QDSmVNHzZ+Xu7qL0735uTdwLs9Bg8ve9/FkjK
 2DvXd/755KMrbz30+1NU1ZKoOfFT6g6HJc9ZN09leyNlcftM/72kG4sSMj8siskO97diyz+o
 xFKckWioxVxUnAgASW27J88CAAA=
X-CMS-MailID: 20200204095216eucas1p137a2adf666e82d490aefca96a269acd9
X-Msg-Generator: CA
X-RootMTR: 20200204095216eucas1p137a2adf666e82d490aefca96a269acd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095216eucas1p137a2adf666e82d490aefca96a269acd9
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095216eucas1p137a2adf666e82d490aefca96a269acd9@eucas1p1.samsung.com>
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

These break statements was left over when commit 3036a626e9ef ("nvme:
add Get/Set Feature Timestamp support") was merged.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index dd548d9b6605..c9ad6aaa5f95 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -788,7 +788,6 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
-        break;
     default:
         trace_nvme_dev_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -831,11 +830,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         req->cqe.result =3D
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
         break;
-
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
-        break;
-
     default:
         trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
--=20
2.25.0


