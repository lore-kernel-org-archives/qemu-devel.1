Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FCEC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D4920820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwIZ90hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D4920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9pl-00006F-ID
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dx-00062L-K8
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dw-0001it-7w
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:33931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9dw-0001iS-15
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id i2so2995222plt.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TkngbE1sypwzNw5h/VQnw7E5NCmBkYtpc+Uhii5AlrQ=;
 b=XwIZ90hB2CIGWSqQcEgNJC4CmbYZApVA+zixo4kT+7ltge4skV/DmOeG61fhd52mn0
 qnXG1fB5s1rUDljJEmh4Yixngl4yuqwDBAZCBv8fuw8Njco8HXN5024VL52jscZrPg4/
 n2otznL32FwvVhJgwHJQKvI9VtgoO6m1gvlPo5xcT+0zwFSEMWZQ5clHn95QmkVxfh8Z
 /O8V0mSgp9vbOe+pZBfWFj3iiVZ/h8WLuQi3mDn5zuzj0mIW4/0iQLDSw7MXlEcJ+DUb
 7soVGz6diYtu0LxfVdchRzzw29vlt3TlIQymqzNDF52D6/m9tcZ0aBZEQr78zNOupNi/
 Obfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TkngbE1sypwzNw5h/VQnw7E5NCmBkYtpc+Uhii5AlrQ=;
 b=ArgAsJ8e7xOQhdMu10EH2w1kwhMlw5DhGSO7+YGlfvvjl72Vzkpda2O+a2vh6irbx4
 oM1QTK/lfWNOk0M+cImaLm+tyn7ubnYbWFGYRwcSjcZtOZTXJfCoiFZE0hicWfV6hX67
 EQ/ySlwbfnnaHXneI2dFBj9KdZYGkNdH1nYxneQOENVIaBz+HNYG1Itq3M7wWsY7vfpo
 AX6ga2mRqfdEAVV0BfrDJQbU4S4bNHDaMNWZu22C7Xh8g6PM7ZR3bqfOya+Xq+Q7EC8h
 Ofqwr10JQCPbhQ4Rp+JekLYtPnFCqCiooirsoU8mTKJDAqwlBFRMnBwjH1DWYx60R5h4
 Me5g==
X-Gm-Message-State: APjAAAUBk2p43Hz0R/BkUirCue0AZbU4JiZN1C9ImuB70whsILeSja9o
 JPOPeBCFqYJZraqS8TnJs0NG9whxM1k=
X-Google-Smtp-Source: APXvYqyoVlX62swd9vNzHdD5JIufxqzSlthoUf0jxON+Ojx5J9twmfj1byo8y4WcqmUsOB8/sb0RYQ==
X-Received: by 2002:a17:902:26c:: with SMTP id
 99mr69928531plc.215.1560132158733; 
 Sun, 09 Jun 2019 19:02:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:54 -0700
Message-Id: <20190610020218.9228-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [PULL 15/39] target/lm32: Use env_cpu, env_archcpu
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
Replace lm32_env_get_cpu with env_archcpu.  The combination
CPU(lm32_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/lm32/cpu.h       |  5 -----
 target/lm32/helper.c    | 19 ++++++-------------
 target/lm32/op_helper.c |  6 +++---
 target/lm32/translate.c |  2 +-
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index ad9452eb9f..7fb65fb4b6 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -195,11 +195,6 @@ struct LM32CPU {
     uint32_t features;
 };
 
-static inline LM32CPU *lm32_env_get_cpu(CPULM32State *env)
-{
-    return container_of(env, LM32CPU, env);
-}
-
 #define ENV_OFFSET offsetof(LM32CPU, env)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 8cd4840052..9f3b107474 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -58,28 +58,23 @@ hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 void lm32_breakpoint_insert(CPULM32State *env, int idx, target_ulong address)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
-
-    cpu_breakpoint_insert(CPU(cpu), address, BP_CPU,
+    cpu_breakpoint_insert(env_cpu(env), address, BP_CPU,
                           &env->cpu_breakpoint[idx]);
 }
 
 void lm32_breakpoint_remove(CPULM32State *env, int idx)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
-
     if (!env->cpu_breakpoint[idx]) {
         return;
     }
 
-    cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[idx]);
+    cpu_breakpoint_remove_by_ref(env_cpu(env), env->cpu_breakpoint[idx]);
     env->cpu_breakpoint[idx] = NULL;
 }
 
 void lm32_watchpoint_insert(CPULM32State *env, int idx, target_ulong address,
                             lm32_wp_t wp_type)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
     int flags = 0;
 
     switch (wp_type) {
@@ -98,26 +93,24 @@ void lm32_watchpoint_insert(CPULM32State *env, int idx, target_ulong address,
     }
 
     if (flags != 0) {
-        cpu_watchpoint_insert(CPU(cpu), address, 1, flags,
-                &env->cpu_watchpoint[idx]);
+        cpu_watchpoint_insert(env_cpu(env), address, 1, flags,
+                              &env->cpu_watchpoint[idx]);
     }
 }
 
 void lm32_watchpoint_remove(CPULM32State *env, int idx)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
-
     if (!env->cpu_watchpoint[idx]) {
         return;
     }
 
-    cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[idx]);
+    cpu_watchpoint_remove_by_ref(env_cpu(env), env->cpu_watchpoint[idx]);
     env->cpu_watchpoint[idx] = NULL;
 }
 
 static bool check_watchpoints(CPULM32State *env)
 {
-    LM32CPU *cpu = lm32_env_get_cpu(env);
+    LM32CPU *cpu = env_archcpu(env);
     int i;
 
     for (i = 0; i < cpu->num_watchpoints; i++) {
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index be12b11b02..d184550a7b 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -16,7 +16,7 @@
 #if !defined(CONFIG_USER_ONLY)
 void raise_exception(CPULM32State *env, int index)
 {
-    CPUState *cs = CPU(lm32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit(cs);
@@ -29,7 +29,7 @@ void HELPER(raise_exception)(CPULM32State *env, uint32_t index)
 
 void HELPER(hlt)(CPULM32State *env)
 {
-    CPUState *cs = CPU(lm32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
@@ -39,7 +39,7 @@ void HELPER(hlt)(CPULM32State *env)
 void HELPER(ill)(CPULM32State *env)
 {
 #ifndef CONFIG_USER_ONLY
-    CPUState *cs = CPU(lm32_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     fprintf(stderr, "VM paused due to illegal instruction. "
             "Connect a debugger or switch to the monitor console "
             "to find out more.\n");
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index f0e0e7058e..b9f2f2c4a7 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1053,7 +1053,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPULM32State *env = cs->env_ptr;
-    LM32CPU *cpu = lm32_env_get_cpu(env);
+    LM32CPU *cpu = env_archcpu(env);
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
     uint32_t page_start;
-- 
2.17.1


