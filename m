Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411A8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCED218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qh/utKe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCED218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwKn-00081T-S6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYn-0001Ub-6i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYk-0006Ke-7o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYj-0006Fc-JW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130938euoutp02f73317f633f300198c919ed55a028632~hx8Ft2C9-0729207292euoutp02i
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130938euoutp02f73317f633f300198c919ed55a028632~hx8Ft2C9-0729207292euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760978;
 bh=IhArvh8wsatoKg68q7q++7YYyroe8ry44zVhMwiTbLA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=qh/utKe3UMAST9QOJBr9CuiH3S5BlGvIYIOf8Q9Xz8tn1O5uKBknltVf1UOSGuErS
 pcvSRrWeugIX3aPIy9nCA4G4YI0qRSF8P9vpF9+JC+NUMad4OAlSeRjsrxEN5qKivf
 B0COgMjZiY1QzmLgAEB+0JoJ//4sYQ0XsSNYFC+4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130937eucas1p2177fdc2d0b6314b5d611f58e1a56976f~hx8Fh63G03259332593eucas1p2b;
 Thu, 19 Dec 2019 13:09:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 83.05.60679.1967BFD5; Thu, 19
 Dec 2019 13:09:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130937eucas1p26be4db4b75dc87168bceff37f4fd5588~hx8FQMb_T3066330663eucas1p2U;
 Thu, 19 Dec 2019 13:09:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20191219130937eusmtrp1660186267703d8b1ac8abc8bd99ef125~hx8FPnjg62186021860eusmtrp13;
 Thu, 19 Dec 2019 13:09:37 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-ca-5dfb769196af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.4D.08375.1967BFD5; Thu, 19
 Dec 2019 13:09:37 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130937eusmtip1aa70315cbd6f799e14ced6a57bf3979a~hx8FIccMq2511425114eusmtip1g;
 Thu, 19 Dec 2019 13:09:37 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:36 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:36 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 05/24] nvme: populate the mandatory subnqn and ver fields
Date: Thu, 19 Dec 2019 14:09:02 +0100
Message-ID: <20191219130921.309264-6-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7oTy37HGjz4bGqxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4MpY2/mYvWC1QMW76awNjD95uhg5OSQETCR6j+9j72Lk4hASWMEo8fDSZzYI5wujxNLp
 v1ghnM+MEqf2zGCDaVnz6jIjiC0ksJxRYvYzbbiirf//s0A4ZxglfqxsYoZwdjFKTD/yih2k
 hU1AU2L7H5AqTg4RAWmJ9quTwHYwC1xnlDj0+yJYkbCAj0Tb62XMIDaLgKrEtPNdQA0cHLwC
 VhLvDvhBnCEvsfXbJ1YQm1PAWmJL722wk3gFBCVOznwCNp8ZqKZ562xmCFtC4uCLF2AHSQis
 YpdYfKaTGWKQi0TTk+uMELawxKvjW9ghbBmJ05N7WCAauhkl+j58heqeAfTOsu9sIBdJAK3u
 O5MD0eAoMfnjaUaIMJ/EjbeCEIv5JCZtm84MEeaV6GgTgqhWk9jRtJVxAqPyLCRnz0Jy9iwk
 Zy9gZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmFpO/zv+ZQfjrj9JhxgFOBiVeHhf
 JP+OFWJNLCuuzD3EKMHBrCTCe7vjZ6wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNIT
 S1KzU1MLUotgskwcnFINjCw/9Vhnrz01axZTxPwzdzzlG04dOlc4NdL966NppvMXXvU8sinz
 YpQjC09G//z3hnMe3XAy2JN8wNxaMXBrj8FxkwVXQ8K5k2x1DRt7VyWr3Wfkf1GU/E7EtSB/
 sdXia2q/J6ZPuvlfTGzpdW+JlyplWcV/t4rNMsv+2Bu8QcfRaL2y+ERpOyWW4oxEQy3mouJE
 AKKoM1opAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7oTy37HGqxco2Kxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtY2/mYvWC1QMW76awN
 jD95uhg5OSQETCTWvLrM2MXIxSEksJRR4sjf64wQCRmJT1c+skPYwhJ/rnWxQRR9ZJQ4dHYp
 lHOGUeLA29NMEM4uRonTX74xg7SwCWhKbP/znwXEFhGQlmi/OokVpIhZ4DpQ+++LYHOFBXwk
 2l4vA2tgEVCVmHa+C6iBg4NXwEri3QE/iNXyElu/fWIFsTkFrCW29N4GO08IqOTxz49g83kF
 BCVOznwCZjMD1Tdvnc0MYUtIHHzxgnkCo/AsJGWzkJTNQlK2gJF5FaNIamlxbnpusaFecWJu
 cWleul5yfu4mRmCEbTv2c/MOxksbgw8xCnAwKvHwvkz+HSvEmlhWXJl7iFGCg1lJhPd2x89Y
 Id6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4HRn9eSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
 9MSS1OzU1ILUIpg+Jg5OqQZGgTt3VinaT9l22uHnZoG/Sw8ZT8r7f5fh8rIW2bkr47QKtbb1
 Kj3Tbf3/wlB8pYpc1VnXs0Kb15fc/CY3fWKVtfZyL/2fX1cXCVh/fuJ68WCfp6do4L0bfReC
 mc/0qoVvqBC7sPjvc5Hb5W+kF5/ebya9Yu7Bx4Gc2Uw/pSVbeG6pf0q7HzxHU4mlOCPRUIu5
 qDgRABIqc03GAgAA
X-CMS-MailID: 20191219130937eucas1p26be4db4b75dc87168bceff37f4fd5588
X-Msg-Generator: CA
X-RootMTR: 20191219130937eucas1p26be4db4b75dc87168bceff37f4fd5588
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130937eucas1p26be4db4b75dc87168bceff37f4fd5588
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130937eucas1p26be4db4b75dc87168bceff37f4fd5588@eucas1p2.samsung.com>
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

Required for compliance with NVMe revision 1.2.1 or later. See NVM
Express 1.2.1, Section 5.11 ("Identify command"), Figure 90 and Section
7.9 ("NVMe Qualified Names").

This also bumps the supported version to 1.2.1.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e458b8292ac0..8f7049dc2dd5 100644
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
2.24.1


