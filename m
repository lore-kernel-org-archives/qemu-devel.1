Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC0C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488742084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488742084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDocL-0005FV-69
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 07:08:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hDoba-0004wy-1M
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hDobZ-00078w-4s
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:07:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hDobY-00071L-Q0
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:07:53 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
	by localhost (Postfix) with SMTP id 7DF99746622;
	Tue,  9 Apr 2019 13:07:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 5C5FF7465DB; Tue,  9 Apr 2019 13:07:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 09 Apr 2019 12:56:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: qemu-devel@nongnu.org
Message-Id: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH] ati-vga: Fix check for blt outside vram
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Andrew Randrianasulu <randrianasulu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409105618.UGAXIa-ySvjGbTwgJ8WArn4Who910Q2EduiI64I58Hg@z>

Fix the check preventing calling pixman functions that would access
memory outside allocated vram. The r128 X driver sometimes seem to try
blits that span outside vram, this check prevents crashing QEMU in
that case. (The r128 X driver may have problems even on real hardware
so I'm not sure if it's a client bug or emulation problem but at least
QEMU should survive.)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
---
 hw/display/ati_2d.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index bc98ba6eeb..fe3ae14864 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
                 s->regs.dst_width, s->regs.dst_height);
         end =3D s->vga.vram_ptr + s->vga.vram_size;
         if (src_bits >=3D end || dst_bits >=3D end ||
-            src_bits + (s->regs.src_y + s->regs.dst_height) * src_stride=
 +
-            s->regs.src_x >=3D end ||
-            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride=
 +
-            s->regs.dst_x >=3D end) {
+            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_heig=
ht) *
+            src_stride * sizeof(uint32_t) >=3D end ||
+            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_heig=
ht) *
+            dst_stride * sizeof(uint32_t) >=3D end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
             return;
         }
@@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
                 filler);
         end =3D s->vga.vram_ptr + s->vga.vram_size;
         if (dst_bits >=3D end ||
-            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride=
 +
-            s->regs.dst_x >=3D end) {
+            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_heig=
ht) *
+            dst_stride * sizeof(uint32_t) >=3D end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n=
");
             return;
         }
--=20
2.13.7


