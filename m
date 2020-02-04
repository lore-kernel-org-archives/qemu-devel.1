Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A3621582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a5oDYhhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A3621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuw8-0002pt-El
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusq-0004ZJ-HP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusp-0007k6-FQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusp-0007Iz-9Y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095228euoutp02eb530756f70395c63cd902dbc7862fda~wKkXLtW7W2946329463euoutp02R
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204095228euoutp02eb530756f70395c63cd902dbc7862fda~wKkXLtW7W2946329463euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809948;
 bh=mfUvDxHlnHRvW20FJPrrta98RCok2EM3cc2TPEyj3Zc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=a5oDYhhTR2pPpv0uS/7E+XaJjxASR7nOOSu6aqIRGtqlnc/+363QvudvMGPleAERb
 pqHvnJe+FC3nvBDrq8s1wH/kDFNxn9/lZ2XUKDEPY63oTfczTMSW0bTHKSVTiMNbtS
 NkYiQm3XKMCziIjzrpBTyFSuihgJEIJ8zqiMH5Zg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204095228eucas1p137cfe587e2106258f919547c5b3be6f7~wKkW8ut8_0251202512eucas1p1b;
 Tue,  4 Feb 2020 09:52:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 95.9E.61286.CDE393E5; Tue,  4
 Feb 2020 09:52:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095227eucas1p2d86cd6abcb66327dc112d58c83664139~wKkWlhNnB2189621896eucas1p2M;
 Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095227eusmtrp2aa79ed0055e556e3389419acb40dad8e~wKkWk-VRd0487104871eusmtrp2r;
 Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-0e-5e393edcf30c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.6A.07950.BDE393E5; Tue,  4
 Feb 2020 09:52:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095227eusmtip239e6d654c21cb411f9ebfa37a940e860~wKkWcbWnH2319123191eusmtip2P;
 Tue,  4 Feb 2020 09:52:27 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:27 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:26 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 19/26] pci: pass along the return value of dma_memory_rw
Date: Tue, 4 Feb 2020 10:52:01 +0100
Message-ID: <20200204095208.269131-20-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7p37CzjDB6vZrfY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGe3vtrEVXOWoOPeik6WBsZ29i5GTQ0LARKKh+yBTFyMXh5DACkaJ
 UwcamSGcL4wSn3ruM0I4nxklPk94yAbTcnTeHqjEckaJGb+3M8FVPd7YCJU5zSjRcv0xVGYn
 o8Se/+9YQfrZBDQltv/5zwJiiwhIS7RfncQKUsQs8JtRYm7jRLAlwgLeEsev7wVrYBFQkXj+
 8CKYzStgLbG/4RAzxCHyErMbT4PVc4LEV51ggqgRlDg58wnYAmagmuats8FekhDYxi5xa/Ip
 VohmF4mjXSsYIWxhiVfHt0ADREbi/875TBAN3YwSfR++QnXPYJSYvuw70DoOIMdaou9MDojJ
 DPTO+l36EFFHiZ4TVRAmn8SNt4IQJ/BJTNo2nRkizCvR0SYEsUhNYkfTVsYJjMqzkBw9C8nR
 sxDGL2BkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYbk7/O/5pB+PXS0mHGAU4GJV4
 eC/YWcQJsSaWFVfmHmKU4GBWEuE9r28ZJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB
 9MSS1OzU1ILUIpgsEwenVAOjSHVE+nrr01VVM0U17U/cKpnk8+2waFvPm6IX9xuU9qdec8m/
 bObfcD3pzgWdz89PGqUEmD2eK/JZLiOdW8FOgIfxkBaX7M+8002BWZY3nvfO0r3ffkisTmtH
 54WmmMQ3jcVF+9dLZ5mw7VjBMPXHEmbpmYtnMbD+S4up8570rDo6f/F3Dz8lluKMREMt5qLi
 RAC92NYeMwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7q37SzjDO6v1LXY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Ge3v
 trEVXOWoOPeik6WBsZ29i5GTQ0LAROLovD2MXYxcHEICSxkltje+ZoJIyEh8uvIRqkhY4s+1
 LjaIoo+MEn//djFBOKcZJXZtf8cO4exklDjxbBsLSAubgKbE9j//wWwRAWmJ9quTWEFsZoHf
 jBJ/+gJBbGEBb4nj1/eCxVkEVCSeP7wIZvMKWEvsbzjEDLFaXmJ242k2EJsTJL7qBNBmDqBl
 VhKtR7khygUlTs58wgIxXlOidftvdghbXqJ562zmCYzCs5CUzUJSNgtJ2QJG5lWMIqmlxbnp
 ucVGesWJucWleel6yfm5mxiBUbft2M8tOxi73gUfYhTgYFTi4dVwtIgTYk0sK67MPcQowcGs
 JMJ7Xt8yTog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgQkhryTe0NTQ3MLS0NzY3NjMQkmc
 t0PgYIyQQHpiSWp2ampBahFMHxMHp1QD48n1na9qPzI8ebCZ8fKCuPn3287/UmGPPehYXi/K
 85RH+vDBFzN1jA7ePnelNubf7ox5jAp9uftL1zLs0DnGdstvy8473hfylujszbwc1W2S9a7V
 V4iTaeLxkusLmBesCL07+1JTyqMbGv/qDh1bIWTYfXe34cGUkP+id+QLvqtJhHAEzkjc4KXE
 UpyRaKjFXFScCACvDZgT0AIAAA==
X-CMS-MailID: 20200204095227eucas1p2d86cd6abcb66327dc112d58c83664139
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204095227eucas1p2d86cd6abcb66327dc112d58c83664139
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095227eucas1p2d86cd6abcb66327dc112d58c83664139
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095227eucas1p2d86cd6abcb66327dc112d58c83664139@eucas1p2.samsung.com>
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
index 2acd8321af2f..b5013b834b20 100644
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
2.25.0


