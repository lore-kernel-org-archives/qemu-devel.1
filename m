Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89209C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E855206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrzVp2f9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E855206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKZK-00080W-FP
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3i2YGXwsKCnAVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYC-0006G0-IG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:32 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:51887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3i2YGXwsKCnAVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com>)
 id 1jtKY8-00010j-Go
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:32 -0400
Received: by mail-qt1-x849.google.com with SMTP id h24so395356qtk.18
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=lrKRk7BwvWnw1gIsSVH7zHuPuTHTBnigFtRalcwc1Vg=;
 b=ZrzVp2f9XUpC7LjTlwPbgVRgAC+8e1LZw9yZgelEUpcYwe9sIXcmilqhKCP6dAazni
 z+p23RWkCXByxP44vkb7bgt5ceafPF47lVRFcxRug4OYzywsEzukN0CyOds1dmI/3wkH
 nns0NfwVBYo1jEkaQm3rspCaKwuasJzadytmdsa9aXsfP7PyE6oHmKZHnnPONBn9zVh7
 0K/gj19oFozVw5XY2uZgLPgb6tu6G10ZJ6dAHqxtniu8BBaFR9q8sDTKV0jsT6Vm+j2m
 JKtx/jLYB7FHOpSQoyo/bqiW1rXwBAyDgc/lGSVXqX10aFyfcOanG1YQSBhUBYQMZmxy
 zTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=lrKRk7BwvWnw1gIsSVH7zHuPuTHTBnigFtRalcwc1Vg=;
 b=d5SB4SMMaGp+uJ1fn+RiaP7AMPzYxuhXIKDADoHjiI2Tk5Xo/fcS6FZVsqoqC6EMn2
 9avOz2A/H6FxI34xHAc6mGgZpT4ayIQFIzAVpsgwInlr/E5R9bVqSZs/UBgdTt4XkvE6
 AOp5JVoKBPc+nbVUr0RO//tbA1GEpaSK0GqmhmfChdX5Undd+nS5/+CD0hfqL3n/w1oj
 F3w+uNJsBThzB6fAiUj46xloCqQd1MYb844b6+4JpeP43nGSf3WSZ7JJD7C69nLAIZgM
 lnZKUWoza9SMcKSK/7TrYd817XPG9sb7QYaefqmEFeXyNPH0s4Ws5AoqxxuNbXzqTw2Y
 S84w==
X-Gm-Message-State: AOAM530HXhufkSb/DZ3jykztIP+yxSd0ssPxvPzN0IfTs6dpF/xsBEdU
 I2PlfwtVWUJWMdt0cYL8wwaiDRpOjuL/OWD1ow==
X-Google-Smtp-Source: ABdhPJwn2Si39Ian/VBGWGBueofcimwtaMwHhIdr7lQUZ6nOKSbBId/Etpm80/IE2yt1muFqUEjcmSVcgUsLT5T7Gg==
X-Received: by 2002:a05:6214:612:: with SMTP id
 z18mr59415479qvw.46.1594254987275; 
 Wed, 08 Jul 2020 17:36:27 -0700 (PDT)
Date: Wed,  8 Jul 2020 17:35:58 -0700
In-Reply-To: <20200709003608.3834629-1-hskinnemoen@google.com>
Message-Id: <20200709003608.3834629-2-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control Registers
 device model
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>,
 Joel Stanley <joel@jms.id.au>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3i2YGXwsKCnAVgYWbbSacSbUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Implement a device model for the System Global Control Registers in the
NPCM730 and NPCM750 BMC SoCs.

This is primarily used to enable SMP boot (the boot ROM spins reading
the SCRPAD register) and DDR memory initialization; other registers are
best effort for now.

The reset values of the MDLR and PWRON registers are determined by the
SoC variant (730 vs 750) and board straps respectively.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 include/hw/misc/npcm7xx_gcr.h |  76 ++++++++++++
 hw/misc/npcm7xx_gcr.c         | 226 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   8 ++
 hw/arm/Kconfig                |   3 +
 hw/misc/Makefile.objs         |   1 +
 hw/misc/trace-events          |   4 +
 6 files changed, 318 insertions(+)
 create mode 100644 include/hw/misc/npcm7xx_gcr.h
 create mode 100644 hw/misc/npcm7xx_gcr.c

diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm7xx_gcr.h
new file mode 100644
index 0000000000..4884676be2
--- /dev/null
+++ b/include/hw/misc/npcm7xx_gcr.h
@@ -0,0 +1,76 @@
+/*
+ * Nuvoton NPCM7xx System Global Control Registers.
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
+#ifndef NPCM7XX_GCR_H
+#define NPCM7XX_GCR_H
+
+#include "exec/memory.h"
+#include "hw/sysbus.h"
+
+enum NPCM7xxGCRRegisters {
+    NPCM7XX_GCR_PDID,
+    NPCM7XX_GCR_PWRON,
+    NPCM7XX_GCR_MFSEL1          =3D 0x0c / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL2,
+    NPCM7XX_GCR_MISCPE,
+    NPCM7XX_GCR_SPSWC           =3D 0x038 / sizeof(uint32_t),
+    NPCM7XX_GCR_INTCR,
+    NPCM7XX_GCR_INTSR,
+    NPCM7XX_GCR_HIFCR           =3D 0x050 / sizeof(uint32_t),
+    NPCM7XX_GCR_INTCR2          =3D 0x060 / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL3,
+    NPCM7XX_GCR_SRCNT,
+    NPCM7XX_GCR_RESSR,
+    NPCM7XX_GCR_RLOCKR1,
+    NPCM7XX_GCR_FLOCKR1,
+    NPCM7XX_GCR_DSCNT,
+    NPCM7XX_GCR_MDLR,
+    NPCM7XX_GCR_SCRPAD3,
+    NPCM7XX_GCR_SCRPAD2,
+    NPCM7XX_GCR_DAVCLVLR        =3D 0x098 / sizeof(uint32_t),
+    NPCM7XX_GCR_INTCR3,
+    NPCM7XX_GCR_VSINTR          =3D 0x0ac / sizeof(uint32_t),
+    NPCM7XX_GCR_MFSEL4,
+    NPCM7XX_GCR_CPBPNTR         =3D 0x0c4 / sizeof(uint32_t),
+    NPCM7XX_GCR_CPCTL           =3D 0x0d0 / sizeof(uint32_t),
+    NPCM7XX_GCR_CP2BST,
+    NPCM7XX_GCR_B2CPNT,
+    NPCM7XX_GCR_CPPCTL,
+    NPCM7XX_GCR_I2CSEGSEL,
+    NPCM7XX_GCR_I2CSEGCTL,
+    NPCM7XX_GCR_VSRCR,
+    NPCM7XX_GCR_MLOCKR,
+    NPCM7XX_GCR_SCRPAD          =3D 0x013c / sizeof(uint32_t),
+    NPCM7XX_GCR_USB1PHYCTL,
+    NPCM7XX_GCR_USB2PHYCTL,
+    NPCM7XX_GCR_NR_REGS,
+};
+
+typedef struct NPCM7xxGCRState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint32_t regs[NPCM7XX_GCR_NR_REGS];
+
+    uint32_t reset_pwron;
+    uint32_t reset_mdlr;
+    uint32_t reset_intcr3;
+} NPCM7xxGCRState;
+
+#define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
+#define NPCM7XX_GCR(obj) OBJECT_CHECK(NPCM7xxGCRState, (obj), TYPE_NPCM7XX=
_GCR)
+
+#endif /* NPCM7XX_GCR_H */
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
new file mode 100644
index 0000000000..9934cd238d
--- /dev/null
+++ b/hw/misc/npcm7xx_gcr.c
@@ -0,0 +1,226 @@
+/*
+ * Nuvoton NPCM7xx System Global Control Registers.
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
+#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+
+#include "trace.h"
+
+static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] =3D {
+    [NPCM7XX_GCR_PDID]          =3D 0x04a92750,   /* Poleg A1 */
+    [NPCM7XX_GCR_MISCPE]        =3D 0x0000ffff,
+    [NPCM7XX_GCR_SPSWC]         =3D 0x00000003,
+    [NPCM7XX_GCR_INTCR]         =3D 0x0000035e,
+    [NPCM7XX_GCR_HIFCR]         =3D 0x0000004e,
+    [NPCM7XX_GCR_INTCR2]        =3D (1U << 19),   /* DDR initialized */
+    [NPCM7XX_GCR_RESSR]         =3D 0x80000000,
+    [NPCM7XX_GCR_DSCNT]         =3D 0x000000c0,
+    [NPCM7XX_GCR_DAVCLVLR]      =3D 0x5a00f3cf,
+    [NPCM7XX_GCR_SCRPAD]        =3D 0x00000008,
+    [NPCM7XX_GCR_USB1PHYCTL]    =3D 0x034730e4,
+    [NPCM7XX_GCR_USB2PHYCTL]    =3D 0x034730e4,
+};
+
+static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned siz=
e)
+{
+    uint32_t reg =3D offset / sizeof(uint32_t);
+    NPCM7xxGCRState *s =3D opaque;
+
+    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
+                      __func__, (unsigned int)offset);
+        return 0;
+    }
+
+    trace_npcm7xx_gcr_read(offset, s->regs[reg]);
+
+    return s->regs[reg];
+}
+
+static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    uint32_t reg =3D offset / sizeof(uint32_t);
+    NPCM7xxGCRState *s =3D opaque;
+    uint32_t value =3D v;
+
+    trace_npcm7xx_gcr_write(offset, value);
+
+    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
+                      __func__, (unsigned int)offset);
+        return;
+    }
+
+    switch (reg) {
+    case NPCM7XX_GCR_PDID:
+    case NPCM7XX_GCR_PWRON:
+    case NPCM7XX_GCR_INTSR:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-only=
\n",
+                      __func__, (unsigned int)offset);
+        return;
+
+    case NPCM7XX_GCR_RESSR:
+    case NPCM7XX_GCR_CP2BST:
+        /* Write 1 to clear */
+        value =3D s->regs[reg] & ~value;
+        break;
+
+    case NPCM7XX_GCR_RLOCKR1:
+    case NPCM7XX_GCR_MDLR:
+        /* Write 1 to set */
+        value |=3D s->regs[reg];
+        break;
+    };
+
+    s->regs[reg] =3D value;
+}
+
+static const struct MemoryRegionOps npcm7xx_gcr_ops =3D {
+    .read       =3D npcm7xx_gcr_read,
+    .write      =3D npcm7xx_gcr_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid      =3D {
+        .min_access_size        =3D 4,
+        .max_access_size        =3D 4,
+        .unaligned              =3D false,
+    },
+};
+
+static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
+{
+    NPCM7xxGCRState *s =3D NPCM7XX_GCR(obj);
+
+    QEMU_BUILD_BUG_ON(sizeof(s->regs) !=3D sizeof(cold_reset_values));
+
+    switch (type) {
+    case RESET_TYPE_COLD:
+        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+        s->regs[NPCM7XX_GCR_PWRON] =3D s->reset_pwron;
+        s->regs[NPCM7XX_GCR_MDLR] =3D s->reset_mdlr;
+        s->regs[NPCM7XX_GCR_INTCR3] =3D s->reset_intcr3;
+        break;
+    }
+}
+
+static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
+{
+    NPCM7xxGCRState *s =3D NPCM7XX_GCR(dev);
+    uint64_t dram_size;
+    Error *err =3D NULL;
+    Object *obj;
+
+    obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required dram-mr link not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+    dram_size =3D memory_region_size(MEMORY_REGION(obj));
+
+    /* Power-on reset value */
+    s->reset_intcr3 =3D 0x00001002;
+
+    /*
+     * The GMMAP (Graphics Memory Map) field is used by u-boot to detect t=
he
+     * DRAM size, and is normally initialized by the boot block as part of=
 DRAM
+     * training. However, since we don't have a complete emulation of the
+     * memory controller and try to make it look like it has already been
+     * initialized, the boot block will skip this initialization, and we n=
eed
+     * to make sure this field is set correctly up front.
+     *
+     * WARNING: some versions of u-boot only looks at bits 8 and 9, so 2 G=
iB or
+     * more of DRAM will be interpreted as 128 MiB.
+     *
+     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408db=
aad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
+     */
+    if (dram_size >=3D 2 * GiB) {
+        s->reset_intcr3 |=3D 4 << 8;
+    } else if (dram_size >=3D 1 * GiB) {
+        s->reset_intcr3 |=3D 3 << 8;
+    } else if (dram_size >=3D 512 * MiB) {
+        s->reset_intcr3 |=3D 2 << 8;
+    } else if (dram_size >=3D 256 * MiB) {
+        s->reset_intcr3 |=3D 1 << 8;
+    } else if (dram_size >=3D 128 * MiB) {
+        s->reset_intcr3 |=3D 0 << 8;
+    } else {
+        error_setg(errp,
+                   "npcm7xx_gcr: DRAM size %" PRIu64
+                   " is too small (need 128 MiB minimum)",
+                   dram_size);
+        return;
+    }
+}
+
+static void npcm7xx_gcr_init(Object *obj)
+{
+    NPCM7xxGCRState *s =3D NPCM7XX_GCR(obj);
+
+    memory_region_init_io(&s->iomem, obj, &npcm7xx_gcr_ops, s,
+                          TYPE_NPCM7XX_GCR, 4 * KiB);
+    sysbus_init_mmio(&s->parent, &s->iomem);
+}
+
+static const VMStateDescription vmstate_npcm7xx_gcr =3D {
+    .name =3D "npcm7xx-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static Property npcm7xx_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0)=
,
+    DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0)=
,
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc =3D "NPCM7xx System Global Control Registers";
+    dc->realize =3D npcm7xx_gcr_realize;
+    dc->vmsd =3D &vmstate_npcm7xx_gcr;
+    rc->phases.enter =3D npcm7xx_gcr_enter_reset;
+
+    device_class_set_props(dc, npcm7xx_gcr_properties);
+}
+
+static const TypeInfo npcm7xx_gcr_info =3D {
+    .name               =3D TYPE_NPCM7XX_GCR,
+    .parent             =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size      =3D sizeof(NPCM7xxGCRState),
+    .instance_init      =3D npcm7xx_gcr_init,
+    .class_init         =3D npcm7xx_gcr_class_init,
+};
+
+static void npcm7xx_gcr_register_type(void)
+{
+    type_register_static(&npcm7xx_gcr_info);
+}
+type_init(npcm7xx_gcr_register_type);
diff --git a/MAINTAINERS b/MAINTAINERS
index 42388f1de2..43173a338a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -723,6 +723,14 @@ S: Odd Fixes
 F: hw/arm/musicpal.c
 F: docs/system/arm/musicpal.rst
=20
+Nuvoton NPCM7xx
+M: Havard Skinnemoen <hskinnemoen@google.com>
+M: Tyrone Ting <kfting@nuvoton.com>
+L: qemu-arm@nongnu.org
+S: Supported
+F: hw/*/npcm7xx*
+F: include/hw/*/npcm7xx*
+
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4a224a6351..192a8dec3b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -354,6 +354,9 @@ config XLNX_VERSAL
     select VIRTIO_MMIO
     select UNIMP
=20
+config NPCM7XX
+    bool
+
 config FSL_IMX25
     bool
     select IMX
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 5aaca8a039..40a9d1c01e 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -51,6 +51,7 @@ common-obj-$(CONFIG_IMX) +=3D imx_rngc.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-hpdmc.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-pfpu.o
 common-obj-$(CONFIG_MAINSTONE) +=3D mst_fpga.o
+common-obj-$(CONFIG_NPCM7XX) +=3D npcm7xx_gcr.o
 common-obj-$(CONFIG_OMAP) +=3D omap_clk.o
 common-obj-$(CONFIG_OMAP) +=3D omap_gpmc.o
 common-obj-$(CONFIG_OMAP) +=3D omap_l4.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ebea53735c..48e2d54c49 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -107,6 +107,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 " val=3D0x%"P=
RIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"PRIx64 " val=3D0x%x"
=20
+# npcm7xx_gcr.c
+npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 =
" value: 0x%08" PRIx32
+npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 =
" value: 0x%08" PRIx32
+
 # stm32f4xx_syscfg
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %=
d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
--=20
2.27.0.383.g050319c2ae-goog


