Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8ACC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 00:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2631820706
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 00:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fI1n0wf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2631820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joyH3-0007jy-El
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 20:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DYv2XgsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1joyCP-0007vX-HK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 19:56:01 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DYv2XgsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com>)
 id 1joyCM-0002At-Kg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 19:56:01 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id f16so11582082ybp.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=c4FRN4nMHg8ekZ0T126HkvZJ16z0qmHNtGTXzE8nVaI=;
 b=fI1n0wf6OCtOvFmCQH2flMysGibux5mIw8PsXk/N5j8Jr+s93xan3VLR+Q+QpKpCzn
 Mqakyv5ishfbxJ1UCgnKsJibWaM2/mCEpKnsgN4PgA0IbJKmUn/8vmDLT9p77Qp187ZS
 rS03ycBK3TquyCGfEVGSuNLNgkc8rgc0mKloS9oyyFQee3gKW6npw7Gs8uoiISPL1m5C
 LJVNKxpCp5xBNj6KUDBnnVJ3wKoC6/vYJMxOkd/rSj7fEM+WeZxqKtP4N6xrtlrN5sua
 SMaWqjiX4luw9sE6KWFvYcZnefmlT59uIQEfArGX4lMrjpions5cjlLOalZGP/l0aJrB
 lKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=c4FRN4nMHg8ekZ0T126HkvZJ16z0qmHNtGTXzE8nVaI=;
 b=o3N+MITJ4X+ScITuyRpRlOv0a9n8YHVUVPoTKULXIYHQsNyUSQSCeElxYWbXoO9274
 nugs16Rx6tPWsqhaL/qEoi5Uf9Mixd4A5ZpkZfklt1j0dMAuFJMLt2k4Ah1s6UuUqZE2
 jQdQWCsGXhmQEsRVQgV8lfTSJRCR6JsRo88V3I1ZVY7QPkWB6ncH1M6HFG92f4lS7mUF
 gyO6g8i1fSsWMU58TO0SMQ7+2U7WEv2V6bB2Tjr4oKFjKCB1RyZXYtYcpS7/JNpuR8zc
 HOml2zAo8axfTMJYrJUv0xA9NBjv/FKJaGkQmAj9fE2e66+vKPYArQ/ViFa89HCMfdcF
 c5kQ==
X-Gm-Message-State: AOAM533SuU+LAMAFw270wSs7OXv9m77As+eeeeRl2Vsutfhd8Va71025
 XHMYEtLcypW/DZUx5a+ilghS2PqTR6sI4vkR/A==
X-Google-Smtp-Source: ABdhPJzhRd1/SMsnJpT61Ctgsuqr6pl7e4Ipu3fN8vW6qGKfA9gRK+kDnNNS435BoGmmvkOZOTKIiqWBL8vi36jPyQ==
X-Received: by 2002:a05:6902:100b:: with SMTP id
 w11mr6295345ybt.232.1593215757182; 
 Fri, 26 Jun 2020 16:55:57 -0700 (PDT)
Date: Fri, 26 Jun 2020 16:55:16 -0700
In-Reply-To: <20200626235519.591734-1-hskinnemoen@google.com>
Message-Id: <20200626235519.591734-10-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3 09/12] hw/mem: Stubbed out NPCM7xx Memory Controller model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, clg@kaod.org, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3DYv2XgsKCvojumkppgoqgpiqqing.eqosgow-fgxgnpqpipw.qti@flex--hskinnemoen.bounces.google.com;
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

This just implements the bare minimum to cause the boot block to skip
memory initialization.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/npcm7xx.c            | 10 +++++
 hw/mem/Makefile.objs        |  1 +
 hw/mem/npcm7xx_mc.c         | 83 +++++++++++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h    |  2 +
 include/hw/mem/npcm7xx_mc.h | 35 ++++++++++++++++
 5 files changed, 131 insertions(+)
 create mode 100644 hw/mem/npcm7xx_mc.c
 create mode 100644 include/hw/mem/npcm7xx_mc.h

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 825910a4bf..4ab7fdd405 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -45,6 +45,7 @@
 #define NPCM7XX_CPUP_BA         (0xF03FE000)
 #define NPCM7XX_GCR_BA          (0xF0800000)
 #define NPCM7XX_CLK_BA          (0xF0801000)
+#define NPCM7XX_MC_BA           (0xF0824000)
=20
 /* Memory blocks at the end of the address space */
 #define NPCM7XX_RAM2_BA         (0xFFFD0000)
@@ -159,6 +160,7 @@ static void npcm7xx_init(Object *obj)
                             TYPE_NPCM7XX_KEY_STORAGE);
     object_initialize_child(obj, "otp2", &s->fuse_array,
                             TYPE_NPCM7XX_FUSE_ARRAY);
+    object_initialize_child(obj, "mc", &s->mc, TYPE_NPCM7XX_MC);
=20
     for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
         object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TI=
MER);
@@ -257,6 +259,14 @@ static void npcm7xx_realize(DeviceState *dev, Error **=
errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
     npcm7xx_init_fuses(s);
=20
+    /* Fake Memory Controller (MC) */
+    sysbus_realize(SYS_BUS_DEVICE(&s->mc), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mc), 0, NPCM7XX_MC_BA);
+
     /* Timer Modules (TIM) */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) !=3D ARRAY_SIZE(s->tim)=
);
     for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index 56345befd0..9a33ef7b35 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,3 +1,4 @@
 common-obj-$(CONFIG_DIMM) +=3D pc-dimm.o
 common-obj-y +=3D memory-device.o
+common-obj-$(CONFIG_NPCM7XX) +=3D npcm7xx_mc.o
 common-obj-$(CONFIG_NVDIMM) +=3D nvdimm.o
diff --git a/hw/mem/npcm7xx_mc.c b/hw/mem/npcm7xx_mc.c
new file mode 100644
index 0000000000..03a7fb53dc
--- /dev/null
+++ b/hw/mem/npcm7xx_mc.c
@@ -0,0 +1,83 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/mem/npcm7xx_mc.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#define NPCM7XX_MC_REGS_SIZE (4 * KiB)
+
+static uint64_t npcm7xx_mc_read(void *opaque, hwaddr addr, unsigned int si=
ze)
+{
+    /*
+     * If bits 8..11 @ offset 0 are not zero, the boot block thinks the me=
mory
+     * controller has already been initialized and will skip DDR training.
+     */
+    if (addr =3D=3D 0) {
+        return 0x100;
+    }
+
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+
+    return 0;
+}
+
+static void npcm7xx_mc_write(void *opaque, hwaddr addr, uint64_t v,
+                             unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: mostly unimplemented\n", __func__);
+}
+
+static const MemoryRegionOps npcm7xx_mc_ops =3D {
+    .read =3D npcm7xx_mc_read,
+    .write =3D npcm7xx_mc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+};
+
+static void npcm7xx_mc_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxMCState *s =3D NPCM7XX_MC(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &npcm7xx_mc_ops, s, "regs",
+                          NPCM7XX_MC_REGS_SIZE);
+    sysbus_init_mmio(&s->parent, &s->mmio);
+}
+
+static void npcm7xx_mc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc =3D "NPCM7xx Memory Controller stub";
+    dc->realize =3D npcm7xx_mc_realize;
+}
+
+static const TypeInfo npcm7xx_mc_types[] =3D {
+    {
+        .name =3D TYPE_NPCM7XX_MC,
+        .parent =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(NPCM7xxMCState),
+        .class_init =3D npcm7xx_mc_class_init,
+    },
+};
+DEFINE_TYPES(npcm7xx_mc_types);
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 360cd965a7..8f49f7015c 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -17,6 +17,7 @@
=20
 #include "hw/boards.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
 #include "hw/misc/npcm7xx_gcr.h"
 #include "hw/nvram/npcm7xx_otp.h"
@@ -65,6 +66,7 @@ typedef struct NPCM7xxState {
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxOTPState     key_storage;
     NPCM7xxOTPState     fuse_array;
+    NPCM7xxMCState      mc;
 } NPCM7xxState;
=20
 #define TYPE_NPCM7XX    "npcm7xx"
diff --git a/include/hw/mem/npcm7xx_mc.h b/include/hw/mem/npcm7xx_mc.h
new file mode 100644
index 0000000000..8781f5c979
--- /dev/null
+++ b/include/hw/mem/npcm7xx_mc.h
@@ -0,0 +1,35 @@
+/*
+ * Nuvoton NPCM7xx Memory Controller stub
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef NPCM7XX_MC_H
+#define NPCM7XX_MC_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+/**
+ * struct NPCM7xxMCState - Device state for the memory controller.
+ * @parent: System bus device.
+ * @mmio: Memory region through which registers are accessed.
+ */
+typedef struct NPCM7xxMCState {
+    SysBusDevice parent;
+
+    MemoryRegion mmio;
+} NPCM7xxMCState;
+
+#define TYPE_NPCM7XX_MC "npcm7xx-mc"
+#define NPCM7XX_MC(obj) OBJECT_CHECK(NPCM7xxMCState, (obj), TYPE_NPCM7XX_M=
C)
+
+#endif /* NPCM7XX_MC_H */
--=20
2.27.0.212.ge8ba1cc988-goog


