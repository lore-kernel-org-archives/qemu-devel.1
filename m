Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A715C55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D6D2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/f/GBx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D6D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRl7F-0000Na-Gc
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 19:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5U-0007EF-5g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5R-0006mN-6A
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jRl5Q-0006ic-Ec
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 19:16:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id i10so8586602wrv.10
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mDfF+nCaDRfOLKLYCWQdtmluZlHSpxwXCWsiYI5lMHI=;
 b=t/f/GBx0pXhXgn67L08pNOWEiH0EIcVkMbejMjrFOqPqqNyf9QHbdSu+RUs45cLBi6
 WMiQpj5CvPHZ7nOAysUOp6ZD9Pk/TJzUAG5/sE2iYjYj3RtOMn8X9PUzuwXEVu8s/1Ap
 jUyZ5BelTvnV6tBp5drVGlbxLpOM10dtp79tma9yCDb5KnYxTBxv2yXjbakLypt3LCCt
 mtuOQxECzShAst3gyOWGUzePHlY6fuTuA6h7qw6/YvhxPF2ytNhcPgzkVQs8vg549PgU
 7D4MgOUzMskU6LoTKpz48nnpWh8kZvSZLHkkg/4a42R032jGlo8xtzeipb+dDQKt2jPb
 Ck3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mDfF+nCaDRfOLKLYCWQdtmluZlHSpxwXCWsiYI5lMHI=;
 b=saC28COAKkeXpe4flf0WRC1Wopgdyh0KeksZ+gvg8PGjealdbuVQUeMm8bU3MN1era
 ycnRrL+JwNGw9bkHuywgKkMRyERjAEXTKJvFXEEG+B4A6xq0KJiN9iN9aB15laCHrd8r
 yujn/6aWLfDnWekDEJ4NJwTIBFlKFKEGKiRCyj152pHwv48ydjp39FvfVEJLQTFhwxMl
 BABcrxI/bMqCgpxQUxRVPvDLjY4bDeEnuYr8as1DWujpt9xc9qNi3T1R1M9KW7N2NsS0
 0x6dlcLLp+IhChg4NdrFbm+xau/239IJ9uDQ2X5fQex3kdTZrWT/3RyjeJWwUbGt3XbU
 w8gA==
X-Gm-Message-State: AGi0PuYL/kj7ici3iBPgOapEl7pIDCUiJityYbmMao7qdFs+gdta5P3I
 lL182CL35E8bxpsOvINCmWT73RFG
X-Google-Smtp-Source: APiQypJ7LvwKNq1T5UUNg8uBXIEtPX985Bdg3zSd7Mk2zeGnu2ekcZGOLSoiZg45cVZef8qvvpbd0A==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr8067713wru.164.1587683810004; 
 Thu, 23 Apr 2020 16:16:50 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h13sm5498122wrs.22.2020.04.23.16.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 16:16:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] hw/net/tulip: Log descriptor overflows
Date: Fri, 24 Apr 2020 01:16:43 +0200
Message-Id: <20200423231644.15786-3-f4bug@amsat.org>
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Log with GUEST_ERROR what the guest is doing wrong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/tulip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 1295f51d07..470f635acb 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -172,6 +172,11 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
         }
 
         if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: descriptor overflow "
+                          "(ofs: %u, len:%d, size:%zu)\n",
+                          __func__, s->rx_frame_len, len,
+                          sizeof(s->rx_frame));
             return;
         }
         pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
@@ -187,6 +192,11 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
         }
 
         if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: descriptor overflow "
+                          "(ofs: %u, len:%d, size:%zu)\n",
+                          __func__, s->rx_frame_len, len,
+                          sizeof(s->rx_frame));
             return;
         }
         pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
@@ -584,6 +594,9 @@ static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *desc)
     int len2 = (desc->control >> TDES1_BUF2_SIZE_SHIFT) & TDES1_BUF2_SIZE_MASK;
 
     if (s->tx_frame_len + len1 > sizeof(s->tx_frame)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: descriptor overflow (ofs: %u, len:%d, size:%zu)\n",
+                      __func__, s->tx_frame_len, len1, sizeof(s->tx_frame));
         return -1;
     }
     if (len1) {
@@ -593,6 +606,9 @@ static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *desc)
     }
 
     if (s->tx_frame_len + len2 > sizeof(s->tx_frame)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: descriptor overflow (ofs: %u, len:%d, size:%zu)\n",
+                      __func__, s->tx_frame_len, len2, sizeof(s->tx_frame));
         return -1;
     }
     if (len2) {
-- 
2.21.1


