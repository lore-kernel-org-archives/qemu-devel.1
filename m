Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9786C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 21:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FBC2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 21:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="eT1I9sn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FBC2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=o2online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv64m-0001Av-NG
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 16:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rsta2@o2online.de>) id 1iv4oZ-0000iC-Ri
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rsta2@o2online.de>) id 1iv4oY-0007Ei-RF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:40:23 -0500
Received: from mail1435c50.megamailservers.eu ([91.136.14.35]:47996
 helo=mail263c50.megamailservers.eu)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rsta2@o2online.de>)
 id 1iv4oV-0007BJ-Ly; Fri, 24 Jan 2020 14:40:20 -0500
X-Authenticated-User: 017626146082@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
 s=maildub; t=1579888529;
 bh=msyG0+vgYVYZwtyOlvLTdyb7wfWrEyYcTNuAHZIeYUw=;
 h=From:To:Cc:Subject:Date:From;
 b=eT1I9sn5WbSdZ1/3B7nj+TUuJIwzNnC12NXg/fcKIMIn/UqnlZ5OAoexvzKOSIJsf
 OBu3CMrh5xEkhMpasm043sAUhpw1lGxFhWVpXztigEOMepV7SBtuv5nk8V/5aWFBxc
 /Kn+zsgwvn8yZJfDGSgAxSqJJhyjfzJoUQYNh8H0=
Feedback-ID: rsta2@o2online.
Received: from desktop2.localnet (178-21-1-177.ilmprovider.net [178.21.1.177])
 (authenticated bits=0)
 by mail263c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 00OHtQO8027697
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jan 2020 17:55:28 +0000
From: Rene Stange <rsta2@o2online.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] bcm2835_dma: Fix TD mode
Date: Fri, 24 Jan 2020 18:55:25 +0100
Message-ID: <5099495.CBsx362VbF@desktop2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-RefID: str=0001.0A0B0204.5E2B2F91.0003, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC: 0
X-CHA: v=2.3 cv=II989TnG c=1 sm=1 tr=0 a=oFQkuSNlBNCQRuITVo1IXg==:117
 a=oFQkuSNlBNCQRuITVo1IXg==:17 a=kj9zAlcOel0A:10 a=KlKTeOmF2TGtJzamOh8A:9
 a=CjuIK1q_8ugA:10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 91.136.14.35
X-Mailman-Approved-At: Fri, 24 Jan 2020 16:00:10 -0500
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TD (two dimensions) DMA mode did not work, because the xlen variable has
not been re-initialized before each additional ylen run through in
bcm2835_dma_update(). Furthermore ylen has to be increased by one after
reading it from the TXFR_LEN register, because a value of zero has to
result in one run through of the ylen loop. Both issues have been fixed.

Signed-off-by: Rene Stange <rsta2@o2online.de>
---
 hw/dma/bcm2835_dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 1e458d7fba..0881c9506e 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -54,7 +54,7 @@
 static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
 {
     BCM2835DMAChan *ch = &s->chan[c];
-    uint32_t data, xlen, ylen;
+    uint32_t data, xlen, xlen_td, ylen;
     int16_t dst_stride, src_stride;
 
     if (!(s->enable & (1 << c))) {
@@ -72,13 +72,13 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
 
         if (ch->ti & BCM2708_DMA_TDMODE) {
             /* 2D transfer mode */
-            ylen = (ch->txfr_len >> 16) & 0x3fff;
-            xlen = ch->txfr_len & 0xffff;
+            ylen = ((ch->txfr_len >> 16) & 0x3fff) + 1;
+            xlen_td = xlen = ch->txfr_len & 0xffff;
             dst_stride = ch->stride >> 16;
             src_stride = ch->stride & 0xffff;
         } else {
             ylen = 1;
-            xlen = ch->txfr_len;
+            xlen_td = xlen = ch->txfr_len;
             dst_stride = 0;
             src_stride = 0;
         }
@@ -117,6 +117,7 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
             if (--ylen != 0) {
                 ch->source_ad += src_stride;
                 ch->dest_ad += dst_stride;
+                xlen = xlen_td;
             }
         }
         ch->cs |= BCM2708_DMA_END;
-- 
2.16.4





