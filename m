Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACAC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5097207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJBlU/UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5097207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwVm-0004Cl-Ia
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw60-0003YS-Dl
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5x-0006ek-8B
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:04 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5w-0006dS-K4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:40:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id f21so1461288plj.10
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xyookMrLFMxgbzGDAo81NwXe/jFxyBCLMjB+5LZHPQQ=;
 b=KJBlU/UUP8SBSi+VzPmvIkUkhGtVQB9awpc+UO+AKSGHNNuj15qlA8tVnlikOVONST
 s94QogqWLdewu/H/IGopK5ev6QIC0wecSlRloXr0kflk9Ve4oKMccf3hqan6g0/065I0
 5OGuOr6Q33vV7XBDhmgEXs7htIjaC5cQM6YBBr79/xKN2czYtL5uTSGwkmMgHGs4H739
 5XyarLaMOB3i6S3iRHpKtjFMY4cSGm0w7/nPjjBAyNIUgqBNpJDWIFH8PVtpBxkilko0
 YNz0/jNebfol62RshkjJIPlWte4wmn2ycUJMk8WvKAT15VKMi+oU8sngkpRsRYUKX99K
 ZMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xyookMrLFMxgbzGDAo81NwXe/jFxyBCLMjB+5LZHPQQ=;
 b=ciOdE+PQ8d/3Vgt5VaKcooZKj6FQxAXegKuYHghGZDf/sOft8LS8duJLwV6Vvivvv3
 7ofDmxj/qQP4rH53Ar4D/FCyUGFdrBaaj2BVNyRwTL0e8L62rwj76bUHd801hru1vPYX
 EnSjaGErgVpPPWfqWWwUFOCBX2jlMAy6VvoP1DoMzwhqTDW17aNaZZJTeIo5mvbaIYrv
 GEco46u7guO5jgmo511beD2k+CKJC5Byn0h91cOCfLmEPCLjZYL7S9HswIzZasqIVY6N
 tdURex02nDvgerCWS69mAIcJqSNjB8CrA4VWByUUfDZzhTWZaNB/4Nk5ZJEgU92ZXrhi
 5tYQ==
X-Gm-Message-State: APjAAAUKLG7xHXSfHQUld1CM132MEap1GcdN4HRTNZ7ea/q4ryowPn4h
 OwdpVFDE8D+UMctkkPbdfmhOGcs5OPU=
X-Google-Smtp-Source: APXvYqyAOptBsOcQ4U/+xpLe+40YQkImgOByr5UedGgwRH1cpRTaHJ28JGh4Y9cvwxaUIHyFP+Z3pw==
X-Received: by 2002:a17:902:8bc8:: with SMTP id
 r8mr6388734plo.338.1569613198824; 
 Fri, 27 Sep 2019 12:39:58 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/18] target/s390x: Remove ilen argument from
 trigger_pgm_exception
Date: Fri, 27 Sep 2019 12:39:24 -0700
Message-Id: <20190927193925.23567-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All but one caller passes ILEN_UNWIND, which is not stored.
For the one use case in s390_cpu_tlb_fill, set int_pgm_ilen
directly, simply to avoid the assert within do_program_interrupt.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    | 2 +-
 target/s390x/excp_helper.c | 7 ++++---
 target/s390x/interrupt.c   | 7 ++-----
 target/s390x/mmu_helper.c  | 2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c993c3ef40..d37816104d 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -317,7 +317,7 @@ void cpu_unmap_lowcore(LowCore *lowcore);
 
 
 /* interrupt.c */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
 void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index c252e9a7d8..e70c20d363 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -42,7 +42,7 @@ void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ILEN_UNWIND);
+    trigger_pgm_exception(env, code);
     cpu_loop_exit(cs);
 }
 
@@ -96,7 +96,7 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 {
     S390CPU *cpu = S390_CPU(cs);
 
-    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING, ILEN_UNWIND);
+    trigger_pgm_exception(&cpu->env, PGM_ADDRESSING);
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.  */
     cpu->env.__excp_addr = address;
@@ -186,7 +186,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
      * and so unwinding will not occur.  However, ILEN is also undefined
      * for that case -- we choose to set ILEN = 2.
      */
-    trigger_pgm_exception(env, excp, 2);
+    env->int_pgm_ilen = 2;
+    trigger_pgm_exception(env, excp);
     cpu_loop_exit_restore(cs, retaddr);
 }
 
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 2b71e03914..4cdbbc8849 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -22,16 +22,13 @@
 #endif
 
 /* Ensure to exit the TB after this call! */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
 {
     CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = code;
-    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
-    if (ilen != ILEN_UNWIND) {
-        env->int_pgm_ilen = ilen;
-    }
+    /* env->int_pgm_ilen is already set, or will be set during unwinding */
 }
 
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra)
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 768f50a255..839b35fae9 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,7 +44,7 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
         if (type != PGM_ADDRESSING) {
             stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
         }
-        trigger_pgm_exception(env, type, ILEN_UNWIND);
+        trigger_pgm_exception(env, type);
     }
 }
 
-- 
2.17.1


