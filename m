Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD70C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7BF20C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7BF20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyDK-0002Ax-57
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7e-0004pF-Dt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7c-0002WT-Ox
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy7c-0002Vx-Gp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4F6E10C0526
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:59:59 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D20811690F;
 Tue, 20 Aug 2019 06:59:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:20 +0200
Message-Id: <1566284395-30287-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 20 Aug 2019 06:59:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/36] kvm: i386: halt poll control MSR support
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marcelo Tosatti <mtosatti@redhat.com>

Add support for halt poll control MSR: save/restore, migration
and new feature name.

The purpose of this MSR is to allow the guest to disable
host halt poll.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Message-Id: <20190603230408.GA7938@amt.cnet>
[Do not enable by default, as pointed out by Mark Kanda. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/asm-x86/kvm_para.h |  2 ++
 target/i386/cpu.c                           |  4 +++-
 target/i386/cpu.h                           |  1 +
 target/i386/kvm.c                           | 14 ++++++++++++++
 target/i386/machine.c                       | 20 ++++++++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standard-headers/asm-x86/kvm_para.h
index 35cd8d6..e171514 100644
--- a/include/standard-headers/asm-x86/kvm_para.h
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -29,6 +29,7 @@
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 #define KVM_FEATURE_PV_SEND_IPI	11
+#define KVM_FEATURE_POLL_CONTROL	12
 
 #define KVM_HINTS_REALTIME      0
 
@@ -47,6 +48,7 @@
 #define MSR_KVM_ASYNC_PF_EN 0x4b564d02
 #define MSR_KVM_STEAL_TIME  0x4b564d03
 #define MSR_KVM_PV_EOI_EN      0x4b564d04
+#define MSR_KVM_POLL_CONTROL	0x4b564d05
 
 struct kvm_steal_time {
 	uint64_t steal;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19751e3..9a8f244 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -906,7 +906,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
-            NULL, NULL, NULL, NULL,
+            "kvm-poll-control", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "kvmclock-stable-bit", NULL, NULL, NULL,
@@ -5660,6 +5660,8 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "kvm_steal_time", obj, "kvm-steal-time", &error_abort);
     object_property_add_alias(obj, "kvm_pv_eoi", obj, "kvm-pv-eoi", &error_abort);
     object_property_add_alias(obj, "kvm_pv_unhalt", obj, "kvm-pv-unhalt", &error_abort);
+    object_property_add_alias(obj, "kvm_poll_control", obj, "kvm-poll-control",
+                              &error_abort);
     object_property_add_alias(obj, "svm_lock", obj, "svm-lock", &error_abort);
     object_property_add_alias(obj, "nrip_save", obj, "nrip-save", &error_abort);
     object_property_add_alias(obj, "tsc_scale", obj, "tsc-scale", &error_abort);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b3dc55..44e42f5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1260,6 +1260,7 @@ typedef struct CPUX86State {
     uint64_t steal_time_msr;
     uint64_t async_pf_en_msr;
     uint64_t pv_eoi_en_msr;
+    uint64_t poll_control_msr;
 
     /* Partition-wide HV MSRs, will be updated only on the first vcpu */
     uint64_t msr_hv_hypercall;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dbbb137..327c95a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1782,6 +1782,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
 
         hyperv_x86_synic_reset(cpu);
     }
+    /* enabled by default */
+    env->poll_control_msr = 1;
 }
 
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
@@ -2490,6 +2492,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
             kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, env->steal_time_msr);
         }
+
+        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
+            kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
+        }
+
         if (has_architectural_pmu_version > 0) {
             if (has_architectural_pmu_version > 1) {
                 /* Stop the counter.  */
@@ -2875,6 +2882,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
         kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, 0);
     }
+    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
+        kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
+    }
     if (has_architectural_pmu_version > 0) {
         if (has_architectural_pmu_version > 1) {
             kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
@@ -3109,6 +3119,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_KVM_STEAL_TIME:
             env->steal_time_msr = msrs[i].data;
             break;
+        case MSR_KVM_POLL_CONTROL: {
+            env->poll_control_msr = msrs[i].data;
+            break;
+        }
         case MSR_CORE_PERF_FIXED_CTR_CTRL:
             env->msr_fixed_ctr_ctrl = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index b114609..2ddd295 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -439,6 +439,14 @@ static const VMStateDescription vmstate_exception_info = {
     }
 };
 
+/* Poll control MSR enabled by default */
+static bool poll_control_msr_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    return cpu->env.poll_control_msr != 1;
+}
+
 static const VMStateDescription vmstate_steal_time_msr = {
     .name = "cpu/steal_time_msr",
     .version_id = 1,
@@ -472,6 +480,17 @@ static const VMStateDescription vmstate_pv_eoi_msr = {
     }
 };
 
+static const VMStateDescription vmstate_poll_control_msr = {
+    .name = "cpu/poll_control_msr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = poll_control_msr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.poll_control_msr, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool fpop_ip_dp_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1356,6 +1375,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_async_pf_msr,
         &vmstate_pv_eoi_msr,
         &vmstate_steal_time_msr,
+        &vmstate_poll_control_msr,
         &vmstate_fpop_ip_dp,
         &vmstate_msr_tsc_adjust,
         &vmstate_msr_tscdeadline,
-- 
1.8.3.1



