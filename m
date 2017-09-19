Received: from eggs.gnu.org ([2001:4830:134:3::10]:59874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfI-00042R-B0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfC-0005L3-G4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:12 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfC-0005Kw-98
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:06 -0400
Received: by mail-wm0-x241.google.com with SMTP id x17so3721997wmd.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:08 +0200
Message-Id: <1505824179-21541-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/50] i386/kvm: set tsc_khz before configuring
 Hyper-V CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

Timing-related Hyper-V enlightenments will benefit from knowing the final
tsc_khz value. This commit just moves the code in preparation for further
changes.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-Id: <20170807085703.32267-3-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b14a0db..15d56ae 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -695,6 +695,25 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     cpuid_i = 0;
 
+    r = kvm_arch_set_tsc_khz(cs);
+    if (r < 0) {
+        goto fail;
+    }
+
+    /* vcpu's TSC frequency is either specified by user, or following
+     * the value used by KVM if the former is not present. In the
+     * latter case, we query it from KVM and record in env->tsc_khz,
+     * so that vcpu's TSC frequency can be migrated later via this field.
+     */
+    if (!env->tsc_khz) {
+        r = kvm_check_extension(cs->kvm_state, KVM_CAP_GET_TSC_KHZ) ?
+            kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
+            -ENOTSUP;
+        if (r > 0) {
+            env->tsc_khz = r;
+        }
+    }
+
     /* Paravirtualization CPUIDs */
     if (hyperv_enabled(cpu)) {
         c = &cpuid_data.entries[cpuid_i++];
@@ -961,25 +980,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    r = kvm_arch_set_tsc_khz(cs);
-    if (r < 0) {
-        goto fail;
-    }
-
-    /* vcpu's TSC frequency is either specified by user, or following
-     * the value used by KVM if the former is not present. In the
-     * latter case, we query it from KVM and record in env->tsc_khz,
-     * so that vcpu's TSC frequency can be migrated later via this field.
-     */
-    if (!env->tsc_khz) {
-        r = kvm_check_extension(cs->kvm_state, KVM_CAP_GET_TSC_KHZ) ?
-            kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
-            -ENOTSUP;
-        if (r > 0) {
-            env->tsc_khz = r;
-        }
-    }
-
     if (cpu->vmware_cpuid_freq
         /* Guests depend on 0x40000000 to detect this feature, so only expose
          * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V) */
-- 
1.8.3.1
