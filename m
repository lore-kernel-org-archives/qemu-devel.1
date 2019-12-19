Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC05C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5353621D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vp8UR39b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5353621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42075 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwQL-0006DB-Ch
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYn-0001V3-Ei
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYk-0006Kl-8S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYj-0006Fw-I6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130939euoutp010cd208c62af03fae4691d29e65cf82a0~hx8GkHjJd1365313653euoutp01n
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191219130939euoutp010cd208c62af03fae4691d29e65cf82a0~hx8GkHjJd1365313653euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760979;
 bh=P67+qrgZG/ujpUDGpG8EZZk9Za7CJHhitfAKNXsv0FY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Vp8UR39bna1A1dyKCx8CjSi2cxlK2mDJ3lYzriH2LVhV/kh5zOcS9cWO51ELaOC05
 Ky3H4iFwJscbJ6wF4nEme9M1cwsa7iosFzmf+Mqq9m9GpM4uBG+H/6ZFVfb0/2rMJC
 Bkm+XWZBDGfxm6I5jOLgjUdO7+HOmCrM2YYz2NmU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130938eucas1p228e936a4ce0b32c9224c1d7fbdca1717~hx8GU0Y3g0340903409eucas1p2A;
 Thu, 19 Dec 2019 13:09:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 14.05.60679.2967BFD5; Thu, 19
 Dec 2019 13:09:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130938eucas1p2b962d75ab2df429772bb172f94a01f3d~hx8F8u_B31986619866eucas1p2d;
 Thu, 19 Dec 2019 13:09:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130938eusmtrp2133548ae5505b79b11ada0961e7c1b3d~hx8F8GbC83097130971eusmtrp28;
 Thu, 19 Dec 2019 13:09:38 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-ce-5dfb76920ae7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 36.BE.07950.2967BFD5; Thu, 19
 Dec 2019 13:09:38 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130938eusmtip1d00455f5d63edb6cd07394ad2b2ca76e~hx8F1AyHd3187731877eusmtip1E;
 Thu, 19 Dec 2019 13:09:38 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:37 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:37 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 06/24] nvme: refactor nvme_addr_read
Date: Thu, 19 Dec 2019 14:09:03 +0100
Message-ID: <20191219130921.309264-7-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7qTyn7HGizZp2+xub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4MrYeO8JS8FeroquDc/YGhhncHQxcnJICJhIbFuznaWLkYtDSGAFo8SL1UfZIZwvjBLv
 j19mg3A+M0psOtrODNOy5G0jI0RiOaPEujUzEarazr1khnDOAGVWnmeCcHYxSpz6cRisn01A
 U2L7n/8sILaIgLRE+9VJrCBFzALXGSUO/b7IDpIQFjCXePp3KROIzSKgKrH/XAtYnFfASuL+
 gStMEIfIS2z99okVxOYUsJbY0nubEaJGUOLkzCdgC5iBapq3zmaGsCUkDr54AfXEKnaJe9u8
 uxg5gGwXicuw4BCWeHV8CzuELSPxf+d8sAckBLoZJfo+fGWGcGYwSkxf9p0Notlaou9MDkSD
 o0TX9HnMEGE+iRtvBSHW8klM2jYdKswr0dEmBFGtJrGjaSvjBEblWUiOnoXk6FlIjl7AyLyK
 UTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMLmc/nf8yw7GXX+SDjEKcDAq8fC+SP4dK8Sa
 WFZcmXuIUYKDWUmE93bHz1gh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YW
 pBbBZJk4OKUaGENk/EXLHliZ5D0/8Hg/S5N4ZuW7Npkq+4SKbRZiEbbimndSI5q4nnlt/lMd
 kJd4f+JCsd8lCzSVun5+bipY/YIxfk/Mxamz4xtDns/MmlD44FINv/Ce01wH3pgJTZc+tVh2
 qdfvSKHEgjaf1pdPrJZJ3gn4u2fthjfuZ0OrPh+ufnv1veSOXUosxRmJhlrMRcWJADk8+Jgq
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7qTyn7HGmxbL2Kxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvYeO8JS8FeroquDc/Y
 GhhncHQxcnJICJhILHnbyNjFyMUhJLCUUWL97umsEAkZiU9XPrJD2MISf651sUEUfWSUaGh8
 AtVxhlHi8KUvYB1CArsYJf60B4PYbAKaEtv//GcBsUUEpCXar05iBWlgFrjOKHHo90WwscIC
 5hJP/y5lArFZBFQl9p9rAYvzClhJ3D9whQlitbzE1m+fwBZwClhLbOm9zQixzEri8c+PLBD1
 ghInZz4Bs5mB6pu3zmaGsCUkDr54wTyBUXgWkrJZSMpmISlbwMi8ilEktbQ4Nz232EivODG3
 uDQvXS85P3cTIzDGth37uWUHY9e74EOMAhyMSjy8Dmm/Y4VYE8uKK3MPMUpwMCuJ8N7u+Bkr
 xJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnA+M8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQ
 nliSmp2aWpBaBNPHxMEp1cDovT4+8MaWmstTFjGsy5wRYHlga8trHvcFB4yvvbxx+J5c2BOd
 l09PeNkce2Xt06ukH994bcGB27OcgjIXLHIxDmufd/PZfY5mOe4KD+3sTKnvbclCO5fL5Cks
 n/K5Y17eZUEbyxd7ZBb8mnxyX+UbHYeNXF/7rWNVF6sxnJcofH3jpJa1gXKCEktxRqKhFnNR
 cSIA9/UXrccCAAA=
X-CMS-MailID: 20191219130938eucas1p2b962d75ab2df429772bb172f94a01f3d
X-Msg-Generator: CA
X-RootMTR: 20191219130938eucas1p2b962d75ab2df429772bb172f94a01f3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130938eucas1p2b962d75ab2df429772bb172f94a01f3d
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130938eucas1p2b962d75ab2df429772bb172f94a01f3d@eucas1p2.samsung.com>
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

Pull the controller memory buffer check to its own function. The check
will be used on its own in later patches.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8f7049dc2dd5..a41ebf578f04 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -54,14 +54,22 @@
=20
 static void nvme_process_sq(void *opaque);
=20
+static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
+{
+    hwaddr low =3D n->ctrl_mem.addr;
+    hwaddr hi  =3D n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
+
+    return addr >=3D low && addr < hi;
+}
+
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
 {
-    if (n->cmbsz && addr >=3D n->ctrl_mem.addr &&
-                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size=
))) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
-    } else {
-        pci_dma_read(&n->parent_obj, addr, buf, size);
+    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
+        memcpy(buf, (void *) &n->cmbuf[addr - n->ctrl_mem.addr], size);
+        return;
     }
+
+    pci_dma_read(&n->parent_obj, addr, buf, size);
 }
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
--=20
2.24.1


