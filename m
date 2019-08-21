Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B4C41514
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63872233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iLNllmOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63872233A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LEM-00040X-Pw
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0Q-0004XV-FP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0O-000844-8b
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:06 -0400
Received: from ozlabs.org ([203.11.71.1]:33927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0N-00080y-M8; Wed, 21 Aug 2019 03:26:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjC1N27z9sPV; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372351;
 bh=WXwNYOWKcVD8fT6frteigyYRh/UVz+d5FBWDZT7i9rQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iLNllmOh2zTxqOSj/iwteCxEA7jtU/kdcutl/0Oza9GpLq/FhcfiBcoBmUxPqtmJI
 9WL7dRHeG+SZcQ6dv0aCgWpEv7FUCWNJzoDb9BDiIJdyy41r/CtO08zdFjaL8N0RYV
 hbLcqQ5NZBRZRDWfoIdPh11ThkOLeswbTYteGnM8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:15 +1000
Message-Id: <20190821072542.23090-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 15/42] spapr: Implement dispatch tracking for tcg
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

Implement cpu_exec_enter/exit on ppc which calls into new methods of
the same name in PPCVirtualHypervisorClass. These are used by spapr
to implement the splpar VPA dispatch counter initially.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20190718034214.14948-2-npiggin@gmail.com>
[dwg: Removed unnecessary CONFIG_USER_ONLY checks as suggested by gkurz]
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  | 48 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c            |  5 ----
 include/hw/ppc/spapr.h          |  7 +++++
 target/ppc/cpu.h                |  4 +++
 target/ppc/translate_init.inc.c | 27 +++++++++++++++++++
 5 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 22a45c3737..08cc7c2bd6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4306,6 +4306,52 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
     return NULL;
 }
=20
+static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU =
*cpu)
+{
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    /* These are only called by TCG, KVM maintains dispatch state */
+
+    if (spapr_cpu->vpa_addr) {
+        CPUState *cs =3D CPU(cpu);
+        uint32_t dispatch;
+
+        dispatch =3D ldl_be_phys(cs->as,
+                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTE=
R);
+        dispatch++;
+        if ((dispatch & 1) !=3D 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "VPA: incorrect dispatch counter value for "
+                          "dispatched partition %u, correcting.\n", disp=
atch);
+            dispatch++;
+        }
+        stl_be_phys(cs->as,
+                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch=
);
+    }
+}
+
+static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *=
cpu)
+{
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
+
+    if (spapr_cpu->vpa_addr) {
+        CPUState *cs =3D CPU(cpu);
+        uint32_t dispatch;
+
+        dispatch =3D ldl_be_phys(cs->as,
+                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTE=
R);
+        dispatch++;
+        if ((dispatch & 1) !=3D 1) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "VPA: incorrect dispatch counter value for "
+                          "preempted partition %u, correcting.\n", dispa=
tch);
+            dispatch++;
+        }
+        stl_be_phys(cs->as,
+                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch=
);
+    }
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -4362,6 +4408,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->hpte_set_r =3D spapr_hpte_set_r;
     vhc->get_pate =3D spapr_get_pate;
     vhc->encode_hpt_for_kvm_pr =3D spapr_encode_hpt_for_kvm_pr;
+    vhc->cpu_exec_enter =3D spapr_cpu_exec_enter;
+    vhc->cpu_exec_exit =3D spapr_cpu_exec_exit;
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 47b566882b..4c5ea17250 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -875,11 +875,6 @@ unmap_out:
 #define FLAGS_DEREGISTER_DTL       0x0000c00000000000ULL
 #define FLAGS_DEREGISTER_SLBSHADOW 0x0000e00000000000ULL
=20
-#define VPA_MIN_SIZE           640
-#define VPA_SIZE_OFFSET        0x4
-#define VPA_SHARED_PROC_OFFSET 0x9
-#define VPA_SHARED_PROC_VAL    0x2
-
 static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
     CPUState *cs =3D CPU(cpu);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60553d32c4..5d36eec9d0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -525,6 +525,13 @@ void spapr_register_hypercall(target_ulong opcode, s=
papr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
=20
+/* Virtual Processor Area structure constants */
+#define VPA_MIN_SIZE           640
+#define VPA_SIZE_OFFSET        0x4
+#define VPA_SHARED_PROC_OFFSET 0x9
+#define VPA_SHARED_PROC_VAL    0x2
+#define VPA_DISPATCH_COUNTER   0x100
+
 /* ibm,set-eeh-option */
 #define RTAS_EEH_DISABLE                 0
 #define RTAS_EEH_ENABLE                  1
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 630a25c246..50245a8c4d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1224,6 +1224,10 @@ struct PPCVirtualHypervisorClass {
     void (*hpte_set_r)(PPCVirtualHypervisor *vhyp, hwaddr ptex, uint64_t=
 pte1);
     void (*get_pate)(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *entry);
     target_ulong (*encode_hpt_for_kvm_pr)(PPCVirtualHypervisor *vhyp);
+#ifndef CONFIG_USER_ONLY
+    void (*cpu_exec_enter)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+    void (*cpu_exec_exit)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+#endif
 };
=20
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 9cd2033bb9..c9fcd87095 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10469,6 +10469,28 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
=20
     return !msr_le;
 }
+
+static void ppc_cpu_exec_enter(CPUState *cs)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =3D
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->cpu_exec_enter(cpu->vhyp, cpu);
+    }
+}
+
+static void ppc_cpu_exec_exit(CPUState *cs)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+    if (cpu->vhyp) {
+        PPCVirtualHypervisorClass *vhc =3D
+            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+        vhc->cpu_exec_exit(cpu->vhyp, cpu);
+    }
+}
 #endif
=20
 static void ppc_cpu_instance_init(Object *obj)
@@ -10622,6 +10644,11 @@ static void ppc_cpu_class_init(ObjectClass *oc, =
void *data)
     cc->tcg_initialize =3D ppc_translate_init;
     cc->tlb_fill =3D ppc_cpu_tlb_fill;
 #endif
+#ifndef CONFIG_USER_ONLY
+    cc->cpu_exec_enter =3D ppc_cpu_exec_enter;
+    cc->cpu_exec_exit =3D ppc_cpu_exec_exit;
+#endif
+
     cc->disas_set_info =3D ppc_disas_set_info;
=20
     dc->fw_name =3D "PowerPC,UNKNOWN";
--=20
2.21.0


