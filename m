Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7298C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800AC206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBojf8Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800AC206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHne-0004s9-Ez
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHls-0001Zx-Oi
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30534
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlp-0005AA-C9
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiGn/nHni1Lk3kZNk9PZIsmBEvCzwQMaTtX8WHKOh6U=;
 b=VBojf8Q+6+M1UpnfC3u4iCAIfEtlK6/q35Q1z7f/9K+t3tFFOFADICVYNFnBVKCCIkiI+o
 2Uk1G34o0Hkg8nYbcHEIunFPCVx38pa2179DLt+L69LjoaJ1Rg0t+Ukl8sjrYIKjLz+GnC
 V7d1iXKWelhDOCUO/ZAp32p2Efeoc1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-CF5a3oIbM0y9Ji1ME4fAVA-1; Thu, 28 May 2020 08:36:22 -0400
X-MC-Unique: CF5a3oIbM0y9Ji1ME4fAVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80EA31855A0E;
 Thu, 28 May 2020 12:36:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B83449E0E8;
 Thu, 28 May 2020 12:36:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 09EDA9D6A; Thu, 28 May 2020 14:36:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] sm501: Clean up local variables in sm501_2d_operation
Date: Thu, 28 May 2020 14:36:06 +0200
Message-Id: <20200528123609.27362-19-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Make variables local to the block they are used in to make it clearer
which operation they are needed for.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: ae59f8138afe7f6a5a4a82539d0f61496a906b06.1590089984.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 97660090bb20..5ed57703d811 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -699,28 +699,19 @@ static inline void hwc_invalidate(SM501State *s, int crt)
 
 static void sm501_2d_operation(SM501State *s)
 {
-    /* obtain operation parameters */
     int cmd = (s->twoD_control >> 16) & 0x1F;
     int rtl = s->twoD_control & BIT(27);
-    int src_x = (s->twoD_source >> 16) & 0x01FFF;
-    int src_y = s->twoD_source & 0xFFFF;
-    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
-    int dst_y = s->twoD_destination & 0xFFFF;
-    int width = (s->twoD_dimension >> 16) & 0x1FFF;
-    int height = s->twoD_dimension & 0xFFFF;
-    uint32_t color = s->twoD_foreground;
     int format = (s->twoD_stretch >> 20) & 0x3;
     int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
     /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
     int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
     int rop = s->twoD_control & 0xFF;
-    uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
+    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
+    int dst_y = s->twoD_destination & 0xFFFF;
+    int width = (s->twoD_dimension >> 16) & 0x1FFF;
+    int height = s->twoD_dimension & 0xFFFF;
     uint32_t dst_base = s->twoD_destination_base & 0x03FFFFFF;
-
-    /* get frame buffer info */
-    uint8_t *src = s->local_mem + src_base;
     uint8_t *dst = s->local_mem + dst_base;
-    int src_pitch = s->twoD_pitch & 0x1FFF;
     int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
@@ -758,6 +749,13 @@ static void sm501_2d_operation(SM501State *s)
 
     switch (cmd) {
     case 0x00: /* copy area */
+    {
+        int src_x = (s->twoD_source >> 16) & 0x01FFF;
+        int src_y = s->twoD_source & 0xFFFF;
+        uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
+        uint8_t *src = s->local_mem + src_base;
+        int src_pitch = s->twoD_pitch & 0x1FFF;
+
 #define COPY_AREA(_bpp, _pixel_type, rtl) {                                   \
         int y, x, index_d, index_s;                                           \
         for (y = 0; y < height; y++) {                              \
@@ -793,8 +791,11 @@ static void sm501_2d_operation(SM501State *s)
             break;
         }
         break;
-
+    }
     case 0x01: /* fill rectangle */
+    {
+        uint32_t color = s->twoD_foreground;
+
 #define FILL_RECT(_bpp, _pixel_type) {                                      \
         int y, x;                                                           \
         for (y = 0; y < height; y++) {                            \
@@ -819,7 +820,7 @@ static void sm501_2d_operation(SM501State *s)
             break;
         }
         break;
-
+    }
     default:
         qemu_log_mask(LOG_UNIMP, "sm501: not implemented 2D operation: %d\n",
                       cmd);
-- 
2.18.4


