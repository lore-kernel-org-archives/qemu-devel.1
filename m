Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC4C2D0A7
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C905C21D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STBBIZyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C905C21D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHbyU-0006ab-Us
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwi-0002ua-QK
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:36341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwg-0004D6-QD
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:12 -0400
Received: by mail-pj1-x1029.google.com with SMTP id b17so4429347pji.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NCHT5fgIvwDcF4K56DTDB0FLtjYLg/nKnYjeWLy1ICY=;
 b=STBBIZyczgTwCopMTEJOA+ZySjUp1HsoIwsV4GRrmwl1O4A3bNEpjQcKLw4Jji+3nK
 19vjthoLnaXP7e5lTFjoIDKwTOUlzug3JGrHpfGAnVRmgicUPgRfoshanPiSkUzAfp7b
 v6/AgKhJTVayVCLvxaIJqfbMt18/hLHWPMdYJSVvtVvHnYafjLkiu2+F1pzFN/mzPFZi
 eP9XtzGpFjcxSoVEmbvWA5dYU6XZvxwfzAHWh7RCRwoD8tIsBk2EA3/bTvamuc210Y7t
 zjThwDfWOpsPb/3MZv9Q2lVVNKzTghdAJmWbndZWRetTY2ph3Y7tU9++S4+S91GXgJqs
 IOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NCHT5fgIvwDcF4K56DTDB0FLtjYLg/nKnYjeWLy1ICY=;
 b=RDJCdFuIAgZHehOxGrk18zUwfHL8TK8HfJp33Ywt3F33LV0oj89Fv++WpWCvHHm/Mz
 1VfcmPRaXkF0F2LIkM2MBf0KlhaPBvNFeWKZtO9GRMTKpgFoWM5npZHPAXk4zYoLhbfC
 0Eurlnx89J1B/YEVgpSbTz8+SFWS0zya6bjCWkoLDK/wDsxd6UzVV1RZsEt59ovOHVEe
 FUuZVt+RznORXZkF0Ar+yEORf7xNK9DfyexJsJnn+0Oqj+r84694D2SOouJfKKVlOX55
 AxO/vrQVR3ujZX1Low5CGPEZGriHWIx7Op/o1SPMXTmMCbk7ghPhxGkwsiZXqXDGPWfx
 o+XA==
X-Gm-Message-State: AOAM530bNG8IbKPIvlZfvsLuea1xMCn0hZAEPo5VYWMGA4zCeGI2FQkC
 56+E7HYc4n2Up+2saLZvw9ZQnPYwqhWOHw==
X-Google-Smtp-Source: ABdhPJx990jZk5gxIZprKMEX7IUMmvbFIhns21m/AaoSwQoGwHVVGMm3XLt2EZkZOK2LB/vV/ZZxsA==
X-Received: by 2002:a17:90b:a0a:: with SMTP id
 gg10mr11565237pjb.20.1600041729085; 
 Sun, 13 Sep 2020 17:02:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 31sm6538252pgs.59.2020.09.13.17.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 17:02:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] disas: Enable capstone disassembly for sparc
Date: Sun, 13 Sep 2020 17:01:53 -0700
Message-Id: <20200914000153.1725632-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914000153.1725632-1-richard.henderson@linaro.org>
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c            |  2 ++
 target/sparc/cpu.c |  4 ++++
 meson.build        | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/disas.c b/disas.c
index 5e943181d8..b71d06d890 100644
--- a/disas.c
+++ b/disas.c
@@ -196,6 +196,8 @@ static void initialize_debug_host(CPUDebug *s)
 #elif defined(__sparc__)
     s->info.print_insn = print_insn_sparc;
     s->info.mach = bfd_mach_sparc_v9b;
+    s->info.cap_arch = CS_ARCH_SPARC;
+    s->info.cap_mode = CS_MODE_V9;
 #elif defined(__arm__)
     /* TCG only generates code for arm mode.  */
     s->info.print_insn = print_insn_arm;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cf21efd85f..e0b0a88d26 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -25,6 +25,8 @@
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
+#include "disas/capstone.h"
+
 
 //#define DEBUG_FEATURES
 
@@ -100,8 +102,10 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_sparc;
+    info->cap_arch = CS_ARCH_SPARC;
 #ifdef TARGET_SPARC64
     info->mach = bfd_mach_sparc_v9b;
+    info->cap_mode = CS_MODE_V9;
 #endif
 }
 
diff --git a/meson.build b/meson.build
index 82cf4a9258..b1c54024ac 100644
--- a/meson.build
+++ b/meson.build
@@ -661,6 +661,16 @@ else
     )
   endif
 
+  if 'CONFIG_SPARC_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_SPARC', '1')
+    capstone_files += files(
+      'capstone/arch/Sparc/SparcDisassembler.c',
+      'capstone/arch/Sparc/SparcInstPrinter.c',
+      'capstone/arch/Sparc/SparcMapping.c',
+      'capstone/arch/Sparc/SparcModule.c'
+    )
+  endif
+
   if 'CONFIG_S390_DIS' in config_all_disas
     capstone_data.set('CAPSTONE_HAS_SYSZ', '1')
     capstone_files += files(
-- 
2.25.1


