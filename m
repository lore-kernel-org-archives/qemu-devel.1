Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1516C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD820205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLvEtcP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD820205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDteK-0006WN-Si
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHF-0004ST-Tc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHE-0002yk-EJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHE-0002wL-8t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dh0QaW36S0ly7XnA717+46Hg5QZjkgBSBDC6x6/CnNM=;
 b=XLvEtcP3djM/EwRFZXMnkMCBA9PLnfwK8oZfHsM1vLY4XIAp8bBDviek9d58jBKXUK2WLn
 G4kidsEC7erYNb24rLz8CJyyad5uglewPMqcc+vkoSYFipDRVByffg2aVlzj8YjHj8jl8O
 ffbtyG/b2Ayr1zdZf7J4Ehzy4jCNIB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-3ZXJcEZrNi2aLV9VfC1icQ-1; Mon, 16 Mar 2020 12:07:37 -0400
X-MC-Unique: 3ZXJcEZrNi2aLV9VfC1icQ-1
Received: by mail-wr1-f72.google.com with SMTP id f13so3057397wro.23
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3HJ4BPrTTJoaZ0DIQ+Bm5OwC5QHXxR7lFDDNNHr42oA=;
 b=HGp0jtzujKECIiF7zQDTGXOenwiwnUA1MjKFl+xWFiI9XA+bQ2iXQRP5uufE5L4VV6
 yjYKJSVlJaOUtHAOdjCMckKKpHMe120gD4lFMopbvakr/UVpG/Lyq9jkBcq/NjfGILNN
 iH/bAU6cCIZ/o/m3axuUVwUfbx/3vqCGc6bj3pn+LeRjKK+XCMmNuSatLgrJ8PyBuWxw
 qv4DMzdz2geUCKOFP6erAy51JhFFxFtQ7GqYWrONnT8wyGEQw9+M3dkPzOT7wUreGlOh
 T8tRihsLy30E6Tj3sDb5bnxHwqbDZEOGE5Q5ATGV4gAvPZLublORHVKscpvwgKnD3XSs
 bY2Q==
X-Gm-Message-State: ANhLgQ2ztolXtQLz742NIiER94Lsc07lzR2pGWpI+VpsGuDVOzLS84UF
 ISwih4XtwUQ+U86B0BWEDsIDckPjNFnSMxMQvAnWAt2p3kcwvyOBz9nvm5cvFA2OC8aUbJCGQly
 Q5lNpX7G1cLZA4Ok=
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr47288wrw.351.1584374852711;
 Mon, 16 Mar 2020 09:07:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtrKaxBzOd8Im5SmvT1u80g+l61wwRhiOvBIE54mUu/WaIr9u73VUZDQPx9shnTaY32+aclQQ==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr47263wrw.351.1584374852435;
 Mon, 16 Mar 2020 09:07:32 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id 127sm68345wmd.38.2020.03.16.09.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/19] target/arm: Restrict ARMv4 cpus to TCG accel
Date: Mon, 16 Mar 2020 17:06:25 +0100
Message-Id: <20200316160634.3386-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM requires a cpu based on (at least) the ARMv7 architecture.

Only enable the following ARMv4 CPUs when TCG is available:

  - StrongARM (SA1100/1110)
  - OMAP1510 (TI925T)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |  2 -
 target/arm/cpu.c                | 33 -----------------
 target/arm/cpu_v4.c             | 65 +++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |  2 +
 target/arm/Kconfig              |  4 ++
 target/arm/Makefile.objs        |  2 +
 6 files changed, 73 insertions(+), 35 deletions(-)
 create mode 100644 target/arm/cpu_v4.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 8b89d8c4c0..0652396296 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -17,8 +17,6 @@ CONFIG_INTEGRATOR=3Dy
 CONFIG_FSL_IMX31=3Dy
 CONFIG_MUSICPAL=3Dy
 CONFIG_MUSCA=3Dy
-CONFIG_CHEETAH=3Dy
-CONFIG_SX1=3Dy
 CONFIG_NSERIES=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d2813eb81a..b08b6933be 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2459,36 +2459,6 @@ static void cortex_a15_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
 }
=20
-static void ti925t_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_V4T);
-    set_feature(&cpu->env, ARM_FEATURE_OMAPCP);
-    cpu->midr =3D ARM_CPUID_TI925T;
-    cpu->ctr =3D 0x5109149;
-    cpu->reset_sctlr =3D 0x00000070;
-}
-
-static void sa1100_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "intel,sa1100";
-    set_feature(&cpu->env, ARM_FEATURE_STRONGARM);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    cpu->midr =3D 0x4401A11B;
-    cpu->reset_sctlr =3D 0x00000070;
-}
-
-static void sa1110_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_STRONGARM);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    cpu->midr =3D 0x6901B119;
-    cpu->reset_sctlr =3D 0x00000070;
-}
-
 static void pxa250_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -2727,9 +2697,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
     { .name =3D "cortex-a15",  .initfn =3D cortex_a15_initfn },
-    { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
-    { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
-    { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
     { .name =3D "pxa250",      .initfn =3D pxa250_initfn },
     { .name =3D "pxa255",      .initfn =3D pxa255_initfn },
     { .name =3D "pxa260",      .initfn =3D pxa260_initfn },
diff --git a/target/arm/cpu_v4.c b/target/arm/cpu_v4.c
new file mode 100644
index 0000000000..1de00a03ee
--- /dev/null
+++ b/target/arm/cpu_v4.c
@@ -0,0 +1,65 @@
+/*
+ * ARM generic helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+
+/* CPU models. These are not needed for the AArch64 linux-user build. */
+#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+
+static void ti925t_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V4T);
+    set_feature(&cpu->env, ARM_FEATURE_OMAPCP);
+    cpu->midr =3D ARM_CPUID_TI925T;
+    cpu->ctr =3D 0x5109149;
+    cpu->reset_sctlr =3D 0x00000070;
+}
+
+static void sa1100_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "intel,sa1100";
+    set_feature(&cpu->env, ARM_FEATURE_STRONGARM);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    cpu->midr =3D 0x4401A11B;
+    cpu->reset_sctlr =3D 0x00000070;
+}
+
+static void sa1110_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_STRONGARM);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    cpu->midr =3D 0x6901B119;
+    cpu->reset_sctlr =3D 0x00000070;
+}
+
+static const ARMCPUInfo arm_v4_cpus[] =3D {
+    { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
+    { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
+    { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
+    { .name =3D NULL }
+};
+
+static void arm_v4_cpu_register_types(void)
+{
+    const ARMCPUInfo *info =3D arm_v4_cpus;
+
+    while (info->name) {
+        arm_cpu_register(info);
+        info++;
+    }
+}
+
+type_init(arm_v4_cpu_register_types)
+
+#endif
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e3d7e7694a..7fc0cff776 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -28,6 +28,7 @@ config ARM_VIRT
=20
 config CHEETAH
     bool
+    select ARM_V4
     select OMAP
     select TSC210X
=20
@@ -242,6 +243,7 @@ config COLLIE
=20
 config SX1
     bool
+    select ARM_V4
     select OMAP
=20
 config VERSATILE
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index e68c71a6ff..0d496d318a 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -1,2 +1,6 @@
+config ARM_V4
+    depends on TCG
+    bool
+
 config ARM_V7M
     bool
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index fa278bb4c1..bc0f63ebbc 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -68,6 +68,8 @@ obj-y +=3D crypto_helper.o
 obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
 obj-y +=3D m_helper.o
=20
+obj-$(CONFIG_ARM_V4) +=3D cpu_v4.o
+
 obj-$(CONFIG_SOFTMMU) +=3D psci.o
=20
 obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
--=20
2.21.1


