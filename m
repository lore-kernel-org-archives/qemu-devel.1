Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22ADC4347E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F829216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVZFklJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F829216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPx2-00005p-VE
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPov-0008BK-4R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:47 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:33639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPom-0000Iu-Ge
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:44 -0400
Received: by mail-pj1-x1041.google.com with SMTP id md22so243571pjb.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J+BOVOHGD/QEo5qK+coXTJ7fUE4O+DKxbUmsuQDQSc8=;
 b=yVZFklJCySAXao2GaMbnYtfDemeyeBrlYIN7T5twoToUNRHb2fG6yU2bPxOnHdraar
 3AE6kwvngR0yMzWfbI4w3NlNkTd0AyDgu7ejpQEjIMiQHXLYQHZnppI3GTZPrtCg9SGr
 Qo0v/LU1OQeLbuC0iik1nGHFdzUGRbnAMp3R0TWIqFLlyKcNis4OCqnGOBHCxNT87lHM
 LEfGfQdwtiucEFmlSLV1vtoYbk0rAHgo5s7BQwXzgsnJFSk4Xf2q19YwpnrR9y8LFOHv
 D1+Qz3CKQlc5JOmtug8a2TLwlXHNk76KAY4NzM6/aoR5kkPN9+8nRKySqw5KD6y4aIs5
 EekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J+BOVOHGD/QEo5qK+coXTJ7fUE4O+DKxbUmsuQDQSc8=;
 b=ahp/HxX1VmIanpPGbfmSRR+d/jR0NTJU9Rl4GbZWhh922gd45LvO9fr1aEsyoiyVZG
 qse8sPwTA4x7Z2oQMuF2e11gd4fpR8EPFN3pauJoNsna4pg/9L6AfP55Uz+WlnCKzYoe
 UYMDVTnN+EbsjddPROVcRLTPpjMDGzwk2eEaRoEH9xrhbnIUHKAmi87JRFyLpEZHO8J4
 n/OmLn5iveelFP8sJlSR4xGcfai3s6q+XQH3nWlCEY6URAAJfUbk/mp1zgkSnyaxbFkY
 J/eIhoLER0Wv6e7mfxpX4f82NXdlRegi6Ns1Ja/fcFbyuKcLDFhLkmfH/2kO0wcDCsjl
 CeZw==
X-Gm-Message-State: AOAM5311rpFQ2vkPHXWKeAM/eJzX1CRxuspLlEFLv1V47uY0/j47baMe
 U/stKK4YetjCLbkVkN9WoA9hPk4+OV06mA==
X-Google-Smtp-Source: ABdhPJzT4uijQ8mwrvdGxBFzrHityhvl0bPPlmhe6TqOeZnqggiLD/K0g0bKySVHrpz5aen7TunLGw==
X-Received: by 2002:a17:90b:350b:: with SMTP id
 ls11mr392341pjb.201.1600710092199; 
 Mon, 21 Sep 2020 10:41:32 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm12585379pfm.86.2020.09.21.10.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:41:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/11] disas: Configure capstone for aarch64 host without
 libvixl
Date: Mon, 21 Sep 2020 10:41:15 -0700
Message-Id: <20200921174118.39352-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921174118.39352-1-richard.henderson@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ifdef tangle failed to set cap_arch if libvixl itself
was not configured (e.g. due to lack of c++ compiler).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index d0ccd4b727..01c8bc6c9e 100644
--- a/disas.c
+++ b/disas.c
@@ -428,9 +428,11 @@ static void initialize_debug_host(CPUDebug *s)
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


