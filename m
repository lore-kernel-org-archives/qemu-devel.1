Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECAEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCFC22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f/6bKuM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCFC22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LYS-0005Aa-2y
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1F-0005dv-B9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1D-0000HM-MS
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:57 -0400
Received: from ozlabs.org ([203.11.71.1]:44999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1D-0008V3-37; Wed, 21 Aug 2019 03:26:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjG6kBqz9sR5; Wed, 21 Aug 2019 17:25:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372354;
 bh=JvTyhoY02W3DptPDPZ0esZT0tYoex1tMvFPextlvu7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f/6bKuM/0nBMUNwrqcu+vZOGc655MQKccZr0pQehB1D3yTY/rO+vzm6sZnH4M/eg3
 Wlt/rDTNjCHqlcJvPFNqXFK0kT8X//J7O6EuR3LkJ6/3UxLm05pLyDJqxQsfCY2FkC
 0MHy3fF0+5IjuAzPiLAwoytLQA+ihxRecJmWwGGo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:32 +1000
Message-Id: <20190821072542.23090-33-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 32/42] ppc: remove idle_timer logic
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
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The logic is broken for multiple vcpu guests, also causing memory leak.
The logic is in place to handle kvm not having KVM_CAP_PPC_IRQ_LEVEL,
which is part of the kernel now since 2.6.37. Instead of fixing the
leak, drop the redundant logic which is not excercised on new kernels
anymore. Exit with error on older kernels.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-Id: <156406409479.19996.7606556689856621111.stgit@lep8c.aus.stgla=
bs.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 75 ++++--------------------------------------------
 1 file changed, 5 insertions(+), 70 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6162a903fa..8c5b1f25cc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -58,7 +58,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[=
] =3D {
 };
=20
 static int cap_interrupt_unset;
-static int cap_interrupt_level;
 static int cap_segstate;
 static int cap_booke_sregs;
 static int cap_ppc_smt;
@@ -89,25 +88,6 @@ static int cap_large_decr;
=20
 static uint32_t debug_inst_opcode;
=20
-/*
- * XXX We have a race condition where we actually have a level triggered
- *     interrupt, but the infrastructure can't expose that yet, so the g=
uest
- *     takes but ignores it, goes to sleep and never gets notified that =
there's
- *     still an interrupt pending.
- *
- *     As a quick workaround, let's just wake up again 20 ms after we in=
jected
- *     an interrupt. That way we can assure that we're always reinjectin=
g
- *     interrupts in case the guest swallowed them.
- */
-static QEMUTimer *idle_timer;
-
-static void kvm_kick_cpu(void *opaque)
-{
-    PowerPCCPU *cpu =3D opaque;
-
-    qemu_cpu_kick(CPU(cpu));
-}
-
 /*
  * Check whether we are running with KVM-PR (instead of KVM-HV).  This
  * should only be used for fallback tests - generally we should use
@@ -127,7 +107,6 @@ static int kvmppc_get_dec_bits(void);
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_interrupt_unset =3D kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ=
);
-    cap_interrupt_level =3D kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL=
);
     cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
     cap_booke_sregs =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
     cap_ppc_smt_possible =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_P=
OSSIBLE);
@@ -163,9 +142,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      */
     cap_ppc_pvr_compat =3D false;
=20
-    if (!cap_interrupt_level) {
-        fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
-                        "VM to stall at times!\n");
+    if (!kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL)) {
+        error_report("KVM: Host kernel doesn't have level irq capability=
");
+        exit(1);
     }
=20
     kvm_ppc_register_host_cpu_type(ms);
@@ -493,8 +472,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
=20
-    idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
-
     switch (cenv->mmu_model) {
     case POWERPC_MMU_BOOKE206:
         /* This target supports access to KVM's guest TLB */
@@ -1334,7 +1311,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, =
int level)
         return 0;
     }
=20
-    if (!kvm_enabled() || !cap_interrupt_unset || !cap_interrupt_level) =
{
+    if (!kvm_enabled() || !cap_interrupt_unset) {
         return 0;
     }
=20
@@ -1351,49 +1328,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq,=
 int level)
=20
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
-    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    CPUPPCState *env =3D &cpu->env;
-    int r;
-    unsigned irq;
-
-    qemu_mutex_lock_iothread();
-
-    /*
-     * PowerPC QEMU tracks the various core input pins (interrupt,
-     * critical interrupt, reset, etc) in PPC-specific
-     * env->irq_input_state.
-     */
-    if (!cap_interrupt_level &&
-        run->ready_for_interrupt_injection &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-        (env->irq_input_state & (1 << PPC_INPUT_INT)))
-    {
-        /*
-         * For now KVM disregards the 'irq' argument. However, in the
-         * future KVM could cache it in-kernel to avoid a heavyweight
-         * exit when reading the UIC.
-         */
-        irq =3D KVM_INTERRUPT_SET;
-
-        trace_kvm_injected_interrupt(irq);
-        r =3D kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
-        if (r < 0) {
-            printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
-        }
-
-        /* Always wake up soon in case the interrupt was level based */
-        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                       (NANOSECONDS_PER_SECOND / 50));
-    }
-
-    /*
-     * We don't know if there are more interrupts pending after
-     * this. However, the guest will return to userspace in the course
-     * of handling this one anyways, so we will get a chance to
-     * deliver the rest.
-     */
-
-    qemu_mutex_unlock_iothread();
+    return;
 }
=20
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
--=20
2.21.0


