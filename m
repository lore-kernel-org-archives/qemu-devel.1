Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143CAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD03821D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 04:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD03821D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii9tI-0000i3-S9
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 23:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9o0-0000b8-Gh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ii9nz-0003Oi-DT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 23:22:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34446)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ii9nz-00020J-8I; Thu, 19 Dec 2019 23:22:23 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id D5C2C28D4F; Thu, 19 Dec 2019 23:22:02 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <d57bdec6a81f3f520cab6fb6f2ceea723313bf7f.1576815466.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1576815466.git.fthain@telegraphics.com.au>
References: <cover.1576815466.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 11/13] dp8393x: Clear descriptor in_use field when necessary
Date: Fri, 20 Dec 2019 15:17:46 +1100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in accordance with section 3.4.7 of the datasheet:

    When the system appends more descriptors, the SONIC releases ownership
    of the descriptor after writing 0000h to the RXpkt.in_use field.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/net/dp8393x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index f35b8b48aa..6b69cca329 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -806,6 +806,15 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
             return -1;
         }
         /* Link has been updated by host */
+
+        /* Clear in_use */
+        size = sizeof(uint16_t) * width;
+        address = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, size, 1);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
     }
 
-- 
2.23.0


