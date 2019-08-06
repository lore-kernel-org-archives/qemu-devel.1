Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB113C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 18:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8453A2075B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 18:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8453A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv4gd-0004Hm-Pm
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 14:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sean.j.christopherson@intel.com>) id 1hv4dx-0004OG-WB
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sean.j.christopherson@intel.com>) id 1hv4dw-00073O-Aa
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:6393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
 id 1hv4dw-0006yu-0w
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Aug 2019 11:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; d="scan'208";a="176715099"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
 by orsmga003.jf.intel.com with ESMTP; 06 Aug 2019 11:57:00 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Date: Tue,  6 Aug 2019 11:56:41 -0700
Message-Id: <20190806185649.2476-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806185649.2476-1-sean.j.christopherson@intel.com>
References: <20190806185649.2476-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [RFC PATCH 12/20] i386: kvm: Add support for exposing
 PROVISIONKEY to guest
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

KVM (and the Linux kernel in general) restricts access to a subset of
enclave attributes to provide additional security for an uncompromised
kernel, e.g. to prevent malware from using the PROVISIONKEY to ensure
its nodes are running inside a geniune SGX enclave and/or to obtain a
stable fingerprint.  Currently, only the PROVISIONKEY is restricted by
KVM/Linux.

To expose privileged attributes to a KVM guest, QEMU must prove to KVM
that it is allowed to access an attribute by passing KVM an open file
descriptor pointing at the associated SGX attribute file, e.g.
/dev/sgx/provision, using the capability ioctl() KVM_CAP_SGX_ATTRIBUTE.

If requested by the user (via its CPUID bit), attempt to enable guest
access to the PROVISIONKEY.  Do not error out if /dev/sgx/provision is
inaccessible, i.e. treat failure like any other unavailable feature.
Exit immediately if enabling fails as KVM should report support for
PROVISIONKEY via CPUID if and only if it supports KVM_CAP_SGX_ATTRIBUTE.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 target/i386/cpu.c      |  5 ++++-
 target/i386/kvm-stub.c |  5 +++++
 target/i386/kvm.c      | 25 +++++++++++++++++++++++++
 target/i386/kvm_i386.h |  3 +++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1bb9586230..a951a02baa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4560,7 +4560,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= XSTATE_FP_MASK | XSTATE_SSE_MASK;
 
             /* Access to PROVISIONKEY requires additional credentials. */
-            *eax &= ~(1U << 4);
+            if ((*eax & (1U << 4)) &&
+                !kvm_enable_sgx_provisioning(cs->kvm_state)) {
+                *eax &= ~(1U << 4);
+            }
         }
 #endif
         break;
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index 872ef7df4c..b4708386b5 100644
--- a/target/i386/kvm-stub.c
+++ b/target/i386/kvm-stub.c
@@ -38,6 +38,11 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
 {
     abort();
 }
+
+bool kvm_enable_sgx_provisioning(void)
+{
+    return false;
+}
 #endif
 
 bool kvm_hv_vpindex_settable(void)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e40c4fd673..dcda0bb0e9 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4111,6 +4111,31 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
     }
 }
 
+static bool has_sgx_provisioning;
+
+static bool __kvm_enable_sgx_provisioning(KVMState *s)
+{
+    int fd, ret;
+
+    fd = open("/dev/sgx/provision", O_RDONLY);
+    if (fd < 0) {
+        return false;
+    }
+
+    ret = kvm_vm_enable_cap(s, KVM_CAP_SGX_ATTRIBUTE, 0, fd);
+    if (ret) {
+        error_report("Could not enable SGX PROVISIONKEY: %s", strerror(-ret));
+        exit(1);
+    }
+    close(fd);
+    return true;
+}
+
+bool kvm_enable_sgx_provisioning(KVMState *s)
+{
+    return MEMORIZE(__kvm_enable_sgx_provisioning(s), has_sgx_provisioning);
+}
+
 static bool host_supports_vmx(void)
 {
     uint32_t ecx, unused;
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 06fe06bdb3..d9c3018744 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -66,4 +66,7 @@ bool kvm_enable_x2apic(void);
 bool kvm_has_x2apic_api(void);
 
 bool kvm_hv_vpindex_settable(void);
+
+bool kvm_enable_sgx_provisioning(KVMState *s);
+
 #endif
-- 
2.22.0


