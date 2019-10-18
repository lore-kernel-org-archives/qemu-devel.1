Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE13CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03699222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pATM9ssF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03699222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWX8-0005pT-TO
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ7-0006oz-U4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWJ6-0005cl-NH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:57 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWJ6-0005c9-I8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:56 -0400
Received: by mail-pg1-x544.google.com with SMTP id r1so3739500pgj.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iym+ywFHjEBpwuu12wdHsU0gouX4jDUf3/+DDNH9pyk=;
 b=pATM9ssFkxdigDI20QfMiusWkLq9ZFxqjeIY84nbG+ObLMz20Bk5mN8NBKXHLAtYCK
 SqSxE4tOdn6VrESxF94B1nPMlHxkEi+ROiz9wEXeruDUOJvEz1m8LPuvpAgiE27FzrcV
 Q875XXTvOR1tnKjLjl6hkAg7+a/SL9rt+XXKaQM/1Xzf4QovmWHlpMpCvx6lmxD2tdcI
 uWbYbNHtH27PEHBekoL9PEDQM8qatIauBE2asth1uVJ7PX9CPQvtyZwRWAnRNRa0JMJN
 S/uEHGcknS5SONOXKK+djAeyziJIJQtNLLqBrX+WCcrKNMivoe8f6qB+rKJvL7SoXwS8
 RZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iym+ywFHjEBpwuu12wdHsU0gouX4jDUf3/+DDNH9pyk=;
 b=XWMevuYojBWFxaTOfZ01/itFW90111sU8D292cWS9SAyDQIFjEZQJAvnN0ffWjr2wx
 kvUurmuyld4GO9Qrg1+AdsCdDAkvIZeu4Bl28mQZJxMDJ05GPtVA+8Ud9VdwGgKpL/Rl
 E+lnh8wKkN4UPVaoxJMp1d2JDTp6hseAmCvOzEe7XXUqNcdTOJf/AR+DVloJjiq/A3I2
 FOiXEm5fQ9BSJdKIMkAoZmXmnCgZQ3nE/eD/I1bhMg16rNv/TA8yB25X7tP69IF5Q4PX
 vdpHYX2P6aX9Q16jktwnbijWUUca/k7FK4zSJk+hwSZpLdheJtUfBfmKYtGBzhCD00WC
 wCLQ==
X-Gm-Message-State: APjAAAXOy/0ixdaka+LGr4oXjEYg6ufi5u66ZvCIeRxplJycc2GcIqEx
 CIl+YeGCZ/iElURWIcnAud5T6/n7J1k=
X-Google-Smtp-Source: APXvYqyEZzJOoYjgY/4/WGnJED6vZ7cCjAez8SeGJXJL9TZ01Ntz0/7YiyycHgQAIRi33qr1X9UFlw==
X-Received: by 2002:a63:3104:: with SMTP id x4mr11264412pgx.135.1571420695215; 
 Fri, 18 Oct 2019 10:44:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 18/22] target/arm: Rebuild hflags at CPSR writes
Date: Fri, 18 Oct 2019 10:44:27 -0700
Message-Id: <20191018174431.1784-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ccc2cecb46..b529d6c1bf 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -224,6 +224,7 @@ uint32_t HELPER(usat16)(CPUARMState *env, uint32_t x, uint32_t shift)
 void HELPER(setend)(CPUARMState *env)
 {
     env->uncached_cpsr ^= CPSR_E;
+    arm_rebuild_hflags(env);
 }
 
 /* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
@@ -387,6 +388,8 @@ uint32_t HELPER(cpsr_read)(CPUARMState *env)
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     cpsr_write(env, val, mask, CPSRWriteByInstr);
+    /* TODO: Not all cpsr bits are relevant to hflags.  */
+    arm_rebuild_hflags(env);
 }
 
 /* Write the CPSR for a 32-bit exception return */
-- 
2.17.1


