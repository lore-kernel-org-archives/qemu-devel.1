Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E4ECE58E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597DA20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFaD6LL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597DA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxxe-0000mA-9x
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvJ-0007JT-7h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvH-0005yu-HS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvH-0005x4-BX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id v8so19150800wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xbXPv2RF3r3lJivkBr9kmxKqq17UhIjfz0xNCVqHlWU=;
 b=qFaD6LL8FzEURO4TEhMYUrqi1TkpsSCQ4Qf16bdXVPLyIPP9Hvyt9xVWZs8gVXcVof
 /L263HeDN6Xs/SWVJHZ0Qp5yjlsJClabCXoazBsaMDBtxs373vaeRWFDR9jUf3sTE0xu
 rVmy0CwfjtkSjLNDIZe3LhdyD3FCn6GNWuWMBRBlKZ7EepFfAIYPGss+uBtRTuu/b+jn
 HAVp43PiBoyC++Dn5qW7BRv8A5pgeUZliKarhAqwJDniz+kt9tklkG2pcsjysEcjh/ha
 C3mXO6yZjjW9WJwpYBWG8FvtReGicrxg+qn7buIuw/XRprOOTcXHDww78IxDkxLzCqza
 RE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbXPv2RF3r3lJivkBr9kmxKqq17UhIjfz0xNCVqHlWU=;
 b=LbiHpgj2TKoX2LjQEi/rrDBsOhltM9mwfeNFrTBcexTrqPrL+9RRcR3cmN7bIbAgtF
 91cp8C4JFRe3dlUoKxJaQh+FDtVlobTPoW8581xNggceYtplqcIfj8o3IupIyPkxG8Dx
 6BaFbF9biHJXF9pGoVU3Q8XeDe4tRKrZB7FXFn9D746/RpLwExe95nXCWeO5sZ0ZYlKH
 YvtRHLm79cbev0DctLWlyLMXHqidLPk0UyvVPMubQxwVCV2z9NXrEPIOowp0686k33Nk
 q2AD02xVEajpeI1ZMuikOIophpFOoRpq4LvD33TIpNCbabp2a29SWfFyXVr5TzyEv5M4
 EdBw==
X-Gm-Message-State: APjAAAXfFe3mRy90eDcQ4BEl1oFD0Ad2qKd08m4HwgnO6dg1hUbsD2x9
 BJfDUZl1kflAlG50lzHWeWZI+Q==
X-Google-Smtp-Source: APXvYqx8Fm7cHvED4IO5rxGYPBRGDH3q/kW7D6iElNFsPau6UoTNCOSxBGpm5TNQlA89J6xPuE3ZEA==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr11845837wrr.365.1571050193565; 
 Mon, 14 Oct 2019 03:49:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm19810331wrc.18.2019.10.14.03.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1AD61FF90;
 Mon, 14 Oct 2019 11:49:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 03/55] cpu: introduce cpu_in_exclusive_context()
Date: Mon, 14 Oct 2019 11:48:56 +0100
Message-Id: <20191014104948.4291-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


