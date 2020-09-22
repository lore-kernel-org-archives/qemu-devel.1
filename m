Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8FC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8E9238A1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="rWRw0pGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8E9238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKf4d-000593-Ku
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2R-0002Jd-Kd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2P-0001s6-Ak
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id l71so11525374pge.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uQrg1REyMjiUFdnwANv+hN+vv/GKYugaQbmL1Bq+zcc=;
 b=rWRw0pGsRJ+BAci003Wmj8VSnJYyjRMbniDuJvP0+7kyuBQNxTKMCFb3vKRqi8XVFQ
 hThsrEa1AGUEyCL6SdkLqjJ9V+BVz/q5fb2inyG/XaS+D9gEWRE4YJuA8Z3QZOv0MnTg
 kHARQ9phN6ftVCIBmW/l+iSktW6I61fe4TMtlYPO3JtxzOBP3v5GJmzcbmcvjm+P/rgy
 rFGbUNDPlsRjDQMVspVR/ZW0aDKv2K9ZNvvZ2yPFzs941sFzdKpmPmO85G0F0dLx7yE3
 kTL1tug06MSbf8DBcY8NjlgQafZdUQX2Fyx5o6J5GuEOFz4YgEZtxyJJkgTg7PC3BUX2
 N89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uQrg1REyMjiUFdnwANv+hN+vv/GKYugaQbmL1Bq+zcc=;
 b=e56aNNI8GN0MXAQDHBPhBFIOfYnKcOQFJpZ6beNFX1sXPGUMRJ5897bAPf/dhsx4mk
 jBVt/Z4HGSCA5ywrRGf7EPvMynVm/LKwj57XqLcJWF53VOFcn2NUoDJdRx6ndD7hl4Kj
 bekBDw37uRLisRPE5mztA0NERR5gFxoVowbhaHaD8A9tNC73RPuJpPpV3EgCccwrEBGF
 A7hqeZXBixQbLpU2xOe3KmcpDtmWewIMKRkJvVoG7Equfvx1ENeO3bB5G08UWzouiJPn
 KH2FmAvxsmHoVhvIXUVN6wGwcBJRk0EXc7NK2MU38CFSdXrDvCvXVzKJzkITpVX31HN0
 q6DA==
X-Gm-Message-State: AOAM533g+E8lvANZUPSIRT5Mz2OIXiYStU+HMi1uA8kIG6fUFsazSKB6
 YZOgSU8QRlU5670QVxFVBk8xiyeDrGvocQ==
X-Google-Smtp-Source: ABdhPJy/XWX2MaJcWGO4gr4SbWRkwzhHUb1rVrwbZzcMKz2TrLFkSxKSVUorPon4xJAks/orMW6WxA==
X-Received: by 2002:a63:1925:: with SMTP id z37mr2897417pgl.23.1600768600121; 
 Tue, 22 Sep 2020 02:56:40 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id e2sm2013239pjm.27.2020.09.22.02.56.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:56:39 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v2 1/3] target-i386: seperate MCIP & MCE_MASK error reason
Date: Tue, 22 Sep 2020 17:56:28 +0800
Message-Id: <20200922095630.394893-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200922095630.394893-1-pizhenwei@bytedance.com>
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
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
Cc: mtosatti@redhat.com, armbru@redhat.com, pizhenwei@bytedance.com,
 qemu-devel@nongnu.org
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


