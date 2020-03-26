Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E959C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1568920714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRPUtv/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1568920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYOE-0005Y9-7C
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJx-0005yc-6B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJw-0001Lx-2v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:41 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJv-0001Lo-V5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:40 -0400
Received: by mail-qk1-x742.google.com with SMTP id c145so8135247qke.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YU0MJsBdXP71+ASBscgMltueTCsYgt9Kz0FY+8TmezY=;
 b=qRPUtv/akgVcHvO+hR1YAC0yYSKT2HKFgxWHIoayjmuKTmJnCgBp3r43j12XDdQzcS
 UiJ2Ej9GbopPedr4MMOM+JFIDTnlXG7rjwfOCQdZEK9x3RM9OIXEPBzA3mt6QFvK9aag
 5wbmEnx35dNMQL/GaU8cYs5t+1hOCNmTudBV/7v5XtfpxyxQoHS1V0IMJ69toq4AmF8S
 To1JDqzasMS4juzMFKf2h6cFMlqJoFGReR692QhrSxbYEhkBDpWVG1aiNWpNuNbaUxEy
 0TVO1vKO3R+hk+aDACh4Jltyr0rzQUX1DUB3D1TDBAC/m+vHoK6EOYdz4r6yJOpwHDI4
 l9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YU0MJsBdXP71+ASBscgMltueTCsYgt9Kz0FY+8TmezY=;
 b=lCy4rS6/1RgOznUjLUqyl7xytdLMtjJhQ9XOLeBWG6uPoQd/mS1TGbvys0pVqWF3Vx
 HbypAq8eBdG+uZycqYGzgWUVSMTC0k3NYhuR5HoN05G5SjVM1BnAzczfvyvGLYv9dBp0
 AqsTsTIpr/pfoj8ySoIHN6jiU98zw3I16oZ2nzMrcEi8Sx4b+xBQCTk8iVc2AJOuoUxA
 vwmPCQgmd9Hka/1LZTR5V/J779VU13UOqqShpUppXBMNaYgFfgRrjScaniGLmj2OfCeU
 aRkksPPd36NTBWjNnIHX1iBPRq5Tj80TcDLXZ6MskfKgyLT+0Y9N5wBr2QoRmzIZawCU
 pBWg==
X-Gm-Message-State: ANhLgQ1nLXyZ9WEK3lkBWGcCLGTmaQDZtoNCNOLL92zib5IJZreQqQdW
 gooXsdeoSHMN3XRAuVf9ix4RGTTP/FsEvQ==
X-Google-Smtp-Source: ADFU+vvwJxq7BydI+XKT9bCFwly5uFhZ9+KOy/xGKkseEvNVMS04vOzB6PDeVgpxIi65EWP2WvLQpg==
X-Received: by 2002:a37:a4d6:: with SMTP id
 n205mr10319510qke.352.1585251459236; 
 Thu, 26 Mar 2020 12:37:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:38 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/74] cpu: move run_on_cpu to cpus-common
Date: Thu, 26 Mar 2020 15:30:47 -0400
Message-Id: <20200326193156.4322-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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

We don't pass a pointer to qemu_global_mutex anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c         |  2 +-
 cpus.c                |  5 -----
 include/hw/core/cpu.h | 10 ----------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 9031c31005..bf5794cc17 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -119,7 +119,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     cpu_mutex_unlock(cpu);
 }
 
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item wi;
     bool has_bql = qemu_mutex_iothread_locked();
diff --git a/cpus.c b/cpus.c
index e1f3327bbc..ff8f37cf88 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1189,11 +1189,6 @@ void qemu_init_cpu_loop(void)
     qemu_thread_get_self(&io_thread);
 }
 
-void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
-{
-    do_run_on_cpu(cpu, func, data);
-}
-
 static void qemu_kvm_destroy_vcpu(CPUState *cpu)
 {
     if (kvm_destroy_vcpu(cpu) < 0) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9c3ec715e2..9c6a426c35 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -766,16 +766,6 @@ void qemu_cpu_kick(CPUState *cpu);
  */
 bool cpu_is_stopped(CPUState *cpu);
 
-/**
- * do_run_on_cpu:
- * @cpu: The vCPU to run on.
- * @func: The function to be executed.
- * @data: Data to pass to the function.
- *
- * Used internally in the implementation of run_on_cpu.
- */
-void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
-
 /**
  * run_on_cpu:
  * @cpu: The vCPU to run on.
-- 
2.17.1


