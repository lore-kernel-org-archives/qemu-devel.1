Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99990C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EED22070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EED22070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2rQX-0002nh-Lj
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 02:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i2rPA-0001xX-LZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i2rP9-0005op-CH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:26:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2190 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i2rP9-0005mU-2E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:26:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 62C6BDA8E3D67DB3B66D;
 Wed, 28 Aug 2019 14:25:58 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 28 Aug 2019
 14:25:47 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <kraxel@redhat.com>
Date: Wed, 28 Aug 2019 14:25:35 +0800
Message-ID: <20190828062535.1573-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH] xhci: Fix memory leak in xhci_kick_epctx
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
Cc: fangying <fangying1@huawei.com>, zhouyibo3@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fangying <fangying1@huawei.com>

Address Sanitizer shows memory leak in xhci_kick_epctx hw/usb/hcd-xhci.c:=
1912.
A sglist is leaked when a packet is retired and returns USB_RET_NAK statu=
s.
The leak stack is as bellow:

Direct leak of 2688 byte(s) in 168 object(s) allocated from:
    #0 0xffffae8b11db in __interceptor_malloc (/lib64/libasan.so.4+0xd31d=
b)
    #1 0xffffae5c9163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xaaaabb6fb3f7 in qemu_sglist_init dma-helpers.c:43
    #3 0xaaaabba705a7 in pci_dma_sglist_init include/hw/pci/pci.h:837
    #4 0xaaaabba705a7 in xhci_xfer_create_sgl hw/usb/hcd-xhci.c:1443
    #5 0xaaaabba705a7 in xhci_setup_packet hw/usb/hcd-xhci.c:1615
    #6 0xaaaabba77a6f in xhci_kick_epctx hw/usb/hcd-xhci.c:1912
    #7 0xaaaabbdaad27 in timerlist_run_timers util/qemu-timer.c:592
    #8 0xaaaabbdab19f in qemu_clock_run_timers util/qemu-timer.c:606
    #9 0xaaaabbdab19f in qemu_clock_run_all_timers util/qemu-timer.c:692
    #10 0xaaaabbdab9a3 in main_loop_wait util/main-loop.c:524
    #11 0xaaaabb6ff5e7 in main_loop vl.c:1806
    #12 0xaaaabb1e1453 in main vl.c:4488

Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f578264..2d85d8f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1914,6 +1914,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, u=
nsigned int streamid)
             }
             usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
             if (xfer->packet.status =3D=3D USB_RET_NAK) {
+                xhci_xfer_unmap(xfer);
                 return;
             }
             xhci_try_complete_packet(xfer);
--=20
1.8.3.1



