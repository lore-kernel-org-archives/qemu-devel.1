Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2416C206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/kYo9ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2416C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYfQ-0005gC-8h
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKa-00079N-0M
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKY-0001id-SR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:19 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:32891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKX-0001hu-IC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:18 -0400
Received: by mail-qv1-xf44.google.com with SMTP id p19so3717096qve.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pBQreEfimlo/TeCu0za1hNbEWK5jCOhKGwDICZx6xko=;
 b=P/kYo9ulqhpp050EUJd06JPmSSGs9/dQd6u7mVV6aCajHrvKc7u9Jb/OwY9vaMQCZD
 a3Ps41Vd32xrllgwiKcjy+XCsoeDBZ/c/hQLIrJJAV/z7WsGv42J7HYn0I4VK3EwrDIB
 nWvUyj7KEmHXI70uO7gzFfH32mXySbLvrE0mTgas+YziWKDPNuhR8Y4ZjjnCmKNrq/Ei
 xoEk8kq6/3k+5vlK2BOpSOahe6LUyuR5tEJrr/Ntysmo3mJVX/wMAu2bp/Opom06j4b+
 BrAw+FBweGL+GMyvSWDATo8BNKqKv0Z4CaI2pLxJI5fmIK/6DV/f1BqvAvIPBlAAd1vn
 ujTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pBQreEfimlo/TeCu0za1hNbEWK5jCOhKGwDICZx6xko=;
 b=IHZny/dtqSnQeOq7qqT6qG6fzAIW+9JwvFw/0aqrTA0zdNAR1nlBBLKPSGDMRijBk0
 v36xMgGRfRTZGFjiwSh5PZHK3XB/NDbUuABcXMtjUkqdRNjPWVgThCgrNtL/6oEEIXJ+
 92bTSDZY7UtgDOIyLFV0jFFIiHAsMHD227WmA+74fTVfMAu9uC2O5L415J73V5YewNq3
 SE0twSW4yXPI0ZGKk+wB2ilcS63yeC3h3YHkPY+T2nrq1iNkz3uOpbbz75FSIKxFMhB6
 ZVzEmOrnReL8vVQ0cz+d4Y7Mvo1xPktg5R+GF1ootSuiA/CFXNJcdD9q4Pi5B6G/f+YN
 r9vQ==
X-Gm-Message-State: ANhLgQ3GPkyqIpOh4JSzcbCL/cZvvv1E+c5E8mRw4Uu16yjp0z+/0bIG
 krsJDnptVn1bXRcuXq0CXLpOD6p3BJzVSw==
X-Google-Smtp-Source: ADFU+vu6wB3XDnsGcnaInvDM7QDGI3lOlgWH2opLsjjYkBYPA5RD3qXKO3GgJzXaWfSW9C5ZIngpnQ==
X-Received: by 2002:ad4:53a2:: with SMTP id j2mr10100056qvv.145.1585251496372; 
 Thu, 26 Mar 2020 12:38:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 31/74] cpu-exec: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:13 -0400
Message-Id: <20200326193156.4322-32-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
 accel/tcg/cpu-exec.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d95c4848a4..e296894ea1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -425,14 +425,21 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     return tb;
 }
 
-static inline bool cpu_handle_halt(CPUState *cpu)
+static inline bool cpu_handle_halt_locked(CPUState *cpu)
 {
-    if (cpu->halted) {
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu_halted(cpu)) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
         if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
+
+            /* prevent deadlock; cpu_mutex must be acquired _after_ the BQL */
+            cpu_mutex_unlock(cpu);
             qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
+
             apic_poll_irq(x86_cpu->apic_state);
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
             qemu_mutex_unlock_iothread();
@@ -442,12 +449,22 @@ static inline bool cpu_handle_halt(CPUState *cpu)
             return true;
         }
 
-        cpu->halted = 0;
+        cpu_halted_set(cpu, 0);
     }
 
     return false;
 }
 
+static inline bool cpu_handle_halt(CPUState *cpu)
+{
+    bool ret;
+
+    cpu_mutex_lock(cpu);
+    ret = cpu_handle_halt_locked(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
+}
+
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -546,7 +563,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
-            cpu->halted = 1;
+            cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
             qemu_mutex_unlock_iothread();
             return true;
-- 
2.17.1


