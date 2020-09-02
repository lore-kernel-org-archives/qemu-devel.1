Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D136C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED0620767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEkJsJ2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED0620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbnz-0001SC-08
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVp-0006AR-Uc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVm-0000I0-KC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ktoQfh7Azf87EbiJtqzsLJ4A8BhkUu1bCw5VGpaiJo=;
 b=TEkJsJ2f9VoMnq3c8sZRKST8vKOvxCljiwvy4gws9Aa53CXHVOdXEy4EGGQdwflmLLxODw
 0BeQxASKQWZMDRDNVlvcjE8gyhv9DvplhiSu6OKWse9Axo2uAJKW6aX+HPvIi+XvxbSUBb
 eFj3RYhMRFPox3f8u5PnAIDb8YGTo0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-6bGZtU9WP1elzVL8WdI9kw-1; Wed, 02 Sep 2020 18:45:46 -0400
X-MC-Unique: 6bGZtU9WP1elzVL8WdI9kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B59118A2251;
 Wed,  2 Sep 2020 22:45:44 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8AC65D9CC;
 Wed,  2 Sep 2020 22:45:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 59/63] kvm: Rename KVM_STATE to KVM_ACCEL
Date: Wed,  2 Sep 2020 18:43:07 -0400
Message-Id: <20200902224311.1321159-60-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, berrange@redhat.com,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: qemu-ppc@nongnu.org
---
 include/sysemu/kvm.h |  2 +-
 accel/kvm/kvm-all.c  | 18 +++++++++---------
 target/arm/kvm.c     |  2 +-
 target/i386/kvm.c    |  2 +-
 target/mips/kvm.c    |  2 +-
 target/ppc/kvm.c     |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 5bbea53883..89c422e1e7 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -204,7 +204,7 @@ struct KVMState;
 
 #define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
 typedef struct KVMState KVMState;
-DECLARE_INSTANCE_CHECKER(KVMState, KVM_STATE,
+DECLARE_INSTANCE_CHECKER(KVMState, KVM_ACCEL,
                          TYPE_KVM_ACCEL)
 
 extern KVMState *kvm_state;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..bdf63ca3a3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -214,7 +214,7 @@ void kvm_resample_fd_notify(int gsi)
 
 int kvm_get_max_memslots(void)
 {
-    KVMState *s = KVM_STATE(current_accel());
+    KVMState *s = KVM_ACCEL(current_accel());
 
     return s->nr_slots;
 }
@@ -256,7 +256,7 @@ static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 
 bool kvm_has_free_slot(MachineState *ms)
 {
-    KVMState *s = KVM_STATE(ms->accelerator);
+    KVMState *s = KVM_ACCEL(ms->accelerator);
     bool result;
     KVMMemoryListener *kml = &s->memory_listener;
 
@@ -1970,7 +1970,7 @@ static int kvm_max_vcpu_id(KVMState *s)
 
 bool kvm_vcpu_id_is_valid(int vcpu_id)
 {
-    KVMState *s = KVM_STATE(current_accel());
+    KVMState *s = KVM_ACCEL(current_accel());
     return vcpu_id >= 0 && vcpu_id < kvm_max_vcpu_id(s);
 }
 
@@ -1996,7 +1996,7 @@ static int kvm_init(MachineState *ms)
     const char *kvm_type;
     uint64_t dirty_log_manual_caps;
 
-    s = KVM_STATE(ms->accelerator);
+    s = KVM_ACCEL(ms->accelerator);
 
     /*
      * On systems where the kernel can support different base page
@@ -3084,7 +3084,7 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
 static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
                                  hwaddr start_addr, hwaddr size)
 {
-    KVMState *kvm = KVM_STATE(ms->accelerator);
+    KVMState *kvm = KVM_ACCEL(ms->accelerator);
     int i;
 
     for (i = 0; i < kvm->nr_as; ++i) {
@@ -3102,7 +3102,7 @@ static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
 {
-    KVMState *s = KVM_STATE(obj);
+    KVMState *s = KVM_ACCEL(obj);
     int64_t value = s->kvm_shadow_mem;
 
     visit_type_int(v, name, &value, errp);
@@ -3112,7 +3112,7 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
 {
-    KVMState *s = KVM_STATE(obj);
+    KVMState *s = KVM_ACCEL(obj);
     int64_t value;
 
     if (!visit_type_int(v, name, &value, errp)) {
@@ -3126,7 +3126,7 @@ static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
 {
-    KVMState *s = KVM_STATE(obj);
+    KVMState *s = KVM_ACCEL(obj);
     OnOffSplit mode;
 
     if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
@@ -3173,7 +3173,7 @@ bool kvm_kernel_irqchip_split(void)
 
 static void kvm_accel_instance_init(Object *obj)
 {
-    KVMState *s = KVM_STATE(obj);
+    KVMState *s = KVM_ACCEL(obj);
 
     s->kvm_shadow_mem = -1;
     s->kernel_irqchip_allowed = true;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378..55583075f3 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -216,7 +216,7 @@ bool kvm_arm_pmu_supported(void)
 
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
-    KVMState *s = KVM_STATE(ms->accelerator);
+    KVMState *s = KVM_ACCEL(ms->accelerator);
     int ret;
 
     ret = kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_SIZE);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 205b68bc0c..2949c5f048 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -155,7 +155,7 @@ bool kvm_allows_irq0_override(void)
 
 static bool kvm_x2apic_api_set_flags(uint64_t flags)
 {
-    KVMState *s = KVM_STATE(current_accel());
+    KVMState *s = KVM_ACCEL(current_accel());
 
     return !kvm_vm_enable_cap(s, KVM_CAP_X2APIC_API, 0, flags);
 }
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 72637a1e02..30f9c0349a 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1277,7 +1277,7 @@ int mips_kvm_type(MachineState *machine, const char *vm_type)
 {
 #if defined(KVM_CAP_MIPS_VZ) || defined(KVM_CAP_MIPS_TE)
     int r;
-    KVMState *s = KVM_STATE(machine->accelerator);
+    KVMState *s = KVM_ACCEL(machine->accelerator);
 #endif
 
 #if defined(KVM_CAP_MIPS_VZ)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d85ba8ffe0..e446637137 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -263,7 +263,7 @@ static void kvm_get_smmu_info(struct kvm_ppc_smmu_info *info, Error **errp)
 
 struct ppc_radix_page_info *kvm_get_radix_page_info(void)
 {
-    KVMState *s = KVM_STATE(current_accel());
+    KVMState *s = KVM_ACCEL(current_accel());
     struct ppc_radix_page_info *radix_page_info;
     struct kvm_ppc_rmmu_info rmmu_info;
     int i;
@@ -2943,7 +2943,7 @@ void kvmppc_svm_off(Error **errp)
         return;
     }
 
-    rc = kvm_vm_ioctl(KVM_STATE(current_accel()), KVM_PPC_SVM_OFF);
+    rc = kvm_vm_ioctl(KVM_ACCEL(current_accel()), KVM_PPC_SVM_OFF);
     if (rc && rc != -ENOTTY) {
         error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
     }
-- 
2.26.2


