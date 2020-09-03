Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970EC2BC0E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C62206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpfXSgm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C62206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvkU-0007aO-8U
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj5-00069z-QY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj3-00084m-O4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id c19so6083994wmd.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hOtqBYNVN0odFdezyYG5pn2QHUjOmA1+K/WZY0tpkq0=;
 b=TpfXSgm2WUu6IzjPY75GkWOL2vzKGMJmWRX43OVD7HGwwccWmAYhVPQl061kqcaWYP
 jglUYwgrFbxrY7nyEK+0rdysMQZJQFwTmD0AA/h0Idq3WJl3btgcrOmSh2aQsF0m73ok
 32PUKsP1QE5Uh6fyPIC1YxO+oQJOA3ppyLBVGyj1R9wAgBc2c7xkb/BQcO1Jqf9oJce5
 GzJYSqkn+0u8OuWLpJMhJLKzT9DFj5+vcCj0ngEcvRIYZkHu6uiOaMtOTFFgzQFbbEP9
 3RRER364g1wzWs3ZiuA+2oqobPVxmPYrAOwDaKxHM2cm2NJNcthE3lMPR6GqaSQN085d
 aTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hOtqBYNVN0odFdezyYG5pn2QHUjOmA1+K/WZY0tpkq0=;
 b=GHjnhiDZYFm28pvcgVXjbwNwQAX/6eahH32lBpTdkWuMrOnDkaWu4JAm/2JFOyaNWE
 csqR55ZgerZ6w4jOMwZy8MOd2WU9evvtpYT0Fw1MYigck+7W+hmcOWXKDVpyeIlKXhkD
 dDU2ya6zul6fuoav4v2blsOQEJG6xRFXuXCM9DRpYBuY/o86kDQBsTTdWb2Mj1YFNb5T
 VVQw0Tf/m9B5TmGve8lRQsmSe8GHAwL1vdtkZG6Y4dIH8LTb/rg8bK5ZNFG2Y1LtXnly
 7wkNQ4umxaPJ3jjbD3lnQQt2xc+BDyXUfLCdi3X0iNE9q+qnxhM8nWIJuRvc9FivD0vR
 3slA==
X-Gm-Message-State: AOAM533kq1ujPrHk3wApTApuaUCQPs5+BblbCwf6AGSqcj5lKTLwovzY
 DXH3KLV5F+9u+CV0WZSzmtpwAg==
X-Google-Smtp-Source: ABdhPJziafnF1rxURkGDV/L7i1tyNJs3klFneSeHLtA+KcUm4xSSaF5KHQOwQV6nvM6az+qniP9NnA==
X-Received: by 2002:a1c:408a:: with SMTP id n132mr3977627wma.45.1599164452304; 
 Thu, 03 Sep 2020 13:20:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p14sm7285023wrg.96.2020.09.03.13.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:20:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/arm/mps2: New board model mps2-an386
Date: Thu,  3 Sep 2020 21:20:46 +0100
Message-Id: <20200903202048.15370-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903202048.15370-1-peter.maydell@linaro.org>
References: <20200903202048.15370-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kumar Gala <kumar.gala@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement a model of the MPS2 with the AN386 firmware. This is
essentially identical to the AN385 firmware, but it has a
Cortex-M4 rather than a Cortex-M3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
The docs update is new since v1, but I've kept the Reviewed-bys
as there is no code change.
---
 docs/system/arm/mps2.rst |  8 +++++---
 hw/arm/mps2.c            | 30 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index 3a98cb59b0d..e680a4ceb71 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -1,5 +1,5 @@
-Arm MPS2 boards (``mps2-an385``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
-================================================================================
+Arm MPS2 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
+================================================================================================
 
 These board models all use Arm M-profile CPUs.
 
@@ -12,6 +12,8 @@ QEMU models the following FPGA images:
 
 ``mps2-an385``
   Cortex-M3 as documented in ARM Application Note AN385
+``mps2-an386``
+  Cortex-M4 as documented in ARM Application Note AN386
 ``mps2-an511``
   Cortex-M3 'DesignStart' as documented in AN511
 ``mps2-an505``
@@ -21,7 +23,7 @@ QEMU models the following FPGA images:
 
 Differences between QEMU and real hardware:
 
-- AN385 remapping of low 16K of memory to either ZBT SSRAM1 or to
+- AN385/AN386 remapping of low 16K of memory to either ZBT SSRAM1 or to
   block RAM is unimplemented (QEMU always maps this to ZBT SSRAM1, as
   if zbt_boot_ctrl is always zero)
 - QEMU provides a LAN9118 ethernet rather than LAN9220; the only guest
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 9f12934ca8f..559b297e788 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -15,6 +15,7 @@
  * as seen by the guest depend significantly on the FPGA image.
  * We model the following FPGA images:
  *  "mps2-an385" -- Cortex-M3 as documented in ARM Application Note AN385
+ *  "mps2-an386" -- Cortex-M4 as documented in ARM Application Note AN386
  *  "mps2-an511" -- Cortex-M3 'DesignStart' as documented in AN511
  *
  * Links to the TRM for the board itself and to the various Application
@@ -47,6 +48,7 @@
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
+    FPGA_AN386,
     FPGA_AN511,
 } MPS2FPGAType;
 
@@ -79,6 +81,7 @@ typedef struct {
 
 #define TYPE_MPS2_MACHINE "mps2"
 #define TYPE_MPS2_AN385_MACHINE MACHINE_TYPE_NAME("mps2-an385")
+#define TYPE_MPS2_AN386_MACHINE MACHINE_TYPE_NAME("mps2-an386")
 #define TYPE_MPS2_AN511_MACHINE MACHINE_TYPE_NAME("mps2-an511")
 
 #define MPS2_MACHINE(obj)                                       \
@@ -142,7 +145,7 @@ static void mps2_common_init(MachineState *machine)
      *
      * Common to both boards:
      *  0x21000000..0x21ffffff : PSRAM (16MB)
-     * AN385 only:
+     * AN385/AN386 only:
      *  0x00000000 .. 0x003fffff : ZBT SSRAM1
      *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
      *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
@@ -157,7 +160,7 @@ static void mps2_common_init(MachineState *machine)
      *  0x20000000 .. 0x2001ffff : SRAM
      *  0x20400000 .. 0x207fffff : ZBT SSRAM 2&3
      *
-     * The AN385 has a feature where the lowest 16K can be mapped
+     * The AN385/AN386 has a feature where the lowest 16K can be mapped
      * either to the bottom of the ZBT SSRAM1 or to the block RAM.
      * This is of no use for QEMU so we don't implement it (as if
      * zbt_boot_ctrl is always zero).
@@ -166,6 +169,7 @@ static void mps2_common_init(MachineState *machine)
 
     switch (mmc->fpga_type) {
     case FPGA_AN385:
+    case FPGA_AN386:
         make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
         make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
         make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
@@ -193,6 +197,7 @@ static void mps2_common_init(MachineState *machine)
     armv7m = DEVICE(&mms->armv7m);
     switch (mmc->fpga_type) {
     case FPGA_AN385:
+    case FPGA_AN386:
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
@@ -229,6 +234,7 @@ static void mps2_common_init(MachineState *machine)
 
     switch (mmc->fpga_type) {
     case FPGA_AN385:
+    case FPGA_AN386:
     {
         /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
          * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
@@ -380,7 +386,7 @@ static void mps2_common_init(MachineState *machine)
      */
     lan9118_init(&nd_table[0], 0x40200000,
                  qdev_get_gpio_in(armv7m,
-                                  mmc->fpga_type == FPGA_AN385 ? 13 : 47));
+                                  mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
@@ -409,6 +415,17 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->scc_id = 0x41043850;
 }
 
+static void mps2_an386_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MPS2MachineClass *mmc = MPS2_MACHINE_CLASS(oc);
+
+    mc->desc = "ARM MPS2 with AN386 FPGA image for Cortex-M4";
+    mmc->fpga_type = FPGA_AN386;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mmc->scc_id = 0x41043860;
+}
+
 static void mps2_an511_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -435,6 +452,12 @@ static const TypeInfo mps2_an385_info = {
     .class_init = mps2_an385_class_init,
 };
 
+static const TypeInfo mps2_an386_info = {
+    .name = TYPE_MPS2_AN386_MACHINE,
+    .parent = TYPE_MPS2_MACHINE,
+    .class_init = mps2_an386_class_init,
+};
+
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
@@ -445,6 +468,7 @@ static void mps2_machine_init(void)
 {
     type_register_static(&mps2_info);
     type_register_static(&mps2_an385_info);
+    type_register_static(&mps2_an386_info);
     type_register_static(&mps2_an511_info);
 }
 
-- 
2.20.1


