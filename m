Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA48C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694CA206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="v9029UNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694CA206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE5os-0008Rt-IH
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kE5oA-0007dg-4c
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:06:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kE5o5-0002pz-9V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:06:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id 7so3849156pgm.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=uQrg1REyMjiUFdnwANv+hN+vv/GKYugaQbmL1Bq+zcc=;
 b=v9029UNjqKXghW5tuQ8sPiKfTZabmkbhly/wiK0AkAWjeBDsTEUVNHrwj850Fro89u
 qtgvaPpgoXJ+1oeBACWdl+32HLPTOPMEl+oKR9B0HV4BDfa2wfxAtGokKugagXAtkruT
 fJZXYoNlZ7ZZ1oDBXdfN5bPfka/iXxhsIC2MK4/eVBmC41T5IDY37o5Iy/rzuQJBi56Y
 r7zyQcYZupaGZZWjTgoKLuJV1bLR+aMoCM7nifSD/MFRJkAIf6kU4Xs5770FVjHhoIAy
 vwwO1JR6KJGQ2rNZMq4PYdjOFDkw1euhUsHYmLOa9sRWLAQduPZn7Uja1Si/jz7YU3zj
 4Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=uQrg1REyMjiUFdnwANv+hN+vv/GKYugaQbmL1Bq+zcc=;
 b=QnIwuTqI1IN/qPkAu5E67rm6mNo4dimzf+jreHSwa3V25vpDDe7zrb8pgW2+xx0azg
 /245zum16KtkIrO5iQ5kPxCAUwywZHxgaACpE8TbYeEXu9Y7o1PcHXuDEt5LalvIvxKh
 HVpW0BqHQj5eYnF7dBjfvvxf4j7sYplUqCVvAI9YDxtMTmkKVHDv82i7cdxsiyF4tK6Y
 1Y0D7mFn2acUAOhKyJrNnr6T+r4c5aNfB3ws/wRuy2/y8ZyP/De8eredhYsM6NK9e+oP
 35fjAmmNeXCuAhLp/VtCgzYgyvZL6vH8kkdhXM9JljHc8jpzqOk53C6OeIr0ILBOWx83
 IXXw==
X-Gm-Message-State: AOAM532ZfislOVq+Lv+ObqGAEJix+aXK7rUacs/QtBSKrELcleUGRft5
 ku7K5tzf/USRWy34hXFAfDSSUg==
X-Google-Smtp-Source: ABdhPJwVU1oXhQj+vOm0w0kTqs/NX6lfZQWW6JeBT1qXOOzzIKtGhUa8IbUs4R2goBztlmkkSSE0rw==
X-Received: by 2002:a62:4ec9:: with SMTP id c192mr7344485pfb.188.1599203202380; 
 Fri, 04 Sep 2020 00:06:42 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id k5sm19793137pjl.3.2020.09.04.00.06.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Sep 2020 00:06:41 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	ehabkost@redhat.com
Subject: [PATCH] target-i386: seperate MCIP & MCE_MASK error reason
Date: Fri,  4 Sep 2020 15:06:35 +0800
Message-Id: <20200904070635.51318-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x541.google.com
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

Previously we can only get a simple string "Triple fault" in qemu
log. Add detailed message for the two reasons to describe why qemu
has to reset the guest.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 target/i386/helper.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e2c3..0c7fd32491 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -857,6 +857,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *cenv = &cpu->env;
     uint64_t *banks = cenv->mce_banks + 4 * params->bank;
+    char msg[64];
+    bool need_reset = false;
 
     cpu_synchronize_state(cs);
 
@@ -894,16 +896,25 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
             return;
         }
 
-        if ((cenv->mcg_status & MCG_STATUS_MCIP) ||
-            !(cenv->cr[4] & CR4_MCE_MASK)) {
-            monitor_printf(params->mon,
-                           "CPU %d: Previous MCE still in progress, raising"
-                           " triple fault\n",
-                           cs->cpu_index);
-            qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
+        if (cenv->mcg_status & MCG_STATUS_MCIP) {
+            need_reset = true;
+            snprintf(msg, sizeof(msg), "CPU %d: Previous MCE still in progress,"
+                     " raising triple fault", cs->cpu_index);
+        }
+
+        if (!(cenv->cr[4] & CR4_MCE_MASK)) {
+            need_reset = true;
+            snprintf(msg, sizeof(msg), "CPU %d: MCE capability is not enabled,"
+                     " raising triple fault", cs->cpu_index);
+        }
+
+        if (need_reset) {
+            monitor_printf(params->mon, "%s", msg);
+            qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
         }
+
         if (banks[1] & MCI_STATUS_VAL) {
             params->status |= MCI_STATUS_OVER;
         }
-- 
2.11.0


