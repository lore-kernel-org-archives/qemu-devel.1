Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC9BC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4632070E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs9kTHVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4632070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2tp-0000Af-2w
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2sp-0007ix-Hl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2so-0003YR-Ho
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:44690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2so-0003XU-CM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id az3so568676plb.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 20:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KVGu8j9Uoy9WavakRemYI+JFu7Y8Rpjk9OFUdSfPagE=;
 b=Fs9kTHVApCEbaPI4WZcOyz2O377drFdV55STwIItPBZKsoEWxATCbxpYneS5KQwKdU
 dmSir6kglM/k1FG8cDwdq3t7OOl9ARuUHTA8wWIqIDWwFQId+mzvmhV8muZ7nxZkT15M
 cvE3H8QwW6CjtRL548xM2xK8Cg+KQ5O3PXNnB5am7zM4dgqs4xDa8z5F0umAUSuUjNR5
 nc/ZDlGFMOmNU20n1KAbOAAGIK/1uNDDa6Lj5tYhQpgBeVZMgkynwCH5xdvJTAhubH5x
 x6PUm2GnwWM0b77/n2wd4WYdkH9mV98tcWKnWyurZwkb2j6fZXnr2/REpF+/XQ3WTywh
 7krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KVGu8j9Uoy9WavakRemYI+JFu7Y8Rpjk9OFUdSfPagE=;
 b=lkD1vVq6f2r7tTt7Nj3H7Ude+vZYF3GC4YaoeTLB7EqNmy5KZ4yyV1SoTurS95CGEV
 zeZC5ywwPtcgCcK8z4A9zvOgkATpN7cJBIxUddw0Cb5CrEDZBjMVZqdlBWNFpgNXcEcf
 6QHeWdQHtQOPFvg2igSOG5U0cOgPetcmXMpvYBT6mzSeyDLL5bo5YvoPfFDYNO1NY2f+
 Ga/2dRS4fQkNpswRp/w8V10XyoTIBT3lfewvCQtwAhax0vkj4k9ir9KWG+2FucuMChVN
 fELnETYpEKst396s9G3S8WRQYzApLIXPJvc//v4s7VYLS2bPNqSxiEdXPYhSwMFCvESM
 6Q4g==
X-Gm-Message-State: APjAAAW3wF8jkbsz6bI71SE09z+t080t6RyNy1w1Pd4DyQJcPF3wXqMZ
 2Hxnx8sjFkzdL/WfFttU+6HHyccrbjDZYQ==
X-Google-Smtp-Source: APXvYqxeyCqf4ywogqEaMUpqy8qpQNB3SfOP4Fs4v/3evi0OUQXaUaE2NuKr+Wkt0ymqG8fjLitUiQ==
X-Received: by 2002:a17:902:6909:: with SMTP id
 j9mr3315318plk.269.1578457429021; 
 Tue, 07 Jan 2020 20:23:49 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f9sm1192702pfd.141.2020.01.07.20.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 20:23:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] capstone: Enable disassembly for s390x
Date: Wed,  8 Jan 2020 15:23:37 +1100
Message-Id: <20200108042338.9082-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108042338.9082-1-richard.henderson@linaro.org>
References: <20200108042338.9082-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile           | 1 +
 disas.c            | 3 +++
 target/s390x/cpu.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 12e129ac9d..df1c692ccd 100644
--- a/Makefile
+++ b/Makefile
@@ -504,6 +504,7 @@ CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
 CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
+CAP_CFLAGS += -DCAPSTONE_HAS_SYSZ
 CAP_CFLAGS += -DCAPSTONE_HAS_X86
 
 .PHONY: capstone/all
diff --git a/disas.c b/disas.c
index 3937da6157..845c40fca8 100644
--- a/disas.c
+++ b/disas.c
@@ -660,6 +660,9 @@ void disas(FILE *out, void *code, unsigned long size)
     print_insn = print_insn_m68k;
 #elif defined(__s390__)
     print_insn = print_insn_s390;
+    s.info.cap_arch = CS_ARCH_SYSZ;
+    s.info.cap_insn_unit = 2;
+    s.info.cap_insn_split = 6;
 #elif defined(__hppa__)
     print_insn = print_insn_hppa;
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 625daeedd1..1734ad9c3a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -43,6 +43,7 @@
 #include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat-helpers.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -162,6 +163,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.20.1


