Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111EFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEF020869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcFk3PJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEF020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5jG-0005S5-Nm
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5df-0007zh-HC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dd-0005NM-Te
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dd-0005KN-N4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id b24so2488461wmj.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xbXPv2RF3r3lJivkBr9kmxKqq17UhIjfz0xNCVqHlWU=;
 b=jcFk3PJ1/CmGz5/lRGB9iRGqb2UCbLBsEPlbcZ6hafLKzrw54R2liKw+Zwanewpctz
 caID7vLt/62jUHV0W2nZnwwjw5iqSPElxJoBCf060dyQaj57y1B8Dsv7YBeqqisE27RB
 pMTq6GkXnRQNtbZDNwi5RjYlm+0xCbCzhF2dLF+qBYOdoEReb8ZOvbrcozb+1nXayDq1
 MD3VryDAdo5DunefZRbOkh71yhGygnibbcXDtHesPfK86joxJDx9d7YgPj8zgK0yECSi
 kjJNiV9cdU6Qk0ABfVp0CuRk+x09ShZ8UwV1xtn4f+I6KogxATa7EL2RH7AzS6zVUlff
 JFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbXPv2RF3r3lJivkBr9kmxKqq17UhIjfz0xNCVqHlWU=;
 b=rGfY4SW9zm3ZAL+78VRu0L/Grt92YMUE74kPri69fs98ldWOBUAPNA1ErZSKmzGs4z
 d6CPoq9jQigZgHIZqQ6Ah1kR/4rsbpZ+/P6x+UcGUCQL8a4A/NyH9BFgizbgShWeBG8O
 z7ZNhrBaG5VEseRNdZtxzTzbCkZd9gdHI4yqoplTd+6YeH+OXSrnWz69kYRtX3jD8hL0
 pCz++vRs8DpS+Ygvr4Uqzj4LiGSI1wYZJ/SjVhKYU12b4J7Hyl8vWz3javGk0QxBQP0q
 +WWIBPeOyFUrEUXAsO/Hi6BH0WxBsOkLGOshFwjNgpBfor3/P9+QujfgoL7hlPu4JQhB
 ysjA==
X-Gm-Message-State: APjAAAVSCJpxTzQnvF//ocZzvEL8Q3l6+L6zr9O9eVUNyIetcae2KXul
 BdJ3oWcSH+nUr6J4AXVwfCxInA==
X-Google-Smtp-Source: APXvYqzLXH8Uaz/dL+r9pN/Yk4O8AXyhbnxtgfw3U0OlKLpaghDHA4/ipJk8EmiYRUUcm6g4sVHJIA==
X-Received: by 2002:a05:600c:2908:: with SMTP id
 i8mr2793009wmd.20.1571318179859; 
 Thu, 17 Oct 2019 06:16:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s13sm2015416wmc.28.2019.10.17.06.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1AEE51FF90;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 03/54] cpu: introduce cpu_in_exclusive_context()
Date: Thu, 17 Oct 2019 14:15:24 +0100
Message-Id: <20191017131615.19660-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4
  - -> cpu_in_exclusive_context
  - moved inside start/end exclusive
  - fixed up cpu_exec_step_atomic
---
 accel/tcg/cpu-exec.c  |  5 +----
 cpus-common.c         |  4 ++++
 include/hw/core/cpu.h | 13 +++++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 48272c781b..81c33d6475 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -238,8 +238,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags;
     uint32_t cflags = 1;
     uint32_t cf_mask = cflags & CF_HASH_MASK;
-    /* volatile because we modify it between setjmp and longjmp */
-    volatile bool in_exclusive_region = false;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
@@ -253,7 +251,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
-        in_exclusive_region = true;
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
@@ -273,7 +270,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         assert_no_pages_locked();
     }
 
-    if (in_exclusive_region) {
+    if (cpu_in_exclusive_context(cpu)) {
         /* We might longjump out of either the codegen or the
          * execution, so must make sure we only end the exclusive
          * region if we started it.
diff --git a/cpus-common.c b/cpus-common.c
index af3385a296..eaf590cb38 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -200,11 +200,15 @@ void start_exclusive(void)
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
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 031f587e51..07f2ab0590 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -372,6 +372,7 @@ struct CPUState {
     bool unplug;
     bool crash_occurred;
     bool exit_request;
+    bool in_exclusive_context;
     uint32_t cflags_next_tb;
     /* updates protected by BQL */
     uint32_t interrupt_request;
@@ -783,6 +784,18 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
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


