Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD054C33CB7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B0F206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 23:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B0F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itJja-0001FJ-7a
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 18:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJfj-0004A6-EC
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1itJfh-0003m6-Ai
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 18:07:59 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54732)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1itJfh-0003l4-5e; Sun, 19 Jan 2020 18:07:57 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 6FD8729980; Sun, 19 Jan 2020 18:07:55 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <72b54c52328400d92add805f9ebb935c478556fb.1579474761.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1579474761.git.fthain@telegraphics.com.au>
References: <cover.1579474761.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 11/14] dp8393x: Clear descriptor in_use field to release
 packet
Date: Mon, 20 Jan 2020 09:59:21 +1100
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

When the SONIC receives a packet into the last available descriptor, it
retains ownership of that descriptor for as long as necessary.

Section 3.4.7 of the datasheet says,

    When the system appends more descriptors, the SONIC releases ownership
    of the descriptor after writing 0000h to the RXpkt.in_use field.

The packet can now be processed by the host, so raise a PKTRX interrupt,
just like the normal case.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
Changed since v2:
 - Assert PKTRX interrupt when releasing withheld packet.
---
 hw/net/dp8393x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 13513986f0..99c5dad7c4 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -809,7 +809,17 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
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
+        s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
     }
 
     /* Save current position */
-- 
2.24.1


