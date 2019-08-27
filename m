Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F4C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957E620850
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pC3OgrB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957E620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2PFR-0001GC-PB
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1n-000893-4a
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1l-00077w-Kz
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:08:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1l-00077Y-FA
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:08:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id y9so12493597pfl.4
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VMVNHtG8xLt0ZpdZqzxYszuIzxm6Ie0YlfmnzhGbWKg=;
 b=pC3OgrB7e7eAqtTParyN0fdZq7RKDzBGYLiinj1l6X1YtJRL99rKpHt1owW7/k10hD
 b7ol2oKPdaaLf5Yc3lErsUiZua/K3VnR7uWZ5SuYAmr898z+NRq+05k8tBKRVzDpzEbx
 5svkvkUe8yRMiXBkTm15nDl2tROT+KD5HGBDO8E2050+uuzlY3k6Ry8RPnmpYTUIOAqu
 Eh4umaOzFgM3e1xjYSKtnptioSwLuR0EqnuVdvrUHipsYEwXr0bUsNmOfHp4smWTW4u6
 Q0sV7ZlIoERWANVmb3GVUbFobG9QOLDswzGoIu4QXnonGgIhYQVZOHC7wajRpDStfZfE
 e0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VMVNHtG8xLt0ZpdZqzxYszuIzxm6Ie0YlfmnzhGbWKg=;
 b=nXwD8YjWAua3M79XdxC8QhJQVJ5xRnF5ePMoZs4k+n7YBnbMnjWyL/fPuWYP3Cf3BM
 bdgPnepIC7BGM++0KHwz0kcsYtA8/QUjDE0iS/fu4O8Y3mJoirjlsdrNiWn4Vqwi6DEz
 G1Q7KXA7B2Toet3UPom126ew1ODuN6jRUAmpV82LGzSay693IVFAJYnbgac9IuykuZX8
 GOJYy6umx2g1SCmRjsnddXP1CvwMofdStSop1PiBYRIfvlr8bW2LVvdMna5urqwK4Mwa
 fXfqrA76AQP3jfxk58pUDIdkPfkI4qJKfjAZ1oC9sWI9+iri9EPiiRIOlvgSW/spV3SE
 0VCQ==
X-Gm-Message-State: APjAAAUsbIs+7sq1oSDO6GQaDLoKycSG2NPXQ97VpAq9QpuB8xMHnYrH
 4aMs7UVdk2rMvDq2+U3gfLxj2tRoDD0=
X-Google-Smtp-Source: APXvYqwPoSTUH5a26Pf1j//sz1XvDOlJY1wjMe51fG3EXnjvIYoDflto4H3O8s2Fc+S5fpJfYLzRCg==
X-Received: by 2002:a63:1046:: with SMTP id 6mr19226689pgq.111.1566864480061; 
 Mon, 26 Aug 2019 17:08:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:43 -0700
Message-Id: <20190827000745.19645-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 11/13] target/openrisc: Implement move to/from
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


