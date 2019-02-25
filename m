Received: from eggs.gnu.org ([209.51.188.92]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gyWAr-0006dh-AN
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gyWAq-0000Rx-7E
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:25:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:65458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gyWAp-0008RT-Tf
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:25:04 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Mon, 25 Feb 2019 21:18:22 +0800
Message-Id: <20190225131822.6817-6-weijiang.yang@intel.com>
In-Reply-To: <20190225131822.6817-1-weijiang.yang@intel.com>
References: <20190225131822.6817-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH v3 5/5] Add CET MSR save/restore support for
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Yang Weijiang <weijiang.yang@intel.com>

To support features such as live-migration,
CET runtime MSRs need to be saved in source machine and
restored on destination machine, this patch is to save
and restore CET_U, CET_S, PL0_SSP, PL3_SSP and SSP_TABL_ADDR
MSRs.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.h     |  12 +++++
 target/i386/kvm.c     |  33 ++++++++++++++
 target/i386/machine.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f3f724d8e6..f350684895 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -460,6 +460,12 @@ typedef enum X86Seg {
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 
+#define MSR_IA32_U_CET                  0x6a0
+#define MSR_IA32_S_CET                  0x6a2
+#define MSR_IA32_PL0_SSP                0x6a4
+#define MSR_IA32_PL3_SSP                0x6a7
+#define MSR_IA32_INTR_SSP_TABL          0x6a8
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -1325,6 +1331,12 @@ typedef struct CPUX86State {
 
     uintptr_t retaddr;
 
+    uint64_t u_cet;
+    uint64_t s_cet;
+    uint64_t pl0_ssp;
+    uint64_t pl3_ssp;
+    uint64_t ssp_tabl_addr;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f524e7d929..2ab3c977a4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -63,6 +63,8 @@
 /* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
+#define HAS_CET_CAP(env)  (env->features[FEAT_7_0_ECX] & 0x80 || \
+                           env->features[FEAT_7_0_EDX] & 0x100000)
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -2197,6 +2199,14 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         }
     }
 
+    if (HAS_CET_CAP(env)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, env->u_cet);
+        kvm_msr_entry_add(cpu, MSR_IA32_S_CET, env->s_cet);
+        kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+        kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, env->pl3_ssp);
+        kvm_msr_entry_add(cpu, MSR_IA32_INTR_SSP_TABL, env->ssp_tabl_addr);
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
         return ret;
@@ -2516,6 +2526,14 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
+    if (HAS_CET_CAP(env)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_INTR_SSP_TABL, 0);
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
         return ret;
@@ -2789,6 +2807,21 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
             env->msr_rtit_addrs[index - MSR_IA32_RTIT_ADDR0_A] = msrs[i].data;
             break;
+        case MSR_IA32_U_CET:
+            env->u_cet = msrs[i].data;
+            break;
+        case MSR_IA32_S_CET:
+            env->s_cet = msrs[i].data;
+            break;
+        case MSR_IA32_PL0_SSP:
+            env->pl0_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL3_SSP:
+            env->pl3_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_INTR_SSP_TABL:
+            env->ssp_tabl_addr = msrs[i].data;
+            break;
         }
     }
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..5f8a12ca30 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -810,6 +810,101 @@ static const VMStateDescription vmstate_xss = {
     }
 };
 
+static bool u_cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->u_cet != 0;
+}
+
+static const VMStateDescription vmstate_u_cet = {
+    .name = "cpu/u_cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = u_cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.u_cet, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool s_cet_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->s_cet != 0;
+}
+
+static const VMStateDescription vmstate_s_cet = {
+    .name = "cpu/s_cet",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = s_cet_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.s_cet, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool pl0_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->pl0_ssp != 0;
+}
+
+static const VMStateDescription vmstate_pl0_ssp = {
+    .name = "cpu/pl0_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl0_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool pl3_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->pl3_ssp != 0;
+}
+
+static const VMStateDescription vmstate_pl3_ssp = {
+    .name = "cpu/pl3_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl3_ssp_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.pl3_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool ssp_tabl_addr_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->ssp_tabl_addr != 0;
+}
+
+static const VMStateDescription vmstate_ssp_tabl_addr = {
+    .name = "cpu/ssp_tabl_addr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ssp_tabl_addr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.ssp_tabl_addr, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_X86_64
 static bool pkru_needed(void *opaque)
 {
@@ -1089,6 +1184,11 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
         &vmstate_svm_npt,
+        &vmstate_u_cet,
+        &vmstate_s_cet,
+        &vmstate_pl0_ssp,
+        &vmstate_pl3_ssp,
+        &vmstate_ssp_tabl_addr,
         NULL
     }
 };
-- 
2.17.1
