Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D187C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3A72074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="RfdEwHOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3A72074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ86-0003uF-Is
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyn-0003Om-4I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyl-0005DK-61
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id k13so870593pfg.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rNTLRO7eI/MsFc78yk63Tq1O7QMzt9xIGkepVz1ORQA=;
 b=RfdEwHOm/YtysAXRfe7WQW6Q4ZJNpK8yO+i/9mR3jxX+OVgJP6mkdNtKncDUHHL6HM
 mDQDlHtRVb7661IDKWnF+qQsco+esHlfWIc55TNHHcF+dvbdTIGjm2dtzUpuB686O+7N
 TwriZ6c4+WAZxxAOwawK0HDxkkvxstgpOJg54+cXBR8j/jPNiExY5Zs6rAw9DJ69rK9z
 C/OVMfFxSKt1P/lSw4UrGmJojpdkC0FBz62UqhQ3o2iiaKnSRxbniyqmVjYwDfwmoXMq
 3bO6yDIVqtUugZAwHVod2CAaaXcIGUm1DPwZ/CyTpo2Sl8ru9eTkDyHTD6tXhkuZrPR+
 Nr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rNTLRO7eI/MsFc78yk63Tq1O7QMzt9xIGkepVz1ORQA=;
 b=GICtNV7/AWDQR4/6VaA8PJ0yAf/7AzomgbifSy4ez7n4EnmPslqy8LvgN0jb3EjXbY
 oBnX0nwx2t8ac/m6a06syFHzjDmJ6iYRcLtWm3ikosbmduZ4ZbJDrCX5JdNyj/AStoMK
 PXZ5RWXl4LqI1pjrjoXNJV3oL8EB319rY+UnaZwhf8zDWxQvbkrLU3Acgno6OwW6+eQm
 Wvur/BSL7om0aw8MTXsGb7fvzEPpp291E8sRJSuHlPu021UQG3Rwni051d2FSCfQbM5Q
 AJ875Hde0oPrNWDufJW/S/MsP1EYnDVKR3HAQzusoU7DUVpHyYHWChSNmAYHOy6SKnxi
 u+bg==
X-Gm-Message-State: AOAM532QBHFIJoDP3KtY74VFeg5lq700AYiVAOUdVNNH3ocAIxq0umDC
 7EmOso0mD9TgOWsAUsMjV/u37Q==
X-Google-Smtp-Source: ABdhPJxG0VpP00vLQ3zN321QiHTdOpuRsUyHXysd1hI3TMFTQDpaw+AKN5L+PX/TXrHYh6EtdmRWBg==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr1517836pgk.137.1601460293836; 
 Wed, 30 Sep 2020 03:04:53 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c185sm1884230pfb.123.2020.09.30.03.04.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:04:53 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v3 3/3] target-i386: post memory failure event to uplayer
Date: Wed, 30 Sep 2020 18:04:40 +0800
Message-Id: <20200930100440.1060708-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200930100440.1060708-1-pizhenwei@bytedance.com>
References: <20200930100440.1060708-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x441.google.com
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
Cc: qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Post memory failure event to uplayer to handle hardware memory
corrupted event. Rather than simple QEMU log, QEMU could report more
effective message to uplayer. For example, guest crashes by MCE,
selecting another host server is a better choice.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 target/i386/helper.c | 24 ++++++++++++++++++++----
 target/i386/kvm.c    | 13 ++++++++++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 17e1684ff9..2a184c4835 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/qemu-print.h"
@@ -851,6 +852,15 @@ typedef struct MCEInjectionParams {
     int flags;
 } MCEInjectionParams;
 
+static void emit_guest_memory_failure(MemoryFailureAction action, bool ar,
+                                      bool recursive)
+{
+    MemoryFailureFlags mff = {.action_required = ar, .recursive = recursive};
+
+    qapi_event_send_memory_failure(MEMORY_FAILURE_RECIPIENT_GUEST, action,
+                                   &mff);
+}
+
 static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
 {
     MCEInjectionParams *params = data.host_ptr;
@@ -859,16 +869,18 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     uint64_t *banks = cenv->mce_banks + 4 * params->bank;
     g_autofree char *msg = NULL;
     bool need_reset = false;
+    bool recursive;
+    bool ar = !!(params->status & MCI_STATUS_AR);
 
     cpu_synchronize_state(cs);
+    recursive = !!(cenv->mcg_status & MCG_STATUS_MCIP);
 
     /*
      * If there is an MCE exception being processed, ignore this SRAO MCE
      * unless unconditional injection was requested.
      */
-    if (!(params->flags & MCE_INJECT_UNCOND_AO)
-        && !(params->status & MCI_STATUS_AR)
-        && (cenv->mcg_status & MCG_STATUS_MCIP)) {
+    if (!(params->flags & MCE_INJECT_UNCOND_AO) && !ar && recursive) {
+        emit_guest_memory_failure(MEMORY_FAILURE_ACTION_IGNORE, ar, recursive);
         return;
     }
 
@@ -896,7 +908,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
             return;
         }
 
-        if (cenv->mcg_status & MCG_STATUS_MCIP) {
+        if (recursive) {
             need_reset = true;
             msg = g_strdup_printf("CPU %d: Previous MCE still in progress, "
                                   "raising triple fault", cs->cpu_index);
@@ -909,6 +921,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         }
 
         if (need_reset) {
+            emit_guest_memory_failure(MEMORY_FAILURE_ACTION_FATAL, ar,
+                                      recursive);
             monitor_printf(params->mon, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
@@ -934,6 +948,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     } else {
         banks[1] |= MCI_STATUS_OVER;
     }
+
+    emit_guest_memory_failure(MEMORY_FAILURE_ACTION_INJECT, ar, recursive);
 }
 
 void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9efb07e7c8..923749f5d8 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/qapi-events-run-state.h"
 #include "qapi/error.h"
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
@@ -575,8 +576,17 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
                        (MCM_ADDR_PHYS << 6) | 0xc, flags);
 }
 
+static void emit_hypervisor_memory_failure(MemoryFailureAction action, bool ar)
+{
+    MemoryFailureFlags mff = {.action_required = ar, .recursive = false};
+
+    qapi_event_send_memory_failure(MEMORY_FAILURE_RECIPIENT_HYPERVISOR, action,
+                                   &mff);
+}
+
 static void hardware_memory_error(void *host_addr)
 {
+    emit_hypervisor_memory_failure(MEMORY_FAILURE_ACTION_FATAL, true);
     error_report("QEMU got Hardware memory error at addr %p", host_addr);
     exit(1);
 }
@@ -631,7 +641,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         hardware_memory_error(addr);
     }
 
-    /* Hope we are lucky for AO MCE */
+    /* Hope we are lucky for AO MCE, just notify a event */
+    emit_hypervisor_memory_failure(MEMORY_FAILURE_ACTION_IGNORE, false);
 }
 
 static void kvm_reset_exception(CPUX86State *env)
-- 
2.11.0


