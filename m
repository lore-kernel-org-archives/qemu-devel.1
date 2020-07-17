Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D2B206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dm8Cz0mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D2B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJY4-0003qE-7y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3KD8RXwsKCukSdVTYYPXZPYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSv-0003ap-Mn
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:25 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:42990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3KD8RXwsKCukSdVTYYPXZPYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--hskinnemoen.bounces.google.com>)
 id 1jwJSs-0005GG-IM
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:03:25 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id i203so10128378yba.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=UmmS/IEQWs/xO2jg8Dkq6wyYPgQ1kHSlf3Cj11NzpS8=;
 b=dm8Cz0mW1eMX95iDy5eY9AXyn5yRuckaBbaYUDot9gWxvuocQAHIOocpZ4sG3+UduA
 IpwCiqq0kHWIO3ldGMzQvXSQOEkwOn4RU6y5vtqn+ed7/waUUba3GmayCQ1VarxKbP6g
 d/NDZIuWM9sM8FkxO5ue5u/AVIf3LE51OuQWkz2Ja0UfayvhhoPNeN2KMZpMDmDpsQB4
 szWwIf7gXVcR9u381eRlKntGHWQtByON8ZSHb6a2Sm6lEJkLuTdB74FXNOA3LXNcNrOZ
 XrfINADdetaRqPa3Hf58gPecxYZ9lhsLTGWjiqm7gtF8Eva5+10LPUtvQ20eeE9aP3Z7
 G6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=UmmS/IEQWs/xO2jg8Dkq6wyYPgQ1kHSlf3Cj11NzpS8=;
 b=P+gYbMP0LJE9yEoQyETjUOBl8f2hbNvNhZtEt8o/tw6pIKG5ZtQGQXQ6Mi9fJHwGmR
 t2CnhxfK6i5hYX1sweDrGQKiIEp7cygu/UW3kQUSh3dvAg1HVU4L9SdSIwiqdu5X5Edd
 4DRtEvVWvshCspZ7M6EF0x+3WkLO3DK5PmtPQ4v9Qt+HpQ5oPtjvzs1irHHQpXdvOsOQ
 hOr+rovBkhny0DHHhpYbjcnFMAu6V6EQAFqiMoW69j4cTbq88HWvwPy3SUVX6uXRMPWu
 KSJGseMtWBb/wj7fkQwg9UiTQK6rRYRQuKK5R49XP1d7LRRnvQWRLGFonteX7HHtZimG
 sM4w==
X-Gm-Message-State: AOAM533NmcpU4rKdxJylblMtjfSjE+NHj3dK5ZYJK2suOEGoMlWpr7XS
 cbE5P+yiQxR/Nx1HD5JrMwiuJDftHLBAySWd8vS+RtW9g9EROxA6eCqP+a09/nzcl2V64QnWVma
 e9kSRBy4VSmT165NxJM6XGGcl28dwPnW+35oQWkyMuDr5LJpXKTN0yDSo3LVbNLFxm315uVs7BA
 ==
X-Google-Smtp-Source: ABdhPJy7Nv0haMjwyg451jPAw2psENkUyYVGqIQei9lRI0ujLT9RP3r68eFv8BxtqO7pRd+KTIaYM+5x6jC563II2Q==
X-Received: by 2002:a25:ac02:: with SMTP id w2mr12249939ybi.57.1594965800850; 
 Thu, 16 Jul 2020 23:03:20 -0700 (PDT)
Date: Thu, 16 Jul 2020 23:02:50 -0700
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Message-Id: <20200717060258.1602319-6-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200717060258.1602319-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v6 05/13] hw/arm: Add two NPCM7xx-based machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, Joel Stanley <joel@jms.id.au>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>,
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3KD8RXwsKCukSdVTYYPXZPYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds two new machines, both supported by OpenBMC:

  - npcm750-evb: Nuvoton NPCM750 Evaluation Board.
  - quanta-gsj: A board with a NPCM730 chip.

They rely on the NPCM7xx SoC device to do the heavy lifting. They are
almost completely identical at the moment, apart from the SoC type,
which currently only changes the reset contents of one register
(GCR.MDLR), but they might grow apart a bit more as more functionality
is added.

Both machines can boot the Linux kernel into /bin/sh.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 default-configs/arm-softmmu.mak |   1 +
 include/hw/arm/npcm7xx.h        |  19 +++++
 hw/arm/npcm7xx_boards.c         | 144 ++++++++++++++++++++++++++++++++
 hw/arm/Makefile.objs            |   2 +-
 4 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/npcm7xx_boards.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 8fc09a4a51..9a94ebd0be 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -27,6 +27,7 @@ CONFIG_GUMSTIX=3Dy
 CONFIG_SPITZ=3Dy
 CONFIG_TOSA=3Dy
 CONFIG_Z2=3Dy
+CONFIG_NPCM7XX=3Dy
 CONFIG_COLLIE=3Dy
 CONFIG_ASPEED_SOC=3Dy
 CONFIG_NETDUINO2=3Dy
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index e68d9c79e6..ba7495869d 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -35,6 +35,25 @@
 #define NPCM7XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
 #define NPCM7XX_GIC_CPU_IF_ADDR         (0xf03fe100)  /* GIC within A9 */
=20
+typedef struct NPCM7xxMachine {
+    MachineState        parent;
+} NPCM7xxMachine;
+
+#define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
+#define NPCM7XX_MACHINE(obj)                                            \
+    OBJECT_CHECK(NPCM7xxMachine, (obj), TYPE_NPCM7XX_MACHINE)
+
+typedef struct NPCM7xxMachineClass {
+    MachineClass        parent;
+
+    const char          *soc_type;
+} NPCM7xxMachineClass;
+
+#define NPCM7XX_MACHINE_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(NPCM7xxMachineClass, (klass), TYPE_NPCM7XX_MACHINE)
+#define NPCM7XX_MACHINE_GET_CLASS(obj)                                  \
+    OBJECT_GET_CLASS(NPCM7xxMachineClass, (obj), TYPE_NPCM7XX_MACHINE)
+
 typedef struct NPCM7xxState {
     DeviceState         parent;
=20
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
new file mode 100644
index 0000000000..0b9dce2b35
--- /dev/null
+++ b/hw/arm/npcm7xx_boards.c
@@ -0,0 +1,144 @@
+/*
+ * Machine definitions for boards featuring an NPCM7xx SoC.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/npcm7xx.h"
+#include "hw/core/cpu.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+
+#define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
+#define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
+
+static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
+{
+    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram=
);
+
+    object_property_set_link(OBJECT(soc), "dram-mr", OBJECT(dram),
+                             &error_abort);
+}
+
+static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
+                                        uint32_t hw_straps)
+{
+    NPCM7xxMachineClass *nmc =3D NPCM7XX_MACHINE_GET_CLASS(machine);
+    MachineClass *mc =3D &nmc->parent;
+    Object *obj;
+
+    if (strcmp(machine->cpu_type, mc->default_cpu_type) !=3D 0) {
+        error_report("This board can only be used with %s",
+                     mc->default_cpu_type);
+        exit(1);
+    }
+
+    obj =3D object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
+                                &error_abort, NULL);
+    object_property_set_uint(obj, "power-on-straps", hw_straps, &error_abo=
rt);
+
+    return NPCM7XX(obj);
+}
+
+static void npcm750_evb_init(MachineState *machine)
+{
+    NPCM7xxState *soc;
+
+    soc =3D npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
+    npcm7xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
+
+    npcm7xx_load_kernel(machine, soc);
+}
+
+static void quanta_gsj_init(MachineState *machine)
+{
+    NPCM7xxState *soc;
+
+    soc =3D npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
+    npcm7xx_connect_dram(soc, machine->ram);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
+
+    npcm7xx_load_kernel(machine, soc);
+}
+
+static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *typ=
e)
+{
+    NPCM7xxClass *sc =3D NPCM7XX_CLASS(object_class_by_name(type));
+    MachineClass *mc =3D MACHINE_CLASS(nmc);
+
+    nmc->soc_type =3D type;
+    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D sc->num_cpus;
+}
+
+static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->no_floppy =3D 1;
+    mc->no_cdrom =3D 1;
+    mc->no_parallel =3D 1;
+    mc->default_ram_id =3D "ram";
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
+}
+
+/*
+ * Schematics:
+ * https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-pole=
g/evaluation-board/board_deliverables/NPCM750x_EB_ver.A1.1_COMPLETE.pdf
+ */
+static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxMachineClass *nmc =3D NPCM7XX_MACHINE_CLASS(oc);
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    npcm7xx_set_soc_type(nmc, TYPE_NPCM750);
+
+    mc->desc =3D "Nuvoton NPCM750 Evaluation Board (Cortex A9)";
+    mc->init =3D npcm750_evb_init;
+    mc->default_ram_size =3D 512 * MiB;
+};
+
+static void gsj_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxMachineClass *nmc =3D NPCM7XX_MACHINE_CLASS(oc);
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    npcm7xx_set_soc_type(nmc, TYPE_NPCM730);
+
+    mc->desc =3D "Quanta GSJ (Cortex A9)";
+    mc->init =3D quanta_gsj_init;
+    mc->default_ram_size =3D 512 * MiB;
+};
+
+static const TypeInfo npcm7xx_machine_types[] =3D {
+    {
+        .name           =3D TYPE_NPCM7XX_MACHINE,
+        .parent         =3D TYPE_MACHINE,
+        .instance_size  =3D sizeof(NPCM7xxMachine),
+        .class_size     =3D sizeof(NPCM7xxMachineClass),
+        .class_init     =3D npcm7xx_machine_class_init,
+        .abstract       =3D true,
+    }, {
+        .name           =3D MACHINE_TYPE_NAME("npcm750-evb"),
+        .parent         =3D TYPE_NPCM7XX_MACHINE,
+        .class_init     =3D npcm750_evb_machine_class_init,
+    }, {
+        .name           =3D MACHINE_TYPE_NAME("quanta-gsj"),
+        .parent         =3D TYPE_NPCM7XX_MACHINE,
+        .class_init     =3D gsj_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(npcm7xx_machine_types)
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 13d163a599..c333548ce1 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -41,7 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
 obj-$(CONFIG_STM32F405_SOC) +=3D stm32f405_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_XLNX_VERSAL) +=3D xlnx-versal.o xlnx-versal-virt.o
-obj-$(CONFIG_NPCM7XX) +=3D npcm7xx.o
+obj-$(CONFIG_NPCM7XX) +=3D npcm7xx.o npcm7xx_boards.o
 obj-$(CONFIG_FSL_IMX25) +=3D fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o
--=20
2.28.0.rc0.105.gf9edc3c819-goog


