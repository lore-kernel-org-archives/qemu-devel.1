Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF94CC2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9DF227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzuwWUvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9DF227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0vA-0008VF-FU
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0ta-0006zd-Mx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tZ-0007PI-IQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tZ-0007F6-9M; Thu, 19 Dec 2019 13:51:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id j42so7019940wrj.12;
 Thu, 19 Dec 2019 10:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eIBy99noocVmlwSAa63POWN6vKv6FpnLkLhwBwwq9LM=;
 b=rzuwWUvW7fxrR8Q8rS5X13OM54/eLmN+zTAKxDRco/Oq+BgWmNrUIl1hDDIWXer+Fy
 L8YnYjYdzu/VREz33h1DmdVp1ZV1AaGR3fO9NBba+UOJNV1pQdpBbqAuC6dumVMl6qZP
 UlGW6/h5H1PWsw/K4YpyEoRngGgWynIlAal3ptwF+FFioIhDWpw+Nq8o5FPwZrYlr7ar
 RnhS792N/crlExsgvEPRX4/UKZi+f9ovgG6Jb2hguh3dgpmivk+BHr6KLFHkKHrWyiuZ
 1Srq0elLFhgW9+pZ9HOj/JnX1wLx8CeNIT5NUZhw64eSIcTOLtRs4lFRTlIbMI0qA6pc
 JTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eIBy99noocVmlwSAa63POWN6vKv6FpnLkLhwBwwq9LM=;
 b=f8DydsLICYizaAkKFyJFFmJB+Lu4/GBxutH+i2NeRTYCPzGUiatAsi1WtJoFdaSD5W
 XiiofyIQlmJY3gbourO/156bVSCQlSHWgf1Bh22xgurwjyK0fTWGsej0jcrJWnWRQWZn
 uyhvtRNEf2iuTXKGMgL6zvTEc8iRuLnegl/1vz0gSgBA3zWdutVo3SZudvvEkq6JPEtS
 3L+gI+JuHGI7XkK8PoiDRQ9Z0fqkiUhKYcsh/sJ8fgXd0/4+SyHcmiA/ilJmFOFnFWf8
 tnf2KkYiC43kx5jziqrsCbeVd/QXEvhjPOCe2XsMCDg790BTgKE9iMWO/pAzZUwP8q8k
 AYUQ==
X-Gm-Message-State: APjAAAVcnU76KWeiUNlDt/eI6/YzskyYRDTXQZyw5Zxa8GD8mFNLYScB
 drQWW4G6qaQ0mfN4OpTTZzjB850g
X-Google-Smtp-Source: APXvYqznBI30MLzRunuvTH94RbArJIo8XyU1MvwcT9Wtl4G1B96s4+YMJ9L6JV0fFjxe8mEQ6WjUCw==
X-Received: by 2002:adf:c746:: with SMTP id b6mr10451458wrh.298.1576781490780; 
 Thu, 19 Dec 2019 10:51:30 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 01/13] hw/timer/allwinner: Use the AW_A10_PIT_TIMER_NR
 definition
Date: Thu, 19 Dec 2019 19:51:15 +0100
Message-Id: <20191219185127.24388-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a definition for this magic value '6', use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/allwinner-a10-pit.h | 2 +-
 hw/timer/allwinner-a10-pit.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index 871c95b512..6aceda81ee 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -32,7 +32,7 @@
 
 #define AW_A10_PIT_TIMER_BASE      0x10
 #define AW_A10_PIT_TIMER_BASE_END  \
-    (AW_A10_PIT_TIMER_BASE * 6 + AW_A10_PIT_TIMER_COUNT)
+    (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TIMER_COUNT)
 
 #define AW_A10_PIT_DEFAULT_CLOCK   0x4
 
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index aae880f5b3..117e5c7bf8 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -225,7 +225,7 @@ static void a10_pit_reset(DeviceState *dev)
     s->irq_status = 0;
     a10_pit_update_irq(s);
 
-    for (i = 0; i < 6; i++) {
+    for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
         s->control[i] = AW_A10_PIT_DEFAULT_CLOCK;
         s->interval[i] = 0;
         s->count[i] = 0;
-- 
2.21.0


