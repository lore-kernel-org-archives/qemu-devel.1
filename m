Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613DCC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE12071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuBG5UGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcZy-0004VM-0z
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMm-0006NK-Sy
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMb-0005eg-Ml
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rF29+ivM2oJ8A8MacCH3LRLVPyDVbcedCuAmiAMdg28=;
 b=cuBG5UGHdh04n7rUSUONBnvmgenFE6T52SfMbc7DopVUWOg/b9R0KY5Shq2a3dxupwuW9q
 XQmpmwZyJtzi1NxRwSH/GitW5weP0xkIZct2438cK3KXDxZRuMryxn2M/x2KrjPwnadlQZ
 xQ6ygjC1rhTdkRzUGQqd2Xb45/RK/+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-gZVB7BVxPri7lbqe1S4wdQ-1; Wed, 30 Sep 2020 09:41:42 -0400
X-MC-Unique: gZVB7BVxPri7lbqe1S4wdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0FF11007467
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:41 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FFD165F5E;
 Wed, 30 Sep 2020 13:41:40 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 19/19] i386: expand Hyper-V features during CPU feature
 expansion time
Date: Wed, 30 Sep 2020 15:40:27 +0200
Message-Id: <20200930134027.1348021-20-vkuznets@redhat.com>
In-Reply-To: <20200930134027.1348021-1-vkuznets@redhat.com>
References: <20200930134027.1348021-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make Hyper-V features appear in e.g. QMP query-cpu-model-expansion we
need to expand and set the corresponding CPUID leaves early. Modify
x86_cpu_get_supported_feature_word() to call newly intoduced Hyper-V
specific kvm_hv_get_supported_cpuid() instead of
kvm_arch_get_supported_cpuid(). We can't use kvm_arch_get_supported_cpuid()
as Hyper-V specific CPUID leaves intersect with KVM's.

Note, early expansion will only happen when KVM supports system wide
KVM_GET_SUPPORTED_HV_CPUID ioctl (KVM_CAP_SYS_HYPERV_CPUID).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c      |  4 ++++
 target/i386/kvm-stub.c |  5 +++++
 target/i386/kvm.c      | 15 ++++++++++++---
 target/i386/kvm_i386.h |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a178db255641..272091eab057 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6345,6 +6345,10 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if (env->cpuid_xlevel2 == UINT32_MAX) {
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
+
+    if (kvm_enabled()) {
+        kvm_hyperv_expand_features(cpu, errp);
+    }
 }
 
 /*
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index 872ef7df4c88..4abb5afa1168 100644
--- a/target/i386/kvm-stub.c
+++ b/target/i386/kvm-stub.c
@@ -44,3 +44,8 @@ bool kvm_hv_vpindex_settable(void)
 {
     return false;
 }
+
+void kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
+{
+    return;
+}
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2c62122a1bc8..ba99aecb5a64 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1230,13 +1230,22 @@ static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
  * of 'hv_passthrough' mode and fills the environment with all supported
  * Hyper-V features.
  */
-static void hyperv_expand_features(CPUState *cs, Error **errp)
+void kvm_hyperv_expand_features(X86CPU *cpu, Error **errp)
 {
-    X86CPU *cpu = X86_CPU(cs);
+    CPUState *cs = CPU(cpu);
 
     if (!hyperv_enabled(cpu))
         return;
 
+    /*
+     * When kvm_hyperv_expand_features is called at CPU feature expansion
+     * time per-CPU kvm_state is not available yet so we can only proceed
+     * when KVM_CAP_SYS_HYPERV_CPUID is supported.
+     */
+    if (!cs->kvm_state &&
+        !kvm_check_extension(kvm_state, KVM_CAP_SYS_HYPERV_CPUID))
+        return;
+
     if (cpu->hyperv_passthrough) {
         cpu->hyperv_vendor_id[0] =
             hv_cpuid_get_host(cs, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, R_EBX);
@@ -1569,7 +1578,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
 
     /* Paravirtualization CPUIDs */
-    hyperv_expand_features(cs, &local_err);
+    kvm_hyperv_expand_features(cpu, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return -ENOSYS;
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 064b8798a26c..126a1bcef2dd 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -47,5 +47,6 @@ bool kvm_has_x2apic_api(void);
 bool kvm_has_waitpkg(void);
 
 bool kvm_hv_vpindex_settable(void);
+void kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
 #endif
-- 
2.25.4


