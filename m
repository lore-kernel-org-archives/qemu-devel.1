Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A40C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB9620637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFlOqtGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTtL-0003fU-Sf
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj7-0005Hp-1n
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTj5-0001wE-Mz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:40 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTj5-0001v7-HL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:39 -0400
Received: by mail-pl1-x643.google.com with SMTP id j20so3066369pll.6
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vOc7ZuIgleZgJxOlgoEqlYtRf9AKklvLS59uoi/QsS0=;
 b=IFlOqtGfWq1iMqXTuyU+3m+mptLlC2hlRPuPsNrGog1gzbkUfb5GrqXKWOdGFXhFtR
 CS3dEV1SDG1POMqJyfNr4YxNdTgRd/hKwrm0rSZ8S0s/Oe5h6tPvJWPzVqsC0X2A55Dg
 YjhYUjr4VcBD4F0T7ZCBGsIDhCRxB6/OBIua4JRZp0O/TGetRmEIsTGF5mYFxIsffClg
 WPFnbDIQIG3DauiIUaM8/NK/EIis+nILn60G0z+/wDt7OHWIkjEOXKFB7sLB/1d1PllH
 78ma0/nXlNv68oCzM5bc6SkIhaAA5f+H9ogHB/hXEAByooSrGTkDNxfCx0vbS2Css1R5
 Xq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vOc7ZuIgleZgJxOlgoEqlYtRf9AKklvLS59uoi/QsS0=;
 b=sXmFRYqXICS1Er15XwTYsoC7wmZ/Rbv42gGBN5bMiHSK5+Z9hiDOtthhJhWCzkD/cN
 7Ryn+Z7kJRGYxLj4PAsPApea50/2L63UtrnByHaruV+5TPKClxEQcqFABFQFOjJlglOc
 yn1G2ICWS3kjsp5JYVnMm47/dSUOnPVV4tu0n51oiRbULNv75l9HhBnYAhoQOs2y2SDa
 i+S0SSUXEKnxSCV29T0Je9ykLY0xq3lSI9bMW92RbTswuhZMuz2Q5GnQjduFAH9cfF0c
 8JyYcX6w1Ee29pUY97hPwkQ7lQHIq8gJYhL9NuG/ahHJeC0LKPHL6i6KQq2H+DyiLXy0
 qB1A==
X-Gm-Message-State: ANhLgQ1zKBbp9Q21Bc+VtQgS3I/N9dPPehUx1iBB53igFSIigx+V8x/a
 H76JPnL1/rCKL5hVyzfG2g+bTqkmxtA=
X-Google-Smtp-Source: ADFU+vvZLD+z2DX3O7qKjJAFWxPaKaLsyNkrst8CU0ENJUUsbShw3K7LCngI4kznaQ9t9Ea9KPgt7w==
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr5886357pjn.8.1584042158178; 
 Thu, 12 Mar 2020 12:42:38 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/42] target/arm: Define arm_cpu_do_unaligned_access for
 user-only
Date: Thu, 12 Mar 2020 12:41:50 -0700
Message-Id: <20200312194219.24406-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need this to raise unaligned exceptions from user mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Use EXCP_UNALIGNED for user-only and update cpu_loop.c.
---
 linux-user/aarch64/cpu_loop.c |  7 ++++++
 linux-user/arm/cpu_loop.c     |  7 ++++++
 target/arm/cpu.c              |  2 +-
 target/arm/tlb_helper.c       | 41 ++++++++++++++++++++++-------------
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index bbe9fefca8..3cca637bb9 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -121,6 +121,13 @@ void cpu_loop(CPUARMState *env)
             info._sifields._sigfault._addr = env->exception.vaddress;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
+        case EXCP_UNALIGNED:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->exception.vaddress;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_DEBUG:
         case EXCP_BKPT:
             info.si_signo = TARGET_SIGTRAP;
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index cf618daa1c..d2ce78ae73 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -395,6 +395,13 @@ void cpu_loop(CPUARMState *env)
                 queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             }
             break;
+        case EXCP_UNALIGNED:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->exception.vaddress;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         case EXCP_DEBUG:
         excp_debug:
             info.si_signo = TARGET_SIGTRAP;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3623ecefbd..cb3c3fe8c2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2831,8 +2831,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->tlb_fill = arm_cpu_tlb_fill;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
-#if !defined(CONFIG_USER_ONLY)
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
+#if !defined(CONFIG_USER_ONLY)
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
     cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index e63f8bda29..44d7bcc783 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -107,21 +107,6 @@ static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     raise_exception(env, exc, syn, target_el);
 }
 
-/* Raise a data fault alignment exception for the specified virtual address */
-void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
-                                 MMUAccessType access_type,
-                                 int mmu_idx, uintptr_t retaddr)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    ARMMMUFaultInfo fi = {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.type = ARMFault_Alignment;
-    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
-}
-
 /*
  * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
@@ -198,3 +183,29 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 #endif
 }
+
+/* Raise a data fault alignment exception for the specified virtual address */
+void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+#ifdef CONFIG_USER_ONLY
+    cpu->env.exception.vaddress = vaddr;
+    /*
+     * For HW, this is EXCP_DATA_ABORT with a proper syndrome.
+     * Make it easier for ourselves in linux-user/arm/cpu_loop.c.
+     */
+    cs->exception_index = EXCP_UNALIGNED;
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    ARMMMUFaultInfo fi = {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.type = ARMFault_Alignment;
+    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
+#endif
+}
-- 
2.20.1


