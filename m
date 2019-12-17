Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12560C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AEE2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bvEC2WDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AEE2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5FW-00061n-Iv
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ji-00027a-At
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4jg-0007VS-BS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:45:30 -0500
Received: from ozlabs.org ([203.11.71.1]:37031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4jf-00071A-Dz; Mon, 16 Dec 2019 23:45:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWd2MzYz9sTK; Tue, 17 Dec 2019 15:43:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557821;
 bh=gzHHLUuZkYUSgdIhhuqRz76mOFpXx2kVpf/11Jd9AYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bvEC2WDACRV8Z9GYkbkys5YHwqpQRmJqXNyQKFKhnAH2Fg/gOsheHBDJMZWj6nKes
 MJhuOze8cQrkHcqdZTOLG+IvZhkbRYcj+a6bhXACI9RZVChHlQSEvJq3qNCiMOHjoJ
 u84DJ/atd0d+z4S7m42L1EZozuIic+VAjJxIcXLQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 56/88] ppc: Deassert the external interrupt pin in KVM on reset
Date: Tue, 17 Dec 2019 15:42:50 +1100
Message-Id: <20191217044322.351838-57-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

When a CPU is reset, QEMU makes sure no interrupt is pending by clearing
CPUPPCstate::pending_interrupts in ppc_cpu_reset(). In the case of a
complete machine emulation, eg. a sPAPR machine, an external interrupt
request could still be pending in KVM though, eg. an IPI. It will be
eventually presented to the guest, which is supposed to acknowledge it at
the interrupt controller. If the interrupt controller is emulated in QEMU=
,
either XICS or XIVE, ppc_set_irq() won't deassert the external interrupt
pin in KVM since it isn't pending anymore for QEMU. When the vCPU re-ente=
rs
the guest, the interrupt request is still pending and the vCPU will try
again to acknowledge it. This causes an infinite loop and eventually hang=
s
the guest.

The code has been broken since the beginning. The issue wasn't hit before
because accel=3Dkvm,kernel-irqchip=3Doff is an awkward setup that never g=
ot
used until recently with the LC92x IBM systems (aka, Boston).

Add a ppc_irq_reset() function to do the necessary cleanup, ie. deassert
the IRQ pins of the CPU in QEMU and most importantly the external interru=
pt
pin for this vCPU in KVM.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157548861740.3650476.16879693165328764758.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c                    | 8 ++++++++
 include/hw/ppc/ppc.h            | 2 ++
 target/ppc/translate_init.inc.c | 1 +
 3 files changed, 11 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8dd982fc1e..fab73f1b1f 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1515,3 +1515,11 @@ PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
=20
     return NULL;
 }
+
+void ppc_irq_reset(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+
+    env->irq_input_state =3D 0;
+    kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
+}
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 585be6ab98..89e1dd065a 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -77,6 +77,7 @@ static inline void ppc970_irq_init(PowerPCCPU *cpu) {}
 static inline void ppcPOWER7_irq_init(PowerPCCPU *cpu) {}
 static inline void ppcPOWER9_irq_init(PowerPCCPU *cpu) {}
 static inline void ppce500_irq_init(PowerPCCPU *cpu) {}
+static inline void ppc_irq_reset(PowerPCCPU *cpu) {}
 #else
 void ppc40x_irq_init(PowerPCCPU *cpu);
 void ppce500_irq_init(PowerPCCPU *cpu);
@@ -84,6 +85,7 @@ void ppc6xx_irq_init(PowerPCCPU *cpu);
 void ppc970_irq_init(PowerPCCPU *cpu);
 void ppcPOWER7_irq_init(PowerPCCPU *cpu);
 void ppcPOWER9_irq_init(PowerPCCPU *cpu);
+void ppc_irq_reset(PowerPCCPU *cpu);
 #endif
=20
 /* PPC machines for OpenBIOS */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index ba726dec4d..64a838095c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10461,6 +10461,7 @@ static void ppc_cpu_reset(CPUState *s)
     env->pending_interrupts =3D 0;
     s->exception_index =3D POWERPC_EXCP_NONE;
     env->error_code =3D 0;
+    ppc_irq_reset(cpu);
=20
     /* tininess for underflow is detected before rounding */
     set_float_detect_tininess(float_tininess_before_rounding,
--=20
2.23.0


