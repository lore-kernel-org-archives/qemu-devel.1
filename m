Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED20D2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pld/OcLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED20D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt8g-0006yB-3N
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHS-0004YR-ML
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHQ-0004MW-Sm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHQ-0004LB-P3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0ZyIeVBAofuqhcgRt+fU6Yvdf8+u5Qk+4HNNCwjbvc=;
 b=Pld/OcLA5s/WReK1Vy782jEtty3WCM4FxSyowyXF/e89gtNQtCEcuzXW+seq4q0PZ1wk7s
 l+unScBAC3CoyBLG2iNRSF0f28dmqrJXIqLnQ6xnMPObhDPUOmqnEEdEwriUUm1PYZrTH2
 O40Jv9es/V+NGUDg7hQhHSrilCYTSmg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-EyY_75xvMzmits6HaBNj3A-1; Mon, 16 Mar 2020 12:07:50 -0400
X-MC-Unique: EyY_75xvMzmits6HaBNj3A-1
Received: by mail-wm1-f69.google.com with SMTP id g26so4804654wmk.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ruq5flSyrIJQ0ARl8BHVFpMVJrCuW/pkqeZBiZJSNHg=;
 b=OghQSfNwaqTBETvS6qaoadskNMNCV5q1MdglUBlmONWAOtaFpgUV5uaazsNgV3D2fM
 8XWa8b0sy1VFdEeo/+gpnDuFpMXM5evwR4cSuF8dz19XHWrelCblEZawpcn0dgwof1Jw
 TXy8habVTSGS4JvFvUEFPL1kE5oPF3oJZhsUfwB+i+zoCxuhwlJt4ZlVbrCrXm0bOUDk
 dAZV7n5ncNy+nxhi/juw5AFH4Jen4jZjO5FA1frsmExaILwOanQguYuvE+I5swJyx39M
 vfGbO0REsHROnuMb538u07vU43aDLppeY+HqmOYX2jiM6/ZfmziztBSsyuqjIwOaXZ2Y
 BSMw==
X-Gm-Message-State: ANhLgQ07J8BZ0ATaaMrX4Rk6voa/svspUW0NHQhbsztgYpA4ZSyasNgv
 3BruclEMIZh4ow0XwVCxkFZgPnYFkzLpV3tFi5NI23j2t9q2hLs6aPT09tKFFTSwqCyQdMTTQmv
 63i1e6Qse/gpBf9I=
X-Received: by 2002:a5d:5089:: with SMTP id a9mr63915wrt.187.1584374869132;
 Mon, 16 Mar 2020 09:07:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsH9erD+/AzduZt6/2G1VOVoVwqiEnP7oEPNYJjE5gdXKGGdo2hHizz2wb54XtGoBPo2ebMbQ==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr63883wrt.187.1584374868815;
 Mon, 16 Mar 2020 09:07:48 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id k9sm494508wrd.74.2020.03.16.09.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/19] target/arm: Restrict ARMv7 R-profile cpus to TCG
 accel
Date: Mon, 16 Mar 2020 17:06:28 +0100
Message-Id: <20200316160634.3386-14-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 216.205.24.74
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

A KVM-only build won't be able to run R-profile cpus.

Only enable the following ARMv7 R-Profile CPUs when TCG is available:

  - Cortex-R5
  - Cortex-R5F

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/aarch64-softmmu.mak |  1 -
 target/arm/cpu.c                    | 51 ------------------
 target/arm/cpu_v7r.c                | 83 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                      |  1 +
 target/arm/Kconfig                  |  4 ++
 target/arm/Makefile.objs            |  1 +
 6 files changed, 89 insertions(+), 52 deletions(-)
 create mode 100644 target/arm/cpu_v7r.c

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-=
softmmu.mak
index 958b1e08e4..a4202f5681 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -3,6 +3,5 @@
 # We support all the 32 bit boards so need all their config
 include arm-softmmu.mak
=20
-CONFIG_XLNX_ZYNQMP_ARM=3Dy
 CONFIG_XLNX_VERSAL=3Dy
 CONFIG_SBSA_REF=3Dy
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 34908828a0..84be8792f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1975,55 +1975,6 @@ static void arm_v7m_class_init(ObjectClass *oc, void=
 *data)
     cc->cpu_exec_interrupt =3D arm_v7m_cpu_exec_interrupt;
 }
=20
-static const ARMCPRegInfo cortexr5_cp_reginfo[] =3D {
-    /* Dummy the TCM region regs for the moment */
-    { .name =3D "ATCM", .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 1, .=
opc2 =3D 0,
-      .access =3D PL1_RW, .type =3D ARM_CP_CONST },
-    { .name =3D "BTCM", .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 1, .=
opc2 =3D 1,
-      .access =3D PL1_RW, .type =3D ARM_CP_CONST },
-    { .name =3D "DCACHE_INVAL", .cp =3D 15, .opc1 =3D 0, .crn =3D 15, .crm=
 =3D 5,
-      .opc2 =3D 0, .access =3D PL1_W, .type =3D ARM_CP_NOP },
-    REGINFO_SENTINEL
-};
-
-static void cortex_r5_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_V7MP);
-    set_feature(&cpu->env, ARM_FEATURE_PMSA);
-    set_feature(&cpu->env, ARM_FEATURE_PMU);
-    cpu->midr =3D 0x411fc153; /* r1p3 */
-    cpu->id_pfr0 =3D 0x0131;
-    cpu->id_pfr1 =3D 0x001;
-    cpu->isar.id_dfr0 =3D 0x010400;
-    cpu->id_afr0 =3D 0x0;
-    cpu->isar.id_mmfr0 =3D 0x0210030;
-    cpu->isar.id_mmfr1 =3D 0x00000000;
-    cpu->isar.id_mmfr2 =3D 0x01200000;
-    cpu->isar.id_mmfr3 =3D 0x0211;
-    cpu->isar.id_isar0 =3D 0x02101111;
-    cpu->isar.id_isar1 =3D 0x13112111;
-    cpu->isar.id_isar2 =3D 0x21232141;
-    cpu->isar.id_isar3 =3D 0x01112131;
-    cpu->isar.id_isar4 =3D 0x0010142;
-    cpu->isar.id_isar5 =3D 0x0;
-    cpu->isar.id_isar6 =3D 0x0;
-    cpu->mp_is_up =3D true;
-    cpu->pmsav7_dregion =3D 16;
-    define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
-}
-
-static void cortex_r5f_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cortex_r5_initfn(obj);
-    cpu->isar.mvfr0 =3D 0x10110221;
-    cpu->isar.mvfr1 =3D 0x00000011;
-}
-
 static const ARMCPRegInfo cortexa8_cp_reginfo[] =3D {
     { .name =3D "L2LOCKDOWN", .cp =3D 15, .crn =3D 9, .crm =3D 0, .opc1 =
=3D 1, .opc2 =3D 0,
       .access =3D PL1_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
@@ -2333,8 +2284,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
                              .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-m33",  .initfn =3D cortex_m33_initfn,
                              .class_init =3D arm_v7m_class_init },
-    { .name =3D "cortex-r5",   .initfn =3D cortex_r5_initfn },
-    { .name =3D "cortex-r5f",  .initfn =3D cortex_r5f_initfn },
     { .name =3D "cortex-a7",   .initfn =3D cortex_a7_initfn },
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
diff --git a/target/arm/cpu_v7r.c b/target/arm/cpu_v7r.c
new file mode 100644
index 0000000000..9576844b5c
--- /dev/null
+++ b/target/arm/cpu_v7r.c
@@ -0,0 +1,83 @@
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
+static const ARMCPRegInfo cortexr5_cp_reginfo[] =3D {
+    /* Dummy the TCM region regs for the moment */
+    { .name =3D "ATCM", .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 1, .=
opc2 =3D 0,
+      .access =3D PL1_RW, .type =3D ARM_CP_CONST },
+    { .name =3D "BTCM", .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 1, .=
opc2 =3D 1,
+      .access =3D PL1_RW, .type =3D ARM_CP_CONST },
+    { .name =3D "DCACHE_INVAL", .cp =3D 15, .opc1 =3D 0, .crn =3D 15, .crm=
 =3D 5,
+      .opc2 =3D 0, .access =3D PL1_W, .type =3D ARM_CP_NOP },
+    REGINFO_SENTINEL
+};
+
+static void cortex_r5_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_V7MP);
+    set_feature(&cpu->env, ARM_FEATURE_PMSA);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
+    cpu->midr =3D 0x411fc153; /* r1p3 */
+    cpu->id_pfr0 =3D 0x0131;
+    cpu->id_pfr1 =3D 0x001;
+    cpu->isar.id_dfr0 =3D 0x010400;
+    cpu->id_afr0 =3D 0x0;
+    cpu->isar.id_mmfr0 =3D 0x0210030;
+    cpu->isar.id_mmfr1 =3D 0x00000000;
+    cpu->isar.id_mmfr2 =3D 0x01200000;
+    cpu->isar.id_mmfr3 =3D 0x0211;
+    cpu->isar.id_isar0 =3D 0x02101111;
+    cpu->isar.id_isar1 =3D 0x13112111;
+    cpu->isar.id_isar2 =3D 0x21232141;
+    cpu->isar.id_isar3 =3D 0x01112131;
+    cpu->isar.id_isar4 =3D 0x0010142;
+    cpu->isar.id_isar5 =3D 0x0;
+    cpu->isar.id_isar6 =3D 0x0;
+    cpu->mp_is_up =3D true;
+    cpu->pmsav7_dregion =3D 16;
+    define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
+}
+
+static void cortex_r5f_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cortex_r5_initfn(obj);
+    cpu->isar.mvfr0 =3D 0x10110221;
+    cpu->isar.mvfr1 =3D 0x00000011;
+}
+
+static const ARMCPUInfo arm_v7r_cpus[] =3D {
+    { .name =3D "cortex-r5",   .initfn =3D cortex_r5_initfn },
+    { .name =3D "cortex-r5f",  .initfn =3D cortex_r5f_initfn },
+    { .name =3D NULL }
+};
+
+static void arm_v7r_cpu_register_types(void)
+{
+    const ARMCPUInfo *info =3D arm_v7r_cpus;
+
+    while (info->name) {
+        arm_cpu_register(info);
+        info++;
+    }
+}
+
+type_init(arm_v7r_cpu_register_types)
+
+#endif
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e87dd611f2..d0903d8544 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -340,6 +340,7 @@ config XLNX_ZYNQMP_ARM
     bool
     select AHCI
     select ARM_GIC
+    select ARM_V7R
     select CADENCE
     select DDC
     select DPCD
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index df5f8dff42..9768f9180f 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -10,5 +10,9 @@ config ARM_V6
     depends on TCG
     bool
=20
+config ARM_V7R
+    depends on TCG
+    bool
+
 config ARM_V7M
     bool
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 0473c559c6..a2508f0655 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -71,6 +71,7 @@ obj-y +=3D m_helper.o
 obj-$(CONFIG_ARM_V4) +=3D cpu_v4.o
 obj-$(CONFIG_ARM_V5) +=3D cpu_v5.o
 obj-$(CONFIG_ARM_V6) +=3D cpu_v6.o
+obj-$(CONFIG_ARM_V7R) +=3D cpu_v7r.o
=20
 obj-$(CONFIG_SOFTMMU) +=3D psci.o
=20
--=20
2.21.1


