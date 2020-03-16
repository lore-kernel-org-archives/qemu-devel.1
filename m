Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC0C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DEC20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2XyMgnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DEC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuEu-0000Df-1g
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jDtpL-00038M-Bp
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jDtpJ-0002w7-VL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:59 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jDtpF-0002t5-Na
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:57 -0400
Received: by mail-qk1-x743.google.com with SMTP id u25so27753535qkk.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZWAwQTp/Gfu1n4sLpFLUYHmDggD9ePlAuETyYaPTHZA=;
 b=d2XyMgnjt8mOPqVAp4gxUl1Y362/lpkF1zYWUCQbziPYVVRT8LeHUAKo2Sffhp7nUO
 REmy0Tm+Fq3+etN5vTJmn4LXZ2kszMurhramw5MOeiXFaMLBE5jsPnpSD7PfuSsYS/6X
 AUf+0cWu+SFovSyvqCR0aDhV/5w8p2f1AN+HntkluScF2zfmvUIgn6PhHaj5/wY/yZBn
 yAvFXT5NHQLqqM/6Il4dieqsTWn/KYlr6U2DVej871pEks5K+8qBFaVFk4oeANEWy6i9
 8Mn44DYdG4LYuQDqxdHm5cKXWOlxvg3TIdCJX0fmw5eldVKdntkeZ7iA0QCNXdOADBZz
 ZtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZWAwQTp/Gfu1n4sLpFLUYHmDggD9ePlAuETyYaPTHZA=;
 b=X+pvTMS5r24KQPkallE9Lqkx2GwbFB/tCAReSCq3FtwSQnSTcKsXjAC35NbABbXQiv
 9Wo90SwLwXB6p3JaUNUS34EmhV25aWXJe9xt9tUqttd9w/vla8i4MrflGu6l4KBuc8Bu
 9Tgjj4FAq1HPp2V0ntAqg+RKA4MNnnIgvhB5fwvjTBVMC1ejudCavaRFNTt+kg54Q48O
 0sAjDe4Lw90n1DrUblPZgeIxvkE5c9iJMVH/oPE+FNhlgsw8GKKpyddXXZ5BpbsJRa9k
 Pk1gyG2ykZo73IgFCWPMqMXittHz5n2e76ksttlLVuhOCBnDBGfr1+RBCPHP+LuNvJkG
 TJdg==
X-Gm-Message-State: ANhLgQ2YbXu9ZJztNCYdrOddCoSYs/vgdYdP2ZktqGMbddMF3RNgJA8Q
 yAFtZsoivHz/vR3De7AyLZQ=
X-Google-Smtp-Source: ADFU+vtTrTxd7Z8X94zj01lsbOzd2fTLwwJjzven7szZu3X2JkayDYD9BQYxAKoZ8CJG0ix5lkXVUA==
X-Received: by 2002:a37:8ac3:: with SMTP id m186mr852334qkd.371.1584380812842; 
 Mon, 16 Mar 2020 10:46:52 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:7408:9006:8741:9ceb])
 by smtp.gmail.com with ESMTPSA id
 g7sm218422qki.64.2020.03.16.10.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:46:52 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH v2 3/4] usb-serial: Increase receive buffer to 496
Date: Mon, 16 Mar 2020 13:46:09 -0400
Message-Id: <20200316174610.115820-4-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316174610.115820-1-jandryuk@gmail.com>
References: <20200316174610.115820-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A FTDI USB adapter on an xHCI controller can send 512 byte USB packets.
These are 8 * ( 2 bytes header + 62 bytes data).  A 384 byte receive
buffer is insufficient to fill a 512 byte packet, so bump the receive
size to 496 ( 512 - 2 * 8 ).

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 hw/usb/dev-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index ec091b6a36..77b964588b 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -29,7 +29,7 @@ do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
 #define DPRINTF(fmt, ...) do {} while(0)
 #endif
 
-#define RECV_BUF 384
+#define RECV_BUF (512 - (2 * 8))
 
 /* Commands */
 #define FTDI_RESET		0
-- 
2.24.1


