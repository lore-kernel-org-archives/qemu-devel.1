Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E635AC742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D2D2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djpgZzB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D2D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlu4d-0007PX-TQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlu4R-0006sl-QB
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlu4Q-00007B-4k
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:50:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlu4P-00006J-Su
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:50:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id x4so9661445wrt.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VlbJbQSW8/zo5SQT5J/jriNPih0ZwCvEM2vgRhOqVIc=;
 b=djpgZzB48OJweC1e5h4SQ6eqRHXQUrfUSDTrqDDRbeEGIUW5tN8xJExlNPH9yvWNJB
 2RbYHxj+kvmAF+GeTTl/3fI1am5xZYz/uraeBWCIWwXXPHlSTXF986IE9H6WiZ4WQkFw
 M04IjTdDS2mTH5T0/1odPuYChQWO8aemW2C61syZiDqH48+y7BGM85s6nsdkPzzLveNu
 RGll55kRFHyNcD/5l8e9OuYWGfA+Flba9VkYU8WbeyGm7QZwecpH34gag3+Q/m7WXrSo
 5byGfmmSPZ9Q9jBivY1uJQquwT2BhtFIoqsU+MJWOgzBo4+muf3cu6cKEb88bHlvSzmm
 PHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VlbJbQSW8/zo5SQT5J/jriNPih0ZwCvEM2vgRhOqVIc=;
 b=kfhroriMLUI12e5Og9lbcpnV1mTDhemJHTRoOqiZY8O4BH9B3WiJ+uQiGvrr0pICUy
 XnwgDQGfruAj3dIr46u+IGqcghw/SEm6X48XezZk9zmoW2xVbRSWmxNA7evRQd0GYc0D
 L0V8tPSE857Vej/o7ryLj1oIREeI6+Hdj2o5NqB9SNmfQ28LPXsUu/8Cf6+Rs2gNK4Jo
 TMuE6MVsez+6S5OMlznY2OkVpzHCGDh+Qnd6KykssRYOaph/QcQ6sw/Jq54MzKiQe3l0
 PjWjM3kQIb1sndKUI8dKhc6BazhblmIYXgYmnSlI10u/oZh1sOsh/Ubl1Fyg+Ql3nUux
 yy7g==
X-Gm-Message-State: APjAAAVSZhLWYWSh4SNgvAnkre5jRvlp3N9i3pFkhHQLGkd+FEp+oqCA
 aeNcPmZ1G7V3Kh59MQvtykPxvA==
X-Google-Smtp-Source: APXvYqzVRmXpPsp7fwnhp/ijYBtt54HgWEzrTRqjwdWII9dSs7GMeFA1EhgdBFeD/+gKQcDmoj7jTA==
X-Received: by 2002:adf:e708:: with SMTP id c8mr8260wrm.25.1562932232386;
 Fri, 12 Jul 2019 04:50:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v204sm7757279wma.20.2019.07.12.04.50.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:50:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:50:30 +0100
Message-Id: <20190712115030.26895-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH for-4.1?] hw/arm/fsl-imx6ul.c: Remove dead
 SMP-related code
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
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i.MX6UL always has a single Cortex-A7 CPU (we set FSL_IMX6UL_NUM_CPUS
to 1 in line with this). This means that all the code in fsl-imx6ul.c to
handle multiple CPUs is dead code, and Coverity is now complaining that
it is unreachable (CID 1403008, 1403011).

Remove the unreachable code and the only-executes-once loops,
and replace the single-entry cpu[] array in the FSLIMX6ULState
with a simple cpu member.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The only real reason to put this into 4.1 is because it fixes
some Coverity issues, and it would be nice to be able to get
down to no Coverity issues for the release. I think that pre-rc1
that's a reasonable reason to put this in.

Disclaimer: tested with "make check" as I have no test image for
this board.

 include/hw/arm/fsl-imx6ul.h |  2 +-
 hw/arm/fsl-imx6ul.c         | 62 +++++++++++--------------------------
 hw/arm/mcimx6ul-evk.c       |  2 +-
 3 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 9e94e98f8ee..eda389aec7d 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -61,7 +61,7 @@ typedef struct FslIMX6ULState {
     DeviceState    parent_obj;
 
     /*< public >*/
-    ARMCPU             cpu[FSL_IMX6UL_NUM_CPUS];
+    ARMCPU             cpu;
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
     IMXEPITState       epit[FSL_IMX6UL_NUM_EPITS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index f8601654388..b074177a71d 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -29,16 +29,12 @@
 
 static void fsl_imx6ul_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(obj);
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6UL_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
-    }
+    object_initialize_child(obj, "cpu0", &s->cpu, sizeof(s->cpu),
+                            "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
 
     /*
      * A7MPCORE
@@ -161,42 +157,25 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(dev);
     int i;
-    qemu_irq irq;
     char name[NAME_SIZE];
-    unsigned int smp_cpus = ms->smp.cpus;
+    SysBusDevice *sbd;
+    DeviceState *d;
 
-    if (smp_cpus > FSL_IMX6UL_NUM_CPUS) {
-        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
-                   TYPE_FSL_IMX6UL, FSL_IMX6UL_NUM_CPUS, smp_cpus);
+    if (ms->smp.cpus > 1) {
+        error_setg(errp, "%s: Only a single CPU is supported (%d requested)",
+                   TYPE_FSL_IMX6UL, ms->smp.cpus);
         return;
     }
 
-    for (i = 0; i < smp_cpus; i++) {
-        Object *o = OBJECT(&s->cpu[i]);
-
-        object_property_set_int(o, QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
-
-        /* On uniprocessor, the CBAR is set to 0 */
-        if (smp_cpus > 1) {
-            object_property_set_int(o, FSL_IMX6UL_A7MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
-        }
-
-        if (i) {
-            /* Secondary CPUs start in PSCI powered-down state */
-            object_property_set_bool(o, true,
-                                     "start-powered-off", &error_abort);
-        }
-
-        object_property_set_bool(o, true, "realized", &error_abort);
-    }
+    object_property_set_int(OBJECT(&s->cpu), QEMU_PSCI_CONDUIT_SMC,
+                            "psci-conduit", &error_abort);
+    object_property_set_bool(OBJECT(&s->cpu), true,
+                             "realized", &error_abort);
 
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), smp_cpus, "num-cpu",
-                            &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore), 1, "num-cpu", &error_abort);
     object_property_set_int(OBJECT(&s->a7mpcore),
                             FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL,
                             "num-irq", &error_abort);
@@ -204,18 +183,13 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
 
-    for (i = 0; i < smp_cpus; i++) {
-        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
-        DeviceState  *d   = DEVICE(qemu_get_cpu(i));
+    sbd = SYS_BUS_DEVICE(&s->a7mpcore);
+    d = DEVICE(&s->cpu);
 
-        irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
-        sysbus_connect_irq(sbd, i, irq);
-        sysbus_connect_irq(sbd, i + smp_cpus, qdev_get_gpio_in(d, ARM_CPU_FIQ));
-        sysbus_connect_irq(sbd, i + 2 * smp_cpus,
-                           qdev_get_gpio_in(d, ARM_CPU_VIRQ));
-        sysbus_connect_irq(sbd, i + 3 * smp_cpus,
-                           qdev_get_gpio_in(d, ARM_CPU_VFIQ));
-    }
+    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(d, ARM_CPU_IRQ));
+    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(d, ARM_CPU_FIQ));
+    sysbus_connect_irq(sbd, 2, qdev_get_gpio_in(d, ARM_CPU_VIRQ));
+    sysbus_connect_irq(sbd, 3, qdev_get_gpio_in(d, ARM_CPU_VFIQ));
 
     /*
      * A7MPCORE DAP
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index bbffb11c2a8..1f6f4aed97c 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -71,7 +71,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu[0], &boot_info);
+        arm_load_kernel(&s->soc.cpu, &boot_info);
     }
 }
 
-- 
2.20.1


