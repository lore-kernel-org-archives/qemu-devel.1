Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A0C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954492067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954492067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheRq-0001rH-S2
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jheP9-0007RL-JF
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:22:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:30190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jheP7-0006H0-BP
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:22:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 05464746307;
 Sat,  6 Jun 2020 21:22:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 82CCC7482C8; Sat,  6 Jun 2020 21:22:42 +0200 (CEST)
Message-Id: <b62681e58108651b2ca0d2fdbde8281e87185dbb.1591471056.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1591471056.git.balaton@eik.bme.hu>
References: <cover.1591471056.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/4] sm501: Ignore no-op blits
Date: Sat, 06 Jun 2020 21:17:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:22:43
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

Some guests seem to try source copy blits with same source and dest
which are no-op so avoid calling pixman for these.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 85d54b598f..3397ca9fbf 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -788,6 +788,11 @@ static void sm501_2d_operation(SM501State *s)
                               (rop2_source_is_pattern ?
                                   " with pattern source" : ""));
             }
+            /* Ignore no-op blits, some guests seem to do this */
+            if (src_base == dst_base && src_pitch == dst_pitch &&
+                src_x == dst_x && src_y == dst_y) {
+                break;
+            }
             /* Check for overlaps, this could be made more exact */
             uint32_t sb, se, db, de;
             sb = src_base + src_x + src_y * (width + src_pitch);
-- 
2.21.3


