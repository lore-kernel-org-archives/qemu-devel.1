Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E449C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45265205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G6Azbc/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45265205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Oy-0004hb-7B
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96Z-0002UD-1w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE96V-00008a-Qx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:46 -0400
Received: from ozlabs.org ([203.11.71.1]:59027)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE96U-0005xN-VQ; Tue, 17 Mar 2020 06:05:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTL16ytnz9sTX; Tue, 17 Mar 2020 21:04:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439481;
 bh=CFx9U3Nn3GNQcuH3RQT4UN9qMLOEmEHZjLqKFif0dpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G6Azbc/xBnjkG0yrX/SU16HnDbIGyELVqXL47Hi5k7MDnyPWjH+AVNGwV1vTD7I+o
 krTd6hS1um2MzOlrOLM7Ei8e21mwfgUjUs+mhfQ5Wknjcab0T7GvQTHiA6/h9CMaPw
 Q3HUrfjZJKAMtdZlRuESURX680O32QG50ruAXEsE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 38/45] ppc/spapr: Change FWNMI names
Date: Tue, 17 Mar 2020 21:04:16 +1100
Message-Id: <20200317100423.622643-39-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The option is called "FWNMI", and it involves more than just machine
checks, also machine checks can be delivered without the FWNMI option,
so re-name various things to reflect that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200316142613.121089-3-npiggin@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                    | 28 ++++++++++++++--------------
 hw/ppc/spapr_caps.c               | 14 +++++++-------
 hw/ppc/spapr_events.c             | 14 +++++++-------
 hw/ppc/spapr_rtas.c               | 17 +++++++++--------
 include/hw/ppc/spapr.h            | 27 +++++++++++++++++----------
 tests/qtest/libqos/libqos-spapr.h |  2 +-
 6 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 878ed3f719..822dea8118 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1688,11 +1688,11 @@ static void spapr_machine_reset(MachineState *mac=
hine)
=20
     spapr->cas_reboot =3D false;
=20
-    spapr->mc_status =3D -1;
-    spapr->guest_machine_check_addr =3D -1;
+    spapr->fwnmi_machine_check_addr =3D -1;
+    spapr->fwnmi_machine_check_interlock =3D -1;
=20
     /* Signal all vCPUs waiting on this condition */
-    qemu_cond_broadcast(&spapr->mc_delivery_cond);
+    qemu_cond_broadcast(&spapr->fwnmi_machine_check_interlock_cond);
=20
     migrate_del_blocker(spapr->fwnmi_migration_blocker);
 }
@@ -1981,7 +1981,7 @@ static bool spapr_fwnmi_needed(void *opaque)
 {
     SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
=20
-    return spapr->guest_machine_check_addr !=3D -1;
+    return spapr->fwnmi_machine_check_addr !=3D -1;
 }
=20
 static int spapr_fwnmi_pre_save(void *opaque)
@@ -1992,7 +1992,7 @@ static int spapr_fwnmi_pre_save(void *opaque)
      * Check if machine check handling is in progress and print a
      * warning message.
      */
-    if (spapr->mc_status !=3D -1) {
+    if (spapr->fwnmi_machine_check_interlock !=3D -1) {
         warn_report("A machine check is being handled during migration. =
The"
                 "handler may run and log hardware error on the destinati=
on");
     }
@@ -2000,15 +2000,15 @@ static int spapr_fwnmi_pre_save(void *opaque)
     return 0;
 }
=20
-static const VMStateDescription vmstate_spapr_machine_check =3D {
-    .name =3D "spapr_machine_check",
+static const VMStateDescription vmstate_spapr_fwnmi =3D {
+    .name =3D "spapr_fwnmi",
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .needed =3D spapr_fwnmi_needed,
     .pre_save =3D spapr_fwnmi_pre_save,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
-        VMSTATE_INT32(mc_status, SpaprMachineState),
+        VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
+        VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -2047,7 +2047,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
         &vmstate_spapr_cap_fwnmi,
-        &vmstate_spapr_machine_check,
+        &vmstate_spapr_fwnmi,
         NULL
     }
 };
@@ -2869,7 +2869,7 @@ static void spapr_machine_init(MachineState *machin=
e)
         spapr_create_lmb_dr_connectors(spapr);
     }
=20
-    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_ON) {
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) =3D=3D SPAPR_CAP_ON) {
         /* Create the error string for live migration blocker */
         error_setg(&spapr->fwnmi_migration_blocker,
             "A machine check is being handled during migration. The hand=
ler"
@@ -3038,7 +3038,7 @@ static void spapr_machine_init(MachineState *machin=
e)
         kvmppc_spapr_enable_inkernel_multitce();
     }
=20
-    qemu_cond_init(&spapr->mc_delivery_cond);
+    qemu_cond_init(&spapr->fwnmi_machine_check_interlock_cond);
 }
=20
 static int spapr_kvm_type(MachineState *machine, const char *vm_type)
@@ -4519,7 +4519,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_dual;
     smc->dr_phb_enabled =3D true;
@@ -4597,7 +4597,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
     spapr_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_OFF;
     smc->rma_limit =3D 16 * GiB;
     mc->nvdimm_supported =3D false;
 }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 8b27d3ac09..f626d769a0 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -509,7 +509,7 @@ static void cap_ccf_assist_apply(SpaprMachineState *s=
papr, uint8_t val,
     }
 }
=20
-static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
+static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
                                 Error **errp)
 {
     if (!val) {
@@ -626,14 +626,14 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
         .type =3D "bool",
         .apply =3D cap_ccf_assist_apply,
     },
-    [SPAPR_CAP_FWNMI_MCE] =3D {
-        .name =3D "fwnmi-mce",
-        .description =3D "Handle fwnmi machine check exceptions",
-        .index =3D SPAPR_CAP_FWNMI_MCE,
+    [SPAPR_CAP_FWNMI] =3D {
+        .name =3D "fwnmi",
+        .description =3D "Implements PAPR FWNMI option",
+        .index =3D SPAPR_CAP_FWNMI,
         .get =3D spapr_cap_get_bool,
         .set =3D spapr_cap_set_bool,
         .type =3D "bool",
-        .apply =3D cap_fwnmi_mce_apply,
+        .apply =3D cap_fwnmi_apply,
     },
 };
=20
@@ -774,7 +774,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MA=
XPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
-SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
+SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
=20
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 11303258d4..27ba8a2c19 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -837,7 +837,7 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, =
bool recovered)
=20
     env->gpr[3] =3D rtas_addr + RTAS_ERROR_LOG_OFFSET;
     env->msr =3D msr;
-    env->nip =3D spapr->guest_machine_check_addr;
+    env->nip =3D spapr->fwnmi_machine_check_addr;
=20
     g_free(ext_elog);
 }
@@ -849,7 +849,7 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
     int ret;
     Error *local_err =3D NULL;
=20
-    if (spapr->guest_machine_check_addr =3D=3D -1) {
+    if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
         /*
          * This implies that we have hit a machine check either when the
          * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
@@ -861,19 +861,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool reco=
vered)
         return;
     }
=20
-    while (spapr->mc_status !=3D -1) {
+    while (spapr->fwnmi_machine_check_interlock !=3D -1) {
         /*
          * Check whether the same CPU got machine check error
          * while still handling the mc error (i.e., before
          * that CPU called "ibm,nmi-interlock")
          */
-        if (spapr->mc_status =3D=3D cpu->vcpu_id) {
+        if (spapr->fwnmi_machine_check_interlock =3D=3D cpu->vcpu_id) {
             qemu_system_guest_panicked(NULL);
             return;
         }
-        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
+        qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_co=
nd);
         /* Meanwhile if the system is reset, then just return */
-        if (spapr->guest_machine_check_addr =3D=3D -1) {
+        if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
             return;
         }
     }
@@ -889,7 +889,7 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recove=
red)
         warn_report("Received a fwnmi while migration was in progress");
     }
=20
-    spapr->mc_status =3D cpu->vcpu_id;
+    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
     spapr_mce_dispatch_elog(cpu, recovered);
 }
=20
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index fe83b50c66..0b8c481593 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -415,7 +415,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
 {
     hwaddr rtas_addr;
=20
-    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) =
{
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) =3D=3D SPAPR_CAP_OFF) {
         rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
         return;
     }
@@ -426,7 +426,8 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
         return;
     }
=20
-    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
+    spapr->fwnmi_machine_check_addr =3D rtas_ld(args, 1);
+
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
@@ -436,18 +437,18 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
                                    target_ulong args,
                                    uint32_t nret, target_ulong rets)
 {
-    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) =
{
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) =3D=3D SPAPR_CAP_OFF) {
         rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
         return;
     }
=20
-    if (spapr->guest_machine_check_addr =3D=3D -1) {
+    if (spapr->fwnmi_machine_check_addr =3D=3D -1) {
         /* NMI register not called */
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
     }
=20
-    if (spapr->mc_status !=3D cpu->vcpu_id) {
+    if (spapr->fwnmi_machine_check_interlock !=3D cpu->vcpu_id) {
         /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" *=
/
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -455,10 +456,10 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
=20
     /*
      * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
-     * hence unset mc_status.
+     * hence unset fwnmi_machine_check_interlock.
      */
-    spapr->mc_status =3D -1;
-    qemu_cond_signal(&spapr->mc_delivery_cond);
+    spapr->fwnmi_machine_check_interlock =3D -1;
+    qemu_cond_signal(&spapr->fwnmi_machine_check_interlock_cond);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     migrate_del_blocker(spapr->fwnmi_migration_blocker);
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 35b489a549..64b83402cb 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -79,10 +79,10 @@ typedef enum {
 #define SPAPR_CAP_LARGE_DECREMENTER     0x08
 /* Count Cache Flush Assist HW Instruction */
 #define SPAPR_CAP_CCF_ASSIST            0x09
-/* FWNMI machine check handling */
-#define SPAPR_CAP_FWNMI_MCE             0x0A
+/* Implements PAPR FWNMI option */
+#define SPAPR_CAP_FWNMI                 0x0A
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
=20
 /*
  * Capability Values
@@ -192,14 +192,21 @@ struct SpaprMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
=20
-    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls=
 */
-    target_ulong guest_machine_check_addr;
-    /*
-     * mc_status is set to -1 if mc is not in progress, else is set to t=
he CPU
-     * handling the mc.
+    /* State related to FWNMI option */
+
+    /* Machine Check Notification Routine address
+     * registered by "ibm,nmi-register" RTAS call.
+     */
+    target_ulong fwnmi_machine_check_addr;
+
+    /* Machine Check FWNMI synchronization, fwnmi_machine_check_interloc=
k is
+     * set to -1 if a FWNMI machine check is not in progress, else is se=
t to
+     * the CPU that was delivered the machine check, and is set back to =
-1
+     * when that CPU makes an "ibm,nmi-interlock" RTAS call. The cond is=
 used
+     * to synchronize other CPUs.
      */
-    int mc_status;
-    QemuCond mc_delivery_cond;
+    int fwnmi_machine_check_interlock;
+    QemuCond fwnmi_machine_check_interlock_cond;
=20
     /*< public >*/
     char *kvm_type;
diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqo=
s-spapr.h
index d9c4c22343..16174dbada 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -13,6 +13,6 @@ void qtest_spapr_shutdown(QOSState *qs);
     "cap-sbbc=3Dbroken,"                           \
     "cap-ibs=3Dbroken,"                            \
     "cap-ccf-assist=3Doff,"                        \
-    "cap-fwnmi-mce=3Doff"
+    "cap-fwnmi=3Doff"
=20
 #endif
--=20
2.24.1


