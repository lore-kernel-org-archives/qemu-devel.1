Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69854C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB0920989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB0920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvN4-0003Dq-Cj
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:22:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKP-0000h2-Jd
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKO-0008Cu-KI
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvKM-0008A7-DX; Tue, 07 May 2019 04:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A18843082134;
	Tue,  7 May 2019 08:19:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDD39614D6;
	Tue,  7 May 2019 08:19:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id B1C8AA1E9; Tue,  7 May 2019 10:19:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:19:45 +0200
Message-Id: <20190507081946.19264-8-kraxel@redhat.com>
In-Reply-To: <20190507081946.19264-1-kraxel@redhat.com>
References: <20190507081946.19264-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 07 May 2019 08:19:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/8] ati-vga: Fix check for blt outside vram
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Fix the check preventing calling pixman functions that would access
memory outside allocated vram. The r128 X driver sometimes seem to try
blits that span outside vram, this check prevents crashing QEMU in
that case. (The r128 X driver may have problems even on real hardware
so I'm not sure if it's a client bug or emulation problem but at least
QEMU should survive.)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
Message-Id: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_2d.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index bc98ba6eebf6..fe3ae148647b 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
                 s->regs.dst_width, s->regs.dst_height);
         end = s->vga.vram_ptr + s->vga.vram_size;
         if (src_bits >= end || dst_bits >= end ||
-            src_bits + (s->regs.src_y + s->regs.dst_height) * src_stride +
-            s->regs.src_x >= end ||
-            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride +
-            s->regs.dst_x >= end) {
+            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_height) *
+            src_stride * sizeof(uint32_t) >= end ||
+            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
+            dst_stride * sizeof(uint32_t) >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
@@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
                 filler);
         end = s->vga.vram_ptr + s->vga.vram_size;
         if (dst_bits >= end ||
-            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride +
-            s->regs.dst_x >= end) {
+            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
+            dst_stride * sizeof(uint32_t) >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
-- 
2.18.1


