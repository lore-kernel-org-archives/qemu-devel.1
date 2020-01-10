Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6D6C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C612082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C612082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ips1E-0000cv-7B
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1ips0e-0000Bj-1I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1ips0c-00041f-Lc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:59:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56936 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1ips0c-0003YR-9s; Fri, 10 Jan 2020 05:59:18 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6905F66E5737D2D7369D;
 Fri, 10 Jan 2020 18:59:08 +0800 (CST)
Received: from HGHY4C002233111.china.huawei.com (10.133.205.93) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 18:59:00 +0800
From: <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <kraxel@redhat.com>
Subject: [PATCH] xhci: Fix memory leak in xhci_kick_epctx when poweroff GuestOS
Date: Fri, 10 Jan 2020 18:58:55 +0800
Message-ID: <20200110105855.81144-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: qemu-trivial@nongnu.org, Chen Qun <kuhn.chenqun@huawei.com>,
 pannengyuan@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

start vm with libvirt, when GuestOS running, enter poweroff command using
the xhci keyboard, then ASAN shows memory leak stack=EF=BC=9A

Direct leak of 80 byte(s) in 5 object(s) allocated from:
    #0 0xfffd1e6431cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31c=
b)
    #1 0xfffd1e107163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xaaad39051367 in qemu_sglist_init /qemu/dma-helpers.c:43
    #3 0xaaad3947c407 in pci_dma_sglist_init /qemu/include/hw/pci/pci.h:8=
42
    #4 0xaaad3947c407 in xhci_xfer_create_sgl /qemu/hw/usb/hcd-xhci.c:144=
6
    #5 0xaaad3947c407 in xhci_setup_packet /qemu/hw/usb/hcd-xhci.c:1618
    #6 0xaaad3948625f in xhci_submit /qemu/hw/usb/hcd-xhci.c:1827
    #7 0xaaad3948625f in xhci_fire_transfer /qemu/hw/usb/hcd-xhci.c:1839
    #8 0xaaad3948625f in xhci_kick_epctx /qemu/hw/usb/hcd-xhci.c:1991
    #9 0xaaad3948f537 in xhci_doorbell_write /qemu/hw/usb/hcd-xhci.c:3158
    #10 0xaaad38bcbfc7 in memory_region_write_accessor /qemu/memory.c:483
    #11 0xaaad38bc654f in access_with_adjusted_size /qemu/memory.c:544
    #12 0xaaad38bd1877 in memory_region_dispatch_write /qemu/memory.c:148=
2
    #13 0xaaad38b1c77f in flatview_write_continue /qemu/exec.c:3167
    #14 0xaaad38b1ca83 in flatview_write /qemu/exec.c:3207
    #15 0xaaad38b268db in address_space_write /qemu/exec.c:3297
    #16 0xaaad38bf909b in kvm_cpu_exec /qemu/accel/kvm/kvm-all.c:2383
    #17 0xaaad38bb063f in qemu_kvm_cpu_thread_fn /qemu/cpus.c:1246
    #18 0xaaad39821c93 in qemu_thread_start /qemu/util/qemu-thread-posix.=
c:519
    #19 0xfffd1c8378bb  (/lib64/libpthread.so.0+0x78bb)
    #20 0xfffd1c77616b  (/lib64/libc.so.6+0xd616b)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 80988bb305..0d3d96d05a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2000,6 +2000,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, u=
nsigned int streamid)
         if (xfer !=3D NULL && xfer->running_retry) {
             DPRINTF("xhci: xfer nacked, stopping schedule\n");
             epctx->retry =3D xfer;
+            xhci_xfer_unmap(xfer);
             break;
         }
         if (count++ > TRANSFER_LIMIT) {
--=20
2.23.0



