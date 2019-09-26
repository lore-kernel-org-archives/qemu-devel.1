Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795E821D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYqXsYGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDWeP-0004UG-Sf
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc1-0002Wb-L5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWc0-0004cr-5W
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:25 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWc0-0004c9-0f
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:24 -0400
Received: by mail-pf1-f174.google.com with SMTP id y5so2136786pfo.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W0jcE++wD2TJpXHODYvTUeOTJfY0O+5q0kOFaZ7p0Ak=;
 b=uYqXsYGW6HKpwCpBRpflGlgaI8XL6LAzbEomevBFF0uvUXcVJ7Zbtr8rvAEQeiXphT
 WQPzFrLvhwvguTEvsNQNkcsZFa/5gJJRnnH65roeHSjwQlzeBt7UcmvUyI5O7Oo2JN0H
 R0gAxWjn4WuNojbKaC0XamnLNfUhEHYaFsZbg6mlrtDGaShUSn2MOEGIB9kS99oH6702
 GufdPCmw/HjTp3UAYJ5+PjMtw46I0Ala539HRmmrVd9VPd5U6hr8zZe2YYnhHzhWWhu3
 9EtaP8g3dD0ARWd4NAk+nDcTUfGqwinmt0Mo+pnDuUyQ+UZmg+BX6hGslB1xxk3uIDrD
 QjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W0jcE++wD2TJpXHODYvTUeOTJfY0O+5q0kOFaZ7p0Ak=;
 b=KTFa0frLBAFWkIXAgezJ0Sc6qDE1+kINiYgGCOcdZOQ/+hBNA4mu6DZem5ujdwKCUS
 f9nVkHYEHdStGku4k+pKdhJnh1EDvXOSSE/DM2fgV2CD3LojzZmgI5CG5Apn5mgdjn9T
 HvOiOIi/7YVs0IS6/RwmEjFT+yGqhkRP1CQ/bhJHmkf6jlTIxPDGQBbsdFV4PDl5psNF
 5YQVUi+Pg6KH9yvcjHn6soq6R605iibCam2VhTrsJ/9zzkMt2SHcACjsptL05cOuNWZc
 2TIbGxivir0QQ+D606xJvg7dWQB4OSGBHY+3b2AweYEAALIRqLiojC+RXlDaxm54sVrE
 Q/3A==
X-Gm-Message-State: APjAAAWF9BzDW/LTTOm5ZQvvW8citxbpEwLjTLyaKauMp3JFZgmW2uM6
 2qeGbHCzZIvWi2dC3GMmZPlAGG/0LwY=
X-Google-Smtp-Source: APXvYqzHZpgbJuTsSmNO+bCKTjmXGMlX13H/3Wjyp5a24ci/p3vqkDAPwAaIn84YcPuICQSihi0/dg==
X-Received: by 2002:a17:90a:6788:: with SMTP id
 o8mr4483294pjj.19.1569515182617; 
 Thu, 26 Sep 2019 09:26:22 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/18] target/s390x: Remove ilen parameter from
 tcg_s390_program_interrupt
Date: Thu, 26 Sep 2019 09:26:00 -0700
Message-Id: <20190926162615.31168-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.174
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

Since we begin the operation with an unwind, we have the proper
value of ilen immediately available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg_s390x.h   | 4 ++--
 target/s390x/excp_helper.c | 8 ++++----
 target/s390x/interrupt.c   | 2 +-
 target/s390x/tcg-stub.c    | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index 2813f9d48e..2f54ccb027 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -14,8 +14,8 @@
 #define TCG_S390X_H
 
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra);
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra);
 void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
                                            uintptr_t ra);
 void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 892f659d5a..681a9c59e1 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -34,15 +34,15 @@
 #include "hw/boards.h"
 #endif
 
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
 
     cpu_restore_state(cs, ra, true);
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
-    trigger_pgm_exception(env, code, ilen);
+    trigger_pgm_exception(env, code, ILEN_UNWIND);
     cpu_loop_exit(cs);
 }
 
@@ -60,7 +60,7 @@ void QEMU_NORETURN tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     if (env->cregs[0] & CR0_AFP) {
         env->fpc = deposit32(env->fpc, 8, 8, dxc);
     }
-    tcg_s390_program_interrupt(env, PGM_DATA, ILEN_AUTO, ra);
+    tcg_s390_program_interrupt(env, PGM_DATA, ra);
 }
 
 void QEMU_NORETURN tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 30a9fb8852..b798e2ecbe 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -40,7 +40,7 @@ void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(env_archcpu(env), code);
     } else if (tcg_enabled()) {
-        tcg_s390_program_interrupt(env, code, ilen, ra);
+        tcg_s390_program_interrupt(env, code, ra);
     } else {
         g_assert_not_reached();
     }
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
index 32adb7276a..d22c898802 100644
--- a/target/s390x/tcg-stub.c
+++ b/target/s390x/tcg-stub.c
@@ -18,8 +18,8 @@
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
 {
 }
-void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                              int ilen, uintptr_t ra)
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env,
+                                              uint32_t code, uintptr_t ra)
 {
     g_assert_not_reached();
 }
-- 
2.17.1


