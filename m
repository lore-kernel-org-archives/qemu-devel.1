Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B079C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373F0218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FjXJsn1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373F0218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwKD-00077o-Pa
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYk-0001Nq-4f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYi-0006Ej-AV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYh-0005vo-Js
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130936euoutp013172376d1d72bde032eb5fb24056d023~hx8Dzg5dT1239912399euoutp01j
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130936euoutp013172376d1d72bde032eb5fb24056d023~hx8Dzg5dT1239912399euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760976;
 bh=4pGJaG9dNAalIoLTbrecHupkHUEJyqGZ2CjhGJZHm/4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=FjXJsn1Gqu5lwHxtpVYrtwz0jinDs8U6228eIKIxz7D+Of6QzznJp7vRhNhSOJ9A5
 gtFgPdTVNcKuW/LCiGqK1NIkG7FotEsGoSeOldv2l+puMogyEppIqOhgEF7/pzlHZc
 9eohety7Sb3ihxYnr9RMA8riKQSuT1AoT497gKbk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130935eucas1p2531adf9e30bb41ddc32bd59067e82ae3~hx8DoBj-E0349703497eucas1p2_;
 Thu, 19 Dec 2019 13:09:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.FF.61286.F867BFD5; Thu, 19
 Dec 2019 13:09:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130935eucas1p2acf93b9e802b7b24818362cb2366950d~hx8DVsL-n1986019860eucas1p2_;
 Thu, 19 Dec 2019 13:09:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130935eusmtrp232a5cba98385f872afe27954c0ba2dce~hx8DVJudn3097130971eusmtrp22;
 Thu, 19 Dec 2019 13:09:35 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-47-5dfb768f2ed2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 84.BE.07950.F867BFD5; Thu, 19
 Dec 2019 13:09:35 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130935eusmtip1cb01fab8d46ca3287e26fbcb70e4b7e6~hx8DMt-Zj2084020840eusmtip13;
 Thu, 19 Dec 2019 13:09:35 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:34 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:34 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 02/24] nvme: remove superfluous breaks
Date: Thu, 19 Dec 2019 14:08:59 +0100
Message-ID: <20191219130921.309264-3-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7r9Zb9jDa53GFts7m9ntJh06Bqj
 xZKLqRbzbilbzHrXzmZxvHcHiwObx6ZVnWwed67tYfN4cm0zk8f7fVfZAliiuGxSUnMyy1KL
 9O0SuDJuPX3OWtDDWbHt5W/mBsZvbF2MnBwSAiYSJ29sYu1i5OIQEljBKDHp5EdGkISQwBdG
 iQ9v0iESnxklpizZxw7TcWHeGTaIxHJGiaMLTrHAVW3ctRxq1hlGiXNX/0OV7WKU+LpyOgtI
 P5uApsT2P//BbBEBaYn2q5PAOpgFrjNKHPp9EWyJsIClxMc9E1hBbBYBVYnjB+Yzgdi8AlYS
 bSfnQJ0uL7H12yewGk4Ba4ktvbcZIWoEJU7OfAK2gBmopnnrbGYIW0Li4IsXzCDLJASWsUs0
 vD3FDDHIReLmp0VQtrDEq+NboD6Vkfi/E2QxSEM3o0Tfh69Q3TMYJaYv+w50BgeQYy3RdyYH
 osFRYv+lB8wQYT6JG28FIRbzSUzaNh0qzCvR0SYEUa0msaNpK+MERuVZSM6eheTsWUjOXsDI
 vIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwvZz+d/zTDsavl5IOMQpwMCrx8Dqk/Y4V
 Yk0sK67MPcQowcGsJMJ7u+NnrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNT
 UwtSi2CyTBycUg2MvAkR+9dduWDR06qzblm/vH79wYgriUIztohZf5/9a8VF32XCG7MdThXx
 /k7br3jq/VkRm6SzNS3WkqWGXH27Ar/xSCbvTzR5G+cds8v1y2Tp26FmEcwtJY9sdRfZ3Dvj
 4/2dOdDPKCVS6LHyAY+8u2b7pefUaSzLPLFd4shCE0mNf2n/1k9QYinOSDTUYi4qTgQASxti
 oysDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7r9Zb9jDe5dkrfY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXcevqctaCHs2Lby9/M
 DYzf2LoYOTkkBEwkLsw7A2YLCSxllDj6QAciLiPx6cpHdghbWOLPtS6gGi6gmo+MEtvftjBC
 OGcYJfZeXM0O4exilHh5ZBsrSAubgKbE9j//WUBsEQFpifark1hBipgFrjNKHPp9EWyusICl
 xMc9E8AaWARUJY4fmM8EYvMKWEm0nZwDdZ+8xNZvn8BqOAWsJbb03maEuNVK4vHPjywQ9YIS
 J2c+AbOZgeqbt85mhrAlJA6+eME8gVF4FpKyWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0
 L10vOT93EyMwxrYd+7llB2PXu+BDjAIcjEo8vA5pv2OFWBPLiitzDzFKcDArifDe7vgZK8Sb
 klhZlVqUH19UmpNafIjRFOi5icxSosn5wPjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
 kpqdmlqQWgTTx8TBKdXAOOVbghiDqUD/cYatMSEXKpQdNmkd2mvu3nj75sOmDWeTLz76IKm/
 MEWSOWHRi2MagrO0zTgYbf8ssX23buECdZ1fj3h38HuzWsvk3spjWlsatJJjifqPNQ3LDzXZ
 5q7e/pRrzdfHInP9rx13VudL6Ty2l//H2kXfP2wtE4hfm3UqsDtZ82t/jxJLcUaioRZzUXEi
 AIDUzxPHAgAA
X-CMS-MailID: 20191219130935eucas1p2acf93b9e802b7b24818362cb2366950d
X-Msg-Generator: CA
X-RootMTR: 20191219130935eucas1p2acf93b9e802b7b24818362cb2366950d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130935eucas1p2acf93b9e802b7b24818362cb2366950d
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130935eucas1p2acf93b9e802b7b24818362cb2366950d@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.11
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

These break statements was left over when commit 3036a626e9ef ("nvme:
add Get/Set Feature Timestamp support") was merged.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index bcb1ca77e1bd..10666a3115c7 100644
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
2.24.1


