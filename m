Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD9C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFD720870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFD720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0i88-0000LN-J0
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5l-0007LF-Dg
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5j-0005nt-Mr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5j-0005nP-GP
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0850111A441;
 Thu, 22 Aug 2019 08:05:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED3895DE5C;
 Thu, 22 Aug 2019 08:05:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 235CB97A1; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:04:57 +0200
Message-Id: <20190822080503.12063-4-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 08:05:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/8] ati-vga: Fix GPIO_MONID register write
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Also update bitbang_i2c state when output bits are changed while
enable bits are set. This fixes EDID access by the ATI FCode ROM.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 292e70a92b7fbfd9a4120d433dbdcfda4e5f6c3c.1565558093.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6cdcbef238fe..eb54f6842fed 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -564,12 +564,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                                addr - GPIO_MONID, data, size);
             /*
              * Rage128p accesses DDC used to get EDID via these bits.
-             * Only touch i2c when write overlaps 3rd byte because some
-             * drivers access this reg via multiple partial writes and
-             * without this spurious bits would be sent.
+             * Because some drivers access this via multiple byte writes
+             * we have to be careful when we send bits to avoid spurious
+             * changes in bitbang_i2c state. So only do it when mask is set
+             * and either the enable bits are changed or output bits changed
+             * while enabled.
              */
             if ((s->regs.gpio_monid & BIT(25)) &&
-                addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) {
+                ((addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) ||
+                 (addr == GPIO_MONID && (s->regs.gpio_monid & 0x60000)))) {
                 s->regs.gpio_monid = ati_i2c(&s->bbi2c, s->regs.gpio_monid, 1);
             }
         }
-- 
2.18.1


