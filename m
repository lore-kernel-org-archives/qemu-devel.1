Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A20B21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9PAL/5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A20B21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL738-0008RX-L9
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wF-00063N-6X
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wD-0004XC-3T
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5wB-0004S9-21
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id y135so7060002wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s/Kxt0sJmOqiRHlmaA5zdwUg0XEvdkyMNiTJ70WsIM0=;
 b=F9PAL/5DGoW202thTWt9PWQxH2Va6V+qW3obqzm+cyizfruo8mxHofOSPKLN3O4JVV
 o2Bhjq1knxePZW2mcPuJB89gxWzQ6ZLINNQh+JfoElCH8yXwzD3IY5mcXrQ7f7QUbUr4
 /slst1r/o8Pb9AaAdsJQQUsA7eR3NzbLK4nGa1aYH0uLFxCRSr3soHIsThhDOD+KlfRw
 +m7BUTOdLO4bRWmrfmwNrV/ksxEpa9g66tLUO+VV8Hn/awtasfu6X7fEQHSllRXGUu8Z
 TphT5UJzYytFVT3WGEcSO7SpFHIpvkrbI0ES0mWiqs4W4gxypJHEp69L7+2flq+KOphF
 7Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s/Kxt0sJmOqiRHlmaA5zdwUg0XEvdkyMNiTJ70WsIM0=;
 b=irwYclXUVoih2XWc7djLbDyLutTGYup7ZosAmVlcg2Ofq/UE52z2iHM4aZkRa3IT8o
 PBtJAHob1dU2i+SJc0sUOdg7ouDOdQet5zX4KmJuGzRe8RKhIkbrfKzmP9kyrFMjhmdy
 Hst3TXjBXHmu3sKGaE0PKtDfIOA7nzVAldBgB4HAnRy9roSC1igfTB114CrGYb5/uYkp
 rAyZZZXnRfR/vLwsHe4fZYb7/+Vjr4WK8RuVRwj27QUng4gb8ReeIBoBAIKh0abPUhzI
 0/OhpUP47wDtsPUcHutiUqp4PhLWqhY2UQx/VO01dD2VcwUmN6Po65qMQQDLbrJEWn3k
 fEfQ==
X-Gm-Message-State: APjAAAVAlGh94/Aut3H/lZ197v209gE7NONZExnhbM+5+LLXBdpra0lW
 nOyV/pCJAgvvdd/eRPOJzKyw9Q==
X-Google-Smtp-Source: APXvYqx4JGfHif4/2AcaGYvtdAnhy+zOLYAgLl7sz280vt5bVVW3Fpv/Mh3XV4x0ZzcJ/N3QLfEfBg==
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr2876832wmd.67.1571319328436; 
 Thu, 17 Oct 2019 06:35:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g185sm2319343wme.10.2019.10.17.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8E0D1FFB5;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 31/54] target/sparc: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:52 +0100
Message-Id: <20191017131615.19660-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c68bf4a2e4..edc23a7c40 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5884,7 +5884,7 @@ static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     CPUSPARCState *env = cs->env_ptr;
     unsigned int insn;
 
-    insn = cpu_ldl_code(env, dc->pc);
+    insn = translator_ldl(env, dc->pc);
     dc->base.pc_next += 4;
     disas_sparc_insn(dc, insn);
 
-- 
2.20.1


