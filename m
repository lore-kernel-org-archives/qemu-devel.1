Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBDC43457
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A0F22461
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 17:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYaWz2r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A0F22461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRIqH-0007NI-TA
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 13:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdm-0000eK-6V
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRIdi-0003ro-HY
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 13:26:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id d81so12886841wmc.1
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GJs+vUPbnbBqVHsKvcVatNykiV7Rg7UUaqvKVc5FZic=;
 b=eYaWz2r4mRDquzy6uPEASAgNB9lW5MXM+p33nvjo4eNH4/HLgmqjrrU3eA1UNEGiG5
 KYi/9fzBjRD6ZTrcB2wzxiLIfiPOQTb3/A8ljKXrgxvsbxMaEt6xW0lmj6+bvjnZohr7
 fmYwmA6GRa96eVLv0Yv4ymyZhJInfjJRXiVehjc7hOiU6rkZI5xtHuUlHOa+Cb0w9CJ9
 UOo1mB2z5V82SfMp4/9RmfIeOoXpawAswsdeQNKtU1cAx9OExam5QoJPuD4O+26kFpKV
 K3DjsboCL/H0ZDMVHa/H93p05RPi1Tqnjy+MyV8rlzaVUBTTu10HIXDU4C37MJNdftqN
 0O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GJs+vUPbnbBqVHsKvcVatNykiV7Rg7UUaqvKVc5FZic=;
 b=H/BPpTJ5ZwrqmfxTiyKK210P+GYO6p7JlCQAcc26BJXhtsaqTqEr747ilKAAdAjl/K
 hNgnS3uUsplorcvsLGdg4t1YBFr3WLzhMk/fYrWJ2zlb3Vy/ey6mu74UDYv2AY75efk0
 /r291Fx6cpvw2oF69adfj2PgjP8u5l99+bM/cZUoRbZgUOHaWS452jFc5+6T/oAM17a1
 qXv6bFdj9N78o/Dhh+tKNNF65R0NUg2dkpPfVt8ZhgaOaoe1khxaK//CMp8bcSjlP/KH
 bMeB0wJDADHcq9uXi7WS3ptiZ57Ww0SnNIpX+IjGELVzQUDrCxyzCY9fzdmhwdjvK8yp
 Vaew==
X-Gm-Message-State: AOAM532OvviJzKK53XYhnMxm8Yk1Lo6e1fFmea2sEAwYXrgoq57bN/rh
 FFCEZNuB5FbBWH6JEgt0bkZi/eHv/WM=
X-Google-Smtp-Source: ABdhPJxempHW8LfOowFAaxwgAsUhj6DQ5ykFG16WIUxFlaJuzZFMZyRjPbUSCsyVE5txDc4nM/8e9A==
X-Received: by 2002:a1c:a9d1:: with SMTP id s200mr3458266wme.107.1602350795548; 
 Sat, 10 Oct 2020 10:26:35 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i11sm16786068wre.32.2020.10.10.10.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 10:26:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/20] target/mips/cpu: Allow the CPU to use dynamic
 frequencies
Date: Sat, 10 Oct 2020 19:26:08 +0200
Message-Id: <20201010172617.3079633-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010172617.3079633-1-f4bug@amsat.org>
References: <20201010172617.3079633-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the Clock API and let the CPU object have an input clock.

If no clock is connected, keep using the default frequency of
200 MHz used since the introduction of the 'r4k' machine in
commit 6af0bf9c7c3.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h |  4 ++++
 target/mips/cpu.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index baeceb892ef..062a4ba6225 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -4,6 +4,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
+#include "hw/clock.h"
 #include "mips-defs.h"
 
 #define TCG_GUEST_DEFAULT_MO (0)
@@ -1151,6 +1152,8 @@ struct CPUMIPSState {
 /**
  * MIPSCPU:
  * @env: #CPUMIPSState
+ * @clock: this CPU input clock (may be connected
+ *         to an output clock from another device).
  * @cp0_count_rate: rate at which the coprocessor 0 counter increments
  *
  * A MIPS CPU.
@@ -1160,6 +1163,7 @@ struct MIPSCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    Clock *clock;
     CPUNegativeOffsetState neg;
     CPUMIPSState env;
     /*
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 461edfe22b7..3deb0245e7c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -27,6 +27,7 @@
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -144,8 +145,8 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = muldiv64(NANOSECONDS_PER_SECOND, cpu->cp0_count_rate,
-                                 CPU_FREQ_HZ_DEFAULT);
+    env->cp0_count_ns = cpu->cp0_count_rate
+                        * clock_get_ns(MIPS_CPU(cpu)->clock);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -155,6 +156,10 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    if (!clock_get(cpu->clock)) {
+        /* Initialize the frequency in case the clock remains unconnected. */
+        clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
+    }
     mips_cp0_period_set(cpu);
 
     cpu_exec_realizefn(cs, &local_err);
@@ -178,6 +183,7 @@ static void mips_cpu_initfn(Object *obj)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
 
     cpu_set_cpustate_pointers(cpu);
+    cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu);
     env->cpu_model = mcc->cpu_def;
 }
 
-- 
2.26.2


