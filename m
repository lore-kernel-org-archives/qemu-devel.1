Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769CBC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949920575
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETvgClfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUNl-0006fz-PE
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUUM5-000580-Rp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUUM2-0006ie-S3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603110814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuGaCQc6pSRlv2Q45hlM3NaD44LgqCPB61qxIz5IikI=;
 b=ETvgClfGmLVjLwJtrzWjRfJG/xZt9Gm04efOYNY0U5dhBe6S4L47JA+wVwh5e+AW+iPez/
 Ae04oN/UNQnjEyEpyMe+nhm9VoZvgwSOMQkwUz+xsqFEJAS+rqdN//ZGOB4k7YgmdZAwxB
 nqE+R/JtSz+DYlV5c1E42y/JccfEjC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-nHZYJkPLN2-VIstypJOTUQ-1; Mon, 19 Oct 2020 08:33:32 -0400
X-MC-Unique: nHZYJkPLN2-VIstypJOTUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CC2564086;
 Mon, 19 Oct 2020 12:33:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76CB1A4D7;
 Mon, 19 Oct 2020 12:33:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E23F71753B; Mon, 19 Oct 2020 14:33:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] usb/hcd-ehci: Fix error handling on missing device for iTD
Date: Mon, 19 Oct 2020 14:33:25 +0200
Message-Id: <20201019123326.9973-3-kraxel@redhat.com>
In-Reply-To: <20201019123326.9973-1-kraxel@redhat.com>
References: <20201019123326.9973-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthony PERARD <anthony.perard@citrix.com>

The EHCI Host Controller emulation attempt to locate the device
associated with a periodic isochronous transfer description (iTD) and
when this fail the host controller is reset.

But according the EHCI spec 1.0 section 5.15.2.4 Host System
Error, the host controller is supposed to reset itself only when it
failed to communicate with the Host (Operating System), like when
there's an error on the PCI bus. If a transaction fails, there's
nothing in the spec that say to reset the host controller.

This patch rework the error path so that the host controller can keep
working when the OS setup a bogus transaction, it also revert to the
behavior of the EHCI emulation to before commits:
e94682f1fe ("ehci: check device is not NULL before calling usb_ep_get()")
7011baece2 ("usb: remove unnecessary NULL device check from usb_ep_get()")

The issue has been found while trying to passthrough a USB device to a
Windows Server 2012 Xen guest via "usb-ehci", which prevent the USB
device from working in Windows. ("usb-ehci" alone works, windows only
setup this weird periodic iTD to device 127 endpoint 15 when the USB
device is passthrough.)

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Message-id: 20201014104106.2962640-1-anthony.perard@citrix.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 2b995443fbfd..ae7f20c502ac 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1447,24 +1447,25 @@ static int ehci_process_itd(EHCIState *ehci,
             dev = ehci_find_device(ehci, devaddr);
             if (dev == NULL) {
                 ehci_trace_guest_bug(ehci, "no device found");
-                qemu_sglist_destroy(&ehci->isgl);
-                return -1;
-            }
-            pid = dir ? USB_TOKEN_IN : USB_TOKEN_OUT;
-            ep = usb_ep_get(dev, pid, endp);
-            if (ep && ep->type == USB_ENDPOINT_XFER_ISOC) {
-                usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false,
-                                 (itd->transact[i] & ITD_XACT_IOC) != 0);
-                if (usb_packet_map(&ehci->ipacket, &ehci->isgl)) {
-                    qemu_sglist_destroy(&ehci->isgl);
-                    return -1;
-                }
-                usb_handle_packet(dev, &ehci->ipacket);
-                usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
-            } else {
-                DPRINTF("ISOCH: attempt to addess non-iso endpoint\n");
-                ehci->ipacket.status = USB_RET_NAK;
+                ehci->ipacket.status = USB_RET_NODEV;
                 ehci->ipacket.actual_length = 0;
+            } else {
+                pid = dir ? USB_TOKEN_IN : USB_TOKEN_OUT;
+                ep = usb_ep_get(dev, pid, endp);
+                if (ep && ep->type == USB_ENDPOINT_XFER_ISOC) {
+                    usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false,
+                                     (itd->transact[i] & ITD_XACT_IOC) != 0);
+                    if (usb_packet_map(&ehci->ipacket, &ehci->isgl)) {
+                        qemu_sglist_destroy(&ehci->isgl);
+                        return -1;
+                    }
+                    usb_handle_packet(dev, &ehci->ipacket);
+                    usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
+                } else {
+                    DPRINTF("ISOCH: attempt to addess non-iso endpoint\n");
+                    ehci->ipacket.status = USB_RET_NAK;
+                    ehci->ipacket.actual_length = 0;
+                }
             }
             qemu_sglist_destroy(&ehci->isgl);
 
-- 
2.27.0


