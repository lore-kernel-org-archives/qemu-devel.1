Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF88C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596D32087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="In0hnPzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596D32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuto-0005yb-HD
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusY-0003qi-IJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusX-00074b-8b
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusX-00073G-3I
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095220euoutp02a8a4a7e710711a4a3b8514c290c2b330~wKkPiR5N12946329463euoutp02B
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095220euoutp02a8a4a7e710711a4a3b8514c290c2b330~wKkPiR5N12946329463euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809940;
 bh=nrU80nnycXVcQCgtYWMp/oKReqBWBVQ0RLR+eX1hwgY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=In0hnPzidGHw20btRdSNzNxISp0OvfqFG+LW/KVYFWNa+8uBPut7fTmQHSDSPeOKy
 esP8mYGOe6K/3mERA2QV0R7Yax6q/rCLQ0vzMdoE9eNI7lT/y4B60XfAdDHlxk6NMX
 +Nscp6M9KQRS+6vFzjRfPQVJQERwzXq7jf95+KMw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095220eucas1p271f24107a9b800d88b6bbaca30fafcbd~wKkPYGqyW1194411944eucas1p2w;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.EB.60679.3DE393E5; Tue,  4
 Feb 2020 09:52:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095219eucas1p1a7d44c741e119939c60ff60b96c7652e~wKkOyJOnn0927009270eucas1p1k;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095219eusmtrp27466baeef473f3078244d24c6e9404ad~wKkOxmGqS0487104871eusmtrp2V;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-22-5e393ed33959
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 80.CC.08375.3DE393E5; Tue,  4
 Feb 2020 09:52:19 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095219eusmtip20ab8a33844fe3b441d2fbd2eb75e587f~wKkOoFppG2684926849eusmtip2J;
 Tue,  4 Feb 2020 09:52:19 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:18 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:18 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 06/26] nvme: refactor nvme_addr_read
Date: Tue, 4 Feb 2020 10:51:48 +0100
Message-ID: <20200204095208.269131-7-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87qX7SzjDBbcsLLY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGYvX/2Qq2MtVMeX/aaYGxhkcXYwcHBICJhLbX/N3MXJxCAmsYJTo
 mbyBCcL5wigxZ+ZUKOczo8TtX9fZYDpuzcyCiC9nlHg1/ypC0fFPz1ggnNOMEg+3nmeGcHYC
 tR+6D9TOycEmoCmx/c9/FhBbREBaov3qJFaQImaB34wScxsngu0QFjCXmPO4DKSGRUBF4s+X
 OWC9vAJWEmsX7AGzJQTkJWY3ngazOQWsJfavOsEEUSMocXLmE7D5zEA1zVtnM0PYEhIHX7wA
 O0hCYBe7xKKfjUwQg1wkmldvYoewhSVeHd8CZctI/N85nwmioZtRou/DV6juGYwS05d9h4aG
 tUTfmRyIBkeJ4wc7WCHCfBI33gpCLOaTmLRtOjNEmFeio00IolpNYkfTVsYJjMqzkJw9C8nZ
 s5CcvYCReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgujn97/iXHYy7/iQdYhTgYFTi
 4T151iJOiDWxrLgy9xCjBAezkgjveX3LOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJ
 pCeWpGanphakFsFkmTg4pRoYp+5UqovOtGHboaXyv34q6zmmHZoaFdc0nrs2qLvpRLMZz5ik
 IhvbWO52Sf26W5n9o2r+wD/frdesqLrYVSE4uUlq9Zsj9pkJCutMdz9Y0a7fJG+tWyX8dubH
 /ay2/6ZremauDLx9fa/GHq240l4epr0Ht5zlZBExPZe8WKTw/w3p938PnTqpxFKckWioxVxU
 nAgAN42qXjMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7qX7SzjDNavErXY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GYvX
 /2Qq2MtVMeX/aaYGxhkcXYwcHBICJhK3ZmZ1MXJxCAksZZSY3jKDqYuREyguI/Hpykd2CFtY
 4s+1LjaIoo+MEnMa/4MVCQmcZpSY0MsJkdjJKHGz5yUzSIJNQFNi+5//LCC2iIC0RPvVSawg
 NrPAb0aJP32BIJuFBcwl5jwuAwmzCKhI/Pkyhw3E5hWwkli7YA8bxGJ5idmNp8FsTgFrif2r
 TjCBtAoB1bQe5YYoF5Q4OfMJC8R0eYnmrbOZIWwJiYMvXjBPYBSehaRsFpKyWUjKFjAyr2IU
 SS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMt23Hfm7ewXhpY/AhRgEORiUe3gt2FnFCrIllxZW5
 hxglOJiVRHjP61vGCfGmJFZWpRblxxeV5qQWH2I0BfptIrOUaHI+MBXklcQbmhqaW1gamhub
 G5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgVJmX++/Go3W7v8vZPTpxX/Ouub3ssuJD
 s7ijf+zd/2RpuIZa2h237H3fZQ+vCRCxSJA7575P70T8Qhk9bZmyJ+/e+mt94f8sfvCfXiqf
 wOysWXp3G4odD730sdAuXulUrVF+OkI9/vWXL1wu+zhnnfK8eP18zEzdwzzGAmHGNdwnOVfP
 f9KWpcRSnJFoqMVcVJwIAP/k6x3NAgAA
X-CMS-MailID: 20200204095219eucas1p1a7d44c741e119939c60ff60b96c7652e
X-Msg-Generator: CA
X-RootMTR: 20200204095219eucas1p1a7d44c741e119939c60ff60b96c7652e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095219eucas1p1a7d44c741e119939c60ff60b96c7652e
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095219eucas1p1a7d44c741e119939c60ff60b96c7652e@eucas1p1.samsung.com>
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

Pull the controller memory buffer check to its own function. The check
will be used on its own in later patches.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9abf74da20f2..ba5089df9ece 100644
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
2.25.0


