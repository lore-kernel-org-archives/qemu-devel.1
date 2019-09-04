Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC7D20820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9rKGZKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC7D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cwi-00021A-IX
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9e-0006Jp-5R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9c-0006uA-FT
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:25 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:44663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9c-0006t2-6o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id k1so76790pls.11
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5HAooVFLsWGcsosw6Q3OZtvuZFTGrXxCMoBP6XCwIK8=;
 b=R9rKGZKanh3PSjw2Xqc7ae9yWdK8ys8c4rZs+VEqCu7tzLHaKGbJynSXPfnp+zQ3P7
 Dtl94ZWuGPezGl6LfT/xuyeChltCOItwg5o1/6vVDb+iWMv9qt9IrudHvUP9GbVCI+O6
 fTpFfccMsnLAKclm2cMHfxl75ZPdDzarj/BmWsAqKQTuBn+9bL0J5hukCZGjZcS4Eg+f
 CXAoovQ/16ePNkkhpMaQx61VdB9CihQLiiMk3jyO15gkMKZp4BqLr9b8tQly7oBl8R4e
 5INroTjndK+iRr7zeKvy8qc4gCxfpvNHB3SVFQc/BzYln0Xdg0zekBEZVDCvGqcjSJPZ
 p2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5HAooVFLsWGcsosw6Q3OZtvuZFTGrXxCMoBP6XCwIK8=;
 b=TM4ePpjtZ6MR/iMyzgHLV8Y0CQejwawZH0PyahLotAnx3qWN5mxq3Ufr0oeN47xplm
 OaTNIJNUax0MVBQ/7l4b5IvkDr6/LvRcAa5AXF5QuwCfQGuthmlx2BJRGkmjJyVSke9x
 FMqpZLWyQLbGoZtMQ8Bwyy8hHbCovB43lmIoNEkLuus2UPpaGCNFiOW5V+KtgUEMJ1yu
 +6ygClnM9TM3U0GWGVYiEiE7AA3AqwaI0K5XNSgBPvfMDwz4xbHTYSFRhy3ZU3m/7LIT
 p1zHA79luOiDO+L9ClL0yOgj8tdZTgtU65nUWZZ79pF2sIWh6PuSW5dweTwFEAvhiSfy
 Bgtw==
X-Gm-Message-State: APjAAAWSzkYOIDNOqWvcZGhwDPQeN4W1oWFedL8Fd0LD1WuoWLj1blZO
 INVSFa4u9fxysoBKY38ZvHSAjw3kJQI=
X-Google-Smtp-Source: APXvYqzvRaybbFaX94wSkelSrqDemr08vBTALICn0z1VQ3Tqg6ZgzGXjOZtTzGWpXXjUb8iioiGKrQ==
X-Received: by 2002:a17:902:7441:: with SMTP id
 e1mr43091517plt.332.1567629923016; 
 Wed, 04 Sep 2019 13:45:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:05 -0700
Message-Id: <20190904204507.32457-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
Subject: [Qemu-devel] [PULL 11/13] target/openrisc: Implement move to/from
 FPCSR
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        |  2 ++
 target/openrisc/cpu.c        |  1 +
 target/openrisc/fpu_helper.c | 13 +++++++++++++
 target/openrisc/machine.c    | 11 +++++++++++
 target/openrisc/sys_helper.c | 18 ++++++++++++------
 5 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 71c5959828..0ad02eab79 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -413,6 +413,8 @@ static inline void cpu_set_sr(CPUOpenRISCState *env, uint32_t val)
     env->sr = (val & ~(SR_F | SR_CY | SR_OV)) | SR_FO;
 }
 
+void cpu_set_fpcsr(CPUOpenRISCState *env, uint32_t val);
+
 #define CPU_INTERRUPT_TIMER   CPU_INTERRUPT_TGT_INT_0
 
 #endif /* OPENRISC_CPU_H */
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b931605e62..f96a69e278 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -55,6 +55,7 @@ static void openrisc_cpu_reset(CPUState *s)
     cpu->env.sr = SR_FO | SR_SM;
     cpu->env.lock_addr = -1;
     s->exception_index = -1;
+    cpu_set_fpcsr(&cpu->env, 0);
 
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 7bcef9dc53..59e1413279 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -61,6 +61,19 @@ void HELPER(update_fpcsr)(CPUOpenRISCState *env)
     }
 }
 
+void cpu_set_fpcsr(CPUOpenRISCState *env, uint32_t val)
+{
+    static const int rm_to_sf[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down
+    };
+
+    env->fpcsr = val & 0x7ff;
+    set_float_rounding_mode(rm_to_sf[extract32(val, 1, 2)], &env->fp_status);
+}
+
 uint64_t HELPER(itofd)(CPUOpenRISCState *env, uint64_t val)
 {
     return int64_to_float64(val, &env->fp_status);
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 0a96404dc6..b92985d99b 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -121,10 +121,21 @@ static const VMStateDescription vmstate_env = {
     }
 };
 
+static int cpu_post_load(void *opaque, int version_id)
+{
+    OpenRISCCPU *cpu = opaque;
+    CPUOpenRISCState *env = &cpu->env;
+
+    /* Update env->fp_status to match env->fpcsr.  */
+    cpu_set_fpcsr(env, env->fpcsr);
+    return 0;
+}
+
 const VMStateDescription vmstate_openrisc_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_CPU(),
         VMSTATE_STRUCT(env, OpenRISCCPU, 1, vmstate_env, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index cf8e637b08..d9fe6c5948 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -37,8 +37,10 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     CPUState *cs = env_cpu(env);
     target_ulong mr;
     int idx;
+#endif
 
     switch (spr) {
+#ifndef CONFIG_USER_ONLY
     case TO_SPR(0, 11): /* EVBAR */
         env->evbar = rb;
         break;
@@ -179,10 +181,12 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         }
         cpu_openrisc_timer_update(cpu);
         break;
-    default:
+#endif
+
+    case TO_SPR(0, 20): /* FPCSR */
+        cpu_set_fpcsr(env, rb);
         break;
     }
-#endif
 }
 
 target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
@@ -193,8 +197,10 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
     OpenRISCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     int idx;
+#endif
 
     switch (spr) {
+#ifndef CONFIG_USER_ONLY
     case TO_SPR(0, 0): /* VR */
         return env->vr;
 
@@ -303,12 +309,12 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
     case TO_SPR(10, 1): /* TTCR */
         cpu_openrisc_count_update(cpu);
         return cpu_openrisc_count_get(cpu);
-
-    default:
-        break;
-    }
 #endif
 
+    case TO_SPR(0, 20): /* FPCSR */
+        return env->fpcsr;
+    }
+
     /* for rd is passed in, if rd unchanged, just keep it back.  */
     return rd;
 }
-- 
2.17.1


