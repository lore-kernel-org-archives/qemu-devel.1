Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10968C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC642067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC642067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheXY-0006EG-67
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jheP8-0007QJ-Ie
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:22:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jheP6-0006Gy-Mq
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:22:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EFEFE748DD0;
 Sat,  6 Jun 2020 21:22:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 773C7746333; Sat,  6 Jun 2020 21:22:42 +0200 (CEST)
Message-Id: <acb431de2d9c7a497d54a548dfc7592eb2b9fe1c.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1591471056.git.balaton@eik.bme.hu>
References: <cover.1591471056.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/4] sm501: Fix bounds checks
Date: Sat, 06 Jun 2020 21:17:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

We don't need to add width to pitch when calculating last point, that
would reject valid ops within the card's local_mem.

Fixes: b15a22bbcbe6a78dc3d88fe3134985e4cdd87de4
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index edd8d24a76..5ae320ddc3 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -723,8 +723,8 @@ static void sm501_2d_operation(SM501State *s)
         dst_y -= height - 1;
     }
 
-    if (dst_base >= get_local_mem_size(s) || dst_base +
-        (dst_x + width + (dst_y + height) * (dst_pitch + width)) *
+    if (dst_base >= get_local_mem_size(s) ||
+        dst_base + (dst_x + width + (dst_y + height) * dst_pitch) *
         (1 << format) >= get_local_mem_size(s)) {
         qemu_log_mask(LOG_GUEST_ERROR, "sm501: 2D op dest is outside vram.\n");
         return;
@@ -749,8 +749,8 @@ static void sm501_2d_operation(SM501State *s)
             src_y -= height - 1;
         }
 
-        if (src_base >= get_local_mem_size(s) || src_base +
-            (src_x + width + (src_y + height) * (src_pitch + width)) *
+        if (src_base >= get_local_mem_size(s) ||
+            src_base + (src_x + width + (src_y + height) * src_pitch) *
             (1 << format) >= get_local_mem_size(s)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "sm501: 2D op src is outside vram.\n");
-- 
2.21.3


