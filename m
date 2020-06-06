Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14990C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7872067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7872067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheQ0-0008AT-7W
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jheP8-0007QN-Nk
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:22:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jheP7-0006H4-B9
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:22:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C773C748DCC;
 Sat,  6 Jun 2020 21:22:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8721A7482CE; Sat,  6 Jun 2020 21:22:42 +0200 (CEST)
Message-Id: <9fab4fe6513fe8b921ce86a57f4ff7e0d5a3c3f9.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1591471056.git.balaton@eik.bme.hu>
References: <cover.1591471056.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/4] sm501: Optimise 1 pixel 2d ops
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

Some guests do 1x1 blits which is faster to do directly than calling a
function for it so avoid overhead in this case.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3397ca9fbf..59693fbb5c 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -793,6 +793,25 @@ static void sm501_2d_operation(SM501State *s)
                 src_x == dst_x && src_y == dst_y) {
                 break;
             }
+            /* Some clients also do 1 pixel blits, avoid overhead for these */
+            if (width == 1 && height == 1) {
+                unsigned int si = (src_x + src_y * src_pitch) * (1 << format);
+                unsigned int di = (dst_x + dst_y * dst_pitch) * (1 << format);
+                switch (format) {
+                case 0:
+                    s->local_mem[dst_base + di] = s->local_mem[src_base + si];
+                    break;
+                case 1:
+                    *(uint16_t *)&s->local_mem[dst_base + di] =
+                                    *(uint16_t *)&s->local_mem[src_base + si];
+                    break;
+                case 2:
+                    *(uint32_t *)&s->local_mem[dst_base + di] =
+                                    *(uint32_t *)&s->local_mem[src_base + si];
+                    break;
+                }
+                break;
+            }
             /* Check for overlaps, this could be made more exact */
             uint32_t sb, se, db, de;
             sb = src_base + src_x + src_y * (width + src_pitch);
@@ -841,9 +860,24 @@ static void sm501_2d_operation(SM501State *s)
             color = cpu_to_le16(color);
         }
 
-        pixman_fill((uint32_t *)&s->local_mem[dst_base],
-                    dst_pitch * (1 << format) / sizeof(uint32_t),
-                    8 * (1 << format), dst_x, dst_y, width, height, color);
+        if (width == 1 && height == 1) {
+            unsigned int i = (dst_x + dst_y * dst_pitch) * (1 << format);
+            switch (format) {
+            case 0:
+                s->local_mem[dst_base + i] = color & 0xff;
+                break;
+            case 1:
+                *(uint16_t *)&s->local_mem[dst_base + i] = color & 0xffff;
+                break;
+            case 2:
+                *(uint32_t *)&s->local_mem[dst_base + i] = color;
+                break;
+            }
+        } else {
+            pixman_fill((uint32_t *)&s->local_mem[dst_base],
+                        dst_pitch * (1 << format) / sizeof(uint32_t),
+                        8 * (1 << format), dst_x, dst_y, width, height, color);
+        }
         break;
     }
     default:
-- 
2.21.3


