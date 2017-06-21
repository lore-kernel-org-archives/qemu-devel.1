Received: from eggs.gnu.org ([2001:4830:134:3::10]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRW-0006YB-9g
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRT-0004RB-Li
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:22 -0400
Received: from mail-eopbgr30131.outbound.protection.outlook.com
	([40.107.3.131]:23929
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiRT-0004Qw-AL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:19 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:06 +0300
Message-Id: <20170621162424.10462-6-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 05/23] hyperv: make SynIC version msr
 constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

The value of HV_X64_MSR_SVERSION is initialized once at vcpu init, and
is reset to zero on vcpu reset, which is wrong.

It is supposed to be a constant, so drop the field from X86CPU, set the
msr with the constant value, and don't bother getting it.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - split out of v1 patch 4
 - make the value constant instead of keeping it on X86CPU

 target/i386/cpu.h | 1 -
 target/i386/kvm.c | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ad8600d..917e3c4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1099,7 +1099,6 @@ typedef struct CPUX86State {
     uint64_t msr_hv_crash_params[HV_CRASH_PARAMS];
     uint64_t msr_hv_runtime;
     uint64_t msr_hv_synic_control;
-    uint64_t msr_hv_synic_version;
     uint64_t msr_hv_synic_evt_page;
     uint64_t msr_hv_synic_msg_page;
     uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 27404dd..2795b63 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -654,7 +654,6 @@ static int hyperv_handle_properties(CPUState *cs)
         }
 
         env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
-        env->msr_hv_synic_version = HV_SYNIC_VERSION;
     }
     if (cpu->hyperv_stimer) {
         if (!has_msr_hv_stimer) {
@@ -1752,10 +1751,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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
@@ -2160,7 +2159,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         uint32_t msr;
 
         kvm_msr_entry_add(cpu, HV_X64_MSR_SCONTROL, 0);
-        kvm_msr_entry_add(cpu, HV_X64_MSR_SVERSION, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_SIEFP, 0);
         kvm_msr_entry_add(cpu, HV_X64_MSR_SIMP, 0);
         for (msr = HV_X64_MSR_SINT0; msr <= HV_X64_MSR_SINT15; msr++) {
@@ -2364,9 +2362,6 @@ static int kvm_get_msrs(X86CPU *cpu)
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
2.9.4
