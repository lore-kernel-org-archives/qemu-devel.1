Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27D820738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27D820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrIz-00075r-Tc
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGP-0002DV-JZ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:57735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jbrGO-0007bm-Q8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:53:57 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 06F73748DDD;
 Thu, 21 May 2020 21:53:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 69C16748DCF; Thu, 21 May 2020 21:53:43 +0200 (CEST)
Message-Id: <7946852258d528497e85f465327fc90b5c3b59fb.1590089984.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1590089984.git.balaton@eik.bme.hu>
References: <cover.1590089984.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 6/7] sm501: Optimize small overlapping blits
Date: Thu, 21 May 2020 21:39:44 +0200
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

AmigaOS tends to do a lot of small blits (even 1 pixel). Avoid malloc
overhead by keeping around a buffer for this and only alloc when
blitting larger areas.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 8bf4d111f4..e7a9f77de7 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -750,6 +750,7 @@ static void sm501_2d_operation(SM501State *s)
     switch (cmd) {
     case 0: /* BitBlt */
     {
+        static uint32_t tmp_buf[16384];
         unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
         unsigned int src_y = s->twoD_source & 0xFFFF;
         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
@@ -812,10 +813,14 @@ static void sm501_2d_operation(SM501State *s)
             de = db + width + height * (width + dst_pitch);
             if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
                 /* regions may overlap: copy via temporary */
-                int llb = width * (1 << format);
+                int free_buf = 0, llb = width * (1 << format);
                 int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
-                uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                         height);
+                uint32_t *tmp = tmp_buf;
+
+                if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
+                    tmp = g_malloc(tmp_stride * sizeof(uint32_t) * height);
+                    free_buf = 1;
+                }
                 pixman_blt((uint32_t *)&s->local_mem[src_base], tmp,
                            src_pitch * (1 << format) / sizeof(uint32_t),
                            tmp_stride, 8 * (1 << format), 8 * (1 << format),
@@ -825,7 +830,9 @@ static void sm501_2d_operation(SM501State *s)
                            dst_pitch * (1 << format) / sizeof(uint32_t),
                            8 * (1 << format), 8 * (1 << format),
                            0, 0, dst_x, dst_y, width, height);
-                g_free(tmp);
+                if (free_buf) {
+                    g_free(tmp);
+                }
             } else {
                 pixman_blt((uint32_t *)&s->local_mem[src_base],
                            (uint32_t *)&s->local_mem[dst_base],
-- 
2.21.3


