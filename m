Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D9C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FE82081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw9zIBc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FE82081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzSa-0006aA-EU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iqzRQ-0005J6-1z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iqzRO-0006xw-Sp
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iqzRO-0006xZ-Ok
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFdQWj2EHe8YiiQZN2dqFwfUGmPnoSjTPeOFeXJ+oOs=;
 b=cw9zIBc1yqprU8FraZJwLrya0za5WX0It+ItpwuRV6FaJVJtrW/SOP3iCjnGw1oDNd24Xf
 Tb7MOVDZkZevX6woRw/NorSHLa8ycQNqII8hSb6U4yktU7GdGbpnpUogAVsw4fcbGyujHd
 WT0d17IuG9U2IyisTTdj40PtLuPf28I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-pxGxxomsOy--dahCN5KpFw-1; Mon, 13 Jan 2020 08:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008FD106F8C1;
 Mon, 13 Jan 2020 13:06:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 144FF5DA76;
 Mon, 13 Jan 2020 13:06:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5DDAF31F68; Mon, 13 Jan 2020 14:06:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] xhci: Fix memory leak in xhci_kick_epctx when poweroff
 GuestOS
Date: Mon, 13 Jan 2020 14:06:45 +0100
Message-Id: <20200113130646.30099-5-kraxel@redhat.com>
In-Reply-To: <20200113130646.30099-1-kraxel@redhat.com>
References: <20200113130646.30099-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pxGxxomsOy--dahCN5KpFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

start vm with libvirt, when GuestOS running, enter poweroff command using
the xhci keyboard, then ASAN shows memory leak stack=EF=BC=9A

Direct leak of 80 byte(s) in 5 object(s) allocated from:
    #0 0xfffd1e6431cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31cb)
    #1 0xfffd1e107163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xaaad39051367 in qemu_sglist_init /qemu/dma-helpers.c:43
    #3 0xaaad3947c407 in pci_dma_sglist_init /qemu/include/hw/pci/pci.h:842
    #4 0xaaad3947c407 in xhci_xfer_create_sgl /qemu/hw/usb/hcd-xhci.c:1446
    #5 0xaaad3947c407 in xhci_setup_packet /qemu/hw/usb/hcd-xhci.c:1618
    #6 0xaaad3948625f in xhci_submit /qemu/hw/usb/hcd-xhci.c:1827
    #7 0xaaad3948625f in xhci_fire_transfer /qemu/hw/usb/hcd-xhci.c:1839
    #8 0xaaad3948625f in xhci_kick_epctx /qemu/hw/usb/hcd-xhci.c:1991
    #9 0xaaad3948f537 in xhci_doorbell_write /qemu/hw/usb/hcd-xhci.c:3158
    #10 0xaaad38bcbfc7 in memory_region_write_accessor /qemu/memory.c:483
    #11 0xaaad38bc654f in access_with_adjusted_size /qemu/memory.c:544
    #12 0xaaad38bd1877 in memory_region_dispatch_write /qemu/memory.c:1482
    #13 0xaaad38b1c77f in flatview_write_continue /qemu/exec.c:3167
    #14 0xaaad38b1ca83 in flatview_write /qemu/exec.c:3207
    #15 0xaaad38b268db in address_space_write /qemu/exec.c:3297
    #16 0xaaad38bf909b in kvm_cpu_exec /qemu/accel/kvm/kvm-all.c:2383
    #17 0xaaad38bb063f in qemu_kvm_cpu_thread_fn /qemu/cpus.c:1246
    #18 0xaaad39821c93 in qemu_thread_start /qemu/util/qemu-thread-posix.c:=
519
    #19 0xfffd1c8378bb  (/lib64/libpthread.so.0+0x78bb)
    #20 0xfffd1c77616b  (/lib64/libc.so.6+0xd616b)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Message-id: 20200110105855.81144-1-kuhn.chenqun@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 80988bb305a1..0d3d96d05a00 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2000,6 +2000,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, uns=
igned int streamid)
         if (xfer !=3D NULL && xfer->running_retry) {
             DPRINTF("xhci: xfer nacked, stopping schedule\n");
             epctx->retry =3D xfer;
+            xhci_xfer_unmap(xfer);
             break;
         }
         if (count++ > TRANSFER_LIMIT) {
--=20
2.18.1


