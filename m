Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB5BC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8780A208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="C7a0ltWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8780A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHorg-0004wg-8k
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHola-0004Kr-Ps
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHolY-0003DP-8R
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:33 -0400
Received: by mail-pg1-x543.google.com with SMTP id 34so11565921pgo.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uQrg1REyMjiUFdnwANv+hN+vv/GKYugaQbmL1Bq+zcc=;
 b=C7a0ltWl6GQDSzT0MRVC+/MVpTf35edDb2/ALFKVEFo6kVoYrnjonGpxCD9AGCuaak
 rL8yOzP/FaJAQs1BhPf1fNNwG3HJsXpwpVuR5/xQmK8rsorGhZ25otdWZjxAz7md7NvC
 bWbw9nbHKp5CclIfm4vKaPTcIk3f6z1v4vpg2e6Ud9iT7nB/F2bREbfN8JkpjtiMNF4e
 WS/mrGxLUSKPOr3XHPUlQlQSkdHkJECMcCsb+k9MweskDKsuRSv1xEBHD1NuIkDB28zj
 Qn+RQF7VPhkjPKsPFBlcgMUsF+3EmKTBnvYopeOwrOypBRcOi1Or+daf6AkeaMIU972w
 qnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uQrg1REyMjiUFdnwANv+hN+vv/GKYugaQbmL1Bq+zcc=;
 b=QGpaoujDZuzoIi5xZK5UvCRxX4InWZxNXJHzBRWv1a0tcKuJXcL/LlyToTfOItvsav
 IXrHntxvhiPmmoBHcl/yhs3QCoK3fYQm/RbyLgKSgYV2U8FR+clKKB9tM8DHdc2/8QC4
 LssGGfGF0+iwYPV0o8hnaKWWUirt6XtuAcB3Lxtk0Kj9JIOfi7xZm/bBAKTFoWjoi897
 Hua40/UrQk3gwjNCJBMX+qI7tA7rgsfmqUIM0CyNyLCp/QCrbNgBr2v1IxAAG+srMsln
 iTQyALCH0xsRc3OwtX/F69hrlyDJlY+Mmfp30xks9KOH0prrg2Z7KfUo5zV+F/CgOgPN
 zzUg==
X-Gm-Message-State: AOAM5323yxNw/Yfsg0AmLxkz+BOIywXNz9WTvIjHQQ9J2oTc2EianNvg
 9qtEQy4VjsmlKMW2XypPyTd11qMTNf9oKQ==
X-Google-Smtp-Source: ABdhPJzse4Mfto7/6YHK4720MVQ6yJ+5UCF6h1YuS2hHbe69kNs5Kr+Ek0SEuxdDDBiV1xa63ukggQ==
X-Received: by 2002:a62:e501:0:b029:13c:1611:6527 with SMTP id
 n1-20020a62e5010000b029013c16116527mr13273942pff.7.1600091010913; 
 Mon, 14 Sep 2020 06:43:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c4sm7626378pjq.7.2020.09.14.06.43.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Sep 2020 06:43:30 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: armbru@redhat.com,
	pbonzini@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 1/3] target-i386: seperate MCIP & MCE_MASK error reason
Date: Mon, 14 Sep 2020 21:43:19 +0800
Message-Id: <20200914134321.958079-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200914134321.958079-1-pizhenwei@bytedance.com>
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x543.google.com
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


