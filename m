Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1AEECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB52D20659
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuxXBH2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB52D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLK2-0005Bj-4J
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFKdj-0003Te-Tq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFKdi-0004ws-JC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:04:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFKdi-0004vv-C3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:04:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so3851915wml.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wc5z3pSXo6Lrt9lS3SIZHRF6PDH8oo6qYuLp22beZMA=;
 b=fuxXBH2DNcPm8uAZiiuSCbtNXzZ0rD3T1UOqPrLwrE2ptU9u37CMhIGvae7NnKkxEd
 6L5G9yn+QDX1PwzvY9+lyj0K2lqknssdIW71HUWN2dMUpoJ45AELOZF2k4gz05sXlkxt
 BiJSujq9FHjOOHzOppOQBxaxITDQu+BktTJL7UgBh+BWYDp0+gQt7ZjTaooVrFCwm8nF
 5v37ge5NNejh9b8NKD0xDJvKSzhV3M5JFDIh+ny51OMQGUH5+MHNj8QECPNDCLV1g5Ra
 RGzfLihl2edzo6uZVxNOz7PhVVFlmSxlJT67MMLV/+/A+LPlHqpo+fYg5BFTxEXv0asN
 GdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wc5z3pSXo6Lrt9lS3SIZHRF6PDH8oo6qYuLp22beZMA=;
 b=A1+Bik8px8P2cDtY94ZPJvo5+W/BHKR71YEaIyizUd0K6NqkXgPExNLx0bZIgTv+MK
 YoY24pVrqoejObZjIonLp3vfwuG1kO49Ci4a3hJqik26FbugwH4U9Py311UEk2NnBRT2
 UIhUF42hR74rvzxtXCchqbRVaLcDaodsudS92k05ucWU4IXa5u5zmJmrUWV2itciipS5
 1OsfdODgxz6pJ/Dw85no02EFbXWPuC28kIBnGshYgJaKCoXLmLcFxXLUjnqJSzsObi81
 brxnNo1Js3uygg6y/4EUFswRXTCcxx3Cp2mpn9OhAmjsx/YRSKVTTGiLLcOKVbtdgTH/
 lKZg==
X-Gm-Message-State: APjAAAWa+r9TH6W6Ol0QU8BJi0EQRv8rzDSJLFeNpst6VaqsMeUXjJBh
 tzvkzRfVEkLyM2gl2N/pWG52EQ==
X-Google-Smtp-Source: APXvYqy1wKzgSYqX9NOM9aUc0HrLKbx6AfQUFcGbVEPt8DQ1CtIgooevm1YJdgQ7VVECXnx/QHonTA==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr4581453wmg.174.1569945876915; 
 Tue, 01 Oct 2019 09:04:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q22sm3824211wmj.5.2019.10.01.09.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 09:04:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3AEC21FF87;
 Tue,  1 Oct 2019 17:04:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] cpus: kick all vCPUs when running thread=single
Date: Tue,  1 Oct 2019 17:04:26 +0100
Message-Id: <20191001160426.26644-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Doug Gale <doug16k@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_cpu_kick is used for a number of reasons including to indicate
there is work to be done. However when thread=single the old
qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
which can lead to a hang in the case that:

  a) the kick is from outside the vCPUs (e.g. iothread)
  b) the timers are paused (i.e. iothread calling run_on_cpu)

To avoid this lets split qemu_cpu_kick_rr into two functions. One for
the timer which continues to advance to the next timeslice and another
for all other kicks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Doug Gale <doug16k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 cpus.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/cpus.c b/cpus.c
index d2c61ff155..bee7209134 100644
--- a/cpus.c
+++ b/cpus.c
@@ -949,8 +949,8 @@ static inline int64_t qemu_tcg_next_kick(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
 }
 
-/* Kick the currently round-robin scheduled vCPU */
-static void qemu_cpu_kick_rr_cpu(void)
+/* Kick the currently round-robin scheduled vCPU to next */
+static void qemu_cpu_kick_rr_next_cpu(void)
 {
     CPUState *cpu;
     do {
@@ -961,6 +961,16 @@ static void qemu_cpu_kick_rr_cpu(void)
     } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
 }
 
+/* Kick all RR vCPUs */
+static void qemu_cpu_kick_rr_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_exit(cpu);
+    };
+}
+
 static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
 {
 }
@@ -993,7 +1003,7 @@ void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
 static void kick_tcg_thread(void *opaque)
 {
     timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    qemu_cpu_kick_rr_cpu();
+    qemu_cpu_kick_rr_next_cpu();
 }
 
 static void start_tcg_kick_timer(void)
@@ -1828,9 +1838,11 @@ void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
     if (tcg_enabled()) {
-        cpu_exit(cpu);
-        /* NOP unless doing single-thread RR */
-        qemu_cpu_kick_rr_cpu();
+        if (qemu_tcg_mttcg_enabled()) {
+            cpu_exit(cpu);
+        } else {
+            qemu_cpu_kick_rr_cpus();
+        }
     } else {
         if (hax_enabled()) {
             /*
-- 
2.20.1


