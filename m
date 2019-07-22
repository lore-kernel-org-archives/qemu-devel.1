Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58418C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF4621921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UK2fS7UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF4621921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpY9n-0000j8-Sj
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9D-0007OC-3N
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9B-000362-Qv
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpY9B-000358-KA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so35145051wma.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=l5k8gNjzcUVX6OXyFMM4mDjUBLlyPFiurmFGH7h+8m8=;
 b=UK2fS7UYYw+TzEarLn+wyi1DN4JuoZGYkROeZKGn3ItsmGi6VastmbnbZrusZg8ErG
 X0PIjrDmtKwl6uqxwWa93AU+z62o2RBeHoC/eRo3CArrMOFPlkcA9IpgqGsaEd5WV4ff
 Xc6GQOuDUwlLEp9BF9YNXg8WqObqFrhJagMElLq/+G4rxVlG707Qg+OxorYqpBj/OUim
 w6RJETvBSpn8q/Mw7qnOvGubc3NnSt/fBjqnvousmuGm0O+eIg9RHhCdrou18ZkNQCT2
 XSDFpsSyugw3Wwwg3QeM4cLnsRxglAbXZ/JDNA2bwy2gdCLg7VaDBCAyVnpEporbtuP2
 Dfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l5k8gNjzcUVX6OXyFMM4mDjUBLlyPFiurmFGH7h+8m8=;
 b=J8/ZqZhmFyoZ81WOx0CjEhiUYmNkKVAD3RO/ImPAEhqCIGjkpMARSA0j9YWYCDdpTs
 pm7U6qLs9kug3DiPDm39rLG9Kz5ZkeYomkQNxhQ1/ISc1CGQahFFDIYPoBIBvLTmDyX5
 pXCf0V8QdhzpSkrK8tPKG0z9mVEXJuw/zOwPJkErvWmh/XHoU9LKaYG1cvpwi129qiYD
 9hhfnY2VGKuzyugJ19cJ0Q0r1ligImiZ/8UVJmMz34xOAv8EMQOti9y/YAQXIW1LKgmT
 MIYmlAb+XX+zZ1DUlMT3Bgd39ZAQXjzZCvfbvyfu6NcOhaEPUG9l+Yv00hRn26y2jLow
 RzNQ==
X-Gm-Message-State: APjAAAV+8c3evraclFYp3+8tw5dcx9uJLODqIiQf0lEruuSGtTzovzBx
 KunbJMj7bIDNUTBo3pCP8g5LBHfA8oXK5Q==
X-Google-Smtp-Source: APXvYqy9y+qqTy8W6eZat68QDU0fZ+fI2SiLETlIDe8mchLun6rsMt6ILoKDya+l3jE0FZs7y0DH9w==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr64471414wmj.89.1563801272399; 
 Mon, 22 Jul 2019 06:14:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f12sm42207217wrg.5.2019.07.22.06.14.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 06:14:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 14:14:24 +0100
Message-Id: <20190722131427.2669-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722131427.2669-1-peter.maydell@linaro.org>
References: <20190722131427.2669-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 2/5] hw/arm/fsl-imx6ul.c: Remove dead
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190712115030.26895-1-peter.maydell@linaro.org
---
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


