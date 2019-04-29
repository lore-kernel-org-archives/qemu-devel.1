Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F468C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 07:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ABA2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 07:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ABA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL0xA-0000D6-V2
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 03:43:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hL0vg-0007an-W4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hL0tJ-00043y-1G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:39:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55056 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1hL0tI-00040t-N4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 03:39:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 599E0DF21DF701332744;
	Mon, 29 Apr 2019 15:39:49 +0800 (CST)
Received: from localhost (10.177.246.209) by DGGEMS414-HUB.china.huawei.com
	(10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Apr 2019
	15:39:40 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <kraxel@redhat.com>
Date: Mon, 29 Apr 2019 15:39:29 +0800
Message-ID: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
X-Mailer: git-send-email 1.8.4.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Longpeng <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429073929._8kRizR31mCreM10QCQGECIKir3Z2ot6exAObRvl5HE@z>

From: Longpeng <longpeng2@huawei.com>

we found the following core in our environment:
0  0x00007fc6b06c2237 in raise ()
1  0x00007fc6b06c3928 in abort ()
2  0x00007fc6b06bb056 in __assert_fail_base ()
3  0x00007fc6b06bb102 in __assert_fail ()
4  0x0000000000702e36 in xhci_kick_ep (...)
6  0x000000000047767f in access_with_adjusted_size (...)
7  0x000000000047944d in memory_region_dispatch_write (...)
8  0x000000000042df17 in address_space_write_continue (...)
10 0x000000000043084d in address_space_rw (...)
11 0x000000000047451b in kvm_cpu_exec (cpu=cpu@entry=0x1ab11b0)
12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
15 0x00007fc6b0a60dd5 in start_thread ()
16 0x00007fc6b078a59d in clone ()
(gdb) bt
(gdb) f 5
(gdb) p /x tmp
$9 = 0x62481a00 <-- last byte 0x00 is @epid

xhci_doorbell_write() already check the upper bound of @slotid an @epid,
it also need to check the lower bound.

Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 hw/usb/hcd-xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ec28bee..b4e6bfc 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3135,9 +3135,9 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
     } else {
         epid = val & 0xff;
         streamid = (val >> 16) & 0xffff;
-        if (reg > xhci->numslots) {
+        if (reg == 0 || reg > xhci->numslots) {
             DPRINTF("xhci: bad doorbell %d\n", (int)reg);
-        } else if (epid > 31) {
+        } else if (epid == 0 || epid > 31) {
             DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
                     (int)reg, (uint32_t)val);
         } else {
-- 
1.8.3.1



