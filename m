Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfK-00046Y-TS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfB-0005Kq-Hu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:14 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfB-0005KM-91
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:05 -0400
Received: by mail-wm0-x241.google.com with SMTP id f4so3732102wmh.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:07 +0200
Message-Id: <1505824179-21541-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/50] i386/kvm: use a switch statement for MSR
 detection
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

Switch is easier on the eye and might lead to better codegen.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170807085703.32267-2-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 75 +++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6db7783..b14a0db 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1081,65 +1081,52 @@ static int kvm_get_supported_msrs(KVMState *s)
             int i;
 
             for (i = 0; i < kvm_msr_list->nmsrs; i++) {
-                if (kvm_msr_list->indices[i] == MSR_STAR) {
+                switch (kvm_msr_list->indices[i]) {
+                case MSR_STAR:
                     has_msr_star = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_VM_HSAVE_PA) {
+                    break;
+                case MSR_VM_HSAVE_PA:
                     has_msr_hsave_pa = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_TSC_AUX) {
+                    break;
+                case MSR_TSC_AUX:
                     has_msr_tsc_aux = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_TSC_ADJUST) {
+                    break;
+                case MSR_TSC_ADJUST:
                     has_msr_tsc_adjust = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_TSCDEADLINE) {
+                    break;
+                case MSR_IA32_TSCDEADLINE:
                     has_msr_tsc_deadline = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_SMBASE) {
+                    break;
+                case MSR_IA32_SMBASE:
                     has_msr_smbase = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_MISC_ENABLE) {
+                    break;
+                case MSR_IA32_MISC_ENABLE:
                     has_msr_misc_enable = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_BNDCFGS) {
+                    break;
+                case MSR_IA32_BNDCFGS:
                     has_msr_bndcfgs = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == MSR_IA32_XSS) {
+                    break;
+                case MSR_IA32_XSS:
                     has_msr_xss = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_CRASH_CTL) {
+                    break;;
+                case HV_X64_MSR_CRASH_CTL:
                     has_msr_hv_crash = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_RESET) {
+                    break;
+                case HV_X64_MSR_RESET:
                     has_msr_hv_reset = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_VP_INDEX) {
+                    break;
+                case HV_X64_MSR_VP_INDEX:
                     has_msr_hv_vpindex = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_VP_RUNTIME) {
+                    break;
+                case HV_X64_MSR_VP_RUNTIME:
                     has_msr_hv_runtime = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_SCONTROL) {
+                    break;
+                case HV_X64_MSR_SCONTROL:
                     has_msr_hv_synic = true;
-                    continue;
-                }
-                if (kvm_msr_list->indices[i] == HV_X64_MSR_STIMER0_CONFIG) {
+                    break;
+                case HV_X64_MSR_STIMER0_CONFIG:
                     has_msr_hv_stimer = true;
-                    continue;
+                    break;
                 }
             }
         }
-- 
1.8.3.1
