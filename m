Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B45C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424C2206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6nNj18A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424C2206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrEX-0002pc-Hw
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8h-00027t-GI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8e-0000kZ-CK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8d-0000ev-FB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so70287613wrf.11
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gqRoR6HeTII8sj4+++ItlQ9YsCPjf/Rl0PEZ/zeyKFI=;
 b=s6nNj18AsKMrJqBZ0JC3IwkFmgsVUwB1p2HwNr7yzxRDZ0q53fSFwd7i8CqdNygHBF
 NnHt7jaxqcvckTzl+//AHdAdo17aoSpADU3jbGVr3R/DJUBmVQGNPwAndwzj6ATmJUY+
 cO7Bq9vjF5lTBQTsY083ZebT0R8o+yEEqPEq5WLnNkAEjQz57jPIwRPEJ0GHQe4pYRUi
 dkZ8DjPQg5O/W1gKkQlWSvBricR0P2rtNhkEUhssKEMPAFLP/N+3z1VEuy+uzBnpmTQE
 7eQgrhKY1SuI3UHp0GHn2ngKlP/HoehWz5F9yT3996fA2GZvHqjbrixn4sml0dWs/4C2
 GLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gqRoR6HeTII8sj4+++ItlQ9YsCPjf/Rl0PEZ/zeyKFI=;
 b=XdRVT0wbVbs86PT6h9pY4P1uQaNcsuzbRtKMdaIX/KT3qE55z7ZMTwMuaI5wIajFhN
 gbwM5VG1ApeQS19JsI7ApNS4/MQoISKvncfU5aoUQQeaRXormE8VNV1XRtgeExbBEYrm
 Hm5HA5lHHtF15Vm4EGzD6lS4wRjci3ytWnkvh6pjqz9vbKakU/ODtxKG+euGQ9+Y84pY
 l9BjrG7POI3Rv+iHlAQjLLJjCbL7i0tdB8Ryv4fx/aO1OVZrx1pI7qXYNDeAFWQhHLDa
 7gLQKaE1ImSvM+Z/HUku2rCkGMxsFDgbITuaNMRrJBZn/+wLWvHeOMu6TbjgjAhyNnlk
 v6og==
X-Gm-Message-State: APjAAAWbJhHn3np8WBKymhLrFgDkRM2zXqVttpv1a0Wmrj8lCBxeeDPi
 jWeWdqJ3oQztod+FDfjRS1tWjA==
X-Google-Smtp-Source: APXvYqwIcCeyCIJDrsGo/q9Qrtirk9OsKfd7qIBnaxGk3YVpWqYZDyiRxJDoKGRG28CSH9PYJBHfDg==
X-Received: by 2002:adf:fb8e:: with SMTP id a14mr40487717wrr.263.1564589247173; 
 Wed, 31 Jul 2019 09:07:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l2sm46099782wmj.4.2019.07.31.09.07.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 49F8F1FF99;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:34 +0100
Message-Id: <20190731160719.11396-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v4 09/54] cpu: introduce
 cpu_in_exclusive_context()
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, aaron@os.amperecomputing.com,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: moved inside start/end_exclusive fns + cleanup]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - -> cpu_in_exclusive_context
  - moved inside start/end exclusive
  - fixed up cpu_exec_step_atomic
---
 accel/tcg/cpu-exec.c |  5 +----
 cpus-common.c        |  4 ++++
 include/qom/cpu.h    | 13 +++++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c85c3ee1e9..ab9dfd4f908 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -239,8 +239,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags;
     uint32_t cflags = 1;
     uint32_t cf_mask = cflags & CF_HASH_MASK;
-    /* volatile because we modify it between setjmp and longjmp */
-    volatile bool in_exclusive_region = false;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
@@ -254,7 +252,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
-        in_exclusive_region = true;
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
@@ -274,7 +271,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         assert_no_pages_locked();
     }
 
-    if (in_exclusive_region) {
+    if (cpu_in_exclusive_context(cpu)) {
         /* We might longjump out of either the codegen or the
          * execution, so must make sure we only end the exclusive
          * region if we started it.
diff --git a/cpus-common.c b/cpus-common.c
index 3ca58c64e80..e87400834be 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -208,11 +208,15 @@ void start_exclusive(void)
      * section until end_exclusive resets pending_cpus to 0.
      */
     qemu_mutex_unlock(&qemu_cpu_list_lock);
+
+    current_cpu->in_exclusive_context = true;
 }
 
 /* Finish an exclusive operation.  */
 void end_exclusive(void)
 {
+    current_cpu->in_exclusive_context = false;
+
     qemu_mutex_lock(&qemu_cpu_list_lock);
     atomic_set(&pending_cpus, 0);
     qemu_cond_broadcast(&exclusive_resume);
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 5ee0046b629..65a0926c49a 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -373,6 +373,7 @@ struct CPUState {
     bool unplug;
     bool crash_occurred;
     bool exit_request;
+    bool in_exclusive_context;
     uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
@@ -785,6 +786,18 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
  */
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * cpu_in_exclusive_context()
+ * @cpu: The vCPU to check
+ *
+ * Returns true if @cpu is an exclusive context, for example running
+ * something which has previously been queued via async_safe_run_on_cpu().
+ */
+static inline bool cpu_in_exclusive_context(const CPUState *cpu)
+{
+    return cpu->in_exclusive_context;
+}
+
 /**
  * qemu_get_cpu:
  * @index: The CPUState@cpu_index value of the CPU to obtain.
-- 
2.20.1


