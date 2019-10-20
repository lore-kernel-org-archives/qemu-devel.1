Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E584CA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 20:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E718E20869
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="LotMt8nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E718E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMIA7-0007S8-21
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 16:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iMI6t-0003X0-8g
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iMI6s-0001AO-3P
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:47:31 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:43584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iMI6r-00019o-Gy
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=tiTGDMHN1vZNDWvO4Ruj3FTopNbi9p5DHVfqGHj/pzc=; b=LotMt8nYeUSVADf55Co4GBeSe5
 szLcpj/2sVqHnaRaVI4atTzzFWCogsZb+qmFLp2lT71hxHPtUfDVrUC878L8o11y86DPGHUQevJIt
 EjQy5TdK8eFQVucU+EAZTLln7yDR0U14Yy/SgTDIYr9yabSrltuQF/RsAVkD6iKDs4fw=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1iMI6q-0002cH-5x; Sun, 20 Oct 2019 22:47:28 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH 4/7] ps2: accept 'Set Key Make and Break' commands
Date: Sun, 20 Oct 2019 22:47:21 +0200
Message-Id: <20191020204724.31537-5-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020204724.31537-1-svens@stackframe.org>
References: <20191020204724.31537-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
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
 hw/input/ps2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 67f92f6112..6c2c7066a6 100644
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
@@ -592,6 +594,10 @@ void ps2_write_keyboard(void *opaque, int val)
                 KBD_REPLY_ACK,
                 KBD_REPLY_POR);
             break;
+        case KBD_CMD_SET_TYPEMATIC:
+        case KBD_CMD_SET_MAKE_BREAK:
+            ps2_queue(&s->common, KBD_REPLY_ACK);
+            break;
         default:
             ps2_queue(&s->common, KBD_REPLY_RESEND);
             break;
-- 
2.23.0


