Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD56BC4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3963123A03
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYnWmQUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3963123A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtj8-0007bw-8F
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLth1-0006To-WC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLth0-0007gA-6U
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:47:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601063261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRV0Vs68DGIGWN+Djgz5OOaKBqUeY1wMvaMh8SgrbcM=;
 b=JYnWmQUdx+tYMhCuuZX1WdtSkSMoN0byfJlMHlykD99feeGoDBqRjHpOnfgBbrPrYqTNsp
 Rp9oZlfblbAvph2b3Dr8bW1bFK344wvMExW2rceOFRdEkhPS3UG7K/g0w4MqifCeVC2REX
 Ud4BTSYmdukDnVgclph9Z4QLd/CZtTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Mr7ffonKOhmxDH8HLbU1WQ-1; Fri, 25 Sep 2020 15:47:39 -0400
X-MC-Unique: Mr7ffonKOhmxDH8HLbU1WQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF269801ADA
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 19:47:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE7C60C15;
 Fri, 25 Sep 2020 19:47:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/87] target/i386: support KVM_FEATURE_ASYNC_PF_INT
Date: Fri, 25 Sep 2020 15:47:35 -0400
Message-Id: <20200925194737.2148096-2-pbonzini@redhat.com>
In-Reply-To: <20200925194737.2148096-1-pbonzini@redhat.com>
References: <20200925194737.2148096-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Linux-5.8 introduced interrupt based mechanism for 'page ready' events
delivery and disabled the old, #PF based one (see commit 2635b5c4a0e4
"KVM: x86: interrupt based APF 'page ready' event delivery"). Linux
guest switches to using in in 5.9 (see commit b1d405751cd5 "KVM: x86:
Switch KVM guest to using interrupts for page ready APF delivery").
The feature has a new KVM_FEATURE_ASYNC_PF_INT bit assigned and
the interrupt vector is set in MSR_KVM_ASYNC_PF_INT MSR. Support this
in QEMU.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20200908141206.357450-1-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c     |  3 ++-
 target/i386/cpu.h     |  1 +
 target/i386/kvm.c     | 10 ++++++++++
 target/i386/machine.c | 19 +++++++++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ffd877dd5..0ea0630e1f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -799,7 +799,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
-            "kvm-poll-control", "kvm-pv-sched-yield", NULL, NULL,
+            "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             "kvmclock-stable-bit", NULL, NULL, NULL,
@@ -6988,6 +6988,7 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "kvm_nopiodelay", obj, "kvm-nopiodelay");
     object_property_add_alias(obj, "kvm_mmu", obj, "kvm-mmu");
     object_property_add_alias(obj, "kvm_asyncpf", obj, "kvm-asyncpf");
+    object_property_add_alias(obj, "kvm_asyncpf_int", obj, "kvm-asyncpf-int");
     object_property_add_alias(obj, "kvm_steal_time", obj, "kvm-steal-time");
     object_property_add_alias(obj, "kvm_pv_eoi", obj, "kvm-pv-eoi");
     object_property_add_alias(obj, "kvm_pv_unhalt", obj, "kvm-pv-unhalt");
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f519d2bfd4..51c1d5f60a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1492,6 +1492,7 @@ typedef struct CPUX86State {
     uint64_t wall_clock_msr;
     uint64_t steal_time_msr;
     uint64_t async_pf_en_msr;
+    uint64_t async_pf_int_msr;
     uint64_t pv_eoi_en_msr;
     uint64_t poll_control_msr;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9efb07e7c8..06c2025c67 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -287,6 +287,7 @@ static const struct kvm_para_features {
     { KVM_CAP_NOP_IO_DELAY, KVM_FEATURE_NOP_IO_DELAY },
     { KVM_CAP_PV_MMU, KVM_FEATURE_MMU_OP },
     { KVM_CAP_ASYNC_PF, KVM_FEATURE_ASYNC_PF },
+    { KVM_CAP_ASYNC_PF_INT, KVM_FEATURE_ASYNC_PF_INT },
 };
 
 static int get_para_features(KVMState *s)
@@ -2821,6 +2822,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
         }
+        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+            kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_int_msr);
+        }
         if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
             kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
         }
@@ -3206,6 +3210,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
     }
+    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
+        kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
+    }
     if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
         kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
     }
@@ -3446,6 +3453,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_KVM_ASYNC_PF_EN:
             env->async_pf_en_msr = msrs[i].data;
             break;
+        case MSR_KVM_ASYNC_PF_INT:
+            env->async_pf_int_msr = msrs[i].data;
+            break;
         case MSR_KVM_PV_EOI_EN:
             env->pv_eoi_en_msr = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index b1acf7d0ef..233e46bb70 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -394,6 +394,13 @@ static bool async_pf_msr_needed(void *opaque)
     return cpu->env.async_pf_en_msr != 0;
 }
 
+static bool async_pf_int_msr_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    return cpu->env.async_pf_int_msr != 0;
+}
+
 static bool pv_eoi_msr_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -467,6 +474,17 @@ static const VMStateDescription vmstate_async_pf_msr = {
     }
 };
 
+static const VMStateDescription vmstate_async_pf_int_msr = {
+    .name = "cpu/async_pf_int_msr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = async_pf_int_msr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.async_pf_int_msr, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_pv_eoi_msr = {
     .name = "cpu/async_pv_eoi_msr",
     .version_id = 1,
@@ -1438,6 +1456,7 @@ VMStateDescription vmstate_x86_cpu = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_exception_info,
         &vmstate_async_pf_msr,
+        &vmstate_async_pf_int_msr,
         &vmstate_pv_eoi_msr,
         &vmstate_steal_time_msr,
         &vmstate_poll_control_msr,
-- 
2.26.2



