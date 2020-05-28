Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC18C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C728D206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXxfpclX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C728D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHrZ-0005IR-W7
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlt-0001cH-IE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlp-00059w-FO
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=kl0xBtkQvSUQVd60CS6Y6dEgde7UHK4QkuNltk2B7pU=;
 b=CXxfpclXo8KOeUmq+GqcMRqXRLs7F0Eu14Xui6qDVJn6f0CE1o6DqgmWObrGuhDWqzlH1e
 U6rAxKKul95FjzN7LQLKcp6ATsiGlhDNr3k3Jklf2xq/nXeWcXsPm/ybrEcrJCQ4B/t+8y
 gSckLJgejL7fRkirH0Evp4bwmZ2NI9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-O7_HnLG7PO67Hlo35-CL6A-1; Thu, 28 May 2020 08:36:21 -0400
X-MC-Unique: O7_HnLG7PO67Hlo35-CL6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7924EC1A2;
 Thu, 28 May 2020 12:36:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21D547A8B4;
 Thu, 28 May 2020 12:36:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 130659D71; Thu, 28 May 2020 14:36:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/21] sm501: Replace hand written implementation with pixman
 where possible
Date: Thu, 28 May 2020 14:36:07 +0200
Message-Id: <20200528123609.27362-20-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Besides being faster this should also prevent malicious guests to
abuse 2D engine to overwrite data or cause a crash.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 205 ++++++++++++++++++++++++++-------------------
 1 file changed, 118 insertions(+), 87 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5ed57703d811..8bf4d111f4b3 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -706,13 +706,12 @@ static void sm501_2d_operation(SM501State *s)
     /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
     int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
     int rop = s->twoD_control & 0xFF;
-    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
-    int dst_y = s->twoD_destination & 0xFFFF;
-    int width = (s->twoD_dimension >> 16) & 0x1FFF;
-    int height = s->twoD_dimension & 0xFFFF;
+    unsigned int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
+    unsigned int dst_y = s->twoD_destination & 0xFFFF;
+    unsigned int width = (s->twoD_dimension >> 16) & 0x1FFF;
+    unsigned int height = s->twoD_dimension & 0xFFFF;
     uint32_t dst_base = s->twoD_destination_base & 0x03FFFFFF;
-    uint8_t *dst = s->local_mem + dst_base;
-    int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
+    unsigned int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
 
@@ -721,104 +720,136 @@ static void sm501_2d_operation(SM501State *s)
         return;
     }
 
-    if (rop_mode == 0) {
-        if (rop != 0xcc) {
-            /* Anything other than plain copies are not supported */
-            qemu_log_mask(LOG_UNIMP, "sm501: rop3 mode with rop %x is not "
-                          "supported.\n", rop);
-        }
-    } else {
-        if (rop2_source_is_pattern && rop != 0x5) {
-            /* For pattern source, we support only inverse dest */
-            qemu_log_mask(LOG_UNIMP, "sm501: rop2 source being the pattern and "
-                          "rop %x is not supported.\n", rop);
-        } else {
-            if (rop != 0x5 && rop != 0xc) {
-                /* Anything other than plain copies or inverse dest is not
-                 * supported */
-                qemu_log_mask(LOG_UNIMP, "sm501: rop mode %x is not "
-                              "supported.\n", rop);
-            }
-        }
-    }
-
     if (s->twoD_source_base & BIT(27) || s->twoD_destination_base & BIT(27)) {
         qemu_log_mask(LOG_UNIMP, "sm501: only local memory is supported.\n");
         return;
     }
 
+    if (!dst_pitch) {
+        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Zero dest pitch.\n");
+        return;
+    }
+
+    if (!width || !height) {
+        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Zero size 2D op.\n");
+        return;
+    }
+
+    if (rtl) {
+        dst_x -= width - 1;
+        dst_y -= height - 1;
+    }
+
+    if (dst_base >= get_local_mem_size(s) || dst_base +
+        (dst_x + width + (dst_y + height) * (dst_pitch + width)) *
+        (1 << format) >= get_local_mem_size(s)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "sm501: 2D op dest is outside vram.\n");
+        return;
+    }
+
     switch (cmd) {
-    case 0x00: /* copy area */
+    case 0: /* BitBlt */
     {
-        int src_x = (s->twoD_source >> 16) & 0x01FFF;
-        int src_y = s->twoD_source & 0xFFFF;
+        unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
+        unsigned int src_y = s->twoD_source & 0xFFFF;
         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
-        uint8_t *src = s->local_mem + src_base;
-        int src_pitch = s->twoD_pitch & 0x1FFF;
+        unsigned int src_pitch = s->twoD_pitch & 0x1FFF;
 
-#define COPY_AREA(_bpp, _pixel_type, rtl) {                                   \
-        int y, x, index_d, index_s;                                           \
-        for (y = 0; y < height; y++) {                              \
-            for (x = 0; x < width; x++) {                           \
-                _pixel_type val;                                              \
-                                                                              \
-                if (rtl) {                                                    \
-                    index_s = ((src_y - y) * src_pitch + src_x - x) * _bpp;   \
-                    index_d = ((dst_y - y) * dst_pitch + dst_x - x) * _bpp;   \
-                } else {                                                      \
-                    index_s = ((src_y + y) * src_pitch + src_x + x) * _bpp;   \
-                    index_d = ((dst_y + y) * dst_pitch + dst_x + x) * _bpp;   \
-                }                                                             \
-                if (rop_mode == 1 && rop == 5) {                              \
-                    /* Invert dest */                                         \
-                    val = ~*(_pixel_type *)&dst[index_d];                     \
-                } else {                                                      \
-                    val = *(_pixel_type *)&src[index_s];                      \
-                }                                                             \
-                *(_pixel_type *)&dst[index_d] = val;                          \
-            }                                                                 \
-        }                                                                     \
-    }
-        switch (format) {
-        case 0:
-            COPY_AREA(1, uint8_t, rtl);
-            break;
-        case 1:
-            COPY_AREA(2, uint16_t, rtl);
-            break;
-        case 2:
-            COPY_AREA(4, uint32_t, rtl);
-            break;
+        if (!src_pitch) {
+            qemu_log_mask(LOG_GUEST_ERROR, "sm501: Zero src pitch.\n");
+            return;
+        }
+
+        if (rtl) {
+            src_x -= width - 1;
+            src_y -= height - 1;
+        }
+
+        if (src_base >= get_local_mem_size(s) || src_base +
+            (src_x + width + (src_y + height) * (src_pitch + width)) *
+            (1 << format) >= get_local_mem_size(s)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sm501: 2D op src is outside vram.\n");
+            return;
+        }
+
+        if ((rop_mode && rop == 0x5) || (!rop_mode && rop == 0x55)) {
+            /* Invert dest, is there a way to do this with pixman? */
+            unsigned int x, y, i;
+            uint8_t *d = s->local_mem + dst_base;
+
+            for (y = 0; y < height; y++) {
+                i = (dst_x + (dst_y + y) * dst_pitch) * (1 << format);
+                for (x = 0; x < width; x++, i += (1 << format)) {
+                    switch (format) {
+                    case 0:
+                        d[i] = ~d[i];
+                        break;
+                    case 1:
+                        *(uint16_t *)&d[i] = ~*(uint16_t *)&d[i];
+                        break;
+                    case 2:
+                        *(uint32_t *)&d[i] = ~*(uint32_t *)&d[i];
+                        break;
+                    }
+                }
+            }
+        } else {
+            /* Do copy src for unimplemented ops, better than unpainted area */
+            if ((rop_mode && (rop != 0xc || rop2_source_is_pattern)) ||
+                (!rop_mode && rop != 0xcc)) {
+                qemu_log_mask(LOG_UNIMP,
+                              "sm501: rop%d op %x%s not implemented\n",
+                              (rop_mode ? 2 : 3), rop,
+                              (rop2_source_is_pattern ?
+                                  " with pattern source" : ""));
+            }
+            /* Check for overlaps, this could be made more exact */
+            uint32_t sb, se, db, de;
+            sb = src_base + src_x + src_y * (width + src_pitch);
+            se = sb + width + height * (width + src_pitch);
+            db = dst_base + dst_x + dst_y * (width + dst_pitch);
+            de = db + width + height * (width + dst_pitch);
+            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
+                /* regions may overlap: copy via temporary */
+                int llb = width * (1 << format);
+                int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
+                uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
+                                         height);
+                pixman_blt((uint32_t *)&s->local_mem[src_base], tmp,
+                           src_pitch * (1 << format) / sizeof(uint32_t),
+                           tmp_stride, 8 * (1 << format), 8 * (1 << format),
+                           src_x, src_y, 0, 0, width, height);
+                pixman_blt(tmp, (uint32_t *)&s->local_mem[dst_base],
+                           tmp_stride,
+                           dst_pitch * (1 << format) / sizeof(uint32_t),
+                           8 * (1 << format), 8 * (1 << format),
+                           0, 0, dst_x, dst_y, width, height);
+                g_free(tmp);
+            } else {
+                pixman_blt((uint32_t *)&s->local_mem[src_base],
+                           (uint32_t *)&s->local_mem[dst_base],
+                           src_pitch * (1 << format) / sizeof(uint32_t),
+                           dst_pitch * (1 << format) / sizeof(uint32_t),
+                           8 * (1 << format), 8 * (1 << format),
+                           src_x, src_y, dst_x, dst_y, width, height);
+            }
         }
         break;
     }
-    case 0x01: /* fill rectangle */
+    case 1: /* Rectangle Fill */
     {
         uint32_t color = s->twoD_foreground;
 
-#define FILL_RECT(_bpp, _pixel_type) {                                      \
-        int y, x;                                                           \
-        for (y = 0; y < height; y++) {                            \
-            for (x = 0; x < width; x++) {                         \
-                int index = ((dst_y + y) * dst_pitch + dst_x + x) * _bpp;   \
-                *(_pixel_type *)&dst[index] = (_pixel_type)color;           \
-            }                                                               \
-        }                                                                   \
-    }
-
-        switch (format) {
-        case 0:
-            FILL_RECT(1, uint8_t);
-            break;
-        case 1:
-            color = cpu_to_le16(color);
-            FILL_RECT(2, uint16_t);
-            break;
-        case 2:
+        if (format == 2) {
             color = cpu_to_le32(color);
-            FILL_RECT(4, uint32_t);
-            break;
+        } else if (format == 1) {
+            color = cpu_to_le16(color);
         }
+
+        pixman_fill((uint32_t *)&s->local_mem[dst_base],
+                    dst_pitch * (1 << format) / sizeof(uint32_t),
+                    8 * (1 << format), dst_x, dst_y, width, height, color);
         break;
     }
     default:
-- 
2.18.4


