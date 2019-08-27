Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DDEC3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9655206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9655206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2WSM-0004am-Vf
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i2WQz-0003XT-1k
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i2WQx-0007dI-P8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:02:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2188 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i2WQx-0007YV-EA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:02:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 673D5E0A6AA544E42E0F;
 Tue, 27 Aug 2019 16:02:19 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 16:02:11 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <kraxel@redhat.com>
Date: Tue, 27 Aug 2019 16:02:09 +0800
Message-ID: <20190827080209.2365-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH] xhci: Fix memory leak in xhci_address_slot
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
Cc: lcf.lichaofeng@huawei.com, Ying Fang <fangying1@huawei.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, zhouyibo3@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f578264948..471759cd4c 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2161,6 +2161,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci, =
unsigned int slotid,
                                   DeviceOutRequest | USB_REQ_SET_ADDRESS=
,
                                   slotid, 0, 0, NULL);
         assert(p.status !=3D USB_RET_ASYNC);
+        usb_packet_cleanup(&p);
     }
=20
     res =3D xhci_enable_ep(xhci, slotid, 1, octx+32, ep0_ctx);
--=20
2.19.1



