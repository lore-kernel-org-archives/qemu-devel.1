Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AAAC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 07:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7A62339E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 07:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7A62339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3EdW-0005o3-3A
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 03:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i3EZh-0001NX-53
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i3EZd-00052M-6f
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i3EZb-0004yR-66
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 03:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 326D718B3D83;
 Thu, 29 Aug 2019 07:10:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1561A5C207;
 Thu, 29 Aug 2019 07:10:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4794131E7F; Thu, 29 Aug 2019 09:10:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 09:10:14 +0200
Message-Id: <20190829071016.16589-2-kraxel@redhat.com>
In-Reply-To: <20190829071016.16589-1-kraxel@redhat.com>
References: <20190829071016.16589-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 29 Aug 2019 07:10:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] xhci: Fix memory leak in xhci_address_slot
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
Cc: Ying Fang <fangying1@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ying Fang <fangying1@huawei.com>

Address Sanitizer shows memory leak in xhci_address_slot
hw/usb/hcd-xhci.c:2156 and the stack is as bellow:

Direct leak of 64 byte(s) in 4 object(s) allocated from:
    #0 0xffff91c6f5ab in realloc (/lib64/libasan.so.4+0xd35ab)
    #1 0xffff91987243 in g_realloc (/lib64/libglib-2.0.so.0+0x57243)
    #2 0xaaaab0b26a1f in qemu_iovec_add util/iov.c:296
    #3 0xaaaab07e5ce3 in xhci_address_slot hw/usb/hcd-xhci.c:2156
    #4 0xaaaab07e5ce3 in xhci_process_commands hw/usb/hcd-xhci.c:2493
    #5 0xaaaab00058d7 in memory_region_write_accessor qemu/memory.c:507
    #6 0xaaaab0000d87 in access_with_adjusted_size memory.c:573
    #7 0xaaaab000abcf in memory_region_dispatch_write memory.c:1516
    #8 0xaaaaaff59947 in flatview_write_continue exec.c:3367
    #9 0xaaaaaff59c33 in flatview_write exec.c:3406
    #10 0xaaaaaff63b3b in address_space_write exec.c:3496
    #11 0xaaaab002f263 in kvm_cpu_exec accel/kvm/kvm-all.c:2288
    #12 0xaaaaaffee427 in qemu_kvm_cpu_thread_fn cpus.c:1290
    #13 0xaaaab0b1a943 in qemu_thread_start util/qemu-thread-posix.c:502
    #14 0xffff908ce8bb in start_thread (/lib64/libpthread.so.0+0x78bb)
    #15 0xffff908165cb in thread_start (/lib64/libc.so.6+0xd55cb)

Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-id: 20190827080209.2365-1-fangying1@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f5782649482b..471759cd4cc0 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2161,6 +2161,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, unsigned int slotid,
                                   DeviceOutRequest | USB_REQ_SET_ADDRESS,
                                   slotid, 0, 0, NULL);
         assert(p.status != USB_RET_ASYNC);
+        usb_packet_cleanup(&p);
     }
 
     res = xhci_enable_ep(xhci, slotid, 1, octx+32, ep0_ctx);
-- 
2.18.1


