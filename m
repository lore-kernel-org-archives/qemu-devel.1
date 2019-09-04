Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36144C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E9920828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJ71HQIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E9920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cc9-0004O2-E6
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9V-00065W-Ov
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9U-0006ix-6T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:41274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9T-0006i9-Si
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id m9so89326pls.8
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NUB/rqkFfUKu2v7QerAjMtUtZI3FXJ/o9W4GMo7Gy60=;
 b=rJ71HQIaqEkUSz+KMQTIDAlS5TDNBjaTyZSB+VAlpy6Zv5f4wCKn4afr6ClPGN/X98
 W/vLXrqavlnupmZaz6G7zNdCUx1ts/J54iqRSBbRSqqqeLnbYgFVSrmrrfQ/nLBbXsPf
 vgAOo/L6FB/7QcQEaNGWssDg67zAfSKvXnL0FIXLu2WcpkDWFWzIAeuLVGNaQM8RZu/R
 K7hye+ej+wRFHkZpAWEh2Vd/VhyO1vqmCRcQNcAllLzkgN8GUp8ryCM8TmS565F6V47I
 UsOUVlVQnUmV4pEc4zC/vJC3rN/LUvVEJg8cg9ygGw+VV2Jt2kS+VT8p7OHlPRUY1otK
 hNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NUB/rqkFfUKu2v7QerAjMtUtZI3FXJ/o9W4GMo7Gy60=;
 b=uoDkX4Of/MVKvbqNCFbNV1cFvLH5ykQ3p34LLcg4TlQji+zvKiBFDju0tB4XYkIbdH
 +kh9Bu1ZUW4db/k9eIgPhKHfyEiMBD4Vbvg9bX3EbusqWjhDTw764+B6vKM/0v6fuzui
 ASGxFXslQ/nKQJY4GLuELNfMf8K1+g5vzNK+9CChTaPSDrP1jT3Z4QyD1kf0KAUAUSqn
 5UrgSwBurGkCk2x6bXcRQkV7y4BWPndYttsb9hlHNz1OhcrkRaNjwJ5PabBNqw7Klz5n
 TnEpcLHwy2PiRSQ1ZeyMDtq02nCzUr4g0m0vW84ikbe1KQiuqENN0iGfUCjeAp2xxNRS
 fTZA==
X-Gm-Message-State: APjAAAX6oDTC2+fdg2PIxNLq4Zb2Bm8AlJW7/2pLuYAGDbypICXFK5Kv
 xbrVUxXdfDbM+Qy4MdqeT11t4NXQUu4=
X-Google-Smtp-Source: APXvYqxwESrnler3/xq6dF7Eag8X9MvmJxWRbEN6Uwe25yJSt8pElJ79FUbcpwERgizPMnVzsAX6hQ==
X-Received: by 2002:a17:902:a415:: with SMTP id
 p21mr18702282plq.319.1567629914328; 
 Wed, 04 Sep 2019 13:45:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:44:58 -0700
Message-Id: <20190904204507.32457-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PULL 04/13] target/openrisc: Make VR and PPC read-only
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These SPRs are read-only.  The writes can simply be ignored,
as we already do for other read-only (or missing) registers.
There is no reason to mask the value in env->vr.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        |  3 ---
 target/openrisc/sys_helper.c | 10 +---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 561f0f7fad..755282f95d 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -68,9 +68,6 @@ enum {
                                       (reg) |= ((v & 0x1f) << 2);\
                                   } while (0)
 
-/* Version Register */
-#define SPR_VR 0xFFFF003F
-
 /* Interrupt */
 #define NR_IRQS  32
 
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 1053409a04..d20f48b659 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -39,10 +39,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     int idx;
 
     switch (spr) {
-    case TO_SPR(0, 0): /* VR */
-        env->vr = rb;
-        break;
-
     case TO_SPR(0, 11): /* EVBAR */
         env->evbar = rb;
         break;
@@ -62,10 +58,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         cpu_set_sr(env, rb);
         break;
 
-    case TO_SPR(0, 18): /* PPC */
-        env->ppc = rb;
-        break;
-
     case TO_SPR(0, 32): /* EPCR */
         env->epcr = rb;
         break;
@@ -204,7 +196,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 
     switch (spr) {
     case TO_SPR(0, 0): /* VR */
-        return env->vr & SPR_VR;
+        return env->vr;
 
     case TO_SPR(0, 1): /* UPR */
         return env->upr;    /* TT, DM, IM, UP present */
-- 
2.17.1


