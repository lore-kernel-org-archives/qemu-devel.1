Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EBC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D97520725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYCGkTjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D97520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3e6B-0005mt-GF
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3e5G-0004to-LW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3e5F-0005l8-J1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:57:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3e5F-0005kR-BW; Mon, 17 Feb 2020 05:57:01 -0500
Received: by mail-wr1-x441.google.com with SMTP id w12so19135401wrt.2;
 Mon, 17 Feb 2020 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QefSIhzsJ5EzH0dIBGDnIAWhsi6Ouz7g5ZmP1cUfx+k=;
 b=qYCGkTjXajFbzKAvzqglT1rLluAgxi+fFNBav4fwQufVtBhNR1sPNNoqW+6q9RYLBV
 IIMdfwT8pQWCfGaOZYSJ2vp24lRg8dW6IhsqG95H3yIyj5vCUcIP/I+5uc45GPtOgeZ2
 /AZbwAq8ZBskxJ0JsofCa8kM6ax5MPT6q7MBzoGXvZSoXznjGYfmI7r29fBnhxb2Anjx
 KRzsNsiPP0dwAsToccwEnmg9qi+EPQa8X0VuG7ff53fB4vymzB9SXLOOnp3/puW696Tm
 BQyZhA9NNx/c2EaOGwtiaLAbc/sQZTDJWJ9x+t9l3Iv6BdCAaCplNkoo46hLR1F7ghnU
 +fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QefSIhzsJ5EzH0dIBGDnIAWhsi6Ouz7g5ZmP1cUfx+k=;
 b=kNEWfELjtB7G6b0Lo89NqHe6mEzyRRw/FbSOqqsKksCeNnLl4bexAaQpu7VBWaOfd/
 BeYNTrQsYVdBS3/AX+orJOeZjz9mZqOqExy3T+lpkc/8nsiSItXRulZtSgRKRkHWAmj2
 MenRjcSfr1+HmOGlACKfw2LHzDD8iV0mr9PC+UNOggOqfaTDLxywn8CgvjqU1Vfb4/hE
 ZGnqVkb9LCgzAoQPPJFAlmW1qBdYS/blKwgL3Nsnwefp8B9v7SYWS6iSZygOFpd3YDSN
 ZhGa5y/Vj2y9f136PMvRWVy6BV3omBoYh0lujM8qFk6IyziLmuwu6+WfS9uHLzNXPRut
 e3kg==
X-Gm-Message-State: APjAAAVR0h6xVy3njAPGgRv9CXF4JWSDWPeMwDMjUegnvzmepkkfgNLo
 sezmkdXsA2nAxeC8SQE7CMMjBwGMg3M=
X-Google-Smtp-Source: APXvYqzNJhOoVK078PqjEChm7aUSDm0o+pkWvQV8Kaa5UZvzHgR2DDA8FoEuhwGNmhbDES0U1gXHvQ==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr21335146wrs.91.1581937019783; 
 Mon, 17 Feb 2020 02:56:59 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a9sm135149wmm.15.2020.02.17.02.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 02:56:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
Date: Mon, 17 Feb 2020 11:56:57 +0100
Message-Id: <20200217105657.31506-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/misc/iotkit-secctl.o
  hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is never read
          value &= 0x00f000f3;
          ^        ~~~~~~~~~~

Fixes: b3717c23e1c
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Corrected bitwise-not precedence (pm215)
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 609869821a..43cf0f9970 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
         break;
     case A_SECPPCINTCLR:
-        value &= 0x00f000f3;
+        s->secppcintstat = ~(value & 0x00f000f3);
         foreach_ppc(s, iotkit_secctl_ppc_update_irq_clear);
         break;
     case A_SECPPCINTEN:
-- 
2.21.1


