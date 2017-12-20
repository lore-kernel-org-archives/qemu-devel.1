Received: from eggs.gnu.org ([2001:4830:134:3::10]:56225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy8-0004OX-1R
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy7-000778-2a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:48 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:44480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy6-00076Z-Q5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:46 -0500
Received: by mail-wm0-x243.google.com with SMTP id t8so11240968wmc.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:23 +0100
Message-Id: <1513790098-9815-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/46] hyperv: make SynIC version msr constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

The value of HV_X64_MSR_SVERSION is initialized once at vcpu init, and
is reset to zero on vcpu reset, which is wrong.

It is supposed to be a constant, so drop the field from X86CPU, set the
msr with the constant value, and don't bother getting it.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20171122181418.14180-4-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 1 -
 target/i386/kvm.c | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 17f1bb7..d605cc6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1107,7 +1107,6 @@ typedef struct CPUX86State {
     uint64_t msr_hv_crash_params[HV_CRASH_PARAMS];
     uint64_t msr_hv_runtime;
     uint64_t msr_hv_synic_control;
-    uint64_t msr_hv_synic_version;
     uint64_t msr_hv_synic_evt_page;
     uint64_t msr_hv_synic_msg_page;
     uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 5d93391..351b64f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -669,7 +669,6 @@ static int hyperv_handle_properties(CPUState *cs)
         }
 
         env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
-        env->msr_hv_synic_version = HV_SYNIC_VERSION;
     }
     if (cpu->hyperv_stimer) {
         if (!has_msr_hv_stimer) {
@@ -1715,10 +1714,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (cpu->hyperv_synic) {
             int j;
 
+            kvm_msr_entry_add(cpu, HV_X64_MSR_SVERSION, HV_SYNIC_VERSION);
+
             kvm_msr_entry_add(cpu, HV_X64_MSR_SCONTROL,
                               env->msr_hv_synic_control);
-            kvm_msr_entry_add(cpu, HV_X64_MSR_SVERSION,
-                              env->msr_hv_synic_version);
             kvm_msr_entry_add(cpu, HV_X64_MSR_SIEFP,
                               env->msr_hv_synic_evt_page);
             kvm_msr_entry_add(cpu, HV_X64_MSR_SIMP,
@@ -2082,7 +2081,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         uint32_t msr;
 
         kvm_msr_entry_add(cpu, HV_X64_MSR_SCONTROL, 0);
-        kvm_msr_entry_add(cpu, HV_X64_MSR_SVERSION, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_SIEFP, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_SIMP, 0);
         for (msr = HV_X64_MSR_SINT0; msr <= HV_X64_MSR_SINT15; msr++) {
@@ -2286,9 +2284,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         case HV_X64_MSR_SCONTROL:
             env->msr_hv_synic_control = msrs[i].data;
             break;
-        case HV_X64_MSR_SVERSION:
-            env->msr_hv_synic_version = msrs[i].data;
-            break;
         case HV_X64_MSR_SIEFP:
             env->msr_hv_synic_evt_page = msrs[i].data;
             break;
-- 
1.8.3.1
