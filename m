Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 07:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107252339E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 07:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107252339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3EbY-00036I-LI
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 03:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i3EZf-0001Ml-Kz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i3EZd-00052F-5t
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i3EZb-0004y4-5q
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9AB75AFDE;
 Thu, 29 Aug 2019 07:10:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1FD196B2;
 Thu, 29 Aug 2019 07:10:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5646031E84; Thu, 29 Aug 2019 09:10:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 09:10:15 +0200
Message-Id: <20190829071016.16589-3-kraxel@redhat.com>
In-Reply-To: <20190829071016.16589-1-kraxel@redhat.com>
References: <20190829071016.16589-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 29 Aug 2019 07:10:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] xhci: Fix memory leak in xhci_kick_epctx
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
Cc: fangying <fangying1@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fangying <fangying1@huawei.com>

Address Sanitizer shows memory leak in xhci_kick_epctx hw/usb/hcd-xhci.c:1912.
A sglist is leaked when a packet is retired and returns USB_RET_NAK status.
The leak stack is as bellow:

Direct leak of 2688 byte(s) in 168 object(s) allocated from:
    #0 0xffffae8b11db in __interceptor_malloc (/lib64/libasan.so.4+0xd31db)
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
Message-id: 20190828062535.1573-1-fangying1@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 471759cd4cc0..80988bb305a1 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1914,6 +1914,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             }
             usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
             if (xfer->packet.status == USB_RET_NAK) {
+                xhci_xfer_unmap(xfer);
                 return;
             }
             xhci_try_complete_packet(xfer);
-- 
2.18.1


