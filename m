Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD5C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD512051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrzWGe6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD512051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt6Y-0003Bl-0S
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsHL-0004VK-ED
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsHH-0003Ja-IM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsHH-0003G2-Aw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6imTlgemnO4l8fO3+EjkoMb/LcYFsVXBVbYJMCxv6M=;
 b=JrzWGe6kAuWn3DbWvMkrComqzbM6EKxXhl3Dl7TenCr1GFADXPMFEtI/YD5KHRDY3ukHq6
 8edHrnXs7d9En5dhGxcddt+esn7nYCS9GwAJ0+0ikswRW7/CQSHudh9k+MfFukS/+bzG1T
 7Yz6LZtCQZJfwOF79KN5K2B5B2CYSR4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-iDQR470NOsSB0Pey8mx7NQ-1; Mon, 16 Mar 2020 12:07:40 -0400
X-MC-Unique: iDQR470NOsSB0Pey8mx7NQ-1
Received: by mail-wr1-f71.google.com with SMTP id g4so1600401wrv.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UM67HGSwESPGxRuh3RiuHLraRXWOuFjnUtJ3FzN+nLQ=;
 b=ImcAXNTwyaSF63u4czkMkU0DT/BQ2nrj465lMuvkxndPNjUCakWcuhlQEU7EtybfkQ
 OhzjGj2Upq1pDPaFQMUSBtamAdLcgJ0YtEuna/rHO1x1nHXfU5Icbp70mx6VwJ9fa8vg
 rmzSsTF6ydnnADL2AfdGoxZFMD1iyvqUDMIcQZhELL8r0uMJKh358X03vqKAl3oiLuVU
 eIGgIHjH+WQuebmWZxZtiOooyX15Qov0QfbhomT7xo1rpSmM1hZeXFCJtTkUFqGP+rXO
 6HVBk7Bap3Fdg4MwoHrxpkbl6NCd9fY+nbLvCsnj67w5R714qi/HwXWUuZU4F7xWMrv+
 z+Hg==
X-Gm-Message-State: ANhLgQ2L5U71VodUl32oTNDLa1UkfweIH7vaX/7kFZvTC8PYUUqmyCnA
 4Qnk83Ds4kxhnrvHDEJuB0i7luaNsThY5CFlHWIZNG/usOYcJQYMS/ejP78x0W3bg+xeDmoTyUt
 PNv6HrKPXLBQeN3M=
X-Received: by 2002:adf:83c4:: with SMTP id 62mr73131wre.105.1584374858397;
 Mon, 16 Mar 2020 09:07:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXZX9N7W7nmymhGKQDv0dc2RHYo7/YhqqMhSWsSZSwUHWK8VJ3cRt1paRdEbEfaNcAsNZgcg==
X-Received: by 2002:adf:83c4:: with SMTP id 62mr73091wre.105.1584374857928;
 Mon, 16 Mar 2020 09:07:37 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id w204sm241548wma.1.2020.03.16.09.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/19] target/arm: Restrict ARMv5 cpus to TCG accel
Date: Mon, 16 Mar 2020 17:06:26 +0100
Message-Id: <20200316160634.3386-12-philmd@redhat.com>
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

Only enable the following ARMv5 CPUs when TCG is available:

  - ARM926
  - ARM946
  - ARM1026
  - XScale (PXA250/255/260/261/262/270)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak |  12 --
 target/arm/cpu.c                | 234 ----------------------------
 target/arm/cpu_v5.c             | 266 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                  |   7 +
 target/arm/Kconfig              |   4 +
 target/arm/Makefile.objs        |   1 +
 6 files changed, 278 insertions(+), 246 deletions(-)
 create mode 100644 target/arm/cpu_v5.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 0652396296..f176a98296 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -13,32 +13,20 @@ CONFIG_ARM_VIRT=3Dy
 CONFIG_CUBIEBOARD=3Dy
 CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
-CONFIG_INTEGRATOR=3Dy
 CONFIG_FSL_IMX31=3Dy
-CONFIG_MUSICPAL=3Dy
 CONFIG_MUSCA=3Dy
 CONFIG_NSERIES=3Dy
 CONFIG_STELLARIS=3Dy
 CONFIG_REALVIEW=3Dy
-CONFIG_VERSATILE=3Dy
 CONFIG_VEXPRESS=3Dy
 CONFIG_ZYNQ=3Dy
-CONFIG_MAINSTONE=3Dy
-CONFIG_GUMSTIX=3Dy
-CONFIG_SPITZ=3Dy
-CONFIG_TOSA=3Dy
-CONFIG_Z2=3Dy
-CONFIG_COLLIE=3Dy
-CONFIG_ASPEED_SOC=3Dy
 CONFIG_NETDUINO2=3Dy
 CONFIG_NETDUINOPLUS2=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
-CONFIG_DIGIC=3Dy
 CONFIG_SABRELITE=3Dy
 CONFIG_EMCRAFT_SF2=3Dy
 CONFIG_MICROBIT=3Dy
-CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
 CONFIG_FSL_IMX6UL=3Dy
 CONFIG_ALLWINNER_H3=3Dy
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b08b6933be..f1d1ba8451 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1834,86 +1834,6 @@ static ObjectClass *arm_cpu_class_by_name(const char=
 *cpu_model)
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
=20
-static void arm926_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm926";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
-    cpu->midr =3D 0x41069265;
-    cpu->reset_fpsid =3D 0x41011090;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00090078;
-
-    /*
-     * ARMv5 does not have the ID_ISAR registers, but we can still
-     * set the field to indicate Jazelle support within QEMU.
-     */
-    cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELL=
E, 1);
-    /*
-     * Similarly, we need to set MVFR0 fields to enable vfp and short vect=
or
-     * support even though ARMv5 doesn't have this register.
-     */
-    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
-    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
-}
-
-static void arm946_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm946";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_PMSA);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    cpu->midr =3D 0x41059461;
-    cpu->ctr =3D 0x0f004006;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void arm1026_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm1026";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_AUXCR);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
-    cpu->midr =3D 0x4106a262;
-    cpu->reset_fpsid =3D 0x410110a0;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00090078;
-    cpu->reset_auxcr =3D 1;
-
-    /*
-     * ARMv5 does not have the ID_ISAR registers, but we can still
-     * set the field to indicate Jazelle support within QEMU.
-     */
-    cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELL=
E, 1);
-    /*
-     * Similarly, we need to set MVFR0 fields to enable vfp and short vect=
or
-     * support even though ARMv5 doesn't have this register.
-     */
-    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
-    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
-
-    {
-        /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0=
,2 */
-        ARMCPRegInfo ifar =3D {
-            .name =3D "IFAR", .cp =3D 15, .crn =3D 6, .crm =3D 0, .opc1 =
=3D 0, .opc2 =3D 1,
-            .access =3D PL1_RW,
-            .fieldoffset =3D offsetof(CPUARMState, cp15.ifar_ns),
-            .resetvalue =3D 0
-        };
-        define_one_arm_cp_reg(cpu, &ifar);
-    }
-}
-
 static void arm1136_r2_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -2459,144 +2379,6 @@ static void cortex_a15_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
 }
=20
-static void pxa250_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr =3D 0x69052100;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa255_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr =3D 0x69052d00;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa260_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr =3D 0x69052903;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa261_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr =3D 0x69052d05;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa262_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    cpu->midr =3D 0x69052d06;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa270a0_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr =3D 0x69054110;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa270a1_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr =3D 0x69054111;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa270b0_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr =3D 0x69054112;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa270b1_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr =3D 0x69054113;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa270c0_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr =3D 0x69054114;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
-static void pxa270c5_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "marvell,xscale";
-    set_feature(&cpu->env, ARM_FEATURE_V5);
-    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
-    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
-    cpu->midr =3D 0x69054117;
-    cpu->ctr =3D 0xd172172;
-    cpu->reset_sctlr =3D 0x00000078;
-}
-
 #ifndef TARGET_AARCH64
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this ho=
st);
  * otherwise, a CPU with as many features enabled as our emulation support=
s.
@@ -2670,9 +2452,6 @@ static void arm_max_initfn(Object *obj)
=20
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-    { .name =3D "arm926",      .initfn =3D arm926_initfn },
-    { .name =3D "arm946",      .initfn =3D arm946_initfn },
-    { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
     /* What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
      * older core than plain "arm1136". In particular this does not
      * have the v6K features.
@@ -2697,19 +2476,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
     { .name =3D "cortex-a15",  .initfn =3D cortex_a15_initfn },
-    { .name =3D "pxa250",      .initfn =3D pxa250_initfn },
-    { .name =3D "pxa255",      .initfn =3D pxa255_initfn },
-    { .name =3D "pxa260",      .initfn =3D pxa260_initfn },
-    { .name =3D "pxa261",      .initfn =3D pxa261_initfn },
-    { .name =3D "pxa262",      .initfn =3D pxa262_initfn },
-    /* "pxa270" is an alias for "pxa270-a0" */
-    { .name =3D "pxa270",      .initfn =3D pxa270a0_initfn },
-    { .name =3D "pxa270-a0",   .initfn =3D pxa270a0_initfn },
-    { .name =3D "pxa270-a1",   .initfn =3D pxa270a1_initfn },
-    { .name =3D "pxa270-b0",   .initfn =3D pxa270b0_initfn },
-    { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
-    { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
-    { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
 #ifndef TARGET_AARCH64
     { .name =3D "max",         .initfn =3D arm_max_initfn },
 #endif
diff --git a/target/arm/cpu_v5.c b/target/arm/cpu_v5.c
new file mode 100644
index 0000000000..7a231ef649
--- /dev/null
+++ b/target/arm/cpu_v5.c
@@ -0,0 +1,266 @@
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
+static void arm926_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm926";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
+    cpu->midr =3D 0x41069265;
+    cpu->reset_fpsid =3D 0x41011090;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00090078;
+
+    /*
+     * ARMv5 does not have the ID_ISAR registers, but we can still
+     * set the field to indicate Jazelle support within QEMU.
+     */
+    cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELL=
E, 1);
+    /*
+     * Similarly, we need to set MVFR0 fields to enable vfp and short vect=
or
+     * support even though ARMv5 doesn't have this register.
+     */
+    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
+    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
+}
+
+static void arm946_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm946";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_PMSA);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    cpu->midr =3D 0x41059461;
+    cpu->ctr =3D 0x0f004006;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void arm1026_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm1026";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_AUXCR);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
+    cpu->midr =3D 0x4106a262;
+    cpu->reset_fpsid =3D 0x410110a0;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00090078;
+    cpu->reset_auxcr =3D 1;
+
+    /*
+     * ARMv5 does not have the ID_ISAR registers, but we can still
+     * set the field to indicate Jazelle support within QEMU.
+     */
+    cpu->isar.id_isar1 =3D FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELL=
E, 1);
+    /*
+     * Similarly, we need to set MVFR0 fields to enable vfp and short vect=
or
+     * support even though ARMv5 doesn't have this register.
+     */
+    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
+    cpu->isar.mvfr0 =3D FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
+
+    {
+        /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0=
,2 */
+        ARMCPRegInfo ifar =3D {
+            .name =3D "IFAR", .cp =3D 15, .crn =3D 6, .crm =3D 0, .opc1 =
=3D 0, .opc2 =3D 1,
+            .access =3D PL1_RW,
+            .fieldoffset =3D offsetof(CPUARMState, cp15.ifar_ns),
+            .resetvalue =3D 0
+        };
+        define_one_arm_cp_reg(cpu, &ifar);
+    }
+}
+
+static void pxa250_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    cpu->midr =3D 0x69052100;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa255_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    cpu->midr =3D 0x69052d00;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa260_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    cpu->midr =3D 0x69052903;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa261_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    cpu->midr =3D 0x69052d05;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa262_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    cpu->midr =3D 0x69052d06;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa270a0_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
+    cpu->midr =3D 0x69054110;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa270a1_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
+    cpu->midr =3D 0x69054111;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa270b0_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
+    cpu->midr =3D 0x69054112;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa270b1_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
+    cpu->midr =3D 0x69054113;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa270c0_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
+    cpu->midr =3D 0x69054114;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static void pxa270c5_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "marvell,xscale";
+    set_feature(&cpu->env, ARM_FEATURE_V5);
+    set_feature(&cpu->env, ARM_FEATURE_XSCALE);
+    set_feature(&cpu->env, ARM_FEATURE_IWMMXT);
+    cpu->midr =3D 0x69054117;
+    cpu->ctr =3D 0xd172172;
+    cpu->reset_sctlr =3D 0x00000078;
+}
+
+static const ARMCPUInfo arm_v5_cpus[] =3D {
+    { .name =3D "arm926",      .initfn =3D arm926_initfn },
+    { .name =3D "arm946",      .initfn =3D arm946_initfn },
+    { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
+    { .name =3D "pxa250",      .initfn =3D pxa250_initfn },
+    { .name =3D "pxa255",      .initfn =3D pxa255_initfn },
+    { .name =3D "pxa260",      .initfn =3D pxa260_initfn },
+    { .name =3D "pxa261",      .initfn =3D pxa261_initfn },
+    { .name =3D "pxa262",      .initfn =3D pxa262_initfn },
+    /* "pxa270" is an alias for "pxa270-a0" */
+    { .name =3D "pxa270",      .initfn =3D pxa270a0_initfn },
+    { .name =3D "pxa270-a0",   .initfn =3D pxa270a0_initfn },
+    { .name =3D "pxa270-a1",   .initfn =3D pxa270a1_initfn },
+    { .name =3D "pxa270-b0",   .initfn =3D pxa270b0_initfn },
+    { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
+    { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
+    { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
+    { .name =3D NULL }
+};
+
+static void arm_v5_cpu_register_types(void)
+{
+    const ARMCPUInfo *info =3D arm_v5_cpus;
+
+    while (info->name) {
+        arm_cpu_register(info);
+        info++;
+    }
+}
+
+type_init(arm_v5_cpu_register_types)
+
+#endif
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7fc0cff776..3b78471de0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -38,6 +38,7 @@ config CUBIEBOARD
=20
 config DIGIC
     bool
+    select ARM_V5
     select PTIMER
     select PFLASH_CFI02
=20
@@ -67,6 +68,7 @@ config HIGHBANK
=20
 config INTEGRATOR
     bool
+    select ARM_V5
     select ARM_TIMER
     select INTEGRATOR_DEBUG
     select PL011 # UART
@@ -93,6 +95,7 @@ config MUSCA
=20
 config MUSICPAL
     bool
+    select ARM_V5
     select BITBANG_I2C
     select MARVELL_88W8618
     select PTIMER
@@ -132,6 +135,7 @@ config OMAP
=20
 config PXA2XX
     bool
+    select ARM_V5
     select FRAMEBUFFER
     select I2C
     select SERIAL
@@ -248,6 +252,7 @@ config SX1
=20
 config VERSATILE
     bool
+    select ARM_V5
     select ARM_TIMER # sp804
     select PFLASH_CFI01
     select LSI_SCSI_PCI
@@ -354,6 +359,7 @@ config XLNX_VERSAL
=20
 config FSL_IMX25
     bool
+    select ARM_V5
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -376,6 +382,7 @@ config FSL_IMX6
=20
 config ASPEED_SOC
     bool
+    select ARM_V5
     select DS1338
     select FTGMAC100
     select I2C
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
index 0d496d318a..028d8382fe 100644
--- a/target/arm/Kconfig
+++ b/target/arm/Kconfig
@@ -2,5 +2,9 @@ config ARM_V4
     depends on TCG
     bool
=20
+config ARM_V5
+    depends on TCG
+    bool
+
 config ARM_V7M
     bool
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index bc0f63ebbc..f66f7f1158 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -69,6 +69,7 @@ obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
 obj-y +=3D m_helper.o
=20
 obj-$(CONFIG_ARM_V4) +=3D cpu_v4.o
+obj-$(CONFIG_ARM_V5) +=3D cpu_v5.o
=20
 obj-$(CONFIG_SOFTMMU) +=3D psci.o
=20
--=20
2.21.1


