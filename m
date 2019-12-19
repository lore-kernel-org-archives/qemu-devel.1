Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601F920663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N5EeoiAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601F920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwVM-0005mE-Ek
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZE-0001xy-7w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZC-0007WX-6M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvZA-00077r-P0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130951euoutp02d79c121f5ecc1c99efc67b0c02e90c15~hx8SFKxcM0697606976euoutp02c
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130951euoutp02d79c121f5ecc1c99efc67b0c02e90c15~hx8SFKxcM0697606976euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760991;
 bh=JSHPvLNtx7G+B0/+Jvm7M8JS310fB0IfwpO9b9Vnmdo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=N5EeoiACuLaBRL3eLzgwW+Y55c76YykIofgsHgm7heNJVp0EXwaOJZFZp+b9RB1l1
 fkFVM3jOixOY+3GkTeV1dyRv5f37E+80dnzoq5dvcN9xKC3GxXutcvdJRObcj3Elwh
 Nj/LyZuQWCa23PDskGv0bkxAyB1L++bdMuc5d30A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130951eucas1p27f1a357b37fca17752489632d9411629~hx8R4Tur11986019860eucas1p2U;
 Thu, 19 Dec 2019 13:09:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id C5.00.61286.F967BFD5; Thu, 19
 Dec 2019 13:09:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130950eucas1p14932d144e3e12fb98a6ec685cf616701~hx8RjpczZ1260812608eucas1p1q;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130950eusmtrp2ad69a17dfc74bb9cc10555ace1ea1dac~hx8RjHPy03120131201eusmtrp2g;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-80-5dfb769f1e74
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 80.5D.08375.E967BFD5; Thu, 19
 Dec 2019 13:09:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130950eusmtip2284512c395b6cfc6cdb45d33ad71d3ea~hx8RcSxrT3240732407eusmtip28;
 Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:50 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:49 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 24/24] nvme: make lba data size configurable
Date: Thu, 19 Dec 2019 14:09:21 +0100
Message-ID: <20191219130921.309264-25-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3d2ud6PJdQo+aSHMDBPSpIhFUoYFI1AK/0mrpt6muU3b3NSC
 sDRnhtP8o5uRoqJhOND5sdmQvIXDL8TSJdMySmgVmrNWiSvbdif575znOec854WXwASNnCgi
 X1lMqZRSuRDnsQfHNmcOt2i3JEe8s7jIXKdDogbagUQds5TosTNWZFzT4SJ7rYWdiov7uu/j
 4iWHDRevOMws8beRefwCO4uXkkvJ87WUKunUVV6eyVZaNMYvtQy7Q8rROq8GcQkgj8HHGQ9W
 g3iEgHyCwOteDmHIDwQblfWIId8RLHTR7B2L+Y6bwyy6EPxea/6vcs1VBjdTCCb03iAZRtD9
 9BPH78fJQzDk3Q5kRZDRoJtvCIgw8g0CemvWd54gwsnTsNae4NewyTh4MbzE8mM+eRIMcyM4
 0yMGBn5uBDK5vnl/7SJiNGEwblgJ5GM+TcVAM8ZggFGXK/BUIE0hMPmwl8UEnYW2IWswNBy+
 2PtDGLwPtq0tLMbwAIF+3RN0NyFo7PyF+5uC77R+Ss4YzoD7vTk4DoWF1TDmcCg0DDZizJgP
 1VUCRn0QLHcHUD2KNe6qbdxV27irdivCulEkpVErZJQ6WUmVJKqlCrVGKUvMKVT0Id93mfxr
 37Agz6tsGpEEEu7hp17bkgg4Uq26TEEjIDBhBH+xelMi4OdKy25SqsIrKo2cUtMommALI/lH
 2z5LBKRMWkwVUFQRpdrZsghuVDnqxFcT0jd74/54pp1J12mr6l3VjYrs9vnInLaXl55dnBFn
 0E+OW+tu6/RDrmm8uu611FCyCoPx9nyDw/y2auHrqOyeoClHEbO/puf5iaylvc404lbKxPlz
 KemXbSZtgSSzNZR0mDImPmi4mfKOzDQIcz2yeeOXk8bNzgOoR8hW50mTEzCVWvoPF9MHfioD
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7rzyn7HGvw9YWixub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtYt6ei4BhvxY5dH9kb
 GD9wdTFyckgImEhsbvzI2sXIxSEksJRR4veKe4wQCRmJT1c+skPYwhJ/rnWxQRR9ZJS4tmI5
 C4RzBsh5fJgZwtnFKPFm/z02kBY2AU2J7X/+s4DYIgLSEu1XJ4HtYBa4zihx6PdFoLkcHMIC
 9hLvFmuB1LAIqEoc3nWHCcTmFbCWmHllHxvEanmJrd8+sYLYnEDxLb23wc4TErCSePzzIwtE
 vaDEyZlPwGxmoPrmrbOZIWwJiYMvXjBPYBSehaRsFpKyWUjKFjAyr2IUSS0tzk3PLTbUK07M
 LS7NS9dLzs/dxAiMsG3Hfm7ewXhpY/AhRgEORiUe3pfJv2OFWBPLiitzDzFKcDArifDe7vgZ
 K8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wOjPK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMk
 kJ5YkpqdmlqQWgTTx8TBKdXAOPXmtCmGT/mffWaT9/TvMBHvmXmpuHvKRr51b1bbnFvR1+IQ
 No399P3bW9qt3/HfufTk5UGjd6fUPL0bfAXnmjfa3fBkTXQsal+xb1tRXeLllNYjSr/eSntF
 T7dsvuS0cc9y2+sHv6aXWlz6dauM00/4+Pzd82MtlxlsK3mbsOHB/buHL6Y9ZFJiKc5INNRi
 LipOBAA0SgTyxgIAAA==
X-CMS-MailID: 20191219130950eucas1p14932d144e3e12fb98a6ec685cf616701
X-Msg-Generator: CA
X-RootMTR: 20191219130950eucas1p14932d144e3e12fb98a6ec685cf616701
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130950eucas1p14932d144e3e12fb98a6ec685cf616701
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130950eucas1p14932d144e3e12fb98a6ec685cf616701@eucas1p1.samsung.com>
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

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.c | 2 +-
 hw/block/nvme-ns.h | 4 +++-
 hw/block/nvme.c    | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 36deedee07a6..dc7e63b01037 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns =3D &ns->id_ns;
=20
-    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    id_ns->lbaf[0].ds =3D ns->params.lbads;
     id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D
         cpu_to_le64(nvme_ns_nlbas(ns));
=20
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index b564bac25f6d..f1fe4db78b41 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -7,10 +7,12 @@
=20
 #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
     DEFINE_PROP_DRIVE("drive", _state, blk), \
-    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
+    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
+    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, BDRV_SECTOR_BITS)
=20
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  lbads;
 } NvmeNamespaceParams;
=20
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0ebb9aabbeb2..a7d32b230ad7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2605,6 +2605,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     if (n->namespace.blk) {
         ns =3D &n->namespace;
         ns->params.nsid =3D 1;
+        ns->params.lbads =3D BDRV_SECTOR_BITS;
=20
         if (nvme_ns_setup(n, ns, &local_err)) {
             error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
--=20
2.24.1


