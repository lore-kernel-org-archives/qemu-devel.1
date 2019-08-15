Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE6C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55140206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55140206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47687 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyOIt-0004NP-9K
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 18:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH9-00034b-Ij
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH7-0006LQ-Uw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hyOH7-0006KS-Ou
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9A6F874B821;
 Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 117D974AAAC; Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Message-Id: <489ce252f9d5f902f7d240ff9895e77bb335f1a9.1565907489.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1565907489.git.balaton@eik.bme.hu>
References: <cover.1565907489.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 16 Aug 2019 00:18:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 3/3] ati-vga: Silence some noisy traces
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

Some registers are accessed very frequently so exclude these from
traces to avoid flooding output with a lot of trace logs when traces
are enabled thus helping debugging.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 5e2c4ba4aa..36d2a75f71 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -489,7 +489,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr add=
r, unsigned int size)
     default:
         break;
     }
-    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
+    if ((addr < CUR_OFFSET || addr > CUR_CLR1 + 3 || (ATI_DEBUG_HW_CURSO=
R &&
+        (addr >=3D CUR_OFFSET && addr <=3D CUR_CLR1 + 3))) &&
+        (addr < GEN_INT_CNTL || addr > GEN_INT_STATUS + 3) &&
+        (addr < GPIO_MONID || addr > GPIO_MONID + 3) &&
+        (addr < AMCGPIO_MASK_MIR || addr > AMCGPIO_EN_MIR + 3) &&
+        (addr < 0x908 || addr > 0x90f) && (addr < 0xc4c || addr > 0xc53)=
 &&
+        addr !=3D RBBM_STATUS && addr !=3D 0x1714 &&
+        addr !=3D 0x7b8 && addr > MM_DATA + 3) {
         trace_ati_mm_read(size, addr, ati_reg_name(addr & ~3ULL), val);
     }
     return val;
@@ -511,7 +518,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
 {
     ATIVGAState *s =3D opaque;
=20
-    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
+    if ((((addr < CUR_OFFSET || addr > CUR_CLR1 + 3) &&
+          addr !=3D CRTC_GEN_CNTL + 2) || (ATI_DEBUG_HW_CURSOR &&
+          addr >=3D CUR_OFFSET && addr <=3D CUR_CLR1 + 3)) &&
+         (addr < GEN_INT_CNTL || addr > GEN_INT_STATUS + 3) &&
+         (addr < GPIO_MONID || addr > GPIO_MONID + 3) &&
+         (addr < AMCGPIO_MASK_MIR || addr > AMCGPIO_EN_MIR + 3) &&
+         (addr < 0x908 || addr > 0x90f) && (addr < 0xc4c || addr > 0xc53=
) &&
+         addr !=3D 0x1714 && addr > MM_DATA + 3) {
         trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data)=
;
     }
     switch (addr) {
--=20
2.13.7


