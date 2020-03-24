Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495FEC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1063F2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4TQClT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1063F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGqzx-0001Ya-7n
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGqyy-00010W-PT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGqyx-0007hH-Lm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:21:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGqyx-0007fw-6H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:21:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id z5so140505wml.5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CHQaOdNNxZcPioBS4lbMYM+C10vqbguaMyMsuR9H7ho=;
 b=A4TQClT3Jr1yYu94epxFZBwvGhI6RM39KuMrEIyeXucaHUwleisLFRVy3dCKcAu8XF
 U4U1cieOBPFiu6wrE0doBIV8E8sPY7S3TWHgjV2g7tHWXfxn8vO8/lBTjLJfXWlNgJMC
 GpA/92D2aX8xrnZVwoxr2pI97b99I5ZmxgT6Fg2O+NIrZbXr21af2oFS7r6wqq8AEQPU
 g1YzBcDSHohOPyJoAA/uKbzvfKaFkTikDUy6BCU8/AzeinQXDSZ5pbeGzquFlLd6QZzL
 6p+XAJdz99Ql6DDzIlVmOXS/oKnHqjsLe9XsakvjdO8JT2RUZKV04quFH+QnuUjNj5/l
 nQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CHQaOdNNxZcPioBS4lbMYM+C10vqbguaMyMsuR9H7ho=;
 b=KZNPgzoD3utEENrUup1pT5o+hV3l/8eaNyGFCEupNd0w+pN8IByPY6uGcsZocb3VPI
 1E7FUxcWdM8EduMFEaJEwGBkQEhfYt41MQ9c80HAu/nn557dK3REigj4R+QZm/v8Lc5i
 hQumB1Av4jMm7XCslItXJr7/u/PuFIdcTdVpVmFcjrzGxQVifQsOOySN79G5jfKalaet
 dcOV9BjWnRKqLWgprHG7RKyXEe93x5q4TeQb2DwIkWh6dx4ZIiuTOXsq1YAbyEExJG7B
 4MXC4TCACVPT63YWXAaC0Lp+TlPnb7cnNzigzTxZ9xAzjIkvLv1/xNbtOmmKu7UJDs21
 ZBqA==
X-Gm-Message-State: ANhLgQ0MkU2sn+gOD5Zq19LBDxnZWTkAdRhNbqW7nAWZX51yld5Nfpnm
 jTFdZBI5frHxzJqurOkhMrZFAw==
X-Google-Smtp-Source: ADFU+vunHkqKfVy00B6Ds2hN4VpGytkgjFm1UoblXDN+TwxM8XmuOat8Q3K38gJJLXDjwxwCXIVkEw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr7764694wmb.89.1585084865736; 
 Tue, 24 Mar 2020 14:21:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k126sm6139942wme.4.2020.03.24.14.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 14:21:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads
Date: Tue, 24 Mar 2020 21:21:03 +0000
Message-Id: <20200324212103.7616-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out (CID 1421926) that the read code for
REG_ADDR_HIGH reads off the end of the buffer, because it does a
32-bit read from byte 4 of a 6-byte buffer.

The code also has an endianness issue for both REG_ADDR_HIGH and
REG_ADDR_LOW, because it will do the wrong thing on a big-endian
host.

Rewrite the read code to use ldl_le_p() and lduw_le_p() to fix this;
the write code is not incorrect, but for consistency we make it use
stl_le_p() and stw_le_p().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/allwinner-sun8i-emac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 3fc5e346401..fc67a1be70a 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -611,10 +611,10 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         value = s->mii_data;
         break;
     case REG_ADDR_HIGH:         /* MAC Address High */
-        value = *(((uint32_t *) (s->conf.macaddr.a)) + 1);
+        value = lduw_le_p(s->conf.macaddr.a + 4);
         break;
     case REG_ADDR_LOW:          /* MAC Address Low */
-        value = *(uint32_t *) (s->conf.macaddr.a);
+        value = ldl_le_p(s->conf.macaddr.a);
         break;
     case REG_TX_DMA_STA:        /* Transmit DMA Status */
         break;
@@ -728,14 +728,10 @@ static void allwinner_sun8i_emac_write(void *opaque, hwaddr offset,
         s->mii_data = value;
         break;
     case REG_ADDR_HIGH:         /* MAC Address High */
-        s->conf.macaddr.a[4] = (value & 0xff);
-        s->conf.macaddr.a[5] = (value & 0xff00) >> 8;
+        stw_le_p(s->conf.macaddr.a + 4, value);
         break;
     case REG_ADDR_LOW:          /* MAC Address Low */
-        s->conf.macaddr.a[0] = (value & 0xff);
-        s->conf.macaddr.a[1] = (value & 0xff00) >> 8;
-        s->conf.macaddr.a[2] = (value & 0xff0000) >> 16;
-        s->conf.macaddr.a[3] = (value & 0xff000000) >> 24;
+        stl_le_p(s->conf.macaddr.a, value);
         break;
     case REG_TX_DMA_STA:        /* Transmit DMA Status */
     case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
-- 
2.20.1


