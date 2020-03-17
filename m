Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5063C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C30205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gpGHSqMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C30205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9N0-0000ak-PP
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96S-0002Ho-JL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96Q-0007xa-NS
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:40 -0400
Received: from ozlabs.org ([203.11.71.1]:57301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96Q-0007fI-9t; Tue, 17 Mar 2020 06:05:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL31M4Nz9sTc; Tue, 17 Mar 2020 21:04:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439483;
 bh=w8FnmTmTKIT07gXVMMuYlFdyZ2CmcEwbXiUvJcwhsFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gpGHSqMSfO3nHyHZ+w/vkYmDxuDhD/w7YjACT+89gXc/igVlucLLHk5wyUl4ZCGQ7
 9WHDD5f+68BsIsCqWwhofFEKC+8mhOse3FTEfiIza4XErSE7wCUgbVt2PMPTUoMkWt
 KK5FeFtO5vmlhhhqBwp/pI2sMcQq7vZmXVQGUvsg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 40/45] ppc/spapr: Fix FWNMI machine check interrupt delivery
Date: Tue, 17 Mar 2020 21:04:18 +1100
Message-Id: <20200317100423.622643-41-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

FWNMI machine check delivery misses a few things that will make it fail
with TCG at least (which we would like to allow in future to improve
testing).

It's not nice to scatter interrupt delivery logic around the tree, so
move it to excp_helper.c and share code where possible.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-5-npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c    | 24 +++----------
 target/ppc/cpu.h         |  1 +
 target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++++++------------
 3 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 27ba8a2c19..323fcef4aa 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -785,28 +785,13 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU =
*cpu, bool recovered,
 static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    uint64_t rtas_addr;
+    CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    target_ulong msr =3D 0;
+    uint64_t rtas_addr;
     struct rtas_error_log log;
     struct mc_extended_log *ext_elog;
     uint32_t summary;
=20
-    /*
-     * Properly set bits in MSR before we invoke the handler.
-     * SRR0/1, DAR and DSISR are properly set by KVM
-     */
-    if (!(*pcc->interrupts_big_endian)(cpu)) {
-        msr |=3D (1ULL << MSR_LE);
-    }
-
-    if (env->msr & (1ULL << MSR_SF)) {
-        msr |=3D (1ULL << MSR_SF);
-    }
-
-    msr |=3D (1ULL << MSR_ME);
-
     ext_elog =3D g_malloc0(sizeof(*ext_elog));
     summary =3D spapr_mce_get_elog_type(cpu, recovered, ext_elog);
=20
@@ -834,12 +819,11 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu=
, bool recovered)
     cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
                               sizeof(env->gpr[3]) + sizeof(log), ext_elo=
g,
                               sizeof(*ext_elog));
+    g_free(ext_elog);
=20
     env->gpr[3] =3D rtas_addr + RTAS_ERROR_LOG_OFFSET;
-    env->msr =3D msr;
-    env->nip =3D spapr->fwnmi_machine_check_addr;
=20
-    g_free(ext_elog);
+    ppc_cpu_do_fwnmi_machine_check(cs, spapr->fwnmi_machine_check_addr);
 }
=20
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5a55fb02bd..3953680534 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1221,6 +1221,7 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunctio=
n f, CPUState *cs,
                                int cpuid, void *opaque);
 #ifndef CONFIG_USER_ONLY
 void ppc_cpu_do_system_reset(CPUState *cs);
+void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
=20
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 027f54c0ed..7f2b5899d3 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -128,6 +128,37 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs,=
 int ail)
     return offset;
 }
=20
+static inline void powerpc_set_excp_state(PowerPCCPU *cpu,
+                                          target_ulong vector, target_ul=
ong msr)
+{
+    CPUState *cs =3D CPU(cpu);
+    CPUPPCState *env =3D &cpu->env;
+
+    /*
+     * We don't use hreg_store_msr here as already have treated any
+     * special case that could occur. Just store MSR and update hflags
+     *
+     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
+     * will prevent setting of the HV bit which some exceptions might ne=
ed
+     * to do.
+     */
+    env->msr =3D msr & env->msr_mask;
+    hreg_compute_hflags(env);
+    env->nip =3D vector;
+    /* Reset exception state */
+    cs->exception_index =3D POWERPC_EXCP_NONE;
+    env->error_code =3D 0;
+
+    /* Reset the reservation */
+    env->reserve_addr =3D -1;
+
+    /*
+     * Any interrupt is context synchronizing, check if TCG TLB needs
+     * a delayed flush on ppc64
+     */
+    check_tlb_flush(env, false);
+}
+
 /*
  * Note that this function should be greatly optimized when called
  * with a constant excp, from ppc_hw_interrupt
@@ -768,29 +799,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
         }
     }
 #endif
-    /*
-     * We don't use hreg_store_msr here as already have treated any
-     * special case that could occur. Just store MSR and update hflags
-     *
-     * Note: We *MUST* not use hreg_store_msr() as-is anyway because it
-     * will prevent setting of the HV bit which some exceptions might ne=
ed
-     * to do.
-     */
-    env->msr =3D new_msr & env->msr_mask;
-    hreg_compute_hflags(env);
-    env->nip =3D vector;
-    /* Reset exception state */
-    cs->exception_index =3D POWERPC_EXCP_NONE;
-    env->error_code =3D 0;
=20
-    /* Reset the reservation */
-    env->reserve_addr =3D -1;
-
-    /*
-     * Any interrupt is context synchronizing, check if TCG TLB needs
-     * a delayed flush on ppc64
-     */
-    check_tlb_flush(env, false);
+    powerpc_set_excp_state(cpu, vector, new_msr);
 }
=20
 void ppc_cpu_do_interrupt(CPUState *cs)
@@ -958,6 +968,26 @@ void ppc_cpu_do_system_reset(CPUState *cs)
=20
     powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_RESET);
 }
+
+void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    CPUPPCState *env =3D &cpu->env;
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
+    target_ulong msr =3D 0;
+
+    /*
+     * Set MSR and NIP for the handler, SRR0/1, DAR and DSISR have alrea=
dy
+     * been set by KVM.
+     */
+    msr =3D (1ULL << MSR_ME);
+    msr |=3D env->msr & (1ULL << MSR_SF);
+    if (!(*pcc->interrupts_big_endian)(cpu)) {
+        msr |=3D (1ULL << MSR_LE);
+    }
+
+    powerpc_set_excp_state(cpu, vector, msr);
+}
 #endif /* !CONFIG_USER_ONLY */
=20
 bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
--=20
2.24.1


