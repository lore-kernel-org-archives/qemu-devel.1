Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C84C2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F58206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aP9XFJ9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F58206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYQv-0002fy-CN
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKn-0007I2-2D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKl-0001rk-4E
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:32 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:41515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKk-0001r7-6B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:30 -0400
Received: by mail-qk1-x730.google.com with SMTP id q188so8164811qke.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sdQwRlLLT+5U59MmV/RF+N1c5notv4MIEsZdFF75BOg=;
 b=aP9XFJ9VWF5r/gKrwYHKn6472A9yf3CD0O4fhxJ5DuOstbCnh21n7LorbfLGPwMfgf
 su57rhAuOuPM5P0tsMPW84XHnBb1lBucyj7n827xnYljc6x29QhBYoBwXJPKKS75gBFe
 XWlttnOxWZB3xEsjShRbL2tXLUKhWx7LFTPs8EqwQiBGNn08UzctKYRrFs90GInPuwlT
 FPHQtQtK0TjUNUjKPf7a0hAHE3yz7XQM/xFy5KVW1PvGfMY6abjwheqzQBGcbKQMJHOz
 G0nSawHwaoTnQZjmP3TH2V4RIQiPc1YMKi5A3Rz4f5Sgy43oHcRnazP7Epc3z5GfliE9
 kSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sdQwRlLLT+5U59MmV/RF+N1c5notv4MIEsZdFF75BOg=;
 b=HjE3HX9Gs6vV4G0D6rtOmOCE9q7ZEE+TRCMOpPmRf9dFs0jIgZf1ETn1dVRmCTYey9
 GGTMGuUtHkQLtrshM5cuuaLz8BdPFzU0swCDnp+U/MJOie06z2biaPclz79Uw9eBECv6
 aXD08hWFIv/YXwd6wgwR8vVkJqx0RJ7azTpEZejtZZBcbsoTyJcHD01XWDJ30sry+ULt
 5WLrke6COA8mnbhWgGj5S2qMW8rTAf5CcZKkDsc/EYN1BGTPaDvfMCzQNS79h1zBs7lv
 leTa7LsbmDkTC8BIMFtrHQsTHYTTvnH01p/AcufStNFeG+0tr4RrzYG4aeJdh6gcfJVz
 67XQ==
X-Gm-Message-State: ANhLgQ1qf4vCAKNL6Kdlw0Q/qOimVF6d2AzoiR6Tc9xlFUJDDCm0Ozpk
 ZHaSn3LgvkbDQwaF5uujDSTdivx3V3LkCw==
X-Google-Smtp-Source: ADFU+vvu8++0z9bMV5v6S7uO76qe7hJXvZWQc7LX/XSqKPbXfSCTM5ISwA/RiOeWJhJVWCYXG+nNkA==
X-Received: by 2002:a05:620a:120e:: with SMTP id
 u14mr9319408qkj.23.1585251509333; 
 Thu, 26 Mar 2020 12:38:29 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:28 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 40/74] i386: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:22 -0400
Message-Id: <20200326193156.4322-41-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
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
 target/i386/cpu.c        | 2 +-
 target/i386/helper.c     | 4 ++--
 target/i386/svm_helper.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 280da50abf..bb6624100f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7114,7 +7114,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 
 static bool x86_cpu_has_work(CPUState *cs)
 {
-    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
+    return x86_cpu_pending_interrupt(cs, cpu_interrupt_request(cs)) != 0;
 }
 
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 058de4073d..623a7299ac 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1029,12 +1029,12 @@ void do_cpu_init(X86CPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     CPUX86State *save = g_new(CPUX86State, 1);
-    int sipi = cs->interrupt_request & CPU_INTERRUPT_SIPI;
+    int sipi = cpu_interrupt_request(cs) & CPU_INTERRUPT_SIPI;
 
     *save = *env;
 
     cpu_reset(cs);
-    cs->interrupt_request = sipi;
+    cpu_interrupt_request_set(cs, sipi);
     memcpy(&env->start_init_save, &save->start_init_save,
            offsetof(CPUX86State, end_init_save) -
            offsetof(CPUX86State, start_init_save));
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 63eb136743..c739bf0d9c 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -316,7 +316,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     if (int_ctl & V_IRQ_MASK) {
         CPUState *cs = env_cpu(env);
 
-        cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_VIRQ);
     }
 
     /* maybe we need to inject an event */
@@ -674,7 +674,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
                        env->vm_vmcb + offsetof(struct vmcb, control.int_ctl));
     int_ctl &= ~(V_TPR_MASK | V_IRQ_MASK);
     int_ctl |= env->v_tpr & V_TPR_MASK;
-    if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+    if (cpu_interrupt_request(cs) & CPU_INTERRUPT_VIRQ) {
         int_ctl |= V_IRQ_MASK;
     }
     x86_stl_phys(cs,
-- 
2.17.1


