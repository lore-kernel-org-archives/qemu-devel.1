Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE3C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A3B20820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT1Xalxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A3B20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haA2u-0006S2-Ps
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e3-0006Ik-BN
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e2-0001lg-AR
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e2-0001lL-4e
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id f25so4142497pgv.10
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pnOBaWOuZI6RQh/0O1nDjt3Ap0L8f++M/zWc9l2w1jE=;
 b=DT1XalxplIcXfF9J5/z+2DSwkPoGtEx64Qvik79+ASBJjsEwdbH2DpqrOzlCu7spR2
 uWVJcVML9UxjwG301o0xk1AG1I9HGTHO04ASgPYj4piQyl+9N7bMFwi0exbBHFWgR48Y
 uVGYwavI+NRgJjNEVO4HpXHaWs4ihl4FXF2wAq/Lv1AwwKUSQPSo6vEtI89Vj2fzLtCe
 cpSfVCk9GFj+yGAYTLHpIQbgNW0PALsQ+ATGs5u6B0acnc7VNlCw+TUldhja2XTW1eWk
 XPLoM7VK0sXzPzWIN4EpJ4fzgAmOMNk65sNOSdgQ50gkI2CkNwILQ4SGEEMVJsIb/93Y
 QTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pnOBaWOuZI6RQh/0O1nDjt3Ap0L8f++M/zWc9l2w1jE=;
 b=NAtOGTGKJaxJQuz5oBjdSPSuYW21d8po2cXNnCxqbR3fATKPn2893jTXJQNe+cY5Fw
 5D/2F58BSkzI5+uwnmeBZZi6g3+pAg3+G+jMasKOWrCBw1ZX3VcyYcBppswt3Anhp/9X
 fIkh2QmKHRkPvYXfKAF1OCmYmFiI4z83eONjBFnxaKtHJohMhmFtyuYcf6Eb4qFNL4DL
 Vode5WJ3yyHbHR/Wc5DE/GNMATVRhe133vn+V5HvmCnfNbNApRDEGPuAVctiR3Kkon0n
 57NxKzmQfQ9OA7nl0LvdjizlgVaMB2uFr38xs3eNuMEqrCSKpRumNVhtS+dpe3/zYUJZ
 tNMQ==
X-Gm-Message-State: APjAAAUV80C96/G87DKFrNisRJ8qF4jZfVBPkuNM/q7TZdj6TZvpzzho
 6bl1zYJ7/naav5q8rg1LNhexShTuK9Y=
X-Google-Smtp-Source: APXvYqzj3nRVPH7UYG52oBTVzzS7kcJpRBXam3yBoUTjlo8k+AYAx5wxm0wGwilGllzBMkOps1BzkQ==
X-Received: by 2002:a17:90a:3688:: with SMTP id
 t8mr2752155pjb.35.1560132164686; 
 Sun, 09 Jun 2019 19:02:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:59 -0700
Message-Id: <20190610020218.9228-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PULL 20/39] target/nios2: Use env_cpu, env_archcpu
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
Replace nios2_env_get_cpu with env_archcpu.  The combination
CPU(nios2_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h |  5 -----
 hw/nios2/cpu_pic.c |  5 +----
 target/nios2/mmu.c | 10 +++++-----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index ae6cf1b4d1..9490ba83e4 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -194,11 +194,6 @@ typedef struct Nios2CPU {
     uint32_t fast_tlb_miss_addr;
 } Nios2CPU;
 
-static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
-{
-    return NIOS2_CPU(container_of(env, Nios2CPU, env));
-}
-
 #define ENV_OFFSET offsetof(Nios2CPU, env)
 
 void nios2_tcg_init(void);
diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 6bccce2f32..9e39955bd1 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -54,12 +54,9 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
 
 void nios2_check_interrupts(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
-
     if (env->irq_pending) {
         env->irq_pending = 0;
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        cpu_interrupt(env_cpu(env), CPU_INTERRUPT_HARD);
     }
 }
 
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 53ed6413b4..9a0bafe786 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -61,7 +61,7 @@ unsigned int mmu_translate(CPUNios2State *env,
                            Nios2MMULookup *lu,
                            target_ulong vaddr, int rw, int mmu_idx)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
     int vpn = vaddr >> 12;
 
@@ -103,7 +103,7 @@ unsigned int mmu_translate(CPUNios2State *env,
 static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 {
     CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int idx;
     MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
 
@@ -127,7 +127,7 @@ static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
 void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 {
     CPUState *cs = env_cpu(env);
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
 
     MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
 
@@ -244,7 +244,7 @@ void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
 
 void mmu_init(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     Nios2MMU *mmu = &env->mmu;
 
     MMU_LOG(qemu_log("mmu_init\n"));
@@ -255,7 +255,7 @@ void mmu_init(CPUNios2State *env)
 
 void dump_mmu(CPUNios2State *env)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2CPU *cpu = env_archcpu(env);
     int i;
 
     qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
-- 
2.17.1


