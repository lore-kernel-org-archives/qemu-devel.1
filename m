Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66173C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D1C2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HavzfZwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D1C2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRl7L-0000fk-8g
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 19:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5a-0007Lw-24
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5R-0006oc-Oy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:17:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5R-0006k4-AB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id t14so8585144wrw.12
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nJURS/g1DqzAgiA/8oS3taBQkSYAAOGZ2MWBgoul9C4=;
 b=HavzfZwtrvOxsiQiIKp4GGBmWBHRj4u4ONCHJa0n865BrZT7TACoI2o5TIqNWeIPkg
 TgurKONOnpmA9Z3bRs42BaT34+HFktTaNsfcVbLPjm4c66M0sBMjepBVYSV0R6NrtTXr
 CQHIzgiCJ40l3LFxhjm02qbE5dMJwDIGYqgUq7PEvqeJCa0rOZP89h2GGk18NHCmQ0n9
 D2TdThbz/ZOI4xaaIfz2MB05vutg5Bmy/QSgJbiy/Cwatn0WURlUp7uHlSEU1dfJ9MzP
 6c3I40vxo40CE5Ksixu/uLh5rtOx0XdHqEEkMDlK6JUgRCJXrR813a7Dwp0yPlBHSNmx
 DnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nJURS/g1DqzAgiA/8oS3taBQkSYAAOGZ2MWBgoul9C4=;
 b=j7o9atT7ttHfSNyNCeMo5vtzPgbAcFQJYhPfJ9hFZ714OoXAYMX/Lptixbtoi3e9Bw
 KIxPNk/+2O8ZFGcctWGDtZrFE8oAv15VRLGapHB3BzTYFI55QBUO7nZTk+Yzc8eX5Vat
 RyFmLphlLXPtpGsiRCMwCmW3rOKUHCtowix3Vq6DpUcoJCcRjuWJoFBd3QvxvH1YXj09
 ry/5tsLckvaF2lw5IZgl/KyekoNW4S9TjPaGxDXl7idk1dFvbCKeXCFQpPW2YTTnOFUu
 ir7FOYeE68YnvpRY0OI6ykRFv9pbIrx6gdYAx+M8wmvXBjzDChQuQ1kL3qcpKtMmoQ+0
 IehA==
X-Gm-Message-State: AGi0PuYcFRX1NHrcbENp8tUUqBBwEL7YKpDUVqnLc7fYQ8cBSpuXdmDm
 4o0WEvUu1lUaVsYdxqXn2UK6fM0O
X-Google-Smtp-Source: APiQypL6CHsOcrS51tjmy5zGENCtOIvxZsFOy2plhOOAY0gptV0JyNNYUMsXZWrrT5SZlPyURk7Pag==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr7383788wrt.407.1587683811658; 
 Thu, 23 Apr 2020 16:16:51 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h13sm5498122wrs.22.2020.04.23.16.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 16:16:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] hw/net/tulip: Set descriptor error bit when lenght is
 incorrect
Date: Fri, 24 Apr 2020 01:16:44 +0200
Message-Id: <20200423231644.15786-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423231644.15786-1-f4bug@amsat.org>
References: <20200423231644.15786-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Helge Deller <deller@gmx.de>,
 Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Jason Wang <jasowang@redhat.com>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a frame lenght is incorrect, set the RDES0 'Error Summary'
and 'Frame too long' bits. Then stop the receive process and
trigger an abnormal interrupt. See [4.3.5 Receive Process].

Cc: Li Qiang <liq3ea@gmail.com>
Cc: Li Qiang <pangpei.lq@antfin.com>
Cc: Ziming Zhang <ezrakiez@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Fixes: 8ffb7265af ("check frame size and r/w data length")
Buglink: https://bugs.launchpad.net/bugs/1874539
Reported-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/tulip.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 470f635acb..671f79b6f4 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -158,7 +158,7 @@ static void tulip_next_rx_descriptor(TULIPState *s,
     s->current_rx_desc &= ~3ULL;
 }
 
-static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
+static int tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
 {
     int len1 = (desc->control >> RDES1_BUF1_SIZE_SHIFT) & RDES1_BUF1_SIZE_MASK;
     int len2 = (desc->control >> RDES1_BUF2_SIZE_SHIFT) & RDES1_BUF2_SIZE_MASK;
@@ -177,7 +177,8 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
                           "(ofs: %u, len:%d, size:%zu)\n",
                           __func__, s->rx_frame_len, len,
                           sizeof(s->rx_frame));
-            return;
+            s->rx_frame_len = 0;
+            return -1;
         }
         pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
@@ -197,12 +198,15 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
                           "(ofs: %u, len:%d, size:%zu)\n",
                           __func__, s->rx_frame_len, len,
                           sizeof(s->rx_frame));
-            return;
+            s->rx_frame_len = 0;
+            return -1;
         }
         pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -= len;
     }
+
+    return 0;
 }
 
 static bool tulip_filter_address(TULIPState *s, const uint8_t *addr)
@@ -274,7 +278,11 @@ static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t size)
             s->rx_frame_len = s->rx_frame_size;
         }
 
-        tulip_copy_rx_bytes(s, &desc);
+        if (tulip_copy_rx_bytes(s, &desc)) {
+            desc.status |= RDES0_ES | RDES0_TL; /* Error: frame too long */
+            s->csr[5] |= CSR5_RPS; /* Receive process stopped */
+            tulip_update_int(s);
+        }
 
         if (!s->rx_frame_len) {
             desc.status |= s->rx_status;
-- 
2.21.1


