Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2280AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E169B20823
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E169B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrJ3-0007E3-2D
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGO-0002D8-TH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:57714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGN-0007ai-Ka
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E839B748DDA;
 Thu, 21 May 2020 21:53:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 656D2748DCC; Thu, 21 May 2020 21:53:43 +0200 (CEST)
Message-Id: <58666389b6cae256e4e972a32c05cf8aa51bffc0.1590089984.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1590089984.git.balaton@eik.bme.hu>
References: <cover.1590089984.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 5/7] sm501: Replace hand written implementation with pixman
 where possible
Date: Thu, 21 May 2020 21:39:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:53:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Besides being faster this should also prevent malicious guests to
abuse 2D engine to overwrite data or cause a crash.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 207 ++++++++++++++++++++++++++-------------------
 1 file changed, 119 insertions(+), 88 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5ed57703d8..8bf4d111f4 100644
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
-
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
+        unsigned int src_pitch = s->twoD_pitch & 0x1FFF;
+
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
2.21.3


