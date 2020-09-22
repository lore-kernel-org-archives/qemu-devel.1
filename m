Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0389C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7FB2388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="RevQ/3fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7FB2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKf5z-00084p-8u
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2X-0002UZ-In
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2V-0001sc-Rn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id n14so11948403pff.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EHvZtj7O7tPXhkiMzmOQzfWVzNatukvByFnFp0mGAN4=;
 b=RevQ/3fYwNr92g+duuuVr1EkEjl0iZhd6Rqb1/LtNkUTxBasoWVWVkf0/MG1tmo8FJ
 ZfGYb9V/Ufsigk9ToB+JdVvRtsee084Pr/VK9KguGu5XvrVc5gbph7MquixNVi95GCQs
 eKOPJibKiCPsKVoKTc/mk8rOnrZUfq3TBFswVXXwYcVnwfO2v3VCFiDEcn3iBwKQExGe
 iBd9pKv/Vh19gaV9nrGpVjaCUiGy26I8srC9e52wwKBw9/ZohqFJH4BtkrR7FG0kc38Y
 SQVf34253g5KZtY6/NNUtOAju7X6TyRSevMdUxS7VriJH9eeWGXVz+vdQZ7e9X9atk2h
 XSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EHvZtj7O7tPXhkiMzmOQzfWVzNatukvByFnFp0mGAN4=;
 b=b81qTqoqvphV2uE7dAAr/39GOKtdE2KsBu+WeAyXDZQf0UmVuAxNssmkC8IJ7qaNB/
 D6ncV3ALj9RYD/P1BAYHbOzm5l5W5+whLmhvyccJnZQLgedZXR9pveSiTlYsuXx5Km3+
 7/+aeyHgF55HmmOTApw80nxE+V3UV5YclVt5LApqHysaf9IQlMn5/8OsOzbOO9MwGpdH
 Qzjx0k4GZxYYf9BydkqU0uzBlWyVRHXV74cnvF0SDRogECz24Ee2WV2jtCUz+0V8B/Z1
 9h46hj04NNVCqGseSe3s8JUNe0C/o2RxDFWUc98XQgFIGjRQUrgwHsxXqVbuAoiNEclp
 V90g==
X-Gm-Message-State: AOAM5304khSdTeTt9H50aaGgEFUhiy8ZjHEZm/NyfcZ5miYr5wak4nFd
 p2te0NuqjTXnIFn6Foz11qzHDg==
X-Google-Smtp-Source: ABdhPJxAX5p0Y6fcgu9jFlxeeO+QZF/v78S6U/3zd6efRjHzAerkZRwrqyFiq5juE+SGFC0JotNKiw==
X-Received: by 2002:a62:10a:0:b029:142:2501:39e1 with SMTP id
 10-20020a62010a0000b0290142250139e1mr3404072pfb.48.1600768606657; 
 Tue, 22 Sep 2020 02:56:46 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id e2sm2013239pjm.27.2020.09.22.02.56.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:56:46 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v2 3/3] target-i386: post memory failure event to uplayer
Date: Tue, 22 Sep 2020 17:56:30 +0800
Message-Id: <20200922095630.394893-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200922095630.394893-1-pizhenwei@bytedance.com>
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mtosatti@redhat.com, armbru@redhat.com, pizhenwei@bytedance.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Post memory failure event to uplayer to handle hardware memory
corrupted event. Rather than simple QEMU log, QEMU could report more
effective message to uplayer. For example, guest crashes by MCE,
selecting another host server is a better choice.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 target/i386/helper.c | 15 +++++++++++++++
 target/i386/kvm.c    |  7 ++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 0c7fd32491..47823c29e4 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/qemu-print.h"
@@ -858,6 +859,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     CPUX86State *cenv = &cpu->env;
     uint64_t *banks = cenv->mce_banks + 4 * params->bank;
     char msg[64];
+    MemoryFailureFlags mf_flags = {0};
     bool need_reset = false;
 
     cpu_synchronize_state(cs);
@@ -869,6 +871,12 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     if (!(params->flags & MCE_INJECT_UNCOND_AO)
         && !(params->status & MCI_STATUS_AR)
         && (cenv->mcg_status & MCG_STATUS_MCIP)) {
+        mf_flags.has_action_required = true;
+        mf_flags.action_required = false;
+        mf_flags.has_recursive = true;
+        mf_flags.recursive = true;
+        qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE_INJECT,
+                                       true, &mf_flags);
         return;
     }
 
@@ -909,6 +917,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         }
 
         if (need_reset) {
+            qapi_event_send_memory_failure(
+                 MEMORY_FAILURE_ACTION_GUEST_MCE_FATAL, false, NULL);
             monitor_printf(params->mon, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
@@ -934,6 +944,11 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     } else {
         banks[1] |= MCI_STATUS_OVER;
     }
+
+    mf_flags.has_action_required = true;
+    mf_flags.action_required = !!(params->status & MCI_STATUS_AR);
+    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE_INJECT,
+                                   true, &mf_flags);
 }
 
 void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9efb07e7c8..989889c291 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-run-state.h"
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
 
@@ -577,6 +578,8 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 
 static void hardware_memory_error(void *host_addr)
 {
+    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_FATAL,
+                                   false, NULL);
     error_report("QEMU got Hardware memory error at addr %p", host_addr);
     exit(1);
 }
@@ -631,7 +634,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         hardware_memory_error(addr);
     }
 
-    /* Hope we are lucky for AO MCE */
+    /* Hope we are lucky for AO MCE, just notify a event */
+    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_IGNORE,
+                                   false, NULL);
 }
 
 static void kvm_reset_exception(CPUX86State *env)
-- 
2.11.0


