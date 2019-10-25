Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40575CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA9F20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkPO8vLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA9F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtZA-00086T-Hc
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE2-0003KK-Gb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE1-0008RE-7u
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE1-0008Qa-1X
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id v6so770847wmj.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jANiCoc6xQGO++RZKyflS33Oep2oq+6QqQq5UE1fZNk=;
 b=OkPO8vLQJdj9P8QXqbLcGeCFebaq5e9uSD8NiVe6Ci6tCM/VGrY30xO0wl9dXCK+BD
 XSko3o0U23HfpKa1qb1js0TD/XM+IWWR3KtbQtHs5rrK9YVwUnnlybGCdj9xbLCbwEr+
 /X4JcPqSXbq9fNAOtIFiAAvDYrJqLmIzXBDOLgcEGHIuNV4rfA+ldvRiQwTldr45GwDm
 Q45Gk+jNOVuPFSIaq54Ian3sJk8ckVYYOIpZ3dPp16w7SwLF7s9tzAkZ6jbitXIm56vT
 57k83ghkS5x5jUobXQzC+7N2bVh+wNJSJSPnXRaxjzujkIgTBCQuN3qO47LMiHOjFQIU
 AnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jANiCoc6xQGO++RZKyflS33Oep2oq+6QqQq5UE1fZNk=;
 b=T34qPVdkJPV3t1RzO+Djb9gp0oTI5fGrSm7pPMKm80JLVoZh51D4BSIfr4VMv50D5u
 btCW/JQzz4NtY243MhH7ICjzXo9C2HP9kpybAN+Iw5OBKiKZb2oaqkIhLI/2Gwu5KheB
 gkEz0lsVg/mi0Ip+3u3EDPM4hYXPp6Og6wUVbw749snp/NozBw+GMi3PW0Erdrdw/D2I
 bvzUNllEZ/NhSiI2ZN+tBEHKitDJ+WXQ68IdTn9H7UV8qtRWLcddghOsQTtRUF6F2eEb
 TA3ICl+Xkhpa0EuQVGzAS8bPEapku761b4IaSo3jWpIsalZ3ghvRlz771qJUMh+LqshQ
 /HEQ==
X-Gm-Message-State: APjAAAWxh6v8/feZKFW9KotrM6S/xLvmKomgpfvl29vBCq2RV8Rs4UuU
 4qZQ/dBAzEQuJhtlCpDhvi1+Ug==
X-Google-Smtp-Source: APXvYqz9VlG6I0TQidgm5DK22k/E2lf87CT0wPv5KjV6AdffhTVIKfKtmhKMNCRDJeYFawXGcfbSRQ==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr1806509wme.72.1571985446981;
 Thu, 24 Oct 2019 23:37:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm1259387wrf.73.2019.10.24.23.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B6891FFA9;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 19/73] cpu: introduce cpu_in_exclusive_context()
Date: Fri, 25 Oct 2019 07:36:19 +0100
Message-Id: <20191025063713.23374-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
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

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 48272c781b7..81c33d6475d 100644
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
index af3385a2968..eaf590cb387 100644
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
index 031f587e512..07f2ab05903 100644
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


