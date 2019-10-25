Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290E421929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvqRnqz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290E421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtoU-0001hO-TC
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN7-00088R-Vk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-0003Hm-Ty
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN5-0003Aw-D4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id r141so776628wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jFa/hOu9KHZ8ebr83jt0r9dYBdNGFT8yLTa2Nx/5eIw=;
 b=lvqRnqz98JlEd9uvJ5JM9/fjGz10OL5WoKXPl7IXscz4f2YbppADPoMQl48ELI3LLJ
 ySAJtlJ46mVQGFEqxG1VEGx0eA1K2nKs0osMcmMy7C4bCnvKeJq5kCcp3TLdsgM0qTnh
 AmVGZZJcvxr6fIgOqmoT9aMjL856SdSzbOowNzlsDjj+Jm3ZHouKRGuGByo8IR5f4lNs
 b4jO6bjGWxX7Fd1Hso+EJUx2R9tPXefjDj3G3li7+oVZTjx8FlcMNkHBXvxeblbjUU6Y
 pt+Ya+AG0bJbwvG04oz+bgmb1i93V0Cya6WZi+l84Pv94hhoIKlhZk6H39E6c7ZBVRs9
 I8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jFa/hOu9KHZ8ebr83jt0r9dYBdNGFT8yLTa2Nx/5eIw=;
 b=tvZP2MZK5xXhALmbYaDdwQ0bf46K6yY1kWQNBK1z9khSsjqKvhA6/c0rijv9i36CmZ
 G6iFsrzvYNowI2XoxPmjtFFzR9sm3QAWidMnylUABm7G/kWykNInaR9kYpWKlVkt13Lr
 RqNIf3H0meea08LYdx6gMptVk5L5e8R0gdKXANB4Nduv8LGnYYiigqX3IyNt9ii5pEcs
 DT2JBAGR9PQoY880nD+aY2cbUd5tg6xSHU62Id7hJ+cne8Khn4Z5XoSqD9l5aNAdv0/X
 nTZwi4ag1Kbvv8hztvUjgDM1eDjppdMu75wpb5XunrlBJQG5UHaeE+/1GwryuvWINaiX
 pKIw==
X-Gm-Message-State: APjAAAWhmZQnXxJli4BijbAjJYH908dsJu+6pyChfgdDrD4kL0bn2Yn5
 Dyp8Iy3tOgpTCHYBI81pcF8sLQ==
X-Google-Smtp-Source: APXvYqyO2tAj8BQM129jh4p8flP6326/sfjNBHEwppSzHbS09lkzu6M5tPL1hdO5AMt61D7lEa5crg==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr1920672wmi.161.1571986000366; 
 Thu, 24 Oct 2019 23:46:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm1136373wrs.66.2019.10.24.23.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B0AC1FFCA;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 50/73] target/openrisc: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:50 +0100
Message-Id: <20191025063713.23374-51-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6addbac8d63..8dd28d6cf17 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1645,7 +1645,7 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
+    uint32_t insn = translator_ldl(&cpu->env, dc->base.pc_next);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.20.1


