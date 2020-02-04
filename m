Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C614C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4292087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uXv4Xie+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuv4-00016W-4L
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusZ-0003qr-ET
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusX-00075D-K2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusX-000742-C7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095219euoutp01756a747c1b05856733c0c54b77a86e47~wKkOyLwlR3027830278euoutp01G
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095219euoutp01756a747c1b05856733c0c54b77a86e47~wKkOyLwlR3027830278euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809939;
 bh=291fx5TOawDgcHMH3BVB6xRjyY+aqZKyU4IofPXEIkg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=uXv4Xie+I8hdAYl3mfVePoBkxIekjwiFAXjF829eAqcf3Q91toSlENhXPG2C4fidC
 chVwzRQqDEjFxtmzx+Pgt8d1yyTtA5exAairqAV3ShHBR4KU+Vqg4yI999vhe9uqks
 NRZxJKBWtVDuzYD7pmxdlKVYJdnNaw+93Jtgt4DU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095219eucas1p1971e46d22411a278bc77fa9bc10e29b6~wKkOinTIA0253302533eucas1p1P;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.DF.60698.3DE393E5; Tue,  4
 Feb 2020 09:52:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095218eucas1p2400645e2400b3d4450386a46e71b9e9a~wKkOIiKz41214112141eucas1p2n;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095218eusmtrp2cf76c481d67f9bd00b46e9834b65c5bd~wKkOH2X-x0485704857eusmtrp2c;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e5-5e393ed3afbe
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.BC.08375.2DE393E5; Tue,  4
 Feb 2020 09:52:18 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095218eusmtip29f3b6e909bfb69d059debd33ab7194f7~wKkN-P23V2738327383eusmtip2M;
 Tue,  4 Feb 2020 09:52:18 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:18 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:17 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 05/26] nvme: populate the mandatory subnqn and ver fields
Date: Tue, 4 Feb 2020 10:51:47 +0100
Message-ID: <20200204095208.269131-6-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7qX7SzjDK6sYLXY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGdcPnGUtWC1QceLBb/YGxp88XYycHBICJhJL7u1mArGFBFYwStyZ
 GtzFyAVkf2GUeDzxDStE4jOjxOpeaZiG352rWCCKljNKPPh/mxXCASo6+OEgM4RzmlFiz+F7
 7BDOTkaJFzf2gS1hE9CU2P7nPwuILSIgLdF+dRJYO7PAb0aJuY0T2UASwgI+Et++XmYHsVkE
 VCRmN/aCNfMKWEksuf2UEeIQeaD4abB6TgFrif2rTkDVCEqcnPkEbAEzUE3z1tnMELaExMEX
 L8DOkxDYxS6xuuEZkMMB5LhIXJgrBTFTWOLV8S3sELaMxP+d85kg6rsZJfo+fIVqnsEoMX3Z
 dzaIZmuJvjM5EA2OEpO7QA4FCfNJ3HgrCLGXT2LStulQq3glOtqEIKrVJHY0bWWcwKg8C8nV
 s5BcPQvJ1QsYmVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEppvT/45/3cG470/SIUYB
 DkYlHl4NR4s4IdbEsuLK3EOMEhzMSiK85/Ut44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96
 GSskkJ5YkpqdmlqQWgSTZeLglGpg5BXrPnzhLAND8/viD/Ff7Dd9uLQw71ebVWnTEhH9+Vk7
 Y2XzsldeZll8l71Tqa28IeOCmmnf0bsH1XWvqOQ5+Ldt5HwlbHe1NGBN4QbtC8+VbtxfKm39
 4NQPa6VwG9eUCdaxB/gEthrmOSbNtJbyXd34+tkKi3N2y1fPt9e7vrBlFX/G6Uc/lViKMxIN
 tZiLihMB4tgh/TMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7qX7CzjDCY2a1ps7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOsH
 zrIWrBaoOPHgN3sD40+eLkZODgkBE4nfnatYuhi5OIQEljJKbJ/1jAkiISPx6cpHdghbWOLP
 tS42EFtI4COjxJmlIRANpxkl9i74xwjh7GSUmDV9OTNIFZuApsT2P/9ZQGwRAWmJ9quTWEFs
 ZoHfjBJ/+gJBbGEBH4lvXy+DbWARUJGY3dgLtplXwEpiye2njBCb5YHip8E2cwpYS+xfdQKo
 hgNomZVE61FuiHJBiZMzn7BAjJeXaN46mxnClpA4+OIF8wRG4VlIymYhKZuFpGwBI/MqRpHU
 0uLc9NxiQ73ixNzi0rx0veT83E2MwJjbduzn5h2MlzYGH2IU4GBU4uG9YGcRJ8SaWFZcmXuI
 UYKDWUmE97y+ZZwQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wPTQV5JvKGpobmFpaG5sbmx
 mYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkbpC12sKgEpfzOe/VvL7Jv403wma2/U+3YJ
 A/mWyUrMU+Kjlur/erq06Pw1vm3tc/f/rDs4h+fe3t/TerXPPFycaVa5yznwqsSbxKuvdaXe
 pBqcEfm/1untTXEVQZ3XkhPXCHjrJyovCDKoe/3+V9DJM4x8Jb39Zy5suzdH0+TJB5/1NaU9
 QfZKLMUZiYZazEXFiQBo+BKRzwIAAA==
X-CMS-MailID: 20200204095218eucas1p2400645e2400b3d4450386a46e71b9e9a
X-Msg-Generator: CA
X-RootMTR: 20200204095218eucas1p2400645e2400b3d4450386a46e71b9e9a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095218eucas1p2400645e2400b3d4450386a46e71b9e9a
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095218eucas1p2400645e2400b3d4450386a46e71b9e9a@eucas1p2.samsung.com>
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

Required for compliance with NVMe revision 1.2.1 or later. See NVM
Express 1.2.1, Section 5.11 ("Identify command"), Figure 90 and Section
7.9 ("NVMe Qualified Names").

This also bumps the supported version to 1.2.1.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f05ebcce3f53..9abf74da20f2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,9 +9,9 @@
  */
=20
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ * Reference Specification: NVM Express 1.2.1
  *
- *  http://www.nvmexpress.org/resources/
+ *   https://nvmexpress.org/resources/specifications/
  */
=20
 /**
@@ -43,6 +43,8 @@
 #include "trace.h"
 #include "nvme.h"
=20
+#define NVME_SPEC_VER 0x00010201
+
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
         (trace_##trace)(__VA_ARGS__); \
@@ -1365,6 +1367,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
+    id->ver =3D cpu_to_le32(NVME_SPEC_VER);
     id->oacs =3D cpu_to_le16(0);
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 0;
@@ -1372,6 +1375,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error=
 **errp)
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
+
+    strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
+    pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
+
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
@@ -1386,7 +1393,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
=20
-    n->bar.vs =3D 0x00010200;
+    n->bar.vs =3D NVME_SPEC_VER;
     n->bar.intmc =3D n->bar.intms =3D 0;
=20
     if (n->params.cmb_size_mb) {
--=20
2.25.0


