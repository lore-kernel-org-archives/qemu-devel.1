Received: from eggs.gnu.org ([2001:4830:134:3::10]:44257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNhHx-0006Ru-IO
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNhHt-0007dX-Iu
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:48:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNhHt-0007cy-DV
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:48:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B583A3082AFD
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 16:48:08 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-60.ams2.redhat.com
	[10.36.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D13E648A2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 16:48:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Nov 2018 17:48:05 +0100
Message-Id: <20181116164806.26929-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] target/i386: kvm: add VMX and SVM migration
 blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Nested VMX and SVM do not support live migration yet.  Add a blocker
until that is worked out.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index db1f4104b6..3b6fbd3f20 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -860,6 +860,8 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
=20
 static Error *invtsc_mig_blocker;
+static Error *vmx_mig_blocker;
+static Error *svm_mig_blocker;
=20
 #define KVM_MAX_CPUID_ENTRIES  100
=20
@@ -1250,6 +1252,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (c) {
         has_msr_feature_control =3D !!(c->ecx & CPUID_EXT_VMX) ||
                                   !!(c->ecx & CPUID_EXT_SMX);
+
+    }
+
+    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker)=
 {
+        error_setg(&vmx_mig_blocker,
+                   "Nested VMX virtualization does not support live migr=
ation yet");
+        r =3D migrate_add_blocker(vmx_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(vmx_mig_blocker);
+            return r;
+        }
+    }
+
+    if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) && !svm_mig=
_blocker) {
+        error_setg(&svm_mig_blocker,
+                   "Nested SVM virtualization does not support live migr=
ation yet");
+        r =3D migrate_add_blocker(svm_mig_blocker, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(svm_mig_blocker);
+            return r;
+        }
     }
=20
     if (env->mcg_cap & MCG_LMCE_P) {
--=20
2.19.1
