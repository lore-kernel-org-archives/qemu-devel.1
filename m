Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0744DC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810962083D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4iMCK46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810962083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9vU-0005c9-H3
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9dv-0005yX-Ot
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9du-0001hL-5P
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9dt-0001gu-Vg
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:38 -0400
Received: by mail-pg1-x542.google.com with SMTP id n2so4138631pgp.11
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3eEZ43+foZOHsJH12yR7I4WMYSzG6ykvnQtbtEqnbDs=;
 b=y4iMCK46fou//0dvO3QeI8VJzW4RRzH4DUEGmDNTmMOSPM+qXl+ni6r7ioZzBm0m1L
 cltVwvtZ6gMe4Fay3Rgco9MRR/p0epfV7mY6nSJiqcnD1k4pMDKX+oL99u6G3E4HuSPk
 EqJwbZ9gigu5a8dY1r+mPyO5J76ELYyMdymTdrSgclpnb5zq7L9kGqvok6i/yxKVvZ5m
 5ztrZy1NjIbmaqOfaZ7jlhgauzPX+TqnNf8LNDC4xVtw1QyKQFcjc4QW3P0FoHZLy1jM
 DKoVvP72p+15ffVCLP4p7V5/lNGK9/Y+H27eqOdyw2gXBA6Y9BRPEEFhWhMSVRu9STS6
 4Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3eEZ43+foZOHsJH12yR7I4WMYSzG6ykvnQtbtEqnbDs=;
 b=Ol+SR9htnGleY/EIvMaxuWneg6SjxWsKhlB9QJzGHgtu8c3UDflWEgbro4L3jjEF2l
 kx9VrWpaR2hkUe45gAvOyvEBMo/5qnms0ru35WjA0Fb8jLeRDQsO4mKRERmOMF8Ha89X
 XXiQX08oTYBD5v+fYw3sGBSOhvAbjdGeCkkhspe01bVyZuPUSxy4wJ57zFu5AcbTDRX2
 Ls/JBxF2xDgWrIj/0C+a6XqGkhWoXLvzRH0iambppUZj5e1Vn9penG3ZBN3WPwO3slYf
 KN44+pQE/NHyqhkhNHNpvEQ+ONHV0N6lvM6Q1lQNYlC0kFEusWGqy0Fj4R2u2Q3bFUEH
 c5Ow==
X-Gm-Message-State: APjAAAVPKOM58Ga50WoyUYcK+W28Bg+yhwmkvfl7Oe1rjSZg8ZOpdRdr
 FFwkTAqjD/XOS2FnEv4TXtUnox+cLa4=
X-Google-Smtp-Source: APXvYqzbTDOi4k/TVhstwk6ccKU+XHKQmkUIcxZyvV8lnvrPyfxUxI4oBOE85NMUAwysgF0AtvK0yw==
X-Received: by 2002:a63:4a20:: with SMTP id x32mr10619243pga.107.1560132156372; 
 Sun, 09 Jun 2019 19:02:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:52 -0700
Message-Id: <20190610020218.9228-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PULL 13/39] target/hppa: Use env_cpu, env_archcpu
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
Replace hppa_env_get_cpu with env_archcpu.  The combination
CPU(hppa_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h          |  5 -----
 linux-user/hppa/cpu_loop.c |  2 +-
 target/hppa/helper.c       |  3 +--
 target/hppa/int_helper.c   |  4 ++--
 target/hppa/mem_helper.c   | 10 ++++------
 target/hppa/op_helper.c    |  8 +++-----
 6 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 0cb1fc8800..75e6a91a5e 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -222,11 +222,6 @@ struct HPPACPU {
     QEMUTimer *alarm_timer;
 };
 
-static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
-{
-    return container_of(env, HPPACPU, env);
-}
-
 #define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 880955fdef..9915456a1d 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -105,7 +105,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
 
 void cpu_loop(CPUHPPAState *env)
 {
-    CPUState *cs = CPU(hppa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     target_siginfo_t info;
     abi_ulong ret;
     int trapnr;
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 11c61b3ca2..0dcd105b88 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -71,8 +71,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     /* If PSW_P changes, it affects how we translate addresses.  */
     if ((psw ^ old_psw) & PSW_P) {
 #ifndef CONFIG_USER_ONLY
-        CPUState *src = CPU(hppa_env_get_cpu(env));
-        tlb_flush_by_mmuidx(src, 0xf);
+        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
 #endif
     }
 }
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 8d5edd3a20..89241c31e7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -77,7 +77,7 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
 {
     env->cr[CR_EIRR] &= ~val;
     qemu_mutex_lock_iothread();
-    eval_interrupt(hppa_env_get_cpu(env));
+    eval_interrupt(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 }
 
@@ -85,7 +85,7 @@ void HELPER(write_eiem)(CPUHPPAState *env, target_ureg val)
 {
     env->cr[CR_EIEM] = val;
     qemu_mutex_lock_iothread();
-    eval_interrupt(hppa_env_get_cpu(env));
+    eval_interrupt(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 0fd3ac6645..b12c5b5054 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -56,7 +56,7 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 
 static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
 {
-    CPUState *cs = CPU(hppa_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     unsigned i, n = 1 << (2 * ent->page_size);
     uint64_t addr = ent->va_b;
 
@@ -329,7 +329,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 
 void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
 {
-    CPUState *src = CPU(hppa_env_get_cpu(env));
+    CPUState *src = env_cpu(env);
     CPUState *cpu;
     trace_hppa_tlb_ptlb(env);
     run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
@@ -346,17 +346,15 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
    number of pages/entries (we choose all), and is local to the cpu.  */
 void HELPER(ptlbe)(CPUHPPAState *env)
 {
-    CPUState *src = CPU(hppa_env_get_cpu(env));
     trace_hppa_tlb_ptlbe(env);
     memset(env->tlb, 0, sizeof(env->tlb));
-    tlb_flush_by_mmuidx(src, 0xf);
+    tlb_flush_by_mmuidx(env_cpu(env), 0xf);
 }
 
 void cpu_hppa_change_prot_id(CPUHPPAState *env)
 {
     if (env->psw & PSW_P) {
-        CPUState *src = CPU(hppa_env_get_cpu(env));
-        tlb_flush_by_mmuidx(src, 0xf);
+        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
     }
 }
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 952e97a7d7..04d23c1b22 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -29,8 +29,7 @@
 
 void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit(cs);
@@ -38,8 +37,7 @@ void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
 
 void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit_restore(cs, ra);
@@ -630,7 +628,7 @@ target_ureg HELPER(read_interval_timer)(void)
 #ifndef CONFIG_USER_ONLY
 void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
+    HPPACPU *cpu = env_archcpu(env);
     uint64_t current = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t timeout;
 
-- 
2.17.1


