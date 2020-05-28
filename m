Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2644206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POKOjD1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2644206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHyS-0002qz-3i
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlz-0001tf-GQ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHls-0005E0-BT
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/6seJUaK2U1QNuJEnB6P9QD85AsJH8sJzJwLeDEzLE=;
 b=POKOjD1elzK1+9E2TrR45qg4hQ5tmLW1qPdjq/iMDRsVlyEWpxJ5FG/YSySRKfGDVYBCxP
 zDQKypCNg5zcfDDmLvpY1N9RtFQuu1lTmtDafdATUqxHODVLlJxcv/FAxc6r/fOal7JZVC
 W7+Q/NGu60Snvxudxy8BVfexP5BzLdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-OlkcRaAEMI-HYdXL3Mt_tg-1; Thu, 28 May 2020 08:36:23 -0400
X-MC-Unique: OlkcRaAEMI-HYdXL3Mt_tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E79E8018A7;
 Thu, 28 May 2020 12:36:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 846915C1D6;
 Thu, 28 May 2020 12:36:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9155C9D55; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] hw/display/cirrus_vga: Convert debug printf() to trace
 event
Date: Thu, 28 May 2020 14:35:54 +0200
Message-Id: <20200528123609.27362-7-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Convert the final bit of DEBUG_BITBLT to a tracepoint.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200526062252.19852-7-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 24 ++++++++++--------------
 hw/display/trace-events |  1 +
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 76e2dc5bb604..92c197cdde1d 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -53,7 +53,6 @@
  */
 
 //#define DEBUG_CIRRUS
-//#define DEBUG_BITBLT
 
 /***************************************
  *
@@ -950,19 +949,16 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
     s->cirrus_blt_dstaddr &= s->cirrus_addr_mask;
     s->cirrus_blt_srcaddr &= s->cirrus_addr_mask;
 
-#ifdef DEBUG_BITBLT
-    printf("rop=0x%02x mode=0x%02x modeext=0x%02x w=%d h=%d dpitch=%d spitch=%d daddr=0x%08x saddr=0x%08x writemask=0x%02x\n",
-           blt_rop,
-           s->cirrus_blt_mode,
-           s->cirrus_blt_modeext,
-           s->cirrus_blt_width,
-           s->cirrus_blt_height,
-           s->cirrus_blt_dstpitch,
-           s->cirrus_blt_srcpitch,
-           s->cirrus_blt_dstaddr,
-           s->cirrus_blt_srcaddr,
-           s->vga.gr[0x2f]);
-#endif
+    trace_vga_cirrus_bitblt_start(blt_rop,
+                                  s->cirrus_blt_mode,
+                                  s->cirrus_blt_modeext,
+                                  s->cirrus_blt_width,
+                                  s->cirrus_blt_height,
+                                  s->cirrus_blt_dstpitch,
+                                  s->cirrus_blt_srcpitch,
+                                  s->cirrus_blt_dstaddr,
+                                  s->cirrus_blt_srcaddr,
+                                  s->vga.gr[0x2f]);
 
     switch (s->cirrus_blt_mode & CIRRUS_BLTMODE_PIXELWIDTHMASK) {
     case CIRRUS_BLTMODE_PIXELWIDTH8:
diff --git a/hw/display/trace-events b/hw/display/trace-events
index c3043e4ced19..bb089a5f5e0c 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -134,6 +134,7 @@ vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
 vga_cirrus_write_gr(uint8_t index, uint8_t val) "GR addr 0x%02x, val 0x%02x"
+vga_cirrus_bitblt_start(uint8_t blt_rop, uint8_t blt_mode, uint8_t blt_modeext, int blt_width, int blt_height, int blt_dstpitch, int blt_srcpitch, uint32_t blt_dstaddr, uint32_t blt_srcaddr, uint8_t gr_val) "rop=0x%02x mode=0x%02x modeext=0x%02x w=%d h=%d dpitch=%d spitch=%d daddr=0x%08"PRIx32" saddr=0x%08"PRIx32" writemask=0x%02x"
 
 # sii9022.c
 sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
-- 
2.18.4


