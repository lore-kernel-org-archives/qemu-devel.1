Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE06C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F24C207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHBJeVcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F24C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLrr-0002mq-ML
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiI-0000Xb-IY
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiH-0007SY-07
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so14195275wre.4
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W69f1MWd6lsJIyf72MtAUNNqNrrt140PbQJ0VWAk4GE=;
 b=iHBJeVcDCWDQV126qWVyhVrgqskHR++O2Q09MPlCx+N64wBaRI7PCNqRycHV7g3gss
 8rOdtir21RCEsANy8dYJnxz3qx0r6y8/jiNFhOq6cBRHFieeI8nxgXlVDvODR16UR2gh
 9B/OkNd43RtuhqwAfAkTCFKqtZwkw9cktKXkMlmSju+THK/w1Yi0NiRR905Z3u+Kq1Zm
 xswjpdpwqgJOlt5dZwWy/gAtOhl01NZtDiM3LOR0pk8tGas5ViqyIo5pHYEsKgjprM83
 FDbaHc9L7+F+rCaZlVpno2aLVuGFGmHogNQ7o9WBdYrM0/sqCRQWFVvH9WJQY1syvPqC
 fHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W69f1MWd6lsJIyf72MtAUNNqNrrt140PbQJ0VWAk4GE=;
 b=X8SjbfnfHBQ8j7sT/Ax/VunA24odFLHO3GjAIVsNNCMIYmGVfwPyl/Fwxq8IPH7bf8
 k5Ptv3WBRxrm/p7yxj7FeQ79x0FY8zZ8A3u7nPKhokVsNwNQLB11zr6eBbLJrp0kuFAZ
 EWTqsTm7aTo6RabZ19Hpd7k3J4T1sZhiFRwzAv7pBS3L+Eap+553GUbulGF5gx6b9knf
 6hgrLpDj5852LhyAmeZKyECij3q6W6YcrbvLCzvV+NL9gWpl2qXttrVZ5rZjDQguTFEz
 JaEcrFRPxWAXBSk5knYAW84S04silzJt5mZnhvwiEYT3WXyQVRIIsrqFBHyAN2H/fZXq
 NWQQ==
X-Gm-Message-State: AOAM532nd8jQfxPQ8+B2exzw77EarRp98+B+IeTT16M7P1rb0MRZW/lt
 XHcEMh1SD/EO3j+i59pncbVeYs/kOLU=
X-Google-Smtp-Source: ABdhPJzNquRkH/sSqLDL5dfLi3BzUXlkwpTvLvA34LUNoet/wjBt03BtZyS0LMnvdSqSxT/exzaBhA==
X-Received: by 2002:adf:9461:: with SMTP id 88mr21677769wrq.307.1602362610458; 
 Sat, 10 Oct 2020 13:43:30 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/20] target/mips/cp0_timer: Explicit unit in variable name
Date: Sat, 10 Oct 2020 22:43:05 +0200
Message-Id: <20201010204319.3119239-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Name variables holding nanoseconds with the '_ns' suffix.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cp0_timer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 9c38e9da1c8..5194c967ae3 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -32,13 +32,14 @@
 /* MIPS R4K timer */
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
-    uint64_t now, next;
+    uint64_t now_ns, next_ns;
     uint32_t wait;
 
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    wait = env->CP0_Compare - env->CP0_Count - (uint32_t)(now / TIMER_PERIOD);
-    next = now + (uint64_t)wait * TIMER_PERIOD;
-    timer_mod(env->timer, next);
+    now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    wait = env->CP0_Compare - env->CP0_Count -
+           (uint32_t)(now_ns / TIMER_PERIOD);
+    next_ns = now_ns + (uint64_t)wait * TIMER_PERIOD;
+    timer_mod(env->timer, next_ns);
 }
 
 /* Expire the timer.  */
@@ -56,16 +57,16 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
     if (env->CP0_Cause & (1 << CP0Ca_DC)) {
         return env->CP0_Count;
     } else {
-        uint64_t now;
+        uint64_t now_ns;
 
-        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         if (timer_pending(env->timer)
-            && timer_expired(env->timer, now)) {
+            && timer_expired(env->timer, now_ns)) {
             /* The timer has already expired.  */
             cpu_mips_timer_expire(env);
         }
 
-        return env->CP0_Count + (uint32_t)(now / TIMER_PERIOD);
+        return env->CP0_Count + (uint32_t)(now_ns / TIMER_PERIOD);
     }
 }
 
-- 
2.26.2


