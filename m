Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF32AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF1C2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn6vxCg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF1C2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5r6-0002R7-89
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pM-0000j0-J5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pL-0001ky-Cy
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:08 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5pL-0001kZ-7E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:07 -0500
Received: by mail-pl1-x641.google.com with SMTP id t14so2233814plr.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ByWTVem8tb3au/b4x5fdyhlm60dqCY2c6IfxCbm59X0=;
 b=Fn6vxCg+bLTN4Sfv3QjrBYBv8NRoqRp+E6p2z5EBU+J1bSy1mLjTDYQ3c7KuX0c3WQ
 r/ECWtgqpt7O+gzH1lOKQ0IaT/UxiB41utWIdfywY05RMBWHYSLI+oJ+Uj57oRWpKtbD
 1itJuKtWqC7J0dW+4JqPlMTRYX6IVdgmEKUXmaKkcEpvRuK+pgqLXXyLpOOCW6RZq9II
 mGgkS9uKm1ETnqbXXJnHzAT1wM7McvDGfKyvkVnmFmxG3d7npCxM8+hDfx4nRe5d63pM
 CZcHnv3hhcWxCp0GOKNALs2BR4LalJ1edIglIjSNdWrB6MCJ2hHSiugV6BZUqFeceaO6
 23KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ByWTVem8tb3au/b4x5fdyhlm60dqCY2c6IfxCbm59X0=;
 b=Dlxc3swSun94nyDU/EXT034DI0RBh+KuhcjR1dvoXd8WLB4T//fvqwFuRzAAimtVop
 MbR/Z9i3PAta5SsKdy55qBTyXKUpvrUpd7Y0A64EFZEONLRZNjDjQtrNP23nw8+EhwUR
 dpLNnQ+O/EqEumUnEIbAuxDANGX2fEUV5LDZ+EQUQXnm96hcxohkeqmLjgiGZppa88GU
 kP4P5YWW1IVgDGoNj5gok2/sHWoM4e2KSschYXxyOr67Ujvf2dzvAm0nxXNGLWH4XD0q
 gHHZ5wnCm2SfuTum1ckA0VzZsa90UJPIpu72Yc9+xBfKUkSW5QRc5jnoDNx9XnZqS3Ey
 GXmQ==
X-Gm-Message-State: APjAAAV3GE+CJAETkLW6s4LCiyX8i9tI/P0KldIMK6L1akcf4QhKdUzB
 C8cmw/BgYLvE0bRYnl+/xWOJmBu1/Y0=
X-Google-Smtp-Source: APXvYqzjfvnv6Lgefi34CIAyZ7Breluaw0itl8FQTIc06EiuDCHlnxq5GHCABhUn8YdRcN/d1jJHfA==
X-Received: by 2002:a17:90a:246c:: with SMTP id
 h99mr365152pje.134.1579660385923; 
 Tue, 21 Jan 2020 18:33:05 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] ps2: accept 'Set Key Make and Break' commands
Date: Tue, 21 Jan 2020 16:32:48 -1000
Message-Id: <20200122023256.27556-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

HP-UX sends both the 'Set key make and break (0xfc) and
'Set all key typematic make and break' (0xfa). QEMU response
with 'Resend' as it doesn't handle these commands. HP-UX than
reports an PS/2 max retransmission exceeded error. Add these
commands and just reply with ACK.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20191220211512.3289-4-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.20.1


