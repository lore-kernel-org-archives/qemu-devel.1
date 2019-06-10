Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70190C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0F620820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXLJIA4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0F620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9yj-0001ko-4M
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e5-0006RO-5f
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e4-0001mb-3Z
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:33933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e3-0001mA-T1
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:48 -0400
Received: by mail-pl1-x630.google.com with SMTP id i2so2995322plt.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tSiI4G5J5ouiA/gsVkWkdNcl9+jS6pdNMYuFN+MKcoA=;
 b=SXLJIA4Zp8CwkFQXbHy2sNyMHnzkXtWeKzkUthau8uS/Qj9jDwmLpdG7JTsHBIaFUq
 Cg5UH4dVHDh7Y3b9koizvXP9smdjnlK7FMogijxFgdW+bOTMBDYx3kPi7K+Yh4mIg/9X
 VHzGJlZPLVOkqyCRJ5YVxMguKCppJH6fflxdbQuI6biWDpa6nAV4200sO3uXuMLoK6aP
 Ofuhgavc55dIqtrtayxVX9HRRTK8xN3xJEQTLj0whZWl9JLPLsF+J34lC5iXA1qaMAZ1
 eIE25SC1b8doAMadG71/MZsFeBNvd3YSy8IugqKzYct2UQvK7yrSSPu0242kt1vxIS/a
 7hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tSiI4G5J5ouiA/gsVkWkdNcl9+jS6pdNMYuFN+MKcoA=;
 b=aT7x+cdERKevOjHVtwSIsFyMHhmFReyagnzpCbI0OokGGs0lWuGw0p8LK4R1vU4Ioz
 Sg2Coeq8dYzvEu7LOMIEMaW3puJ5x6bD+9x0/4ap5zBiAGhbiV0BVk+bnsdm2wAUvICj
 wIdCc0IF/kyVsp8kKeUZUaZ1PHYDsIt9LLQ9u0xKnLRFtgQ/+FVZCy2IVk03Wd4j0gRH
 rAs0qacZEXxaQICPfBXpM79cVnNJYFoWYJPNmcbvd/lWgUtzdJhiyKkjePbviCglrhNC
 ZnaMXrl/ZAmn8qn62o8laxKg3mSXYI4qMrlREoeUr0qF0/LbMjNEhZkhOd4L2u10nxcO
 dIwg==
X-Gm-Message-State: APjAAAW3tonVIh5KxGKxSlZ1hPPeHYr9cxXgt2UC5UTvDd2myasUYhsW
 I552b/Zwd5egMu+8AswCwXSQqadrDKw=
X-Google-Smtp-Source: APXvYqzjRR0Gry088rgsI7Cj2P480O+tGmAgVI2DJlEdfpW+ONCjy9TOWyAgH2Wn5luhQfRKHHhcvw==
X-Received: by 2002:a17:902:70c4:: with SMTP id
 l4mr32324942plt.171.1560132166184; 
 Sun, 09 Jun 2019 19:02:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:00 -0700
Message-Id: <20190610020218.9228-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
Subject: [Qemu-devel] [PULL 21/39] target/openrisc: Use env_cpu, env_archcpu
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

Cleanup in the boilerplate that each target must define.
Replace openrisc_env_get_cpu with env_archcpu.  The combination
CPU(openrisc_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h              | 5 -----
 linux-user/openrisc/cpu_loop.c     | 2 +-
 target/openrisc/exception_helper.c | 5 ++---
 target/openrisc/sys_helper.c       | 8 ++++----
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 50f79d540b..9e46ac5266 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -317,11 +317,6 @@ typedef struct OpenRISCCPU {
 
 } OpenRISCCPU;
 
-static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
-{
-    return container_of(env, OpenRISCCPU, env);
-}
-
 #define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
 void cpu_openrisc_list(void);
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index f496e4b48a..4b8165b261 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -23,7 +23,7 @@
 
 void cpu_loop(CPUOpenRISCState *env)
 {
-    CPUState *cs = CPU(openrisc_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
     abi_long ret;
     target_siginfo_t info;
diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
index 0797cc9d38..d02a1cf0aa 100644
--- a/target/openrisc/exception_helper.c
+++ b/target/openrisc/exception_helper.c
@@ -25,15 +25,14 @@
 
 void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+    OpenRISCCPU *cpu = env_archcpu(env);
 
     raise_exception(cpu, excp);
 }
 
 static void QEMU_NORETURN do_range(CPUOpenRISCState *env, uintptr_t pc)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_RANGE;
     cpu_loop_exit_restore(cs, pc);
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 05f66c455b..8f11cb8202 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -30,8 +30,8 @@
 void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 {
 #ifndef CONFIG_USER_ONLY
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    OpenRISCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     target_ulong mr;
     int idx;
 
@@ -194,8 +194,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
                            target_ulong spr)
 {
 #ifndef CONFIG_USER_ONLY
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    OpenRISCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
     int idx;
 
     switch (spr) {
-- 
2.17.1


