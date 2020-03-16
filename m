Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A3C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A4320658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ER7wfCAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A4320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtwD-0007yH-FT
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHb-0004bv-6j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHY-0005ZM-V6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHY-0005V8-PA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xvIh8Ri8MGdsRwEuM5pCIZMdFKEO3pS7XtCgO8xIIro=;
 b=ER7wfCAgUGkDTZE6uCX3kipzu5rBhYubmpOkWOnZKZkJP+XAUFQBdYrepDuorHzuwsxv2h
 zvd4Ep/AXuLI1p8TcyQBTCDo2Ebr5AjmW/beFJspaumYFqOmAqOJY4OMrdirm4xop1Etq/
 blfkk0sidDyQiA3HcgqbSnI/FwBn+Vw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-zncu3tFzMMS6pFlXzATcxA-1; Mon, 16 Mar 2020 12:07:57 -0400
X-MC-Unique: zncu3tFzMMS6pFlXzATcxA-1
Received: by mail-wm1-f70.google.com with SMTP id f9so3240837wme.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dfDnran3E3vJVzOwh1qQwExgfNmDOU0PLsSJKRIuHk=;
 b=AiRlv/valUDKoUTzhRssNxGds1JXXFWs0zwnXYfujDQgZEnO/k6hRpn7j52JhQVpuW
 yTMGowzMZrChsRRHMWLGh1/UwP48QGfcJpqIui176bn6A/wE66t2raj2MDY/2Ma374DC
 vwd7/TEQj5VfmxBbbw9p7RMqyE5imq5ErVCqZVqoa8NYz+eCwrN+1VuIF4E7WZxXVS9P
 y4yy/PNmatJe96FSjRoKrczxMePWP8A8cd/3Vc0wGu+GxTxkKcU9Ss21n3t/iKSlocv7
 egBQ7J2jhggncJxI7BgyN4CS+iKnhLYW/YU+nEx4cCnmnNYiwDNGHJq+O7ei+jnFkbuj
 2hAw==
X-Gm-Message-State: ANhLgQ28fWBzGtoh9SwB8k0X8T+DdDG55KFEzpDMwR+1a82atsYMyyV6
 1IvYXo1g9V15W+sbE3q3YC8CMGO99YoVp96RDcjiiLlu+g3YcmNqh3vLPPRh5sIb601ILn6pF0T
 aKWtFpen1DzaWLbg=
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr29224306wme.66.1584374875542; 
 Mon, 16 Mar 2020 09:07:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvvUsowZLHDxnYfDB3bDiW71se1HIHUXOcWI+nMKioBIiFsS1gl8oiiU5/RpwkxKCUDyY8mEA==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr29224211wme.66.1584374874213; 
 Mon, 16 Mar 2020 09:07:54 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id u25sm215843wml.17.2020.03.16.09.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/19] target/arm: Restrict ARMv7 M-profile cpus to TCG
 accel
Date: Mon, 16 Mar 2020 17:06:29 +0100
Message-Id: <20200316160634.3386-15-philmd@redhat.com>
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

A KVM-only build won't be able to run M-profile cpus.

Only enable the following ARMv7 M-Profile CPUs when TCG is available:

  - Cortex-M3
  - Cortex-M4
  - Cortex-M33

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |   8 --
 target/arm/cpu.c                | 176 ---------------------------
 target/arm/cpu_v7m.c            | 207 ++++++++++++++++++++++++++++++++
 target/arm/Kconfig              |   1 +
 target/arm/Makefile.objs        |   1 +
 5 files changed, 209 insertions(+), 184 deletions(-)
 create mode 100644 target/arm/cpu_v7m.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 3aa27f3b40..511d74da58 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -12,19 +12,11 @@ CONFIG_ARM_V7M=3Dy
 CONFIG_ARM_VIRT=3Dy
 CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
-CONFIG_HIGHBANK=3Dy
-CONFIG_MUSCA=3Dy
-CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
 CONFIG_VEXPRESS=3Dy
 CONFIG_ZYNQ=3Dy
-CONFIG_NETDUINO2=3Dy
-CONFIG_NETDUINOPLUS2=3Dy
-CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
 CONFIG_SABRELITE=3Dy
-CONFIG_EMCRAFT_SF2=3Dy
-CONFIG_MICROBIT=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
 CONFIG_ALLWINNER_H3=3Dy
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 84be8792f6..dfa7e64c7e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -573,31 +573,6 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrup=
t_request)
     return true;
 }
=20
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request=
)
-{
-    CPUClass *cc =3D CPU_GET_CLASS(cs);
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    bool ret =3D false;
-
-    /* ARMv7-M interrupt masking works differently than -A or -R.
-     * There is no FIQ/IRQ distinction. Instead of I and F bits
-     * masking FIQ and IRQ interrupts, an exception is taken only
-     * if it is higher priority than the current execution priority
-     * (which depends on state like BASEPRI, FAULTMASK and the
-     * currently active exception).
-     */
-    if (interrupt_request & CPU_INTERRUPT_HARD
-        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
-        cs->exception_index =3D EXCP_IRQ;
-        cc->do_interrupt(cs);
-        ret =3D true;
-    }
-    return ret;
-}
-#endif
-
 void arm_cpu_update_virq(ARMCPU *cpu)
 {
     /*
@@ -1834,147 +1809,6 @@ static ObjectClass *arm_cpu_class_by_name(const cha=
r *cpu_model)
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
=20
-static void cortex_m0_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-
-    cpu->midr =3D 0x410cc200;
-}
-
-static void cortex_m3_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    cpu->midr =3D 0x410fc231;
-    cpu->pmsav7_dregion =3D 8;
-    cpu->id_pfr0 =3D 0x00000030;
-    cpu->id_pfr1 =3D 0x00000200;
-    cpu->isar.id_dfr0 =3D 0x00100000;
-    cpu->id_afr0 =3D 0x00000000;
-    cpu->isar.id_mmfr0 =3D 0x00000030;
-    cpu->isar.id_mmfr1 =3D 0x00000000;
-    cpu->isar.id_mmfr2 =3D 0x00000000;
-    cpu->isar.id_mmfr3 =3D 0x00000000;
-    cpu->isar.id_isar0 =3D 0x01141110;
-    cpu->isar.id_isar1 =3D 0x02111000;
-    cpu->isar.id_isar2 =3D 0x21112231;
-    cpu->isar.id_isar3 =3D 0x01111110;
-    cpu->isar.id_isar4 =3D 0x01310102;
-    cpu->isar.id_isar5 =3D 0x00000000;
-    cpu->isar.id_isar6 =3D 0x00000000;
-}
-
-static void cortex_m4_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr =3D 0x410fc240; /* r0p0 */
-    cpu->pmsav7_dregion =3D 8;
-    cpu->isar.mvfr0 =3D 0x10110021;
-    cpu->isar.mvfr1 =3D 0x11000011;
-    cpu->isar.mvfr2 =3D 0x00000000;
-    cpu->id_pfr0 =3D 0x00000030;
-    cpu->id_pfr1 =3D 0x00000200;
-    cpu->isar.id_dfr0 =3D 0x00100000;
-    cpu->id_afr0 =3D 0x00000000;
-    cpu->isar.id_mmfr0 =3D 0x00000030;
-    cpu->isar.id_mmfr1 =3D 0x00000000;
-    cpu->isar.id_mmfr2 =3D 0x00000000;
-    cpu->isar.id_mmfr3 =3D 0x00000000;
-    cpu->isar.id_isar0 =3D 0x01141110;
-    cpu->isar.id_isar1 =3D 0x02111000;
-    cpu->isar.id_isar2 =3D 0x21112231;
-    cpu->isar.id_isar3 =3D 0x01111110;
-    cpu->isar.id_isar4 =3D 0x01310102;
-    cpu->isar.id_isar5 =3D 0x00000000;
-    cpu->isar.id_isar6 =3D 0x00000000;
-}
-
-static void cortex_m7_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr =3D 0x411fc272; /* r1p2 */
-    cpu->pmsav7_dregion =3D 8;
-    cpu->isar.mvfr0 =3D 0x10110221;
-    cpu->isar.mvfr1 =3D 0x12000011;
-    cpu->isar.mvfr2 =3D 0x00000040;
-    cpu->id_pfr0 =3D 0x00000030;
-    cpu->id_pfr1 =3D 0x00000200;
-    cpu->isar.id_dfr0 =3D 0x00100000;
-    cpu->id_afr0 =3D 0x00000000;
-    cpu->isar.id_mmfr0 =3D 0x00100030;
-    cpu->isar.id_mmfr1 =3D 0x00000000;
-    cpu->isar.id_mmfr2 =3D 0x01000000;
-    cpu->isar.id_mmfr3 =3D 0x00000000;
-    cpu->isar.id_isar0 =3D 0x01101110;
-    cpu->isar.id_isar1 =3D 0x02112000;
-    cpu->isar.id_isar2 =3D 0x20232231;
-    cpu->isar.id_isar3 =3D 0x01111131;
-    cpu->isar.id_isar4 =3D 0x01310132;
-    cpu->isar.id_isar5 =3D 0x00000000;
-    cpu->isar.id_isar6 =3D 0x00000000;
-}
-
-static void cortex_m33_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr =3D 0x410fd213; /* r0p3 */
-    cpu->pmsav7_dregion =3D 16;
-    cpu->sau_sregion =3D 8;
-    cpu->isar.mvfr0 =3D 0x10110021;
-    cpu->isar.mvfr1 =3D 0x11000011;
-    cpu->isar.mvfr2 =3D 0x00000040;
-    cpu->id_pfr0 =3D 0x00000030;
-    cpu->id_pfr1 =3D 0x00000210;
-    cpu->isar.id_dfr0 =3D 0x00200000;
-    cpu->id_afr0 =3D 0x00000000;
-    cpu->isar.id_mmfr0 =3D 0x00101F40;
-    cpu->isar.id_mmfr1 =3D 0x00000000;
-    cpu->isar.id_mmfr2 =3D 0x01000000;
-    cpu->isar.id_mmfr3 =3D 0x00000000;
-    cpu->isar.id_isar0 =3D 0x01101110;
-    cpu->isar.id_isar1 =3D 0x02212000;
-    cpu->isar.id_isar2 =3D 0x20232232;
-    cpu->isar.id_isar3 =3D 0x01111131;
-    cpu->isar.id_isar4 =3D 0x01310132;
-    cpu->isar.id_isar5 =3D 0x00000000;
-    cpu->isar.id_isar6 =3D 0x00000000;
-    cpu->clidr =3D 0x00000000;
-    cpu->ctr =3D 0x8000c000;
-}
-
-static void arm_v7m_class_init(ObjectClass *oc, void *data)
-{
-    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
-    CPUClass *cc =3D CPU_CLASS(oc);
-
-    acc->info =3D data;
-#ifndef CONFIG_USER_ONLY
-    cc->do_interrupt =3D arm_v7m_cpu_do_interrupt;
-#endif
-
-    cc->cpu_exec_interrupt =3D arm_v7m_cpu_exec_interrupt;
-}
-
 static const ARMCPRegInfo cortexa8_cp_reginfo[] =3D {
     { .name =3D "L2LOCKDOWN", .cp =3D 15, .crn =3D 9, .crm =3D 0, .opc1 =
=3D 1, .opc2 =3D 0,
       .access =3D PL1_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
@@ -2274,16 +2108,6 @@ static void arm_max_initfn(Object *obj)
=20
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-    { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
-                             .class_init =3D arm_v7m_class_init },
-    { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
-                             .class_init =3D arm_v7m_class_init },
-    { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
-                             .class_init =3D arm_v7m_class_init },
-    { .name =3D "cortex-m7",   .initfn =3D cortex_m7_initfn,
-                             .class_init =3D arm_v7m_class_init },
-    { .name =3D "cortex-m33",  .initfn =3D cortex_m33_initfn,
-                             .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-a7",   .initfn =3D cortex_a7_initfn },
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
diff --git a/target/arm/cpu_v7m.c b/target/arm/cpu_v7m.c
new file mode 100644
index 0000000000..529259b9cd
--- /dev/null
+++ b/target/arm/cpu_v7m.c
@@ -0,0 +1,207 @@
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
+static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request=
)
+{
+    CPUClass *cc =3D CPU_GET_CLASS(cs);
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    bool ret =3D false;
+
+    /*
+     * ARMv7-M interrupt masking works differently than -A or -R.
+     * There is no FIQ/IRQ distinction. Instead of I and F bits
+     * masking FIQ and IRQ interrupts, an exception is taken only
+     * if it is higher priority than the current execution priority
+     * (which depends on state like BASEPRI, FAULTMASK and the
+     * currently active exception).
+     */
+    if (interrupt_request & CPU_INTERRUPT_HARD
+        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
+        cs->exception_index =3D EXCP_IRQ;
+        cc->do_interrupt(cs);
+        ret =3D true;
+    }
+    return ret;
+}
+
+static void cortex_m0_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+
+    cpu->midr =3D 0x410cc200;
+}
+
+static void cortex_m3_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    cpu->midr =3D 0x410fc231;
+    cpu->pmsav7_dregion =3D 8;
+    cpu->id_pfr0 =3D 0x00000030;
+    cpu->id_pfr1 =3D 0x00000200;
+    cpu->isar.id_dfr0 =3D 0x00100000;
+    cpu->id_afr0 =3D 0x00000000;
+    cpu->isar.id_mmfr0 =3D 0x00000030;
+    cpu->isar.id_mmfr1 =3D 0x00000000;
+    cpu->isar.id_mmfr2 =3D 0x00000000;
+    cpu->isar.id_mmfr3 =3D 0x00000000;
+    cpu->isar.id_isar0 =3D 0x01141110;
+    cpu->isar.id_isar1 =3D 0x02111000;
+    cpu->isar.id_isar2 =3D 0x21112231;
+    cpu->isar.id_isar3 =3D 0x01111110;
+    cpu->isar.id_isar4 =3D 0x01310102;
+    cpu->isar.id_isar5 =3D 0x00000000;
+    cpu->isar.id_isar6 =3D 0x00000000;
+}
+
+static void cortex_m4_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr =3D 0x410fc240; /* r0p0 */
+    cpu->pmsav7_dregion =3D 8;
+    cpu->isar.mvfr0 =3D 0x10110021;
+    cpu->isar.mvfr1 =3D 0x11000011;
+    cpu->isar.mvfr2 =3D 0x00000000;
+    cpu->id_pfr0 =3D 0x00000030;
+    cpu->id_pfr1 =3D 0x00000200;
+    cpu->isar.id_dfr0 =3D 0x00100000;
+    cpu->id_afr0 =3D 0x00000000;
+    cpu->isar.id_mmfr0 =3D 0x00000030;
+    cpu->isar.id_mmfr1 =3D 0x00000000;
+    cpu->isar.id_mmfr2 =3D 0x00000000;
+    cpu->isar.id_mmfr3 =3D 0x00000000;
+    cpu->isar.id_isar0 =3D 0x01141110;
+    cpu->isar.id_isar1 =3D 0x02111000;
+    cpu->isar.id_isar2 =3D 0x21112231;
+    cpu->isar.id_isar3 =3D 0x01111110;
+    cpu->isar.id_isar4 =3D 0x01310102;
+    cpu->isar.id_isar5 =3D 0x00000000;
+    cpu->isar.id_isar6 =3D 0x00000000;
+}
+
+static void cortex_m7_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr =3D 0x411fc272; /* r1p2 */
+    cpu->pmsav7_dregion =3D 8;
+    cpu->isar.mvfr0 =3D 0x10110221;
+    cpu->isar.mvfr1 =3D 0x12000011;
+    cpu->isar.mvfr2 =3D 0x00000040;
+    cpu->id_pfr0 =3D 0x00000030;
+    cpu->id_pfr1 =3D 0x00000200;
+    cpu->isar.id_dfr0 =3D 0x00100000;
+    cpu->id_afr0 =3D 0x00000000;
+    cpu->isar.id_mmfr0 =3D 0x00100030;
+    cpu->isar.id_mmfr1 =3D 0x00000000;
+    cpu->isar.id_mmfr2 =3D 0x01000000;
+    cpu->isar.id_mmfr3 =3D 0x00000000;
+    cpu->isar.id_isar0 =3D 0x01101110;
+    cpu->isar.id_isar1 =3D 0x02112000;
+    cpu->isar.id_isar2 =3D 0x20232231;
+    cpu->isar.id_isar3 =3D 0x01111131;
+    cpu->isar.id_isar4 =3D 0x01310132;
+    cpu->isar.id_isar5 =3D 0x00000000;
+    cpu->isar.id_isar6 =3D 0x00000000;
+}
+
+static void cortex_m33_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr =3D 0x410fd213; /* r0p3 */
+    cpu->pmsav7_dregion =3D 16;
+    cpu->sau_sregion =3D 8;
+    cpu->isar.mvfr0 =3D 0x10110021;
+    cpu->isar.mvfr1 =3D 0x11000011;
+    cpu->isar.mvfr2 =3D 0x00000040;
+    cpu->id_pfr0 =3D 0x00000030;
+    cpu->id_pfr1 =3D 0x00000210;
+    cpu->isar.id_dfr0 =3D 0x00200000;
+    cpu->id_afr0 =3D 0x00000000;
+    cpu->isar.id_mmfr0 =3D 0x00101F40;
+    cpu->isar.id_mmfr1 =3D 0x00000000;
+    cpu->isar.id_mmfr2 =3D 0x01000000;
+    cpu->isar.id_mmfr3 =3D 0x00000000;
+    cpu->isar.id_isar0 =3D 0x01101110;
+    cpu->isar.id_isar1 =3D 0x02212000;
+    cpu->isar.id_isar2 =3D 0x20232232;
+    cpu->isar.id_isar3 =3D 0x01111131;
+    cpu->isar.id_isar4 =3D 0x01310132;
+    cpu->isar.id_isar5 =3D 0x00000000;
+    cpu->isar.id_isar6 =3D 0x00000000;
+    cpu->clidr =3D 0x00000000;
+    cpu->ctr =3D 0x8000c000;
+}
+
+static void arm_v7m_class_init(ObjectClass *oc, void *data)
+{
+    ARMCPUClass *acc =3D ARM_CPU_CLASS(oc);
+    CPUClass *cc =3D CPU_CLASS(oc);
+
+    acc->info =3D data;
+#ifndef CONFIG_USER_ONLY
+    cc->do_interrupt =3D arm_v7m_cpu_do_interrupt;
+#endif
+
+    cc->cpu_exec_interrupt =3D arm_v7m_cpu_exec_interrupt;
+}
+
+static const ARMCPUInfo arm_v7m_cpus[] =3D {
+    { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
+                             .class_init =3D arm_v7m_class_init },
+    { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
+                             .class_init =3D arm_v7m_class_init },
+    { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
+                             .class_init =3D arm_v7m_class_init },
+    { .name =3D "cortex-m7",   .initfn =3D cortex_m7_initfn,
+                             .class_init =3D arm_v7m_class_init },
+    { .name =3D "cortex-m33",  .initfn =3D cortex_m33_initfn,
+                             .class_init =3D arm_v7m_class_init },
+    { .name =3D NULL }
+};
+
+static void arm_v7m_cpu_register_types(void)
+{
+    const ARMCPUInfo *info =3D arm_v7m_cpus;
+
+    while (info->name) {
+        arm_cpu_register(info);
+        info++;
+    }
+}
+
+type_init(arm_v7m_cpu_register_types)
+
+#endif
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index 9768f9180f..929e252d89 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -15,4 +15,5 @@ config ARM_V7R
     bool
=20
 config ARM_V7M
+    depends on TCG
     bool
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index a2508f0655..a0df58526b 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -72,6 +72,7 @@ obj-$(CONFIG_ARM_V4) +=3D cpu_v4.o
 obj-$(CONFIG_ARM_V5) +=3D cpu_v5.o
 obj-$(CONFIG_ARM_V6) +=3D cpu_v6.o
 obj-$(CONFIG_ARM_V7R) +=3D cpu_v7r.o
+obj-$(CONFIG_ARM_V7M) +=3D cpu_v7m.o
=20
 obj-$(CONFIG_SOFTMMU) +=3D psci.o
=20
--=20
2.21.1


