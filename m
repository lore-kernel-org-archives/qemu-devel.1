Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7400AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41075206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BalwCH6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41075206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHsf-0008H1-Bu
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHm1-0001zU-IC
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlt-0005Ff-Mm
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfYTyIs8StHB7o2N0JQA2LgTuiRGRst0nDa6SImXiJ0=;
 b=BalwCH6Qxn5cfkkuH4UIDXCh7YN0rt+vDF5V7mZRDOKljm29p/Wtq0YmM1On2dekjYkrgL
 eN5H8kfNKCb/hG5PkcjSPvXTHIzQvN7q0kMKEsz5VRa1Y7zQzSQr/qzcb8Lx14yNS0pkA4
 rKVVnytP7AUlNGeVrd65K8CwXEdfFTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-dWZhFjqXPP2CTOPKbzhjyw-1; Thu, 28 May 2020 08:36:23 -0400
X-MC-Unique: dWZhFjqXPP2CTOPKbzhjyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DD511855A08;
 Thu, 28 May 2020 12:36:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19E3E2B4CC;
 Thu, 28 May 2020 12:36:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA5479D61; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] hw/display/pxa2xx_lcd: Replace printf() call by
 qemu_log_mask()
Date: Thu, 28 May 2020 14:36:02 +0200
Message-Id: <20200528123609.27362-15-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace printf() calls by qemu_log_mask(UNIMP), which is
disabled by default. This avoid flooding the terminal when
fuzzing the device.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200526062252.19852-15-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/pxa2xx_lcd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index d5f2e82a4ec3..ff90104b8011 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -426,9 +426,10 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         if ((s->control[0] & LCCR0_ENB) && !(value & LCCR0_ENB))
             s->status[0] |= LCSR0_QD;
 
-        if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT))
-            printf("%s: internal frame buffer unsupported\n", __func__);
-
+        if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: internal frame buffer unsupported\n", __func__);
+        }
         if ((s->control[3] & LCCR3_API) &&
                 (value & LCCR0_ENB) && !(value & LCCR0_LCDT))
             s->status[0] |= LCSR0_ABC;
@@ -462,9 +463,9 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         break;
 
     case OVL1C1:
-        if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN))
-            printf("%s: Overlay 1 not supported\n", __func__);
-
+        if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN)) {
+            qemu_log_mask(LOG_UNIMP, "%s: Overlay 1 not supported\n", __func__);
+        }
         s->ovl1c[0] = value & 0x80ffffff;
         s->dma_ch[1].up = (value & OVLC1_EN) || (s->control[0] & LCCR0_SDS);
         break;
@@ -474,9 +475,9 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         break;
 
     case OVL2C1:
-        if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN))
-            printf("%s: Overlay 2 not supported\n", __func__);
-
+        if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN)) {
+            qemu_log_mask(LOG_UNIMP, "%s: Overlay 2 not supported\n", __func__);
+        }
         s->ovl2c[0] = value & 0x80ffffff;
         s->dma_ch[2].up = !!(value & OVLC1_EN);
         s->dma_ch[3].up = !!(value & OVLC1_EN);
@@ -488,9 +489,10 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         break;
 
     case CCR:
-        if (!(s->ccr & CCR_CEN) && (value & CCR_CEN))
-            printf("%s: Hardware cursor unimplemented\n", __func__);
-
+        if (!(s->ccr & CCR_CEN) && (value & CCR_CEN)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Hardware cursor unimplemented\n", __func__);
+        }
         s->ccr = value & 0x81ffffe7;
         s->dma_ch[5].up = !!(value & CCR_CEN);
         break;
-- 
2.18.4


