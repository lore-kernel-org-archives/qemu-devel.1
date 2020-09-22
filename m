Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6364C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A48C2376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chAcqkeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A48C2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmjg-0001Xa-Nn
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 14:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOj-00085p-7f
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:13 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:42618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOe-0004LT-DA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id d6so13132774pfn.9
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7lTlFlivfAiJTzCGws6plI8BPc5bxV1RgMbX8sbBRYM=;
 b=chAcqkeAXTZdqMfGFWd4pzCHuQZp/ko/3zd5B3wn9SFMg//uFw/yYjqyOFEBgbY6jA
 IaWQiFP2EcfebDOI6/kV8h+T/lmI6yLtvBzOpWmxCOiRxzmDxvff+etN/Llw4j/05kqZ
 uEF5X/pwzycv8DM7eHkzJeD6VEZsy8I9G8lZQrRjq04jTHfuJK2QInHB6Bd5PGqbRYbE
 deRFj0SeErudf/entQQMGEQsEbESYqqqHvEpfFvKzbfTagxcnVLU+yQXy8DVA7OcoBxn
 SMZTxsqqGdswpYkHT+LIwxd8u/68swr2LgoiflI0kpzMPoo3e3yEz8tPGuvIZBPmsKpk
 /RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7lTlFlivfAiJTzCGws6plI8BPc5bxV1RgMbX8sbBRYM=;
 b=TYmVcb0PEo8GaBt8MTy9+Wr+7LVGSsfJ5mEgnfW55zHUBREG0PNrwrGr35GKIlDWMn
 fxcCUPGT/tc6zDwQu/NwW/0lMzt5Y1V6pdCkPSWFOLM21+vGEXzDM6qtwl1ytDF57ncl
 pJ5DMpUjYeuL8UrqjeQ7zZ/6SOTWz6PjF8yttjZNBo79gEkeHlr+lNaDP8R9BCJ2ESWs
 I5PtG8jGbghI5LYZN3orcAipL2sWq2xCEPxEVHG6dmOnnGsbosBE0od4TCEsIBSbhRxG
 HvZfHUY9ThqRS5GATBG0pLgoBZjFS9vunH9I6b3cHM0p0GzZWHVrxaGCe48h93uodB2A
 4saA==
X-Gm-Message-State: AOAM532LNBbK6tb+jlvAkFVWhPgSZ6DTe56Qabw7sd9tZ6qrj+e1ryGc
 UCJk3AQIRN6qZuo6ehYbDVQl7xzuaB3BwQ==
X-Google-Smtp-Source: ABdhPJwkuSTFhb4ui8LhVYCjG3aio1nPQPQymTuO+bQ/cseGKv2iRvKL86TvGOUx4+khMy8BBi8gZA==
X-Received: by 2002:aa7:9093:0:b029:142:2501:39da with SMTP id
 i19-20020aa790930000b0290142250139damr5082511pfa.41.1600796879744; 
 Tue, 22 Sep 2020 10:47:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] disas: Enable capstone disassembly for s390x
Date: Tue, 22 Sep 2020 10:47:40 -0700
Message-Id: <20200922174741.475876-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build        | 11 +++++++++++
 disas.c            |  3 +++
 target/s390x/cpu.c |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/meson.build b/meson.build
index f06e3a1b65..d9f021837b 100644
--- a/meson.build
+++ b/meson.build
@@ -670,6 +670,17 @@ if capstone_opt == 'internal'
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
diff --git a/disas.c b/disas.c
index 9dfbeededc..7c18d7d2a7 100644
--- a/disas.c
+++ b/disas.c
@@ -203,6 +203,9 @@ static void initialize_debug_host(CPUDebug *s)
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
index e350edc9f5..f21b1f7795 100644
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
-- 
2.25.1


