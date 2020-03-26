Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8748AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D91206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5Js6u4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D91206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYWb-0003Uc-F4
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKc-00079d-1G
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKa-0001je-K1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:21 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:33750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKa-0001j9-GT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:20 -0400
Received: by mail-qt1-x82d.google.com with SMTP id c14so6574278qtp.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ShxiiQVChFNUTjmYIyg4bNMUbV8gv91VOcC+VfAQzoI=;
 b=M5Js6u4oh8aYD/tFpbvxD/w5+X/QYDJAeGo+rIjgizoVoa5zFhQoCCNTzqgv6qw2UU
 r9dTtv9J+G2iFj9Rn1g501SzPYq6ILY2thg+9+68QCLwJxc7eNIg4eEHqp91gwc7EaBy
 6/xvkAntXcoM5an4TadSuN2bc2MukxrxOH72j6LvAa+r/B1vjamh9aGt1ZgnQZOit8++
 2dShacu0Mm7xvhlTG1deVm9hF4X704FmKaco1++dVw/G6Sw3jUXaF0OtnVj72HEOwpY2
 tRg5YrYF+7m6KeJXru1Uwn/CG0StZd9/Qy7U0l58IHAbR+176EYGrEwYTYinHv0q0QtR
 Qnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ShxiiQVChFNUTjmYIyg4bNMUbV8gv91VOcC+VfAQzoI=;
 b=YyriN/lgUUc6eRXxeOOKpcqGOZ7kYkxg2X10Elyyi+vnZBvHBrEKshSn+nFF4k0wm8
 dpZZ1t863uk+jBYV/hr1s1pgBuQc8tluNxca88icQDdD5YZkmzNh9sFcu+ZQ/qk1Cm0o
 WET3IYwU6vwz7liDd2wN9WsqHfMAvNewVKrpOzIACD//nfr6vadRGBxDv2vWP2v6J3Bm
 ikkHGrzf5ImLxfdJXNG0nCPyfwSsAzL31/MZeu9vqbHJrYHnn8wshmpF1h/56Dn6q5k9
 BF30CkloKTl8kbPNP0u97n9YXhu3yRf8Fj6jw5RcHA96uW3GSo+M3OSlLV/hgj4Wi0JY
 yvRA==
X-Gm-Message-State: ANhLgQ0amRT1X8bk9S+21kloQohyDqGemaqKqpzy5uU7DWVs0zj3toit
 c2ByKAfq5HZ7qCS0UZXtiYkrktFbx4/f6g==
X-Google-Smtp-Source: ADFU+vv/4y371roGO0+7dLaZKhPD/oc5VStpwf1kTl6jFWy4YqALbsYfvvBDGR3bQgajaeDdWdEPPg==
X-Received: by 2002:ac8:2a8d:: with SMTP id b13mr9859335qta.90.1585251499002; 
 Thu, 26 Mar 2020 12:38:19 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:18 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 33/74] cpu: define cpu_interrupt_request helpers
Date: Thu, 26 Mar 2020 15:31:15 -0400
Message-Id: <20200326193156.4322-34-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
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

Add a comment about how atomic_read works here. The comment refers to
a "BQL-less CPU loop", which will materialize toward the end
of this series.

Note that the modifications to cpu_reset_interrupt are there to
avoid deadlock during the CPU lock transition; once that is complete,
cpu_interrupt_request will be simple again.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/core/cpu.c         | 27 +++++++++++++++++++++------
 include/hw/core/cpu.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 9683d6408a..01091d0623 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -99,14 +99,29 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
  * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !qemu_mutex_iothread_locked();
+    bool has_bql = qemu_mutex_iothread_locked();
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
 
-    if (need_lock) {
-        qemu_mutex_lock_iothread();
+    if (has_bql) {
+        if (has_cpu_lock) {
+            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+        } else {
+            cpu_mutex_lock(cpu);
+            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+            cpu_mutex_unlock(cpu);
+        }
+        return;
+    }
+
+    if (has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
     }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        qemu_mutex_unlock_iothread();
+    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+    qemu_mutex_unlock_iothread();
+    if (!has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
     }
 }
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 48b46c90ed..1c3701b142 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -522,6 +522,43 @@ static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
     cpu_mutex_unlock(cpu);
 }
 
+/*
+ * When sending an interrupt, setters OR the appropriate bit and kick the
+ * destination vCPU. The latter can then read interrupt_request without
+ * acquiring the CPU lock, because once the kick-induced completes, they'll read
+ * an up-to-date interrupt_request.
+ * Setters always acquire the lock, which guarantees that (1) concurrent
+ * updates from different threads won't result in data races, and (2) the
+ * BQL-less CPU loop will always see an up-to-date interrupt_request, since the
+ * loop holds the CPU lock.
+ */
+static inline uint32_t cpu_interrupt_request(CPUState *cpu)
+{
+    return atomic_read(&cpu->interrupt_request);
+}
+
+static inline void cpu_interrupt_request_or(CPUState *cpu, uint32_t mask)
+{
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request | mask);
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, cpu->interrupt_request | mask);
+    cpu_mutex_unlock(cpu);
+}
+
+static inline void cpu_interrupt_request_set(CPUState *cpu, uint32_t val)
+{
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, val);
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, val);
+    cpu_mutex_unlock(cpu);
+}
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
-- 
2.17.1


