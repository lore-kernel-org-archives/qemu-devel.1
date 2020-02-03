Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026ECC3524C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869EE20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="feU2B+ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869EE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV9b-0001YS-CS
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxq-0003eG-Ch
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxo-0003Sn-EV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:06 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34137 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxo-0002j5-3Q; Mon, 03 Feb 2020 01:12:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBs1hZtz9sT4; Mon,  3 Feb 2020 17:11:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710293;
 bh=h02ZFxBZNpn77OCNsfO9YeyOtGiKTlPS1kn6dDZJ3Q0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=feU2B+ju+ebefta9sjL80/TMq3SsIVLvJg0dx2OdhM7qQpIVkKffb0Q+0ZUSqaRVn
 qN0vMAqquOZS5ADb6ajjHZAW9ZYrUiUtNcZzonBcS2ssc3FWiLqRNdNW7VXoQRVj1C
 Po8V2wV6cwN2nCterDlzoJijPhy/eUUbj8p+RV3c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 26/35] target/ppc: Handle NMI guest exit
Date: Mon,  3 Feb 2020 17:11:14 +1100
Message-Id: <20200203061123.59150-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Aravinda Prasad <arawinda.p@gmail.com>,
 qemu-devel@nongnu.org, groug@kaod.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aravinda Prasad <arawinda.p@gmail.com>

Memory error such as bit flips that cannot be corrected
by hardware are passed on to the kernel for handling.
If the memory address in error belongs to guest then
the guest kernel is responsible for taking suitable action.
Patch [1] enhances KVM to exit guest with exit reason
set to KVM_EXIT_NMI in such cases. This patch handles
KVM_EXIT_NMI exit.

[1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
    (e20bbd3d and related commits)

Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200130184423.20519-4-ganeshgr@linux.ibm.com>
[dwg: #ifdefs to fix compile for 32-bit target]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c          |  8 ++++++++
 hw/ppc/spapr_events.c   | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h  | 10 ++++++++++
 target/ppc/kvm.c        | 18 ++++++++++++++++++
 target/ppc/kvm_ppc.h    |  2 ++
 target/ppc/trace-events |  1 +
 6 files changed, 76 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index aa739e943f..06e295cdf1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1677,6 +1677,12 @@ static void spapr_machine_reset(MachineState *mach=
ine)
     first_ppc_cpu->env.gpr[5] =3D 0;
=20
     spapr->cas_reboot =3D false;
+
+    spapr->mc_status =3D -1;
+    spapr->guest_machine_check_addr =3D -1;
+
+    /* Signal all vCPUs waiting on this condition */
+    qemu_cond_broadcast(&spapr->mc_delivery_cond);
 }
=20
 static void spapr_create_nvram(SpaprMachineState *spapr)
@@ -2971,6 +2977,8 @@ static void spapr_machine_init(MachineState *machin=
e)
=20
         kvmppc_spapr_enable_inkernel_multitce();
     }
+
+    qemu_cond_init(&spapr->mc_delivery_cond);
 }
=20
 static int spapr_kvm_type(MachineState *machine, const char *vm_type)
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index e355e000d0..dfc0de840a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -40,6 +40,7 @@
 #include "hw/ppc/spapr_drc.h"
 #include "qemu/help_option.h"
 #include "qemu/bcd.h"
+#include "qemu/main-loop.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
=20
@@ -622,6 +623,42 @@ void spapr_hotplug_req_remove_by_count_indexed(Spapr=
DrcType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
 }
=20
+void spapr_mce_req_event(PowerPCCPU *cpu)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    CPUState *cs =3D CPU(cpu);
+
+    if (spapr->guest_machine_check_addr =3D=3D -1) {
+        /*
+         * This implies that we have hit a machine check either when the
+         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
+         * called) or between system reset and "ibm,nmi-register".
+         * Fall back to the old machine check behavior in such cases.
+         */
+        cs->exception_index =3D POWERPC_EXCP_MCHECK;
+        ppc_cpu_do_interrupt(cs);
+        return;
+    }
+
+    while (spapr->mc_status !=3D -1) {
+        /*
+         * Check whether the same CPU got machine check error
+         * while still handling the mc error (i.e., before
+         * that CPU called "ibm,nmi-interlock")
+         */
+        if (spapr->mc_status =3D=3D cpu->vcpu_id) {
+            qemu_system_guest_panicked(NULL);
+            return;
+        }
+        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
+        /* Meanwhile if the system is reset, then just return */
+        if (spapr->guest_machine_check_addr =3D=3D -1) {
+            return;
+        }
+    }
+    spapr->mc_status =3D cpu->vcpu_id;
+}
+
 static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             uint32_t token, uint32_t nargs,
                             target_ulong args,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7bc5fc3a9e..909d3976f9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -191,6 +191,15 @@ struct SpaprMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
=20
+    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls=
 */
+    target_ulong guest_machine_check_addr;
+    /*
+     * mc_status is set to -1 if mc is not in progress, else is set to t=
he CPU
+     * handling the mc.
+     */
+    int mc_status;
+    QemuCond mc_delivery_cond;
+
     /*< public >*/
     char *kvm_type;
     char *host_model;
@@ -804,6 +813,7 @@ void spapr_clear_pending_events(SpaprMachineState *sp=
apr);
 int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
+void spapr_mce_req_event(PowerPCCPU *cpu);
=20
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4438d0c743..56a6865521 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1705,6 +1705,13 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_=
run *run)
         ret =3D 0;
         break;
=20
+#if defined(TARGET_PPC64)
+    case KVM_EXIT_NMI:
+        trace_kvm_handle_nmi_exception();
+        ret =3D kvm_handle_nmi(cpu, run);
+        break;
+#endif
+
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reaso=
n);
         ret =3D -1;
@@ -2800,6 +2807,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return data & 0xffff;
 }
=20
+#if defined(TARGET_PPC64)
+int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
+{
+    cpu_synchronize_state(CPU(cpu));
+
+    spapr_mce_req_event(cpu);
+
+    return 0;
+}
+#endif
+
 int kvmppc_enable_hwrng(void)
 {
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HW=
RNG)) {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 2c60dedd0d..9e4f2357cc 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -84,6 +84,8 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
 void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
 void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
=20
+int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
+
 #else
=20
 static inline uint32_t kvmppc_get_tbfreq(void)
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 3dc6740706..6d15aa90b4 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -28,3 +28,4 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
 kvm_handle_epr(void) "handle epr"
 kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
 kvm_handle_debug_exception(void) "handle debug exception"
+kvm_handle_nmi_exception(void) "handle NMI exception"
--=20
2.24.1


