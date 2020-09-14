Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BAFC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C5B208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="iO2NTlUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C5B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHosx-00072J-HB
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHolf-0004aC-QO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:34507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHole-0003Dt-2O
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id v196so12803331pfc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JROvm5rr8+1Wo6J5ML/BSylPouNvBTyMPETS3dPRS0U=;
 b=iO2NTlUwRzUBjKxIrIcrFbtpVDp0XQ0a1GoBBi8ezebXOEJYVnCFA5YE3yDHFpdqN0
 UpWaBYutZ4W4KeHjlRUo8YXQlFpdCWW8EvFRG62gxkpBQmf5/514DLIH3AYrmBwTKN2t
 Yz7jfi/B0b3JGjFqS/Y3jbHISVXncB3CmGQ1E5LcDjurXf13L116h9PLNMYAX0SWIQg3
 huxoZAHVkCFMhas2w877YQjNDg5iqiQJXguTI0mAC1dlCGQzsYmeRo6kR8PXrhcOHc4q
 OrcOAPKjL+uy+FdtvWCXzfGL9Dn/iYq+NmYnnQYKaUeBW1itpVT8EgRpKhrFZSNJb8u2
 3LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JROvm5rr8+1Wo6J5ML/BSylPouNvBTyMPETS3dPRS0U=;
 b=NFZff72ez7sXpfKCl/T3CO/wUgzGYwRWQY1nH3z3cB45bnWruNZ1SVZHUYJoWmSrBl
 UE3vt0HOdpyrcuCXyoSBayfHcGucPmVYg6iL6TZuObHKuAP/0w32IUsfSN9VDY55gc7O
 G5h/2A8xE5xtKUxPjLbJEQSiQh5UjP6bA0iDJnaLKlaa01F8/LB91A1qAGk2WLWi48q+
 6euJbLqrJMumwyDocDLBeQj7uADXgyZ+XQcaDmD7Ooxrmee9PaH5jU7zyKUXXNhilgrz
 eMRPojwaOuVevvyydcFKnlklV/IIN6K1+jBpevw4nU7yDjM/F9TQBb02WOVpeCHYQWVX
 REVw==
X-Gm-Message-State: AOAM533QaBTxmeHJAVCMHd71IAkHVfAHcP3betH+1iddMiqM7ZJPVzsT
 D3zhT79VjU/O5pfeApqyo0v3Yg==
X-Google-Smtp-Source: ABdhPJz3IDFU3LaNb/2kVDj8Xj91ZvFmbnrqBDRygh4Rh/LOCuRErfRq2Y/yjx+HnrSSKzRvQT3idQ==
X-Received: by 2002:a62:4e49:: with SMTP id c70mr13275778pfb.100.1600091016777; 
 Mon, 14 Sep 2020 06:43:36 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c4sm7626378pjq.7.2020.09.14.06.43.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Sep 2020 06:43:36 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: armbru@redhat.com,
	pbonzini@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 3/3] target-i386: post memory failure event to uplayer
Date: Mon, 14 Sep 2020 21:43:21 +0800
Message-Id: <20200914134321.958079-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200914134321.958079-1-pizhenwei@bytedance.com>
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x432.google.com
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
Cc: qemu-devel@nongnu.org, pizhenwei@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Post memory failure event to uplayer to handle hardware memory
corrupted event. Rather than simple QEMU log, QEMU could report more
effective message to uplayer. For example, guest crashes by MCE,
selecting another host server is a better choice.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 target/i386/helper.c | 5 +++++
 target/i386/kvm.c    | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 0c7fd32491..f7b2dbeec8 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/qemu-print.h"
@@ -897,6 +898,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         }
 
         if (cenv->mcg_status & MCG_STATUS_MCIP) {
+            qapi_event_send_memory_failure(
+                 MEMORY_FAILURE_ACTION_GUEST_TRIPLE_FAULT);
             need_reset = true;
             snprintf(msg, sizeof(msg), "CPU %d: Previous MCE still in progress,"
                      " raising triple fault", cs->cpu_index);
@@ -934,6 +937,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     } else {
         banks[1] |= MCI_STATUS_OVER;
     }
+
+    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_GUEST_MCE);
 }
 
 void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 205b68bc0c..63a585cc64 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-run-state.h"
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
 
@@ -577,6 +578,7 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
 
 static void hardware_memory_error(void *host_addr)
 {
+    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_STOP);
     error_report("QEMU got Hardware memory error at addr %p", host_addr);
     exit(1);
 }
@@ -631,7 +633,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         hardware_memory_error(addr);
     }
 
-    /* Hope we are lucky for AO MCE */
+    /* Hope we are lucky for AO MCE, just notify a event */
+    qapi_event_send_memory_failure(MEMORY_FAILURE_ACTION_HYPERVISOR_IGNORE);
 }
 
 static void kvm_reset_exception(CPUX86State *env)
-- 
2.11.0


