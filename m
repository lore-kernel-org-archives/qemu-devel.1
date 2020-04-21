Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C471C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6B820753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS/mhPhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6B820753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsrY-0005eZ-Vi
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsop-0001h1-62
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsom-00085W-Jq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:20:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56724
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQsom-00083s-2c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587475203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzwPOMqdtZSYdT32firlVy7PjpXciFCNA9agXuINWnc=;
 b=CS/mhPhJarpB6vRkSsLuzL5qlosKXN08NqrXqa3ePIG+jVaot2WRl/N+VJ4sH7OSTmow7Y
 Psuae9f8LGmBxB1iKuKLb5WaIiKiYoamIhIrib/bRHCwVXNX7dIoAkLFIk/prW2s5gDH47
 kedSuJ1xcyk+LItTjhBvPSAlGdqyF/c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-D6vGFOAoM3WBH7E0zOTkRw-1; Tue, 21 Apr 2020 09:20:01 -0400
X-MC-Unique: D6vGFOAoM3WBH7E0zOTkRw-1
Received: by mail-wm1-f70.google.com with SMTP id o26so1369065wmh.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oU7W4nI0AW+Rq2I20Q1jXQJWNo5D7Q0B6oX5KyGq0vY=;
 b=WgmDnEHTEVr5WDYb4kJv6U7B9U+O0PSPL8u3bdCXC3NPeqCBdSBzAf6e01EV8NIAeU
 pMO0eRPfvso4GIOvDmFhbtoeLFOAazXLxtRbrymkFHVrN5WCznUakrw2lzhcjUCRSJtd
 GVHLXlMoSZySvHkf17FGEy4d/NLE/G3QMOU0SPay+mtCKMuCu0WFzLQHJkB3+eRpa/PL
 L4MSTqHKAKdmaL0eFSStasylmRYBqRP7FSkV2lnShPpqLDBzWXne7uUEtCAF4Xu9cJ4r
 mswuIEt3oOlIuVpIeSohUF51PRcypKX0+5V962p23fficu549c0+tkAYUTqIUNXbq72w
 lz4Q==
X-Gm-Message-State: AGi0PuYUjesLgPa/uEVabB4huF1i9Zi1uvaQKy82gnJB5LBf9l7ud3ri
 rKIf0XXt+5ktoRWPlgvEgXb2JfV1lxiaV+8xMspdnwZBneRtqQ3VhhyMOhRzgon0AoSBDYL5J/O
 73WuZqUl6PZT7Itw=
X-Received: by 2002:adf:decb:: with SMTP id i11mr23147908wrn.140.1587475199042; 
 Tue, 21 Apr 2020 06:19:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+TgoEiT99/aGLwwWjEMcDPH7HmE4Xm6BGQxAVoTreIQHN/swEbzsB0uB1uJZDkiY8sR4a2g==
X-Received: by 2002:adf:decb:: with SMTP id i11mr23147849wrn.140.1587475198069; 
 Tue, 21 Apr 2020 06:19:58 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z10sm3851877wrg.69.2020.04.21.06.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 06:19:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/arm: Restrict TCG cpus to TCG accel
Date: Tue, 21 Apr 2020 15:19:26 +0200
Message-Id: <20200421131926.12116-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421131926.12116-1-philmd@redhat.com>
References: <20200421131926.12116-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A KVM-only build won't be able to run TCG cpus.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This patch review is funnier using:
'git-diff --color-moved=3Ddimmed-zebra'
---
 target/arm/cpu.c         | 634 -------------------------------------
 target/arm/cpu_tcg.c     | 663 +++++++++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs |   1 +
 3 files changed, 664 insertions(+), 634 deletions(-)
 create mode 100644 target/arm/cpu_tcg.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1ddf850f00..92d90f0925 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -574,32 +574,6 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrup=
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
-    /*
-     * ARMv7-M interrupt masking works differently than -A or -R.
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
@@ -1820,406 +1794,6 @@ static ObjectClass *arm_cpu_class_by_name(const cha=
r *cpu_model)
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
-static void arm1136_r2_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-    /*
-     * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
-     * older core than plain "arm1136". In particular this does not
-     * have the v6K features.
-     * These ID register values are correct for 1136 but may be wrong
-     * for 1136_r2 (in particular r0p2 does not actually implement most
-     * of the ID registers).
-     */
-
-    cpu->dtb_compatible =3D "arm,arm1136";
-    set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
-    cpu->midr =3D 0x4107b362;
-    cpu->reset_fpsid =3D 0x410120b4;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00050078;
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x1;
-    cpu->isar.id_dfr0 =3D 0x2;
-    cpu->id_afr0 =3D 0x3;
-    cpu->isar.id_mmfr0 =3D 0x01130003;
-    cpu->isar.id_mmfr1 =3D 0x10030302;
-    cpu->isar.id_mmfr2 =3D 0x01222110;
-    cpu->isar.id_isar0 =3D 0x00140011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11231111;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x141;
-    cpu->reset_auxcr =3D 7;
-}
-
-static void arm1136_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm1136";
-    set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
-    cpu->midr =3D 0x4117b363;
-    cpu->reset_fpsid =3D 0x410120b4;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00050078;
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x1;
-    cpu->isar.id_dfr0 =3D 0x2;
-    cpu->id_afr0 =3D 0x3;
-    cpu->isar.id_mmfr0 =3D 0x01130003;
-    cpu->isar.id_mmfr1 =3D 0x10030302;
-    cpu->isar.id_mmfr2 =3D 0x01222110;
-    cpu->isar.id_isar0 =3D 0x00140011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11231111;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x141;
-    cpu->reset_auxcr =3D 7;
-}
-
-static void arm1176_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm1176";
-    set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VAPA);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
-    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
-    set_feature(&cpu->env, ARM_FEATURE_EL3);
-    cpu->midr =3D 0x410fb767;
-    cpu->reset_fpsid =3D 0x410120b5;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1dd20d2;
-    cpu->reset_sctlr =3D 0x00050078;
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x11;
-    cpu->isar.id_dfr0 =3D 0x33;
-    cpu->id_afr0 =3D 0;
-    cpu->isar.id_mmfr0 =3D 0x01130003;
-    cpu->isar.id_mmfr1 =3D 0x10030302;
-    cpu->isar.id_mmfr2 =3D 0x01222100;
-    cpu->isar.id_isar0 =3D 0x0140011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11231121;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x01141;
-    cpu->reset_auxcr =3D 7;
-}
-
-static void arm11mpcore_initfn(Object *obj)
-{
-    ARMCPU *cpu =3D ARM_CPU(obj);
-
-    cpu->dtb_compatible =3D "arm,arm11mpcore";
-    set_feature(&cpu->env, ARM_FEATURE_V6K);
-    set_feature(&cpu->env, ARM_FEATURE_VAPA);
-    set_feature(&cpu->env, ARM_FEATURE_MPIDR);
-    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
-    cpu->midr =3D 0x410fb022;
-    cpu->reset_fpsid =3D 0x410120b4;
-    cpu->isar.mvfr0 =3D 0x11111111;
-    cpu->isar.mvfr1 =3D 0x00000000;
-    cpu->ctr =3D 0x1d192992; /* 32K icache 32K dcache */
-    cpu->id_pfr0 =3D 0x111;
-    cpu->id_pfr1 =3D 0x1;
-    cpu->isar.id_dfr0 =3D 0;
-    cpu->id_afr0 =3D 0x2;
-    cpu->isar.id_mmfr0 =3D 0x01100103;
-    cpu->isar.id_mmfr1 =3D 0x10020302;
-    cpu->isar.id_mmfr2 =3D 0x01222000;
-    cpu->isar.id_isar0 =3D 0x00100011;
-    cpu->isar.id_isar1 =3D 0x12002111;
-    cpu->isar.id_isar2 =3D 0x11221011;
-    cpu->isar.id_isar3 =3D 0x01102131;
-    cpu->isar.id_isar4 =3D 0x141;
-    cpu->reset_auxcr =3D 1;
-}
-
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
@@ -2446,174 +2020,6 @@ static void cortex_a15_initfn(Object *obj)
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
@@ -2687,50 +2093,10 @@ static void arm_max_initfn(Object *obj)
=20
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-    { .name =3D "arm926",      .initfn =3D arm926_initfn },
-    { .name =3D "arm946",      .initfn =3D arm946_initfn },
-    { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
-    /*
-     * What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
-     * older core than plain "arm1136". In particular this does not
-     * have the v6K features.
-     */
-    { .name =3D "arm1136-r2",  .initfn =3D arm1136_r2_initfn },
-    { .name =3D "arm1136",     .initfn =3D arm1136_initfn },
-    { .name =3D "arm1176",     .initfn =3D arm1176_initfn },
-    { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
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
-    { .name =3D "cortex-r5",   .initfn =3D cortex_r5_initfn },
-    { .name =3D "cortex-r5f",  .initfn =3D cortex_r5f_initfn },
     { .name =3D "cortex-a7",   .initfn =3D cortex_a7_initfn },
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
     { .name =3D "cortex-a15",  .initfn =3D cortex_a15_initfn },
-    { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
-    { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
-    { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
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
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
new file mode 100644
index 0000000000..899d3ac7bc
--- /dev/null
+++ b/target/arm/cpu_tcg.c
@@ -0,0 +1,663 @@
+/*
+ * ARM generic helpers.
+ * QEMU ARM CPU
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
+static void arm1136_r2_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    /*
+     * What qemu calls "arm1136_r2" is actually the 1136 r0p2, ie an
+     * older core than plain "arm1136". In particular this does not
+     * have the v6K features.
+     * These ID register values are correct for 1136 but may be wrong
+     * for 1136_r2 (in particular r0p2 does not actually implement most
+     * of the ID registers).
+     */
+
+    cpu->dtb_compatible =3D "arm,arm1136";
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    cpu->midr =3D 0x4107b362;
+    cpu->reset_fpsid =3D 0x410120b4;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00050078;
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x1;
+    cpu->isar.id_dfr0 =3D 0x2;
+    cpu->id_afr0 =3D 0x3;
+    cpu->isar.id_mmfr0 =3D 0x01130003;
+    cpu->isar.id_mmfr1 =3D 0x10030302;
+    cpu->isar.id_mmfr2 =3D 0x01222110;
+    cpu->isar.id_isar0 =3D 0x00140011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11231111;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x141;
+    cpu->reset_auxcr =3D 7;
+}
+
+static void arm1136_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm1136";
+    set_feature(&cpu->env, ARM_FEATURE_V6K);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    cpu->midr =3D 0x4117b363;
+    cpu->reset_fpsid =3D 0x410120b4;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00050078;
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x1;
+    cpu->isar.id_dfr0 =3D 0x2;
+    cpu->id_afr0 =3D 0x3;
+    cpu->isar.id_mmfr0 =3D 0x01130003;
+    cpu->isar.id_mmfr1 =3D 0x10030302;
+    cpu->isar.id_mmfr2 =3D 0x01222110;
+    cpu->isar.id_isar0 =3D 0x00140011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11231111;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x141;
+    cpu->reset_auxcr =3D 7;
+}
+
+static void arm1176_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm1176";
+    set_feature(&cpu->env, ARM_FEATURE_V6K);
+    set_feature(&cpu->env, ARM_FEATURE_VAPA);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
+    set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    set_feature(&cpu->env, ARM_FEATURE_EL3);
+    cpu->midr =3D 0x410fb767;
+    cpu->reset_fpsid =3D 0x410120b5;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1dd20d2;
+    cpu->reset_sctlr =3D 0x00050078;
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x11;
+    cpu->isar.id_dfr0 =3D 0x33;
+    cpu->id_afr0 =3D 0;
+    cpu->isar.id_mmfr0 =3D 0x01130003;
+    cpu->isar.id_mmfr1 =3D 0x10030302;
+    cpu->isar.id_mmfr2 =3D 0x01222100;
+    cpu->isar.id_isar0 =3D 0x0140011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11231121;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x01141;
+    cpu->reset_auxcr =3D 7;
+}
+
+static void arm11mpcore_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+
+    cpu->dtb_compatible =3D "arm,arm11mpcore";
+    set_feature(&cpu->env, ARM_FEATURE_V6K);
+    set_feature(&cpu->env, ARM_FEATURE_VAPA);
+    set_feature(&cpu->env, ARM_FEATURE_MPIDR);
+    set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    cpu->midr =3D 0x410fb022;
+    cpu->reset_fpsid =3D 0x410120b4;
+    cpu->isar.mvfr0 =3D 0x11111111;
+    cpu->isar.mvfr1 =3D 0x00000000;
+    cpu->ctr =3D 0x1d192992; /* 32K icache 32K dcache */
+    cpu->id_pfr0 =3D 0x111;
+    cpu->id_pfr1 =3D 0x1;
+    cpu->isar.id_dfr0 =3D 0;
+    cpu->id_afr0 =3D 0x2;
+    cpu->isar.id_mmfr0 =3D 0x01100103;
+    cpu->isar.id_mmfr1 =3D 0x10020302;
+    cpu->isar.id_mmfr2 =3D 0x01222000;
+    cpu->isar.id_isar0 =3D 0x00100011;
+    cpu->isar.id_isar1 =3D 0x12002111;
+    cpu->isar.id_isar2 =3D 0x11221011;
+    cpu->isar.id_isar3 =3D 0x01102131;
+    cpu->isar.id_isar4 =3D 0x141;
+    cpu->reset_auxcr =3D 1;
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
+static const ARMCPUInfo arm_tcg_cpus[] =3D {
+    { .name =3D "arm926",      .initfn =3D arm926_initfn },
+    { .name =3D "arm946",      .initfn =3D arm946_initfn },
+    { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
+    /*
+     * What QEMU calls "arm1136-r2" is actually the 1136 r0p2, i.e. an
+     * older core than plain "arm1136". In particular this does not
+     * have the v6K features.
+     */
+    { .name =3D "arm1136-r2",  .initfn =3D arm1136_r2_initfn },
+    { .name =3D "arm1136",     .initfn =3D arm1136_initfn },
+    { .name =3D "arm1176",     .initfn =3D arm1176_initfn },
+    { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
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
+    { .name =3D "cortex-r5",   .initfn =3D cortex_r5_initfn },
+    { .name =3D "cortex-r5f",  .initfn =3D cortex_r5f_initfn },
+    { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
+    { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
+    { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
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
+};
+
+static void arm_tcg_cpu_register_types(void)
+{
+    size_t i;
+
+    for (i =3D 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
+        arm_cpu_register(&arm_tcg_cpus[i]);
+    }
+}
+
+type_init(arm_tcg_cpu_register_types)
+
+#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index cf26c16f5f..212b588afd 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -61,6 +61,7 @@ obj-y +=3D translate.o op_helper.o
 obj-y +=3D crypto_helper.o
 obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
 obj-y +=3D m_helper.o
+obj-y +=3D cpu_tcg.o
=20
 obj-$(CONFIG_SOFTMMU) +=3D psci.o
=20
--=20
2.21.1


