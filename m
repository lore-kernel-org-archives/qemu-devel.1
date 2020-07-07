Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF94C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BF6206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKcLoNxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BF6206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssi3-0000i9-6R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VcMEXwsKCuwVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com>)
 id 1jssdF-0000L7-4E
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:53 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:37012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VcMEXwsKCuwVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com>)
 id 1jssdD-0007aW-0V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:52 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id y3so48686011ybf.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=wdJTOiMIfl1j905f5R3WZTh4HhkgwrCywqnnHAmMh7k=;
 b=wKcLoNxIkEDQS2K1PxIq1Ye160g1pqyXjXZrvhho0/PrE3CzUzQNnmBy3SyK6jBYHN
 9HAqb/WzD3l9vL37GraGQ3eM+uE/jXZp1ZAuoTdKcPE6OG/Cl89pfSbKEug9Eh3ST1Q6
 PXF+O8E7Qkpjtj9kTtdNZliWHtgs9qcx6zqIqvSt+jE4Bp5B7f3hmvIiMjbNUZAu0J6U
 M5HTBmspX13DrGUngNko4xjIUpSBj9kgaZAhxw5C45Wk4VENF+IcJoN8dFDC7xeP6bYQ
 xXMwlF41dm2UGiNHY5n8N6voskNP2NczF2k+ksI6IEuj7sYgn2IzN0v1Z+XltMufXmNS
 qUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=wdJTOiMIfl1j905f5R3WZTh4HhkgwrCywqnnHAmMh7k=;
 b=kWrg4KM5gJBdNsCBMlrhTILkdTit2M/OEnAVqgobt1iABSwHBE+3tH6WRsXqO5fUC9
 OmVNcMQT1E3wKaRtWYk0Jo7jTixzrbd6CiE5u+YDdxceLp3K0ceG6dq7XOtqdIXpNQSq
 cPQ/VUnIBmg+pCRkSFrGxR0UuRaBn3oq9srYW32B7Dys0YE6oNJqpwNGGaKlJH795oP+
 Cr1MGa4ZfTQYKFSY6kLzqpGThp1orOhbK2hmin4NTTz9OmzqPs6saoDgjhkr6PGRjcsw
 2P6ihxFGKMeb2LC93y/LPDYb5t+uPetFjy3mmA4ur8G6z5MEePson8L2YW5syDDdR+NO
 pWyg==
X-Gm-Message-State: AOAM532/bJyW92tllRVOk1esrZzvUEIL+fWyB6W8HVdGBx+scCEFRdD5
 7vTn7xMBqO5KP4Ij90VXfHtyWuPGZxu+EE+sVg==
X-Google-Smtp-Source: ABdhPJy4OwHyD28I+IB+uKA8lDWBu2sHX4bwPcLKz7PXanv1rMqL2+kJ8F9Ij6aeravOBQN9TvNUEeYzbbAyWJkE3Q==
X-Received: by 2002:a5b:152:: with SMTP id c18mr50083805ybp.393.1594147669231; 
 Tue, 07 Jul 2020 11:47:49 -0700 (PDT)
Date: Tue,  7 Jul 2020 11:47:24 -0700
In-Reply-To: <20200707184730.3047754-1-hskinnemoen@google.com>
Message-Id: <20200707184730.3047754-7-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 06/12] hw/arm: Add two NPCM7xx-based machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, philmd@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, Joel Stanley <joel@jms.id.au>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3VcMEXwsKCuwVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/Makefile.objs     |   2 +-
 hw/arm/npcm7xx_boards.c  | 148 +++++++++++++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h |  19 +++++
 3 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/npcm7xx_boards.c

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
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
new file mode 100644
index 0000000000..205243cde6
--- /dev/null
+++ b/hw/arm/npcm7xx_boards.c
@@ -0,0 +1,148 @@
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
+#include "hw/arm/boot.h"
+#include "hw/arm/npcm7xx.h"
+#include "hw/core/cpu.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+
+#define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
+#define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
+
+static struct arm_boot_info npcm7xx_binfo =3D {
+    .loader_start       =3D NPCM7XX_LOADER_START,
+    .smp_loader_start   =3D NPCM7XX_SMP_LOADER_START,
+    .smp_bootreg_addr   =3D NPCM7XX_SMP_BOOTREG_ADDR,
+    .gic_cpu_if_addr    =3D NPCM7XX_GIC_CPU_IF_ADDR,
+    .write_secondary_boot =3D npcm7xx_write_secondary_boot,
+    .board_id           =3D -1,
+};
+
+static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
+{
+    NPCM7xxClass *sc =3D NPCM7XX_GET_CLASS(soc);
+
+    npcm7xx_binfo.ram_size =3D machine->ram_size;
+    npcm7xx_binfo.nb_cpus =3D sc->num_cpus;
+
+    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
+}
+
+static NPCM7xxState *npcm7xx_create_soc(MachineState *machine,
+                                        uint32_t hw_straps)
+{
+    NPCM7xxMachineClass *nmc =3D NPCM7XX_MACHINE_GET_CLASS(machine);
+    NPCM7xxState *soc;
+
+    soc =3D NPCM7XX(object_new_with_props(nmc->soc_type, OBJECT(machine), =
"soc",
+                                        &error_abort, NULL));
+    object_property_set_link(OBJECT(soc), OBJECT(machine->ram), "dram",
+                             &error_abort);
+    object_property_set_uint(OBJECT(soc), hw_straps, "power-on-straps",
+                             &error_abort);
+    qdev_realize(DEVICE(soc), NULL, &error_abort);
+
+    return soc;
+}
+
+static void npcm750_evb_init(MachineState *machine)
+{
+    NPCM7xxState *soc;
+
+    soc =3D npcm7xx_create_soc(machine, NPCM750_EVB_POWER_ON_STRAPS);
+
+    npcm7xx_load_kernel(machine, soc);
+}
+
+static void quanta_gsj_init(MachineState *machine)
+{
+    NPCM7xxState *soc;
+
+    soc =3D npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
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
+    mc->no_floppy       =3D 1;
+    mc->no_cdrom        =3D 1;
+    mc->no_parallel     =3D 1;
+    mc->default_ram_id  =3D "ram";
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
+    mc->desc            =3D "Nuvoton NPCM750 Evaluation Board (Cortex A9)"=
;
+    mc->init            =3D npcm750_evb_init;
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
+    mc->desc            =3D "Quanta GSJ (Cortex A9)";
+    mc->init            =3D quanta_gsj_init;
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
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 2ffa573b11..e25f5752d7 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -31,6 +31,25 @@
 #define NPCM7XX_SMP_BOOTREG_ADDR        (0xF080013C)  /* GCR.SCRPAD */
 #define NPCM7XX_GIC_CPU_IF_ADDR         (0xF03FE100)  /* GIC within A9 */
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
--=20
2.27.0.212.ge8ba1cc988-goog


