Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B8C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C6920BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="XbNNtVHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C6920BED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSeF3-0001p9-NG
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kSeEF-0001Hk-HG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:41:55 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:59649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kSeEC-0008MY-Jc
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1602672113;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fkxD1ZqjuVqv3DtQ4W/KFKJJ1TJcKRYXqihoRvKxlJE=;
 b=XbNNtVHZLt35bGT/dpHuG1icyhNob9Eb4SKCPAW4tnRd4tFaezh8jCR1
 UQWZBodgBagDt1GnD5QKClOuVBIUoadTyakdLC9mpcf6OxhHlgJkL65Q3
 zN6nVKbLcSztx4xM1KlEuNq/0cJ0JnuMA30dEHsi3WRONa4veFEXjbYDC k=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: yrsWEUKXa6l0ySk+oIEdDvaMId8YGREKhR02jnIFUGJ10z3cqgV3Cy/uRPy3NQtDw6iWcJnJL7
 w28EUkkNZRGX7pwcr5VlBZE9NT0vkXST7jkGqhBiI1NxRTDAy4QuAmHO/OWDArYU0ZY3hoiNjM
 8rGzZI+64rDjRi720iWyBWf+3QvsbJ2309BqkiW/INgMv2KS7mPbU+EHTzRMqi8X/v48KkaqlI
 RtD4pdHpNA/DqxSy/1TtbnHWYg+en0tGl8pRUvDr39qO5pUVLjTfgYgqNmO1ggACAsSWPaBVCd
 UkY=
X-SBRS: 2.5
X-MesageID: 28947370
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,374,1596513600"; d="scan'208";a="28947370"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>, Liam Merwick
 <liam.merwick@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] usb/hcd-ehci: Fix error handling on missing device for iTD
Date: Wed, 14 Oct 2020 11:41:06 +0100
Message-ID: <20201014104106.2962640-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 06:41:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

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
---

CCing the author of e94682f1fe which changed the behavior of EHCI
emulation.
Cc: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/hcd-ehci.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 0b5534ac3a32..b46df501ff63 100644
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
Anthony PERARD


