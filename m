Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E34C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D50206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zd9Uj9wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D50206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7vV-0003t3-A8
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo7ui-0003FE-Bw
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:06:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53623
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo7uf-0001Jm-P6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593014772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QUApCuru5RalVw3ytOYyrCSL4Ev/5iTPW6xiP07/3JI=;
 b=Zd9Uj9wr/qZBb83bbGUNoTgcUVHSOLhg0DIFtXEw3IVbBOWIojUVSxFX7eMS4b9i+P9dkN
 hAwFDOq0tj814cM4wRD9qkq/fMTRbiLpaWXAzSXja1QnQPAS2AoT9Vq1KdYivwlmFmFgK2
 H2D1OnfzIJmJS4zNrU9VDZmOelJ6D2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-xbO5d8yVNgenxvSqtoWFZw-1; Wed, 24 Jun 2020 12:06:10 -0400
X-MC-Unique: xbO5d8yVNgenxvSqtoWFZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631081005512
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:09 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12CAB891E8;
 Wed, 24 Jun 2020 16:06:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] KVM: add support for AMD nested live migration
Date: Wed, 24 Jun 2020 12:06:08 -0400
Message-Id: <20200624160608.383931-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support for nested guest live migration is part of Linux 5.8, add the
corresponding code to QEMU.  The migration format consists of a few
flags, is an opaque 4k blob.

The blob is in VMCB format (the control area represents the L1 VMCB
control fields, the save area represents the pre-vmentry state; KVM does
not use the host save area since the AMD manual allows that) but QEMU
does not really care about that.  However, the flags need to be
copied to hflags/hflags2 and back.

In addition, support for retrieving and setting the AMD nested virtualization
states allows the L1 guest to be reset while running a nested guest, but
a small bug in CPU reset needs to be fixed for that to work.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c     |  1 +
 target/i386/cpu.h     |  5 +++++
 target/i386/kvm.c     | 42 ++++++++++++++++++++++++++++++++++--------
 target/i386/machine.c | 30 +++++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 36cbd3d027..f1cbac2fb5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5987,6 +5987,7 @@ static void x86_cpu_reset(DeviceState *dev)
     /* init to reset state */
 
     env->hflags2 |= HF2_GIF_MASK;
+    env->hflags &= ~HF_GUEST_MASK;
 
     cpu_x86_update_cr0(env, 0x60000010);
     env->a20_mask = ~0x0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7d77efd9e4..282f9ad35f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2118,6 +2118,11 @@ static inline bool cpu_has_vmx(CPUX86State *env)
     return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
 }
 
+static inline bool cpu_has_svm(CPUX86State *env)
+{
+    return env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM;
+}
+
 /*
  * In order for a vCPU to enter VMX operation it must have CR4.VMXE set.
  * Since it was set, CR4.VMXE must remain set as long as vCPU is in
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6adbff3d74..2b6b7443d2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1840,16 +1840,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (max_nested_state_len > 0) {
         assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
 
-        if (cpu_has_vmx(env)) {
+        if (cpu_has_vmx(env) || cpu_has_svm(env)) {
             struct kvm_vmx_nested_state_hdr *vmx_hdr;
 
             env->nested_state = g_malloc0(max_nested_state_len);
             env->nested_state->size = max_nested_state_len;
             env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
 
-            vmx_hdr = &env->nested_state->hdr.vmx;
-            vmx_hdr->vmxon_pa = -1ull;
-            vmx_hdr->vmcs12_pa = -1ull;
+            if (cpu_has_vmx(env)) {
+                    vmx_hdr = &env->nested_state->hdr.vmx;
+                    vmx_hdr->vmxon_pa = -1ull;
+                    vmx_hdr->vmcs12_pa = -1ull;
+            }
         }
     }
 
@@ -3873,6 +3875,20 @@ static int kvm_put_nested_state(X86CPU *cpu)
         return 0;
     }
 
+    /*
+     * Copy flags that are affected by reset from env->hflags and env->hflags2.
+     */
+    if (env->hflags & HF_GUEST_MASK) {
+        env->nested_state->flags |= KVM_STATE_NESTED_GUEST_MODE;
+    } else {
+        env->nested_state->flags &= ~KVM_STATE_NESTED_GUEST_MODE;
+    }
+    if (env->hflags2 & HF2_GIF_MASK) {
+        env->nested_state->flags |= KVM_STATE_NESTED_GIF_SET;
+    } else {
+        env->nested_state->flags &= ~KVM_STATE_NESTED_GIF_SET;
+    }
+
     assert(env->nested_state->size <= max_nested_state_len);
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, env->nested_state);
 }
@@ -3901,11 +3917,19 @@ static int kvm_get_nested_state(X86CPU *cpu)
         return ret;
     }
 
+    /*
+     * Copy flags that are affected by reset to env->hflags and env->hflags2.
+     */
     if (env->nested_state->flags & KVM_STATE_NESTED_GUEST_MODE) {
         env->hflags |= HF_GUEST_MASK;
     } else {
         env->hflags &= ~HF_GUEST_MASK;
     }
+    if (env->nested_state->flags & KVM_STATE_NESTED_GIF_SET) {
+        env->hflags2 |= HF2_GIF_MASK;
+    } else {
+        env->hflags2 &= ~HF2_GIF_MASK;
+    }
 
     return ret;
 }
@@ -3917,6 +3941,12 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    /* must be before kvm_put_nested_state so that EFER.SVME is set */
+    ret = kvm_put_sregs(x86_cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_nested_state(x86_cpu);
         if (ret < 0) {
@@ -3950,10 +3980,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
-    ret = kvm_put_sregs(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
     /* must be before kvm_put_msrs */
     ret = kvm_inject_mce_oldstyle(x86_cpu);
     if (ret < 0) {
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 0c96531a56..8684a247c1 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1071,13 +1071,40 @@ static const VMStateDescription vmstate_vmx_nested_state = {
     }
 };
 
+static bool svm_nested_state_needed(void *opaque)
+{
+    struct kvm_nested_state *nested_state = opaque;
+
+    /*
+     * HF2_GIF_MASK is relevant for non-guest mode but it is already
+     * serialized via hflags2.
+     */
+    return (nested_state->format == KVM_STATE_NESTED_FORMAT_SVM &&
+            nested_state->size > offsetof(struct kvm_nested_state, data));
+}
+
+static const VMStateDescription vmstate_svm_nested_state = {
+    .name = "cpu/kvm_nested_state/svm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = svm_nested_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_U64(hdr.svm.vmcb_pa, struct kvm_nested_state),
+        VMSTATE_UINT8_ARRAY(data.svm[0].vmcb12,
+                            struct kvm_nested_state,
+                            KVM_STATE_NESTED_SVM_VMCB_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool nested_state_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
 
     return (env->nested_state &&
-            vmx_nested_state_needed(env->nested_state));
+            (vmx_nested_state_needed(env->nested_state) ||
+             svm_nested_state_needed(env->nested_state)));
 }
 
 static int nested_state_post_load(void *opaque, int version_id)
@@ -1139,6 +1166,7 @@ static const VMStateDescription vmstate_kvm_nested_state = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_vmx_nested_state,
+        &vmstate_svm_nested_state,
         NULL
     }
 };
-- 
2.26.2


