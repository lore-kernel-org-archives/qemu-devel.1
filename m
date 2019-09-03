Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206DDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ACE22CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ACE22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i57Jl-00072s-FC
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i57Hn-00053S-N2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i57Hm-0005x0-ID
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i57Hj-0005uh-UT; Tue, 03 Sep 2019 07:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F17830603AA;
 Tue,  3 Sep 2019 11:47:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-102.brq.redhat.com [10.40.204.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 038345DAAC;
 Tue,  3 Sep 2019 11:47:40 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 13:47:26 +0200
Message-Id: <20190903114729.3400-3-philmd@redhat.com>
In-Reply-To: <20190903114729.3400-1-philmd@redhat.com>
References: <20190903114729.3400-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 03 Sep 2019 11:47:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/5] target/arm: Restrict pre-ARMv7 cpus to
 TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM requires a cpu based on (at least) the ARMv7 architecture.

The following CPUs are disabled:

* ARMv4

  - StrongARM (SA1100/1110)
  - OMAP1510 (TI925T)

* ARMv5

  - ARM926
  - ARM946
  - ARM1026
  - XScale (PXA250/255/260/261/262/270)

* ARMv6

  - ARM1136
  - ARM1176
  - ARM11MPCore
  - Cortex-M0

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: fixed misplaced #endif (rth), list cpus
---
 target/arm/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..f69780147c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1678,6 +1678,8 @@ static ObjectClass *arm_cpu_class_by_name(const cha=
r *cpu_model)
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
=20
+#ifdef CONFIG_TCG
+
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -1900,6 +1902,8 @@ static void cortex_m0_initfn(Object *obj)
     cpu->midr =3D 0x410cc200;
 }
=20
+#endif
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -2283,6 +2287,8 @@ static void cortex_a15_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
 }
=20
+#ifdef CONFIG_TCG
+
 static void ti925t_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -2451,6 +2457,8 @@ static void pxa270c5_initfn(Object *obj)
     cpu->reset_sctlr =3D 0x00000078;
 }
=20
+#endif
+
 #ifndef TARGET_AARCH64
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this =
host);
  * otherwise, a CPU with as many features enabled as our emulation suppo=
rts.
@@ -2523,6 +2531,7 @@ struct ARMCPUInfo {
=20
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+#ifdef CONFIG_TCG
     { .name =3D "arm926",      .initfn =3D arm926_initfn },
     { .name =3D "arm946",      .initfn =3D arm946_initfn },
     { .name =3D "arm1026",     .initfn =3D arm1026_initfn },
@@ -2536,6 +2545,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
     { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
                              .class_init =3D arm_v7m_class_init },
+#endif
     { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
                              .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
@@ -2548,6 +2558,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "cortex-a8",   .initfn =3D cortex_a8_initfn },
     { .name =3D "cortex-a9",   .initfn =3D cortex_a9_initfn },
     { .name =3D "cortex-a15",  .initfn =3D cortex_a15_initfn },
+#ifdef CONFIG_TCG
     { .name =3D "ti925t",      .initfn =3D ti925t_initfn },
     { .name =3D "sa1100",      .initfn =3D sa1100_initfn },
     { .name =3D "sa1110",      .initfn =3D sa1110_initfn },
@@ -2564,6 +2575,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "pxa270-b1",   .initfn =3D pxa270b1_initfn },
     { .name =3D "pxa270-c0",   .initfn =3D pxa270c0_initfn },
     { .name =3D "pxa270-c5",   .initfn =3D pxa270c5_initfn },
+#endif
 #ifndef TARGET_AARCH64
     { .name =3D "max",         .initfn =3D arm_max_initfn },
 #endif
--=20
2.20.1


