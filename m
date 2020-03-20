Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB8C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 23:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DE52072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 23:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DE52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFR0f-0005Mx-8Q
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 19:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1jFR02-0004qO-6m
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 19:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1jFR00-000799-Or
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 19:24:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1jFQzx-00077M-D7; Fri, 20 Mar 2020 19:24:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02KN2Mda107903; Fri, 20 Mar 2020 19:24:02 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu71cs4ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2020 19:24:01 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02KNMoSU030826;
 Fri, 20 Mar 2020 23:24:01 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 2yrpw7gse6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2020 23:24:01 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02KNO0dB53150152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2020 23:24:00 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B858AE05F;
 Fri, 20 Mar 2020 23:24:00 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7609FAE05C;
 Fri, 20 Mar 2020 23:23:58 +0000 (GMT)
Received: from farosas.linux.ibm.com.ibmuc.com (unknown [9.85.141.34])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2020 23:23:58 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] target/ppc: Add capability for enabling secure guests
Date: Fri, 20 Mar 2020 20:23:53 -0300
Message-Id: <20200320232353.1022066-1-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-20_08:2020-03-20,
 2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200088
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Ram Pai <linuxram@us.ibm.com>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Making use of ppc's Protected Execution Facility (PEF) feature, a
guest can become a secure guest (aka. secure VM - SVM) and have its
memory protected from access by the host. This feature is mediated by
a piece of firmware called the Ultravisor (UV).

The transition from a regular to a secure VM is initiated by the guest
kernel during prom_init via the use of an ultracall (enter secure mode
- UV_ESM) and with cooperation from the hypervisor via an hcall
(H_SVM_INIT_START).

Currently QEMU has no knowledge of this process and no way to
determine if a host supports the feature. A guest with PEF support
enabled would always try to enter secure mode regardless of user
intent or hardware support.

To address the above, a new KVM capability (KVM_CAP_PPC_SECURE_GUEST
[1]) is being introduced in the kernel without which KVM will block
the secure transition.

This patch adds support for checking/enabling this KVM capability via
a new spapr capability (SPAPR_CAP_SECURE_GUEST) and the equivalent
command line switch (-machine pseries,cap-svm). The capability
defaults to off.

1- https://lore.kernel.org/kvm/20200319043301.GA13052@blackberry

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---

I have implemented this to be able to test Paul's patch. I'm sending
it as RFC in case it helps anyone else and if we decide to go in this
direction I can develop it further.

PS: TCG currently gets in a loop of 0x700 due to the lack of 'sc 2'
emulation - and all the rest of PEF, of course =).

---
 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_caps.c    | 30 ++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 target/ppc/kvm.c       | 12 ++++++++++++
 target/ppc/kvm_ppc.h   | 12 ++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..a881ac4e29 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4542,6 +4542,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
+    smc->default_caps.caps[SPAPR_CAP_SECURE_GUEST] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 679ae7959f..375b7e0b30 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -524,6 +524,27 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
     }
 }

+static void cap_secure_guest_apply(SpaprMachineState *spapr,
+                                   uint8_t val, Error **errp)
+{
+    if (!val) {
+        /* capability disabled by default */
+        return;
+    }
+
+    if (!kvm_enabled()) {
+        error_setg(errp, "No PEF support in tcg, try cap-svm=off");
+        return;
+    }
+
+    if (!kvmppc_has_cap_secure_guest()) {
+        error_setg(errp, "KVM implementation does not support secure guests, "
+                   "try cap-svm=off");
+    } else if (kvmppc_enable_cap_secure_guest() < 0) {
+        error_setg(errp, "Error enabling cap-svm, try cap-svm=off");
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -632,6 +653,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_fwnmi_apply,
     },
+    [SPAPR_CAP_SECURE_GUEST] = {
+        .name = "svm",
+        .description = "Allow the guest to become a Secure Guest",
+        .index = SPAPR_CAP_SECURE_GUEST,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_secure_guest_apply,
+    },
 };

 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a0368..7f5289782d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -81,8 +81,9 @@ typedef enum {
 #define SPAPR_CAP_CCF_ASSIST            0x09
 /* Implements PAPR FWNMI option */
 #define SPAPR_CAP_FWNMI                 0x0A
+#define SPAPR_CAP_SECURE_GUEST          0x0B
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_SECURE_GUEST + 1)

 /*
  * Capability Values
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 597f72be1b..9254749cd7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
+static int cap_ppc_secure_guest;

 static uint32_t debug_inst_opcode;

@@ -135,6 +136,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
+    cap_ppc_secure_guest = kvm_vm_check_extension(s, KVM_CAP_PPC_SECURE_GUEST);
     cap_large_decr = kvmppc_get_dec_bits();
     /*
      * Note: setting it to false because there is not such capability
@@ -2532,6 +2534,16 @@ int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
     return 0;
 }

+bool kvmppc_has_cap_secure_guest(void)
+{
+    return !!cap_ppc_secure_guest;
+}
+
+int kvmppc_enable_cap_secure_guest(void)
+{
+    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_SECURE_GUEST, 0, 1);
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 332fa0aa1c..a9a3aa67c6 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -72,6 +72,8 @@ int kvmppc_set_cap_nested_kvm_hv(int enable);
 int kvmppc_get_cap_large_decr(void);
 int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
 int kvmppc_enable_hwrng(void);
+bool kvmppc_has_cap_secure_guest(void);
+int kvmppc_enable_cap_secure_guest(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
@@ -380,6 +382,16 @@ static inline int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
     return -1;
 }

+static inline bool kvmppc_has_cap_secure_guest(void)
+{
+    return false;
+}
+
+static inline int kvmppc_enable_cap_secure_guest(void)
+{
+    return -1;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
--
2.23.0

