Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A1C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 06:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BA12085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 06:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BA12085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx4CJ-00078b-SV
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 02:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hx4Bx-0006jx-1E
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hx4Bw-0007bB-63
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hx4Bw-0007av-1B
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF4DB300501F;
 Mon, 12 Aug 2019 06:52:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F1435D9CA;
 Mon, 12 Aug 2019 06:52:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 23B3317444; Mon, 12 Aug 2019 08:52:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <ppandit@redhat.com>
Date: Mon, 12 Aug 2019 08:52:21 +0200
Message-Id: <20190812065221.20907-2-kraxel@redhat.com>
In-Reply-To: <20190812065221.20907-1-kraxel@redhat.com>
References: <20190812065221.20907-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 12 Aug 2019 06:52:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/1] display/bochs: fix pcie support
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set QEMU_PCI_CAP_EXPRESS unconditionally in init(), then clear it in
realize() in case the device is not connected to a PCIe bus.

This makes sure the pci config space allocation is big enough, so
accessing the PCIe extended config space doesn't overflow the pci
config space buffer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 582133dd719c..8e83b5164b67 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -297,9 +297,10 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
     }
 
     if (pci_bus_is_express(pci_get_bus(dev))) {
-        dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
         ret = pcie_endpoint_cap_init(dev, 0x80);
         assert(ret > 0);
+    } else {
+        dev->cap_present &= ~QEMU_PCI_CAP_EXPRESS;
     }
 
     memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
@@ -322,11 +323,15 @@ static void bochs_display_set_big_endian_fb(Object *obj, bool value,
 
 static void bochs_display_init(Object *obj)
 {
+    PCIDevice *dev = PCI_DEVICE(obj);
+
     /* Expose framebuffer byteorder via QOM */
     object_property_add_bool(obj, "big-endian-framebuffer",
                              bochs_display_get_big_endian_fb,
                              bochs_display_set_big_endian_fb,
                              NULL);
+
+    dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void bochs_display_exit(PCIDevice *dev)
-- 
2.18.1


