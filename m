Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DCBC4727D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DED2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuCquimD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DED2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLwp-0002Jr-7g
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmw-0008GY-84
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmu-0007LC-GH
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id d81so2593057wmc.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+qTSz1E9WPbTWRbvvqKtc2mBpV+7bgZoqIwjSP5/4yk=;
 b=IuCquimDXf+B7F5q6uUK2dKhSU9jrnsEg4ueW3wqSeQ+Hu2ZI8R4secncuTQ9i3VG1
 43jU2dJK2YUtXZt8SKNhpXP2m+WUaYkUa8KCUixgWO0J/zzWC/SNqGrbQhCwZ6RQxHhc
 82db94RxcgAT0pzSv6u+YCMLHQe9vby1ebCTyA2+Oja4ZCZ6B6DR/DGkNoLyIMP9XDLp
 58RmwlJCGvr4uHcjtleq5oWRvzcv50vvxcCxASD5wC5QKwTJMCwh2xpjqeS6Yee/k2Dv
 rDMSOTDe6WnIJ7mz7FJ2eWLIXx8TZarec1jekZL4ih1awyiUy1RbcqO71nEOBVCPzRqg
 wkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+qTSz1E9WPbTWRbvvqKtc2mBpV+7bgZoqIwjSP5/4yk=;
 b=uR79FDfajC7ZlkjWxtFk/MvfYohzpL1Ld5n4aGT1vAauDUi4r1HYWtEDRU7D/ZfdKc
 dPw47aozs/Vt9x8N2fT8j4cBvTbYHH3jptVJWtawaB1HwQy0tHwJQOl8adPWxBWTLSLb
 X6ppsMJh82EVWHkHMhT5kCwcXXdl77hkw2CSqsz+lDpqCw5XBEeFmGPw0njJ0Ldqtjt0
 +V2W3q+noCbFE1wea7yJ4aCNWcbGokZLoVOApGHEijkwA9CHMPwg8k0UZoFKOpW24/w1
 8A5qwse0ybaykXsmy1yeFUiflv7hVUGZZKvwvGo5g83TGAYxkAoXBG6Qc3tfdJRxYZ54
 ZbBg==
X-Gm-Message-State: AOAM531SPDtcnmZt/IZNYxwijGuM6ZukcVJxmsJcttzmqqgUPXd4d8u8
 CvPrx+CslGjlwgt2bG4dAcAI3X0cRUk=
X-Google-Smtp-Source: ABdhPJyu2P2Ic9BnxwXAGYPeNKmI9StUsr8W4hUfFXG780b7NDvObCHcGe1HiRUL+G2IOAvLx2e5XA==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr3611232wmi.6.1601886242818;
 Mon, 05 Oct 2020 01:24:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:24:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] target-i386: post memory failure event to QMP
Date: Mon,  5 Oct 2020 10:23:47 +0200
Message-Id: <20201005082349.354095-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhenwei pi <pizhenwei@bytedance.com>

Post memory failure event through QMP to handle hardware memory corrupted
event. Rather than simply printing to the log, QEMU could report more
effective message to the client. For example, if a guest receives an MCE,
evacuating the host could be a good idea.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20200930100440.1060708-4-pizhenwei@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 24 ++++++++++++++++++++----
 target/i386/kvm.c    | 13 ++++++++++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 17e1684ff9..32fa21a7bb 100644
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
+            emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
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
index f6dae4cfb6..8b12387d30 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/qapi-events-run-state.h"
 #include "qapi/error.h"
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
@@ -549,8 +550,17 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
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
@@ -605,7 +615,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         hardware_memory_error(addr);
     }
 
-    /* Hope we are lucky for AO MCE */
+    /* Hope we are lucky for AO MCE, just notify a event */
+    emit_hypervisor_memory_failure(MEMORY_FAILURE_ACTION_IGNORE, false);
 }
 
 static void kvm_reset_exception(CPUX86State *env)
-- 
2.26.2



