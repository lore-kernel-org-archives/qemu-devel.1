Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0DFC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04AB320856
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AB320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOaB-0001Lt-S7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hjOUB-0007b0-RB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hjOUA-0007bN-Ki
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hjOUA-0007Rs-F0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:42:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 279318830B;
 Fri,  5 Jul 2019 13:42:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com
 [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE497860E3;
 Fri,  5 Jul 2019 13:42:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B561117534; Fri,  5 Jul 2019 15:42:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 15:42:39 +0200
Message-Id: <20190705134239.11718-5-kraxel@redhat.com>
In-Reply-To: <20190705134239.11718-1-kraxel@redhat.com>
References: <20190705134239.11718-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 05 Jul 2019 13:42:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/4] ati-vga: Fix setting offset together with
 pitch for r128pro
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

Turns out my last fix to this broke one case for Rage 128 Pro so
revert that part of previous patch. This now fixes the remaining
rendering problems for MorphOS which now can produce picture with
-device ati-vga (although it may not be optimised yet and video
overlay emulation is still known to be missing).

Fixes: 866ad5f5ff620078f88183aa254f7b02727e6aa3
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: da33261a841755691f698db8190c868df0c0d3ae.1562276605.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 590362ea568c..a747c4cc98c7 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -689,7 +689,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case SRC_PITCH_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.src_offset = (data & 0x1fffff) << 4;
+            s->regs.src_offset = (data & 0x1fffff) << 5;
             s->regs.src_pitch = (data & 0x7fe00000) >> 21;
             s->regs.src_tile = data >> 31;
         } else {
@@ -700,7 +700,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         break;
     case DST_PITCH_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
-            s->regs.dst_offset = (data & 0x1fffff) << 4;
+            s->regs.dst_offset = (data & 0x1fffff) << 5;
             s->regs.dst_pitch = (data & 0x7fe00000) >> 21;
             s->regs.dst_tile = data >> 31;
         } else {
-- 
2.18.1


