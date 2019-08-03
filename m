Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B66C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E652087C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSbLBug1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E652087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htzEQ-0003WJ-HU
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5D-0006vd-HJ
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz5B-0007Rd-F7
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:45759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz59-0007PK-J8
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:43 -0400
Received: by mail-pg1-x52d.google.com with SMTP id o13so37653279pgp.12
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=x75zfy++4h7G7+9uJPGHwt0vV9wve8SgXFTPLCjlkks=;
 b=vSbLBug1LuIdmY3e05odA6DONIHNQKBNmeojBFBcQFRAAln5HmcZSfiO3bZML0gPB5
 o8uOagH6fGlOmk8pB3PnoKl7zwdN7KJ1daKWWnv7qLvZ2hpKzvFkKkhywpFiGYe4Pgc4
 H+7HCtNZ41yARIYpZ3zOhQ040U7hPn1sQ7zwAplnf+MjdUdL6jt5VYhNGQuY9GE4yg+0
 3EQg3ZZYJOKjWUJrtrzD2X3w9kldGktifhfDyKwll+jqOD8QSgGsBIkTATiSDCtG9URd
 S4Hg6G47XIilxW10LxvEJvPMtcjlVL8kqZebme30vgQxacppg4ev4lKoDVYHeGPAXsSt
 hrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=x75zfy++4h7G7+9uJPGHwt0vV9wve8SgXFTPLCjlkks=;
 b=TCnPg9Zx1tmu1qb11hIXkDCGjDc2PEjE2VrJf6cxhijJ3X3hZIBUEkiKZQrdWeSftI
 eP1vW8x7mEsn+iSQzbH9A3OG+p/X8Lna+4u6U0wGgw0eUR8yfYAzzeiGbVsZL2DbDfsn
 x7oXizLsyAU1AdBYsvxQSbZ376GBJHLAaUwcpaa5/ILiqRLYVTH7t86IR/GAg+mjIBGV
 x/YwxuG2vGrkoG7Wsr6DJygVEPL9q/2eGgPkKwoCycDdmmjcdQBGc6BO3uJ5/tcWCuoI
 OyKqTWh0S68emQosiAKvX+oGiiZE8OQvOWtmubIk2p2/TPpH7qebWuZc0kq0JhxqenRb
 Xoxg==
X-Gm-Message-State: APjAAAXvivdFjVSaaubgfrmRSGSEuS9o5JlAdndu94mfcTYa18kmAqS/
 2P1MgONNOYAaOcIPHJGnGz9mPqQ+xRc=
X-Google-Smtp-Source: APXvYqxZ2T2wVdpWFl09fwK3nMJTtfcpGyVFU53yW1XfeyIu/WHv9qxSV4TyuvQAJYewR7ay0JP8zA==
X-Received: by 2002:a17:90a:24ac:: with SMTP id
 i41mr10331984pje.124.1564858118408; 
 Sat, 03 Aug 2019 11:48:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:56 -0700
Message-Id: <20190803184800.8221-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH v3 30/34] target/arm: Update regime_is_user for
 EL2&0
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a0969b78bf..d481716b97 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8936,6 +8936,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_SE0:
+    case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
-- 
2.17.1


