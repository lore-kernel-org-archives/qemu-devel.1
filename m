Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3F6206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mayjm75l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3F6206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHv6-00055K-FJ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlw-0001lw-On
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlr-0005C2-G6
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDmNAE+nCUZciCuaalhJy9w5nGh4jWEWyIn0MRb0hzc=;
 b=Mayjm75l3EzptvQrnNiH7o3z76VKaF7BtN0A4TgCTcFkQH9A6YxPrWKHiOH4M3KquV9F8+
 Db2fwIUnpXyorxAMUqrB4dfMSGfnPApnlKh4LK9G5Qtz7yonQBk/+h1h3KTDK74Kta5A2r
 oQsvcpyQ1z0zJcmJinNN7rtgWMspf8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-p5wut37PNO2EML3fnXlRpg-1; Thu, 28 May 2020 08:36:20 -0400
X-MC-Unique: p5wut37PNO2EML3fnXlRpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EE33107B7C3;
 Thu, 28 May 2020 12:36:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 094AD7A8A6;
 Thu, 28 May 2020 12:36:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C8B519D5B; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/21] hw/display/exynos4210_fimd: Use
 qemu_log_mask(GUEST_ERROR)
Date: Thu, 28 May 2020 14:36:00 +0200
Message-Id: <20200528123609.27362-13-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Replace DPRINT_ERROR() by qemu_log_mask(GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200526062252.19852-13-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/exynos4210_fimd.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 1c0266ce9f2d..4b7286b7c948 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -31,6 +31,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 /* Debug messages configuration */
 #define EXYNOS4210_FIMD_DEBUG              0
@@ -39,20 +40,15 @@
 #if EXYNOS4210_FIMD_DEBUG == 0
     #define DPRINT_L1(fmt, args...)       do { } while (0)
     #define DPRINT_L2(fmt, args...)       do { } while (0)
-    #define DPRINT_ERROR(fmt, args...)    do { } while (0)
 #elif EXYNOS4210_FIMD_DEBUG == 1
     #define DPRINT_L1(fmt, args...) \
         do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
     #define DPRINT_L2(fmt, args...)       do { } while (0)
-    #define DPRINT_ERROR(fmt, args...)  \
-        do {fprintf(stderr, "QEMU FIMD ERROR: "fmt, ## args); } while (0)
 #else
     #define DPRINT_L1(fmt, args...) \
         do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
     #define DPRINT_L2(fmt, args...) \
         do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
-    #define DPRINT_ERROR(fmt, args...)  \
-        do {fprintf(stderr, "QEMU FIMD ERROR: "fmt, ## args); } while (0)
 #endif
 
 #if EXYNOS4210_FIMD_MODE_TRACE == 0
@@ -1108,7 +1104,7 @@ static inline int fimd_get_buffer_id(Exynos4210fimdWindow *w)
     case FIMD_WINCON_BUF2_STAT:
         return 2;
     default:
-        DPRINT_ERROR("Non-existent buffer index\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "FIMD: Non-existent buffer index\n");
         return 0;
     }
 }
@@ -1160,20 +1156,24 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
 
     if (int128_get64(w->mem_section.size) != w->fb_len ||
             !memory_region_is_ram(w->mem_section.mr)) {
-        DPRINT_ERROR("Failed to find window %u framebuffer region\n", win);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Failed to find window %u framebuffer region\n",
+                      win);
         goto error_return;
     }
 
     w->host_fb_addr = cpu_physical_memory_map(fb_start_addr, &fb_mapped_len,
                                               false);
     if (!w->host_fb_addr) {
-        DPRINT_ERROR("Failed to map window %u framebuffer\n", win);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Failed to map window %u framebuffer\n", win);
         goto error_return;
     }
 
     if (fb_mapped_len != w->fb_len) {
-        DPRINT_ERROR("Window %u mapped framebuffer length is less then "
-                "expected\n", win);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Window %u mapped framebuffer length is less than "
+                      "expected\n", win);
         cpu_physical_memory_unmap(w->host_fb_addr, fb_mapped_len, 0, 0);
         goto error_return;
     }
@@ -1490,7 +1490,9 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
             break;
         case 3:
             if (w != 1 && w != 2) {
-                DPRINT_ERROR("Bad write offset 0x%08x\n", offset);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "FIMD: Bad write offset 0x%08"HWADDR_PRIx"\n",
+                              offset);
                 return;
             }
             s->window[w].osdsize = val;
@@ -1624,7 +1626,9 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
         break;
     case FIMD_VIDW0ADD0_B2 ... FIMD_VIDW4ADD0_B2:
         if (offset & 0x0004) {
-            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
+                          offset);
             break;
         }
         w = (offset - FIMD_VIDW0ADD0_B2) >> 3;
@@ -1638,14 +1642,18 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
         break;
     case FIMD_SHD_ADD0_START ... FIMD_SHD_ADD0_END:
         if (offset & 0x0004) {
-            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
+                          offset);
             break;
         }
         s->window[(offset - FIMD_SHD_ADD0_START) >> 3].shadow_buf_start = val;
         break;
     case FIMD_SHD_ADD1_START ... FIMD_SHD_ADD1_END:
         if (offset & 0x0004) {
-            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
+                          offset);
             break;
         }
         s->window[(offset - FIMD_SHD_ADD1_START) >> 3].shadow_buf_end = val;
@@ -1665,7 +1673,8 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
         s->window[w].palette[i] = val;
         break;
     default:
-        DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n", offset);
         break;
     }
 }
@@ -1715,7 +1724,9 @@ static uint64_t exynos4210_fimd_read(void *opaque, hwaddr offset,
             break;
         case 3:
             if (w != 1 && w != 2) {
-                DPRINT_ERROR("bad read offset 0x%08x\n", offset);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "FIMD: bad read offset 0x%08"HWADDR_PRIx"\n",
+                              offset);
                 return 0xBAADBAAD;
             }
             ret = s->window[w].osdsize;
@@ -1809,7 +1820,8 @@ static uint64_t exynos4210_fimd_read(void *opaque, hwaddr offset,
         return s->window[w].palette[i];
     }
 
-    DPRINT_ERROR("bad read offset 0x%08x\n", offset);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "FIMD: bad read offset 0x%08"HWADDR_PRIx"\n", offset);
     return 0xBAADBAAD;
 }
 
-- 
2.18.4


