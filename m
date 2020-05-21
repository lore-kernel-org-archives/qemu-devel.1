Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE03C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6D0207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meorVK5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6D0207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboc8-00009L-0y
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIl-0003cP-4e
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:11 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:38436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIk-0006bU-2i
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:10 -0400
Received: by mail-qt1-x82d.google.com with SMTP id i68so6007532qtb.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=my4fqiSIl1w93gA3LXQg9qyTvqo7M4OmKC+VI+dDUhM=;
 b=meorVK5RVi6Kw55tcaeJQo5fbFT3cQFjgwW/iSnZZGi1g+FIIVpltIQkOO44x5qL+U
 3J8rlJ5Z1v9M+Lj8gCoUmPQJ5dDDwR6zbGh12Y8FkXD5MrLWgrTz2I2bPPmM5RrG/z/1
 og+XdsGNMHL0IArix27FHvFJF398hD35+CfNT/DuftgLesl4q/kagIiHRdI5M+APcT/F
 AhqBhuzQ5MGj2tGAGBzVCj2fr6HKJuI+arwpKvasRo1XKOXENwVBjEsxbP8TQ2ZGMp64
 d1eqb3e6VBp+RcBacHOJjguFo60+REwW7u+hk3q/6DJBfXf8X1an4uB+Gm0UMy/PgPju
 ZPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=my4fqiSIl1w93gA3LXQg9qyTvqo7M4OmKC+VI+dDUhM=;
 b=J5eiiU8za0wXBo7FFIcSyVR8BI1i8JgiCkNjOOEM73sJn47/pnfjl2B1VIhSFk3/44
 JXGUiMI/N/CVBSz+gpFWml0UKqFXbUmZ070s0xB5VR8sWp1F0kIds2BDnzUsuyvuosQ+
 XNUsPW+uZRFncLRRbniBAWqlo3re4W8IQlqK4pOVg5FfAa9enIC0Eb8+BRwepJIcdQ+e
 KpumXgRzgJYb+3TX+4+4YksTGUlPuqCJCP5Wmt+wVy891IpwrlqS0WB2/LfdoxrfVU6D
 tf6qa4syH9vQnd7sxX6Di7XZ8Bj2+w6YbWF6o8LqHUvlDRyPu+CJDEoP4WIvgJkVlhIC
 h4xw==
X-Gm-Message-State: AOAM533M18bFDD43J9yAQhyZs+WS5k0nRpdFy+eeqDPsXK0oGhP+TtWM
 8mC+o6FkBSCSPeXi/PRikaUD3DwRZvvarg==
X-Google-Smtp-Source: ABdhPJzkTbji0EJVRIbe+g7AG4Zc0d9NQ3YKJqrOFIIJ4mDFSNtFKwCMjq4+Yj5HMlY1+l+zkx3APA==
X-Received: by 2002:ac8:39a4:: with SMTP id v33mr11823361qte.251.1590079448777; 
 Thu, 21 May 2020 09:44:08 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:08 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 40/74] i386: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:37 -0400
Message-Id: <20200521164011.638-41-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x82d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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
index 9e8ae1569f..2b60537b23 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7051,7 +7051,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
 
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


