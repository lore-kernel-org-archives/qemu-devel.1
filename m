Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55C2C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747F2227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hGEr2HJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747F2227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwSf-0001Qo-V8
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZG-00021f-B4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvZA-0007RC-QJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvZ8-00071v-Tb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:10:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130950euoutp02a8cbbfbb81c94c17add1c1a06a5d0160~hx8Q0F2ZV0700607006euoutp02Y
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130950euoutp02a8cbbfbb81c94c17add1c1a06a5d0160~hx8Q0F2ZV0700607006euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760990;
 bh=CYRrHfKw1K9Ro4e7lTpoMGBBGlKMP9JOUCvEIyKYx08=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=hGEr2HJs9PZtwULSB6ECF0tc7u9qWdwT1/wOlbDhbkCidsv0RuoOVF8G7X1cqPBap
 0xgRlGjx8gQu55NRRCTifeGaT7p0mdFDxheTN7glQVJyxTUoPs1MkDGuDEcuqSDAWD
 745B1bsY7i6QJnSDaBghD5/5a41QpXUCet26uFjo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130949eucas1p26a52179a5d011456874e9d3b79a7c936~hx8Qp8C9j3066830668eucas1p2p;
 Thu, 19 Dec 2019 13:09:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id BB.5F.60698.D967BFD5; Thu, 19
 Dec 2019 13:09:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130949eucas1p172304dc579f8bda43a8febd234064799~hx8QWGndM1260812608eucas1p1n;
 Thu, 19 Dec 2019 13:09:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130949eusmtrp25b9e013f5a81a6afbc25bb8f511a758f~hx8QViM1f3120131201eusmtrp2Y;
 Thu, 19 Dec 2019 13:09:49 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-79-5dfb769d8cff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FE.4D.08375.D967BFD5; Thu, 19
 Dec 2019 13:09:49 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130949eusmtip15b753a1cc4586914247515b7af33fc90~hx8QP_5Ce2151321513eusmtip1e;
 Thu, 19 Dec 2019 13:09:49 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:48 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:48 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 22/24] nvme: bump controller pci device id
Date: Thu, 19 Dec 2019 14:09:19 +0100
Message-ID: <20191219130921.309264-23-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87pzy37HGrT0mlhs7m9ntJh06Bqj
 xZKLqRbzbilbzHrXzmZxvHcHiwObx6ZVnWwed67tYfN4cm0zk8f7fVfZAliiuGxSUnMyy1KL
 9O0SuDLW/jvMXvCZq+LE9BlMDYw/OboYOTkkBEwkXl+5z9rFyMUhJLCCUeL2vH3MEM4XRom/
 pyeyQTifGSVenTwA5HCAtbzfZgMRX84ocX3RR2aQUWBFL866QyTOMEq8bLzKCOHsYpSY8qWF
 BaSKTUBTYvuf/2C2iIC0RPvVSWDLmQWuM0oc+n2RHSQhLGArsfr3RVYQm0VAVeLJ9KlgcV4B
 a4nNOw6xQVwuL7H12yewGk6g+Jbe24wQNYISJ2c+AVvADFTTvHU2M4QtIXHwxQtmiN5V7BKr
 OqshbBegp38xQtjCEq+Ob2GHsGUk/u+czwRynIRAN6NE34evzBDODEaJ6cu+QwPDWqLvTA5E
 g6PEqZ777BBhPokbbwUh9vJJTNo2nRkizCvR0SYEUa0msaNpK+MERuVZSK6eheTqWUiuXsDI
 vIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwtZz+d/zrDsZ9f5IOMQpwMCrx8Dqk/Y4V
 Yk0sK67MPcQowcGsJMJ7u+NnrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNT
 UwtSi2CyTBycUg2MgU42EeI3f8ctnH2tzLq09oQRW2sLy883P2I6zjy9PT11bUDZ8tJNF2xM
 bVIP8vX6zLPqX8u52OGFGJvYvXnvFz5/235fW2F+afaikuXsucJHmq9PYK0wExYp0Mm8cFzi
 zPZJYjkXM9V/7nn6Sj0ljEe4g2Pusj/P5oRblM4oMZxTuWSOiF2FEktxRqKhFnNRcSIA7CXD
 6ikDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7pzy37HGhxsULDY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBE6dkU5ZeWpCpk
 5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWs/XeYveAzV8WJ6TOY
 Ghh/cnQxcnBICJhIvN9m08XIxSEksJRRYsWtVrYuRk6guIzEpysf2SFsYYk/17rYIIo+Mkq0
 Lb/HAuGcYZQ4ubaDEcLZxSjR/2YeWAubgKbE9j//WUBsEQFpifark1hBipgFrjNKHPp9EaxI
 WMBWYvXvi6wgNouAqsST6VPB4rwC1hKbdxyCukNeYuu3T2A1nEDxLb23GUFsIQEricc/P7JA
 1AtKnJz5BMxmBqpv3jqbGcKWkDj44gXzBEbhWUjKZiEpm4WkbAEj8ypGkdTS4tz03GJDveLE
 3OLSvHS95PzcTYzAGNt27OfmHYyXNgYfYhTgYFTi4X2Z/DtWiDWxrLgy9xCjBAezkgjv7Y6f
 sUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD4z/vJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFC
 AumJJanZqakFqUUwfUwcnFINjC566VsmX/mb2hn440jP3/MuN6XZj//uqe0tD2ZL87stybTq
 0uzAxUcSyhb+jLC+9fnmpyXPtK6mtNi2ZV5fGHNUVEuR0+DfG+MV1493l3A89Z62894Jrn/z
 L93PXnA+c2VQGsMeibaq0xrzbnuLP0qy0EmKsNsvxyc/oTPL0qihNmqfRMW+E0osxRmJhlrM
 RcWJAHo/kqTHAgAA
X-CMS-MailID: 20191219130949eucas1p172304dc579f8bda43a8febd234064799
X-Msg-Generator: CA
X-RootMTR: 20191219130949eucas1p172304dc579f8bda43a8febd234064799
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130949eucas1p172304dc579f8bda43a8febd234064799
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130949eucas1p172304dc579f8bda43a8febd234064799@eucas1p1.samsung.com>
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

Since commits 9d6459d21a6e ("nvme: fix write zeroes offset and count")
and c7fe50bcf1f1 ("nvme: support multiple namespaces") the controller
device no longer has the quirks that the Linux kernel think it has.

As the quirks are applied based on pci vendor and device id, bump the
device id to get rid of them.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e1bf9bf3798b..68c433415169 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2480,7 +2480,7 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *p=
ci_dev)
     pci_conf[PCI_INTERRUPT_PIN] =3D 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
     pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
-    pci_config_set_device_id(pci_conf, 0x5845);
+    pci_config_set_device_id(pci_conf, 0x5846);
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
@@ -2651,7 +2651,7 @@ static void nvme_class_init(ObjectClass *oc, void *=
data)
     pc->exit =3D nvme_exit;
     pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
     pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
-    pc->device_id =3D 0x5845;
+    pc->device_id =3D 0x5846;
     pc->revision =3D 2;
=20
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
--=20
2.24.1


