Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818BC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BBE20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEZrJ0ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BBE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf2N-0001hd-Ic
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctS-0008IE-VE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctQ-0007w4-FC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctQ-0007vJ-CN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXIsUU5e+eDzw2WVvQay4UUnLop5pGbWyW6MKoyD3wE=;
 b=DEZrJ0ETOcJGGMSFzcIEHoJ+zGK1iBxpKBvWbUhLEW5rvFIHqZkoxXCo4jALaWc1GYxWri
 mrszXBGwlWDmaT+hYYqP8idIGIQrSoAX0lJ3Luv81OyQTvDxZ/DqkPRg7jqakf1i8MCDzB
 gykTfWfywZrCGkj8F/Wij8TZ4XvY6AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-2j4YVtbLPU6oDvKPYH33AQ-1; Thu, 23 Jan 2020 08:51:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70370100E102;
 Thu, 23 Jan 2020 13:51:27 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 688F01CB;
 Thu, 23 Jan 2020 13:51:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/59] target/i386: kvm: initialize feature MSRs very early
Date: Thu, 23 Jan 2020 14:50:08 +0100
Message-Id: <1579787449-27599-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2j4YVtbLPU6oDvKPYH33AQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some read-only MSRs affect the behavior of ioctls such as
KVM_SET_NESTED_STATE.  We can initialize them once and for all
right after the CPU is realized, since they will never be modified
by the guest.

Reported-by: Qingua Cheng <qcheng@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1579544504-3616-2-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c      | 81 ++++++++++++++++++++++++++++++----------------=
----
 target/i386/kvm_i386.h |  1 +
 2 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7ee3202..f6dd6b7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -67,6 +67,8 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
=20
+static void kvm_init_msrs(X86CPU *cpu);
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
     KVM_CAP_INFO(SET_TSS_ADDR),
     KVM_CAP_INFO(EXT_CPUID),
@@ -1842,6 +1844,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_tsc_aux =3D false;
     }
=20
+    kvm_init_msrs(cpu);
+
     r =3D hyperv_init_vcpu(cpu);
     if (r) {
         goto fail;
@@ -2660,11 +2664,53 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, Feat=
ureWordArray f)
                       VMCS12_MAX_FIELD_INDEX << 1);
 }
=20
+static int kvm_buf_set_msrs(X86CPU *cpu)
+{
+    int ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (ret < cpu->kvm_msr_buf->nmsrs) {
+        struct kvm_msr_entry *e =3D &cpu->kvm_msr_buf->entries[ret];
+        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx6=
4,
+                     (uint32_t)e->index, (uint64_t)e->data);
+    }
+
+    assert(ret =3D=3D cpu->kvm_msr_buf->nmsrs);
+    return 0;
+}
+
+static void kvm_init_msrs(X86CPU *cpu)
+{
+    CPUX86State *env =3D &cpu->env;
+
+    kvm_msr_buf_reset(cpu);
+    if (has_msr_arch_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+                          env->features[FEAT_ARCH_CAPABILITIES]);
+    }
+
+    if (has_msr_core_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
+                          env->features[FEAT_CORE_CAPABILITY]);
+    }
+
+    /*
+     * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, bu=
t
+     * all kernels with MSR features should have them.
+     */
+    if (kvm_feature_msrs && cpu_has_vmx(env)) {
+        kvm_msr_entry_add_vmx(cpu, env->features);
+    }
+
+    assert(kvm_buf_set_msrs(cpu) =3D=3D 0);
+}
+
 static int kvm_put_msrs(X86CPU *cpu, int level)
 {
     CPUX86State *env =3D &cpu->env;
     int i;
-    int ret;
=20
     kvm_msr_buf_reset(cpu);
=20
@@ -2722,17 +2768,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     }
 #endif
=20
-    /* If host supports feature MSR, write down. */
-    if (has_msr_arch_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
-                          env->features[FEAT_ARCH_CAPABILITIES]);
-    }
-
-    if (has_msr_core_capabs) {
-        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
-                          env->features[FEAT_CORE_CAPABILITY]);
-    }
-
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
@@ -2910,14 +2945,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
=20
         /* Note: MSR_IA32_FEATURE_CONTROL is written separately, see
          *       kvm_put_msr_feature_control. */
-
-        /*
-         * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST=
, but
-         * all kernels with MSR features should have them.
-         */
-        if (kvm_feature_msrs && cpu_has_vmx(env)) {
-            kvm_msr_entry_add_vmx(cpu, env->features);
-        }
     }
=20
     if (env->mcg_cap) {
@@ -2933,19 +2960,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         }
     }
=20
-    ret =3D kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (ret < cpu->kvm_msr_buf->nmsrs) {
-        struct kvm_msr_entry *e =3D &cpu->kvm_msr_buf->entries[ret];
-        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx6=
4,
-                     (uint32_t)e->index, (uint64_t)e->data);
-    }
-
-    assert(ret =3D=3D cpu->kvm_msr_buf->nmsrs);
-    return 0;
+    return kvm_buf_set_msrs(cpu);
 }
=20
=20
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 7d0242f..00bde7a 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -46,4 +46,5 @@ bool kvm_enable_x2apic(void);
 bool kvm_has_x2apic_api(void);
=20
 bool kvm_hv_vpindex_settable(void);
+
 #endif
--=20
1.8.3.1



