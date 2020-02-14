Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A845EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7256A222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeqdMZ2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7256A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cIl-0005x1-Ls
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2cI9-0005P3-K1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2cI8-0002Pv-Bh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:50:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2cI8-0002PK-56
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:50:04 -0500
Received: by mail-wr1-x442.google.com with SMTP id t3so11205156wru.7
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 06:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XBkXQnBXYSP4BiwHYOKQK8ClQtNOT853ujia7Eh5EQs=;
 b=KeqdMZ2CFq3gk6/f9AePDxdvy0dWSzv3YbcInP0faprUm1CFjIrSfKQsIFrV55ncZi
 24xhxcRL71eX1dCvIAKXRfyyFbLxXWkDbYpTjTb9JnGlUUYzMkqXnVP1JhYe2+M5kBq4
 TUJ2PrqhI/NyGezCfDqt2oslxqQgh/0To5esFpI9Sle4sPZawTk8j/fl7x16TqZt89fF
 vI7D5ylRN2CRqFJnVY9Eh2UZDT/a93bjDOWwq4oZEKBRC9hRfZrYsae09wIkhlwCxazq
 IjvfOTe85ZCPdG+BXfwmkWJFtxf8J7ARB+Y3RazwDuS/xJ3jCKMxJ/cfq9Dq8r0gqNzp
 qc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XBkXQnBXYSP4BiwHYOKQK8ClQtNOT853ujia7Eh5EQs=;
 b=Ona4nRk/4iug7f6uD/5h1zf5Nb3+kuvVfXpv6+urLl6RtbvXsnpMr3Kc6/LS8+fZ5J
 40BjXDxquLHt2PkG68afZbTYfHaWvXdbZTNKVTFL4Y7U8MDYgLvbYvrD1Elz+6B28MC8
 QkWLrqLeMNBWYCT/06OPUcEuADFbhvs8kuYivdHYDIIycBVqN/ewh0NbPzU+e15U/+YF
 HTU7nzy0hJB2JQh/OXT+KlFHsw2XIQxvt/DyJFijIW9T4WsDPZg0ax7l69Yb06cw0d96
 gGkjdr8LnzFUMAJHloC1VYuMoNrJQ5EB0XqmCpw7+leRlyNr6XW/fEA5WOq4hNtW9dBM
 ObPg==
X-Gm-Message-State: APjAAAXURx6dd9yphag5eWhg5GlPUi2cKlZNLafMUnIRm0QBxWFxAp4t
 ieCWmM/inKVoRQBztq2D6DcrBg==
X-Google-Smtp-Source: APXvYqy7rzmZl5QJ3Tf5Xdvzqb8R998llxIfeIqrX5Vw25vk4e09QZNdlWWJSov1D6nPikJc4fiTwA==
X-Received: by 2002:a5d:5263:: with SMTP id l3mr4339294wrc.405.1581691802553; 
 Fri, 14 Feb 2020 06:50:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v15sm7503364wrf.7.2020.02.14.06.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 06:50:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94F191FF87;
 Fri, 14 Feb 2020 14:50:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/tcg: fix race in cpu_exec_step_atomic (bug 1863025)
Date: Fri, 14 Feb 2020 14:49:52 +0000
Message-Id: <20200214144952.15502-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Bug 1863025 <1863025@bugs.launchpad.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yifan <me@yifanlu.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bug describes a race whereby cpu_exec_step_atomic can acquire a TB
which is invalidated by a tb_flush before we execute it. This doesn't
affect the other cpu_exec modes as a tb_flush by it's nature can only
occur on a quiescent system. The race was described as:

  B2. tcg_cpu_exec => cpu_exec => tb_find => tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

      C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
          (same TB as B2)

          A3. start_exclusive critical section entered
          A4. do_tb_flush is called, TB memory freed/re-allocated
          A5. end_exclusive exits critical section

  B2. tcg_cpu_exec => cpu_exec => tb_find => tb_gen_code
  B3. tcg_tb_alloc reallocates TB from B2

      C4. start_exclusive critical section entered
      C5. cpu_tb_exec executes the TB code that was free in A4

The simplest fix is to widen the exclusive period to include the TB
lookup. As a result we can drop the complication of checking we are in
the exclusive region before we end it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Yifan <me@yifanlu.com>
Cc: Bug 1863025 <1863025@bugs.launchpad.net>
---
 accel/tcg/cpu-exec.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2560c90eec7..d95c4848a47 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -240,6 +240,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t cf_mask = cflags & CF_HASH_MASK;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        start_exclusive();
+
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb == NULL) {
             mmap_lock();
@@ -247,8 +249,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
             mmap_unlock();
         }
 
-        start_exclusive();
-
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
         cc->cpu_exec_enter(cpu);
@@ -271,14 +271,15 @@ void cpu_exec_step_atomic(CPUState *cpu)
         qemu_plugin_disable_mem_helpers(cpu);
     }
 
-    if (cpu_in_exclusive_context(cpu)) {
-        /* We might longjump out of either the codegen or the
-         * execution, so must make sure we only end the exclusive
-         * region if we started it.
-         */
-        parallel_cpus = true;
-        end_exclusive();
-    }
+
+    /*
+     * As we start the exclusive region before codegen we must still
+     * be in the region if we longjump out of either the codegen or
+     * the execution.
+     */
+    g_assert(cpu_in_exclusive_context(cpu));
+    parallel_cpus = true;
+    end_exclusive();
 }
 
 struct tb_desc {
-- 
2.20.1


