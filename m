Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084BC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 04:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042CF21D93
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 04:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042CF21D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPIMd-0007zE-VE
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 00:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1jPILv-0007TP-3y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1jPILt-0004td-34
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 00:11:42 -0400
Received: from [107.174.27.60] (port=49116 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1jPILs-0004tG-S2; Fri, 17 Apr 2020 00:11:41 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 35256AE80008;
 Fri, 17 Apr 2020 00:09:12 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr: Add PVR setting capability
Date: Fri, 17 Apr 2020 14:11:05 +1000
Message-Id: <20200417041105.63563-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment the VCPU init sequence includes setting PVR which in case of
KVM-HV only checks if it matches the hardware PVR mask as PVR cannot be
virtualized by the hardware. In order to cope with various CPU revisions
only top 16bit of PVR are checked which works for minor revision updates.

However in every CPU generation starting POWER7 (at least) there were CPUs
supporting the (almost) same POWER ISA level but having different top
16bits of PVR - POWER7+, POWER8E, POWER8NVL; this time we got POWER9+
with a new PVR family. We would normally add the PVR mask for the new one
too, the problem with it is that although the physical machines exist,
P9+ is not going to be released as a product, and this situation is likely
to repeat in the future.

Instead of adding every new CPU family in QEMU, this adds a new sPAPR
machine capability to force PVR setting/checking. It is "on" by default
to preserve the existing behavior. When "off", it is the user's
responsibility to specify the correct CPU.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/ppc/spapr.h |  5 ++++-
 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
 target/ppc/kvm.c       | 16 ++++++++++++++--
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e579eaf28c05..5ccac4d56871 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -81,8 +81,10 @@ typedef enum {
 #define SPAPR_CAP_CCF_ASSIST            0x09
 /* Implements PAPR FWNMI option */
 #define SPAPR_CAP_FWNMI                 0x0A
+/* Implements PAPR PVR option */
+#define SPAPR_CAP_PVR                   0x0B
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_PVR + 1)
 
 /*
  * Capability Values
@@ -912,6 +914,7 @@ extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
+extern const VMStateDescription vmstate_spapr_cap_pvr;
 
 static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 841b5ec59b12..ecc74c182b9f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4535,6 +4535,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_PVR] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index eb54f9422722..398b72b77f9f 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -525,6 +525,14 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
     }
 }
 
+static void cap_pvr_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
+{
+    if (val) {
+        return;
+    }
+    warn_report("If you're uing kvm-hv.ko, only \"-cpu host\" is supported");
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -633,6 +641,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_fwnmi_apply,
     },
+    [SPAPR_CAP_PVR] = {
+        .name = "pvr",
+        .description = "Enforce PVR in KVM",
+        .index = SPAPR_CAP_PVR,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_pvr_apply,
+    },
 };
 
 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -773,6 +790,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
+SPAPR_CAP_MIG_STATE(pvr, SPAPR_CAP_PVR);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 03d0667e8f94..a4adc29b6522 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -466,15 +466,27 @@ int kvm_arch_init_vcpu(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *cenv = &cpu->env;
     int ret;
+    SpaprMachineState *spapr;
 
     /* Synchronize sregs with kvm */
     ret = kvm_arch_sync_sregs(cpu);
     if (ret) {
         if (ret == -EINVAL) {
             error_report("Register sync failed... If you're using kvm-hv.ko,"
-                         " only \"-cpu host\" is possible");
+                         " only \"-cpu host\" is supported");
+        }
+        /*
+         * The user chose not to set PVR which makes sense if we are running
+         * on a CPU with known ISA level but unknown PVR.
+         */
+        spapr = (SpaprMachineState *)
+            object_dynamic_cast(OBJECT(qdev_get_machine()), TYPE_SPAPR_MACHINE);
+
+        if (spapr && spapr->eff.caps[SPAPR_CAP_PVR] == SPAPR_CAP_OFF) {
+            ret = 0;
+        } else {
+            return ret;
         }
-        return ret;
     }
 
     switch (cenv->mmu_model) {
-- 
2.17.1


