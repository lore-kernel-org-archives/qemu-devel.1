Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25375C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A706320449
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GqFIVJ+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A706320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVYU-0000oS-1U
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43215)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hjVQP-0001Qt-6a
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hjVQM-00008T-0P
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hjVQK-0008Oi-K3
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:07:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65L3ssF119898;
 Fri, 5 Jul 2019 21:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=c1/s290z5etu0n2dhhW4gTKM/KYEKjonva5/EhYLZIU=;
 b=GqFIVJ+LGAkA/7QG8/2sY22kgXgTR/GX92pg2il3KbclJ+vyFhXi/+Zfq4oOUetdGzgE
 4OprN6smZGcLb1oNPgc2Ifw91FO98/IQNY8A5i0xe6rx/eNuK3dK3TuRCRe+CQTmjf4j
 LRTqIYEhpHccp5jw+jJxPU0jXg00+KihuiKMIpMAGmCgKiJCtRaUfAyp3vAUjXfIs6wZ
 FORMAdyeYecRlaSMH2yHP9PCcAEhbs6mZHooThE99+uzwKTWFgo1XXDeHLp2/0vkj7QC
 VKSejnb9wqeTmt0g9Sp3soj67dVJPeERAbfdVycDDEPjSQRd1PA/r+Xf8/5BPlJa2bIR eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2te61emgg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jul 2019 21:07:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x65L2X1w107403;
 Fri, 5 Jul 2019 21:07:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2thxrvm49m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jul 2019 21:07:05 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x65L744d030880;
 Fri, 5 Jul 2019 21:07:04 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jul 2019 14:07:04 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Sat,  6 Jul 2019 00:06:36 +0300
Message-Id: <20190705210636.3095-5-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705210636.3095-1-liran.alon@oracle.com>
References: <20190705210636.3095-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907050266
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9309
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907050266
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH 4/4] target/i386: kvm: Demand nested migration
 kernel capabilities only when vCPU may have enabled VMX
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
Cc: pbonzini@redhat.com, Joao Martins <joao.m.martins@oracle.com>,
 Liran Alon <liran.alon@oracle.com>, ehabkost@redhat.com, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous to this change, a vCPU exposed with VMX running on a kernel without KVM_CAP_NESTED_STATE
or KVM_CAP_EXCEPTION_PAYLOAD resulted in adding a migration blocker. This was because when code
was written it was thought there is no way to reliabely know if a vCPU is utilising VMX or not
at runtime. However, it turns out that this can be known to some extent:

In order for a vCPU to enter VMX operation it must have CR4.VMXE set.
Since it was set, CR4.VMXE must remain set as long as vCPU is in
VMX operation. This is because CR4.VMXE is one of the bits set
in MSR_IA32_VMX_CR4_FIXED1.
There is one exception to above statement when vCPU enters SMM mode.
When a vCPU enters SMM mode, it temporarily exit VMX operation and
may also reset CR4.VMXE during execution in SMM mode.
When vCPU exits SMM mode, vCPU state is restored to be in VMX operation
and CR4.VMXE is restored to it's original value of being set.
Therefore, when vCPU is not in SMM mode, we can infer whether
VMX is being used by examining CR4.VMXE. Otherwise, we cannot
know for certain but assume the worse that vCPU may utilise VMX.

Summaring all the above, a vCPU may have enabled VMX in case
CR4.VMXE is set or vCPU is in SMM mode.

Therefore, remove migration blocker and check before migration (cpu_pre_save())
if vCPU may have enabled VMX. If true, only then require relevant kernel capabilities.

While at it, demand KVM_CAP_EXCEPTION_PAYLOAD only when vCPU is in guest-mode and
there is a pending/injected exception. Otherwise, this kernel capability is
not required for proper migration.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.h      | 22 ++++++++++++++++++++++
 target/i386/kvm.c      | 26 ++++++--------------------
 target/i386/kvm_i386.h |  1 +
 target/i386/machine.c  | 24 ++++++++++++++++++++----
 4 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cdb0e43676a9..c752c4d936ee 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1872,6 +1872,28 @@ static inline bool cpu_has_svm(CPUX86State *env)
     return env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM;
 }
 
+/*
+ * In order for a vCPU to enter VMX operation it must have CR4.VMXE set.
+ * Since it was set, CR4.VMXE must remain set as long as vCPU is in
+ * VMX operation. This is because CR4.VMXE is one of the bits set
+ * in MSR_IA32_VMX_CR4_FIXED1.
+ *
+ * There is one exception to above statement when vCPU enters SMM mode.
+ * When a vCPU enters SMM mode, it temporarily exit VMX operation and
+ * may also reset CR4.VMXE during execution in SMM mode.
+ * When vCPU exits SMM mode, vCPU state is restored to be in VMX operation
+ * and CR4.VMXE is restored to it's original value of being set.
+ *
+ * Therefore, when vCPU is not in SMM mode, we can infer whether
+ * VMX is being used by examining CR4.VMXE. Otherwise, we cannot
+ * know for certain.
+ */
+static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
+{
+    return cpu_has_vmx(env) &&
+           ((env->cr[4] & CR4_VMXE_MASK) || (env->hflags & HF_SMM_MASK));
+}
+
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 4e2c8652168f..d3af445eeb5d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -128,6 +128,11 @@ bool kvm_has_adjust_clock_stable(void)
     return (ret == KVM_CLOCK_TSC_STABLE);
 }
 
+bool kvm_has_exception_payload(void)
+{
+    return has_exception_payload;
+}
+
 bool kvm_allows_irq0_override(void)
 {
     return !kvm_irqchip_in_kernel() || kvm_has_gsi_routing();
@@ -1341,7 +1346,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
-static Error *nested_virt_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1640,22 +1644,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
-        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
-        error_setg(&nested_virt_mig_blocker,
-                   "Kernel do not provide required capabilities for "
-                   "nested virtualization migration. "
-                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
-                   kvm_max_nested_state_length() > 0,
-                   has_exception_payload);
-        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            error_free(nested_virt_mig_blocker);
-            return r;
-        }
-    }
-
     if (env->mcg_cap & MCG_LMCE_P) {
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
@@ -1670,7 +1658,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             if (local_err) {
                 error_report_err(local_err);
                 error_free(invtsc_mig_blocker);
-                goto fail2;
+                return r;
             }
         }
     }
@@ -1741,8 +1729,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
  fail:
     migrate_del_blocker(invtsc_mig_blocker);
- fail2:
-    migrate_del_blocker(nested_virt_mig_blocker);
 
     return r;
 }
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 3057ba4f7d19..06fe06bdb3d6 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -35,6 +35,7 @@
 bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
 bool kvm_has_adjust_clock_stable(void);
+bool kvm_has_exception_payload(void);
 void kvm_synchronize_all_tsc(void);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 20bda9f80154..c04021937722 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,6 +7,7 @@
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
 #include "hyperv.h"
+#include "kvm_i386.h"
 
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
@@ -232,10 +233,25 @@ static int cpu_pre_save(void *opaque)
     }
 
 #ifdef CONFIG_KVM
-    /* Verify we have nested virtualization state from kernel if required */
-    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
-        error_report("Guest enabled nested virtualization but kernel "
-                "does not support saving of nested state");
+    /*
+     * In case vCPU may have enabled VMX, we need to make sure kernel have
+     * required capabilities in order to perform migration correctly:
+     *
+     * 1) We must be able to extract vCPU nested-state from KVM.
+     *
+     * 2) In case vCPU is running in guest-mode and it has a pending exception,
+     * we must be able to determine if it's in a pending or injected state.
+     * Note that in case KVM don't have required capability to do so,
+     * a pending/injected exception will always appear as an
+     * injected exception.
+     */
+    if (kvm_enabled() && cpu_vmx_maybe_enabled(env) &&
+        (!env->nested_state ||
+         (!kvm_has_exception_payload() && (env->hflags & HF_GUEST_MASK) &&
+          env->exception_injected))) {
+        error_report("Guest maybe enabled nested virtualization but kernel "
+                "does not support required capabilities to save vCPU "
+                "nested state");
         return -EINVAL;
     }
 #endif
-- 
2.20.1


