Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C932EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936D8206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulsJJuPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936D8206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYfJ-0005QH-Mr
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLD-0008Dw-Va
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLC-00027z-ME
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:59 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:36389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLC-00027s-Hh
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:58 -0400
Received: by mail-qv1-xf43.google.com with SMTP id z13so3708528qvw.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SMWSXLQojKe3xf38iwDswTcJa5hw68aVIzkImw5+21g=;
 b=ulsJJuPn6vcdvI4qE+Zfqur8TMA1wlNwhVQWyZIf0qD8GhP0poGc5JyvXNdp79EYDF
 u/Fqr35IyCjhFjx0wHIZfneZ8q6oGpTLFes98DH7YGQpZQ/1sNskLgyhOcyQSAK9rr/6
 zZ5KSNXA462wOfJIloRfXWIkShAJFo4eRnXkPcbkUCKUJ1bUiPTR3TmHfM+WCVb1k/OE
 dfZqU5AfCBSTrWF64eXVH4XP/NhyDjMV8VVRDHShGbhofeIz2EtHpTaKubdKe/hlQuNg
 xrhnZfFaql4ZT+7QvusuU3EqcyD20c59W815aM7pF+Tsy67r9VkA+z/JSyamWDzMMXNn
 m0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SMWSXLQojKe3xf38iwDswTcJa5hw68aVIzkImw5+21g=;
 b=fts/IqCsNtiPV6X4BTt1WAjRHpfz8EuJIUgNY1yQinLY+yV4YHeM+qtcaiGFuDYJyh
 MOl4wT4tk3WAw3dtcJDWYuFC4Hd79zwEzzvTumpggpLzv+TE1Tc0/FTXo7ho1KAyZ+gc
 UjomBQYY2F8Bl7vfa1yO4ga9GaNO/dsBRGyBhAc5HHA9RZSH65hvZKwV0UcOTga7/u6T
 rdf7tlpJq7UyoJCzghd9oalVQqh2118X30eHI+irMGivJ6yArPfmaAzuLk41VtE+xb8F
 Wq8SXbVP1I4O1En0xWTEYEjpn/Uk1/3K4baH7pXNZ89twIizT6Qc2Z747bI6LSl/LTLu
 dyog==
X-Gm-Message-State: ANhLgQ21u/RgvXqg2IZ6ZYZ1AEABCZq4KYMGsHquoZ1pEsKLlt2a1tB4
 d2OXjMVb0k8bnJeGe9hd30oX4htf53JyBQ==
X-Google-Smtp-Source: ADFU+vsZQDr3xzhqc2GD10V3LWu/kX4ZCxMQCVlPhFsTb2s90vu8OkqTJzjpNIW4RaBcemWSJ4NQ1g==
X-Received: by 2002:ad4:514d:: with SMTP id g13mr9632379qvq.229.1585251537028; 
 Thu, 26 Mar 2020 12:38:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:56 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 60/74] accel/tcg: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:42 -0400
Message-Id: <20200326193156.4322-61-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c      | 15 ++++++++-------
 accel/tcg/tcg-all.c       | 12 +++++++++---
 accel/tcg/translate-all.c |  2 +-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 099dd83ee0..b549a37847 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -431,7 +431,7 @@ static inline bool cpu_handle_halt_locked(CPUState *cpu)
 
     if (cpu_halted(cpu)) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
-        if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
+        if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
 
@@ -544,16 +544,17 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      */
     atomic_mb_set(&cpu_neg(cpu)->icount_decr.u16.high, 0);
 
-    if (unlikely(atomic_read(&cpu->interrupt_request))) {
+    if (unlikely(cpu_interrupt_request(cpu))) {
         int interrupt_request;
+
         qemu_mutex_lock_iothread();
-        interrupt_request = cpu->interrupt_request;
+        interrupt_request = cpu_interrupt_request(cpu);
         if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
             /* Mask out external interrupts for this step. */
             interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
         }
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
             cpu->exception_index = EXCP_DEBUG;
             qemu_mutex_unlock_iothread();
             return true;
@@ -562,7 +563,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
-            cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
             cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
             qemu_mutex_unlock_iothread();
@@ -599,10 +600,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
-            interrupt_request = cpu->interrupt_request;
+            interrupt_request = cpu_interrupt_request(cpu);
         }
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
-            cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
+            cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
             /* ensure that no TB jump will be modified as
                the program flow was changed */
             *last_tb = NULL;
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index acfdcfdf59..79b01bf726 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -52,10 +52,16 @@ typedef struct TCGState {
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
     int old_mask;
-    g_assert(qemu_mutex_iothread_locked());
 
-    old_mask = cpu->interrupt_request;
-    cpu->interrupt_request |= mask;
+    if (!cpu_mutex_locked(cpu)) {
+        cpu_mutex_lock(cpu);
+        old_mask = cpu_interrupt_request(cpu);
+        cpu_interrupt_request_or(cpu, mask);
+        cpu_mutex_unlock(cpu);
+    } else {
+        old_mask = cpu_interrupt_request(cpu);
+        cpu_interrupt_request_or(cpu, mask);
+    }
 
     /*
      * If called from iothread context, wake the target cpu in
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 78914154bf..eeb9cd2cd7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2387,7 +2387,7 @@ void dump_opcount_info(void)
 void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
     atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
 }
 
-- 
2.17.1


