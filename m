Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E00EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08783206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MclTpL02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08783206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwdH-0001fv-K8
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ8-0001qu-EF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZ5-0007IS-9J
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:05 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47937)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvZ3-0006bY-26
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:02 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130947euoutp01904fb500e16c563e4a75c064add32e7b~hx8OLargS1365313653euoutp01x
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130947euoutp01904fb500e16c563e4a75c064add32e7b~hx8OLargS1365313653euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760987;
 bh=jpBBUmXuEntRtAATca5MMmA233TrPWVY0pW4njezoZk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=MclTpL028qTk+BeTwDYRnvn7J9ACjoNBbJH2l18sUJE4goIPb8UaY5YkKyYinnufN
 Ol6LCC704wh0iZq34NMW6e/01tC4psT1+lyP5KXb5hP/sQXTEU8BBFgbVko6AJgOCJ
 2ZRQolDn78R6pyBEolG/QVHOszalEsgxz40rF5Zc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130946eucas1p1d909f0c5084481e3718d943989fc8908~hx8N9I4BY1798017980eucas1p17;
 Thu, 19 Dec 2019 13:09:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 79.5F.60698.A967BFD5; Thu, 19
 Dec 2019 13:09:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130946eucas1p1f58691ec4abdc3b1f42a082450758a72~hx8NjMZMj1459314593eucas1p1P;
 Thu, 19 Dec 2019 13:09:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130946eusmtrp231dac4571352dd77864faa6dbbde5597~hx8NiqWDP3120131201eusmtrp2H;
 Thu, 19 Dec 2019 13:09:46 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-6f-5dfb769a7eb8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DC.4D.08375.A967BFD5; Thu, 19
 Dec 2019 13:09:46 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130946eusmtip249537aee15a02bb8693ab15d862616e2~hx8Na3Ej43240732407eusmtip24;
 Thu, 19 Dec 2019 13:09:46 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:45 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:45 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 18/24] pci: pass along the return value of dma_memory_rw
Date: Thu, 19 Dec 2019 14:09:15 +0100
Message-ID: <20191219130921.309264-19-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7qzyn7HGvSfsbDY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBEcdmkpOZklqUW
 6dslcGXMOzyNqeAqR8Xbme+YGhjb2bsYOTkkBEwk9t0+yAhiCwmsYJQ4sqqwi5ELyP7CKPF0
 8xMmCOczo8TJk4uZYTr+nD7GBtGxnFFi0ilJuKIjXS/YIZwzjBKHN9xigajaxSixb78iiM0m
 oCmx/c9/sLiIgLRE+9VJrCANzALXGSUO/b4IdpSwgLfEvSNrwFawCKhKPHu2DexAXgFribmv
 p7FCnCEvsfXbJzCbEyi+pfc2VI2gxMmZT8AWMAPVNG+dzQyyQEJgFbvE8eX9bBDNLhJvvkyD
 hoCwxKvjW6BsGYn/O+czQTR0M0r0ffgK1T2DUWL6su9A3RxAjrVE35kcEJMZ6J31u/Qheh0l
 Jn48wwpRwSdx460gxA18EpO2TWeGCPNKdLQJQVSrSexo2so4gVF5FpKrZyG5ehbC/AWMzKsY
 xVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC08rpf8e/7mDc9yfpEKMAB6MSD69D2u9YIdbE
 suLK3EOMEhzMSiK8tzt+xgrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUg
 tQgmy8TBKdXAqJeWOm1vZKyxdFLAXYWqaz47+E7+M/hzf7bXZul6+STuW/7b8v6eypdp2HZ/
 z8bUtZ837lB9wXX5ig/zweT4xIlTZi05tzvt2eeSly0hdwvWda+YcnoN7zTZc/+aDVn/x1k9
 /NTI8MfokdFix8JXRukyQTXfDsj4pArrLPp+R0HF3Jit/vdEbiWW4oxEQy3mouJEAN5b45cn
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7qzyn7HGty8JGuxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MuYd3gaU8FVjoq3M98x
 NTC2s3cxcnJICJhI/Dl9jK2LkYtDSGApo8SJXe+ZIBIyEp+ufIQqEpb4c60Lqugjo8TeLZtY
 IJwzjBJLpp2GyuxilLjx/RIrSAubgKbE9j//WUBsEQFpifark1hBipgFrjNKHPp9EWyusIC3
 xL0ja9hAbBYBVYlnz7Yxgti8AtYSc19PY4XYLS+x9dsnMJsTKL6l9zZYjZCAlcTjnx9ZIOoF
 JU7OfAJmMwMtbt3+mx3Clpdo3jqbeQKj8CwkZbOQlM1CUraAkXkVo0hqaXFuem6xoV5xYm5x
 aV66XnJ+7iZGYJRtO/Zz8w7GSxuDDzEKcDAq8fC+TP4dK8SaWFZcmXuIUYKDWUmE93bHz1gh
 3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgcmgLySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLp
 iSWp2ampBalFMH1MHJxSDYzMu+TNPU//tcp6LnPts0Wq+66ThrwezmJvt5dMPX1R4Nsjpe18
 zb3HhPn7XnYmzI4JSThzbId1vOoknzYmvfYVbX/dPXskt4tdiOxi+35SJihAaPUBvkVTV51j
 q2EPPvpnqk/nHCmN7BdO0vJTxPZZLCiPXrh4yvTlr48/zl23qFXmveliR3clluKMREMt5qLi
 RACWxKZkyAIAAA==
X-CMS-MailID: 20191219130946eucas1p1f58691ec4abdc3b1f42a082450758a72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219130946eucas1p1f58691ec4abdc3b1f42a082450758a72
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130946eucas1p1f58691ec4abdc3b1f42a082450758a72
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130946eucas1p1f58691ec4abdc3b1f42a082450758a72@eucas1p1.samsung.com>
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

The nvme device needs to know the return value of dma_memory_rw to pass
block/011 from blktests. So pass it along instead of ignoring it.

There are no existing users of the return value, so this patch should be
safe.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index db75c6dfd05e..4d6f2b48a7f7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -783,8 +783,7 @@ static inline AddressSpace *pci_get_address_space(PCI=
Device *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir=
)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir=
);
 }
=20
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
--=20
2.24.1


