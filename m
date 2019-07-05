Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F6C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1936920856
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1936920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjObs-000310-5l
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hjOUF-0007eV-Hi
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hjOUD-0007kb-Di
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hjOUD-0007hB-7v
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90254300DA2B;
 Fri,  5 Jul 2019 13:42:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com
 [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE47317F22;
 Fri,  5 Jul 2019 13:42:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A5AF017473; Fri,  5 Jul 2019 15:42:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 15:42:37 +0200
Message-Id: <20190705134239.11718-3-kraxel@redhat.com>
In-Reply-To: <20190705134239.11718-1-kraxel@redhat.com>
References: <20190705134239.11718-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 05 Jul 2019 13:42:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/4] ati-vga: Fix frame buffer endianness for
 big endian target
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

The extended mode frame buffer should be little endian even when
emulating big endian machine (such as PPC). This fixes color problems
with MorphOS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 439aa85061f103446df7b42632d730971a372432.1562151410.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c    |  1 +
 hw/display/ati_2d.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index c1d9d1518f4a..590362ea568c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -89,6 +89,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+            s->vga.big_endian_fb = false;
             /* reset VBE regs then set up mode */
             s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] = h;
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] = v;
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index c31142af6e19..b09753320a9e 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -124,15 +124,15 @@ void ati_2d_blt(ATIVGAState *s)
 
         switch (s->regs.dp_mix & GMC_ROP3_MASK) {
         case ROP3_PATCOPY:
-            filler = bswap32(s->regs.dp_brush_frgd_clr);
+            filler = s->regs.dp_brush_frgd_clr;
             break;
         case ROP3_BLACKNESS:
-            filler = rgb_to_pixel32(s->vga.palette[0], s->vga.palette[1],
-                                    s->vga.palette[2]) << 8 | 0xff;
+            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[0],
+                     s->vga.palette[1], s->vga.palette[2]);
             break;
         case ROP3_WHITENESS:
-            filler = rgb_to_pixel32(s->vga.palette[3], s->vga.palette[4],
-                                    s->vga.palette[5]) << 8 | 0xff;
+            filler = 0xffUL << 24 | rgb_to_pixel32(s->vga.palette[3],
+                     s->vga.palette[4], s->vga.palette[5]);
             break;
         }
 
-- 
2.18.1


