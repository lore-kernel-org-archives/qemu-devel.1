Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7725C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13F9206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="MmrXsBXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13F9206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPgI-0006zg-H2
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iiPcM-00044i-TB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iiPcL-0004US-IU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:15:26 -0500
Received: from shroom.duncanthrax.net ([2a01:4f8:121:41fa::169]:32827
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iiPcK-0004M0-Tt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TlOs2J/DOVsKTrU4mZauVdbZC2Ry7+/K8wOK+XSZgS0=; b=MmrXsBXsuJ4sZ5VeoBVpxlzRSg
 EUPE9u6r7CHkWqDmtyzZCf3bcDfRdD/pPl/sfFq862G23Y5IVlnqBq0BBropC6kFpb4YkF9+gZ8TY
 L6vP2rjgFc/i5HzudBchyLS+ynttjYXSThSkg8aJ/B2aRTeTn7jArgBTIHPUaA6yjKBc=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1iiPcI-0000lb-Nt; Fri, 20 Dec 2019 22:15:22 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH v5 3/6] ps2: accept 'Set Key Make and Break' commands
Date: Fri, 20 Dec 2019 22:15:09 +0100
Message-Id: <20191220211512.3289-4-svens@stackframe.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220211512.3289-1-svens@stackframe.org>
References: <20191220211512.3289-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:121:41fa::169
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HP-UX sends both the 'Set key make and break (0xfc) and
'Set all key typematic make and break' (0xfa). QEMU response
with 'Resend' as it doesn't handle these commands. HP-UX than
reports an PS/2 max retransmission exceeded error. Add these
commands and just reply with ACK.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/input/ps2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 67f92f6112..0b671b6339 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -49,6 +49,8 @@
 #define KBD_CMD_RESET_DISABLE	0xF5	/* reset and disable scanning */
 #define KBD_CMD_RESET_ENABLE   	0xF6    /* reset and enable scanning */
 #define KBD_CMD_RESET		0xFF	/* Reset */
+#define KBD_CMD_SET_MAKE_BREAK  0xFC    /* Set Make and Break mode */
+#define KBD_CMD_SET_TYPEMATIC   0xFA    /* Set Typematic Make and Break mode */
 
 /* Keyboard Replies */
 #define KBD_REPLY_POR		0xAA	/* Power on reset */
@@ -573,6 +575,7 @@ void ps2_write_keyboard(void *opaque, int val)
         case KBD_CMD_SCANCODE:
         case KBD_CMD_SET_LEDS:
         case KBD_CMD_SET_RATE:
+        case KBD_CMD_SET_MAKE_BREAK:
             s->common.write_cmd = val;
             ps2_queue(&s->common, KBD_REPLY_ACK);
             break;
@@ -592,11 +595,18 @@ void ps2_write_keyboard(void *opaque, int val)
                 KBD_REPLY_ACK,
                 KBD_REPLY_POR);
             break;
+        case KBD_CMD_SET_TYPEMATIC:
+            ps2_queue(&s->common, KBD_REPLY_ACK);
+            break;
         default:
             ps2_queue(&s->common, KBD_REPLY_RESEND);
             break;
         }
         break;
+    case KBD_CMD_SET_MAKE_BREAK:
+        ps2_queue(&s->common, KBD_REPLY_ACK);
+        s->common.write_cmd = -1;
+        break;
     case KBD_CMD_SCANCODE:
         if (val == 0) {
             if (s->common.queue.count <= PS2_QUEUE_SIZE - 2) {
-- 
2.24.0


