Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066FEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FC821D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gt1ubhlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FC821D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHc0r-0000O2-HW
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwf-0002nO-Vw
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:10 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwe-0004Ce-3O
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:09 -0400
Received: by mail-pg1-x543.google.com with SMTP id f2so8059451pgd.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LokPjQNyghrgWvJ1kJqbWazyHqKRlOm6HdtdDxRh6d4=;
 b=Gt1ubhlqQj/dgrQHS3dAMAJVgPNkILwwnw6vl1cIccdKZtEaMiAnNsrazKoZ3jo7nL
 pT1sUWK13y+qE1bfexEO7t88PDk5G91WDrbbLr9alPpwuAH6+7dkgWizAsG2IEDFTJ+8
 GOVW6Q/bkwzYdeFwLh5Q1VIpOp4xsYP06DCDv/FI9RRkurcbaaQsCkl8RBxdsglUJ3sh
 6hjppK3xr43PMXFwSyXFTwIUaawSNQpzHJMqSlmt95dFBtXdZbq+txRhROUwg1Qphq56
 uqwbku1rZLef6Aku1w7wqYHcr/QVYQW8Dnp6PeV4pOFLAcfv0kjgKKug3I5nZvD3sbDo
 /F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LokPjQNyghrgWvJ1kJqbWazyHqKRlOm6HdtdDxRh6d4=;
 b=Fp6SUoLCHTe42rjbMXZ30oDW5bz+O4Yg8f7qTP2vD6nSvVrFG5q9jNpCs7JAIJtd9C
 goTYG3ed9PPgbqOgXN3Mvyce3uPCFey6URjNgi1QLdQcMWDCpc9I1wSmUR7Rl2o6kIMK
 O8Uj/6+M9NyHgz9gF0ZxMJitE0CV3AZvSGAzUBkqCqOuhhNNHQS7OvKFOr8EVa+6lKRY
 j06JlwO3iEIgtQOBFhlwvQ3c6nVEwaYM2XiYWy86A2gIKei/FnAN4p+syOwKh6/GhC3G
 xW6q6GkBr/5jQxQmqZfc8mjnBhW08KCxL6Yi3odMULG2AURO/qMKj97b/mrmZKb6Nxnw
 xaHw==
X-Gm-Message-State: AOAM532guhP0TURl3VpzWk1Sg+z5rp+uGM0Hn4bA289Pk13KpVLYb26n
 3YHRiSwRSSKTG6wYbPKOeFrBE75tSgOFOg==
X-Google-Smtp-Source: ABdhPJzK50LNLDp2cp9fjq/DO4gum+UC9ahfYSlYKKtf8f9SRnck0E/xXAYO4jf0NPss8Z5h9gLyrg==
X-Received: by 2002:a17:902:758b:b029:d1:bb0f:25fc with SMTP id
 j11-20020a170902758bb02900d1bb0f25fcmr8301573pll.40.1600041726466; 
 Sun, 13 Sep 2020 17:02:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 31sm6538252pgs.59.2020.09.13.17.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 17:02:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] disas: Enable capstone disassembly for s390x
Date: Sun, 13 Sep 2020 17:01:51 -0700
Message-Id: <20200914000153.1725632-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914000153.1725632-1-richard.henderson@linaro.org>
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c            |  3 +++
 target/s390x/cpu.c |  4 ++++
 meson.build        | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/disas.c b/disas.c
index 7fb85bbfa8..5e943181d8 100644
--- a/disas.c
+++ b/disas.c
@@ -208,6 +208,9 @@ static void initialize_debug_host(CPUDebug *s)
     s->info.print_insn = print_insn_m68k;
 #elif defined(__s390__)
     s->info.print_insn = print_insn_s390;
+    s->info.cap_arch = CS_ARCH_SYSZ;
+    s->info.cap_insn_unit = 2;
+    s->info.cap_insn_split = 6;
 #elif defined(__hppa__)
     s->info.print_insn = print_insn_hppa;
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 749cd548f0..2a96692691 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -44,6 +44,7 @@
 #include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat-helpers.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -182,6 +183,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/meson.build b/meson.build
index 4839bdabab..82cf4a9258 100644
--- a/meson.build
+++ b/meson.build
@@ -661,6 +661,17 @@ else
     )
   endif
 
+  if 'CONFIG_S390_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_SYSZ', '1')
+    capstone_files += files(
+      'capstone/arch/SystemZ/SystemZDisassembler.c',
+      'capstone/arch/SystemZ/SystemZInstPrinter.c',
+      'capstone/arch/SystemZ/SystemZMapping.c',
+      'capstone/arch/SystemZ/SystemZModule.c',
+      'capstone/arch/SystemZ/SystemZMCTargetDesc.c'
+    )
+  endif
+
   if 'CONFIG_I386_DIS' in config_all_disas
     capstone_data.set('CAPSTONE_HAS_X86', 1)
     capstone_files += files(
-- 
2.25.1


