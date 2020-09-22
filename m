Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D983123787
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoGWuQQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D983123787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmUg-0006Vu-S3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOi-00083l-8j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOf-0004LE-Ix
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:11 -0400
Received: by mail-pf1-x443.google.com with SMTP id n14so13132364pff.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aVjTTGPPlbmxoAcKrlyikOZCYood3q70I0b99WJvGvs=;
 b=JoGWuQQh4GyTFG80W0ad4QgGXomABnZrYUmNNBkOnzd6xAoDYva2pCvPoh3/+zfkzB
 OLBmmp3gRZlxtizGgGofh/b4yBKZt6uQ3ubrMhk8F25N63y2K5i4O1KfIhO6g9cByGbW
 CMWCdlec6XWceOIU2b/Q9aYTyyro6U6t+NH4CkZuq1YaOtkLRRcjj5ockRz9kXMzFwHK
 ayAC8zPaShvkml4mtM+LpXJiQ6qTilSCbqNzN+Ar8PQI9PghUkF/QsUHhm72rIkmsxrR
 MwHwvVayBnE+Rpk4sPq53fHrCl9/fak1H9+zGIOpdX3/mGSdV4aZDCmZXBzBeMhDFAJG
 9lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aVjTTGPPlbmxoAcKrlyikOZCYood3q70I0b99WJvGvs=;
 b=BDggHLlnts8IB0NlCxI9GcxZxfVAZMpLir3iJ+u05XwaknLZIk92Cc2vyCiowjgLaW
 jc6JX82Gif+huL24yIcDxbk7Av4VJcoBQPpyo81HiAlrxT/ZonwnWk8OUiShfv+XZihE
 bb7UzbK3qk/FMVBokqqRlBdgSy5oBA8E5aDVAnmU169jeLrPQKQVccJMfgsnl91rq5Y3
 lkrYAOaaqoffF8fY7mVphW7mDg/tOoTzpXHnivpSSUpUZkA63NdTajB7wKHTyRPBUcRd
 5+wKvJa8aHlYfZDhGolJrouKxOKEDC17HtexlgpJf15d8jnpfjhFzxPjCQhWxYtuThBU
 3rWg==
X-Gm-Message-State: AOAM533oVpJRM9bzQaUgQgxWOb1pGWAawgUFB/DPwTxXSVw5hVbiaHf1
 oSXT98FcsGrKHGBfs1XqUw4TBT7OPXY9xg==
X-Google-Smtp-Source: ABdhPJw3mu5ZsZ1eXAcqnN6IfCddtZj/M20oSQvxXkxxGVUS1iHPl+faUM3sKW+XiRnrU0Ud2M3blg==
X-Received: by 2002:a17:902:9301:b029:d1:cc21:99d0 with SMTP id
 bc1-20020a1709029301b02900d1cc2199d0mr5905070plb.25.1600796876513; 
 Tue, 22 Sep 2020 10:47:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] disas: Configure capstone for aarch64 host without
 libvixl
Date: Tue, 22 Sep 2020 10:47:38 -0700
Message-Id: <20200922174741.475876-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ifdef tangle failed to set cap_arch if libvixl itself
was not configured (e.g. due to lack of c++ compiler).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index 54a540180f..cafd063d42 100644
--- a/disas.c
+++ b/disas.c
@@ -430,9 +430,11 @@ static void initialize_debug_host(CPUDebug *s)
 #else
 #error unsupported RISC-V ABI
 #endif
-#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
-    s->info.print_insn = print_insn_arm_a64;
+#elif defined(__aarch64__)
     s->info.cap_arch = CS_ARCH_ARM64;
+# ifdef CONFIG_ARM_A64_DIS
+    s->info.print_insn = print_insn_arm_a64;
+# endif
 #elif defined(__alpha__)
     s->info.print_insn = print_insn_alpha;
 #elif defined(__sparc__)
-- 
2.25.1


