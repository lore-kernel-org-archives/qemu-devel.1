Received: from eggs.gnu.org ([2001:4830:134:3::10]:39244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fMDJO-0007Do-Kn
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fMDJJ-0000WJ-PC
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:18 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <petrutlucian94@gmail.com>)
	id 1fMDJJ-0000Vj-EO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:13 -0400
Received: by mail-wr0-x231.google.com with SMTP id j1-v6so9462080wrm.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:03:13 -0700 (PDT)
From: petrutlucian94@gmail.com
Date: Fri, 25 May 2018 17:02:22 +0300
Message-Id: <1527256943-7667-2-git-send-email-lpetrut@cloudbasesolutions.com>
In-Reply-To: <1527256943-7667-1-git-send-email-lpetrut@cloudbasesolutions.com>
References: <1527256943-7667-1-git-send-email-lpetrut@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH v3 2/3] WHPX: dynamically load WHP libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>

From: Lucian Petrut <lpetrut@cloudbasesolutions.com>

We're currently linking against import libraries of the WHP DLLs.

By dynamically loading the libraries, we ensure that QEMU will work
on previous Windows versions, where the WHP DLLs will be missing
(assuming that WHP is not requested).

Also, we're simplifying the build process, as we no longer require
the import libraries.

Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
---
 configure                  |  15 +--
 target/i386/whp-dispatch.h |  56 ++++++++++++
 target/i386/whpx-all.c     | 222 ++++++++++++++++++++++++++++++---------------
 3 files changed, 206 insertions(+), 87 deletions(-)
 create mode 100644 target/i386/whp-dispatch.h

diff --git a/configure b/configure
index a8498ab..99b4a28 100755
--- a/configure
+++ b/configure
@@ -2524,20 +2524,7 @@ fi
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
 if test "$whpx" != "no" ; then
-    cat > $TMPC << EOF
-#include <windows.h>
-#include <WinHvPlatform.h>
-#include <WinHvEmulation.h>
-int main(void) {
-    WHV_CAPABILITY whpx_cap;
-    UINT32 writtenSize;
-    WHvGetCapability(WHvCapabilityCodeFeatures, &whpx_cap, sizeof(whpx_cap),
-                     &writtenSize);
-    return 0;
-}
-EOF
-    if compile_prog "" "-lWinHvPlatform -lWinHvEmulation" ; then
-        libs_softmmu="$libs_softmmu -lWinHvPlatform -lWinHvEmulation"
+    if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
         whpx="yes"
     else
         if test "$whpx" = "yes"; then
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
new file mode 100644
index 0000000..d8d3485
--- /dev/null
+++ b/target/i386/whp-dispatch.h
@@ -0,0 +1,56 @@
+#include "windows.h"
+#include <stdbool.h>
+
+#include <WinHvPlatform.h>
+#include <WinHvEmulation.h>
+
+#ifndef WHP_DISPATCH_H
+#define WHP_DISPATCH_H
+
+
+#define LIST_WINHVPLATFORM_FUNCTIONS(X) \
+  X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
+  X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
+  X(HRESULT, WHvSetupPartition, (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvDeletePartition, (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvGetPartitionProperty, (WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, VOID* PropertyBuffer, UINT32 PropertyBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
+  X(HRESULT, WHvSetPartitionProperty, (WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, const VOID* PropertyBuffer, UINT32 PropertyBufferSizeInBytes)) \
+  X(HRESULT, WHvMapGpaRange, (WHV_PARTITION_HANDLE Partition, VOID* SourceAddress, WHV_GUEST_PHYSICAL_ADDRESS GuestAddress, UINT64 SizeInBytes, WHV_MAP_GPA_RANGE_FLAGS Flags)) \
+  X(HRESULT, WHvUnmapGpaRange, (WHV_PARTITION_HANDLE Partition, WHV_GUEST_PHYSICAL_ADDRESS GuestAddress, UINT64 SizeInBytes)) \
+  X(HRESULT, WHvTranslateGva, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, WHV_GUEST_VIRTUAL_ADDRESS Gva, WHV_TRANSLATE_GVA_FLAGS TranslateFlags, WHV_TRANSLATE_GVA_RESULT* TranslationResult, WHV_GUEST_PHYSICAL_ADDRESS* Gpa)) \
+  X(HRESULT, WHvCreateVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Flags)) \
+  X(HRESULT, WHvDeleteVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex)) \
+  X(HRESULT, WHvRunVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, VOID* ExitContext, UINT32 ExitContextSizeInBytes)) \
+  X(HRESULT, WHvCancelRunVirtualProcessor, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Flags)) \
+  X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
+  X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
+
+
+#define LIST_WINHVEMULATION_FUNCTIONS(X) \
+  X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
+  X(HRESULT, WHvEmulatorDestroyEmulator, (WHV_EMULATOR_HANDLE Emulator)) \
+  X(HRESULT, WHvEmulatorTryIoEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_X64_IO_PORT_ACCESS_CONTEXT* IoInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
+  X(HRESULT, WHvEmulatorTryMmioEmulation, (WHV_EMULATOR_HANDLE Emulator, VOID* Context, const WHV_VP_EXIT_CONTEXT* VpContext, const WHV_MEMORY_ACCESS_CONTEXT* MmioInstructionContext, WHV_EMULATOR_STATUS* EmulatorReturnStatus)) \
+
+
+#define WHP_DEFINE_TYPE(return_type, function_name, signature) \
+    typedef return_type (WINAPI *function_name ## _t) signature;
+
+#define WHP_DECLARE_MEMBER(return_type, function_name, signature) \
+    function_name ## _t function_name;
+
+/* Define function typedef */
+LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+
+struct WHPDispatch {
+    LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+    LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+};
+
+extern struct WHPDispatch whp_dispatch;
+
+bool init_whp_dispatch(void);
+
+
+#endif /* WHP_DISPATCH_H */
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index ffc083e..280e2bc 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -25,6 +25,7 @@
 #include "qemu/queue.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "whp-dispatch.h"
 
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
@@ -162,8 +163,11 @@ struct whpx_vcpu {
 };
 
 static bool whpx_allowed;
+static bool whp_dispatch_initialized;
+static HMODULE hWinHvPlatform, hWinHvEmulation;
 
 struct whpx_state whpx_global;
+struct WHPDispatch whp_dispatch;
 
 
 /*
@@ -357,10 +361,11 @@ static void whpx_set_registers(CPUState *cpu)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    hr = WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-                                         whpx_register_names,
-                                         RTL_NUMBER_OF(whpx_register_names),
-                                         &vcxt.values[0]);
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names,
+        RTL_NUMBER_OF(whpx_register_names),
+        &vcxt.values[0]);
 
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
@@ -384,10 +389,11 @@ static void whpx_get_registers(CPUState *cpu)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    hr = WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-                                         whpx_register_names,
-                                         RTL_NUMBER_OF(whpx_register_names),
-                                         &vcxt.values[0]);
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names,
+        RTL_NUMBER_OF(whpx_register_names),
+        &vcxt.values[0]);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
                      hr);
@@ -547,9 +553,10 @@ static HRESULT CALLBACK whpx_emu_getreg_callback(
     struct whpx_state *whpx = &whpx_global;
     CPUState *cpu = (CPUState *)ctx;
 
-    hr = WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-                                         RegisterNames, RegisterCount,
-                                         RegisterValues);
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        RegisterNames, RegisterCount,
+        RegisterValues);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to get virtual processor registers,"
                      " hr=%08lx", hr);
@@ -568,9 +575,10 @@ static HRESULT CALLBACK whpx_emu_setreg_callback(
     struct whpx_state *whpx = &whpx_global;
     CPUState *cpu = (CPUState *)ctx;
 
-    hr = WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-                                         RegisterNames, RegisterCount,
-                                         RegisterValues);
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        RegisterNames, RegisterCount,
+        RegisterValues);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set virtual processor registers,"
                      " hr=%08lx", hr);
@@ -597,8 +605,8 @@ static HRESULT CALLBACK whpx_emu_translate_callback(
     CPUState *cpu = (CPUState *)ctx;
     WHV_TRANSLATE_GVA_RESULT res;
 
-    hr = WHvTranslateGva(whpx->partition, cpu->cpu_index,
-                         Gva, TranslateFlags, &res, Gpa);
+    hr = whp_dispatch.WHvTranslateGva(whpx->partition, cpu->cpu_index,
+                                      Gva, TranslateFlags, &res, Gpa);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to translate GVA, hr=%08lx", hr);
     } else {
@@ -623,16 +631,18 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
     WHV_EMULATOR_STATUS emu_status;
 
-    hr = WHvEmulatorTryMmioEmulation(vcpu->emulator, cpu,
-                                     &vcpu->exit_ctx.VpContext, ctx,
-                                     &emu_status);
+    hr = whp_dispatch.WHvEmulatorTryMmioEmulation(
+        vcpu->emulator, cpu,
+        &vcpu->exit_ctx.VpContext, ctx,
+        &emu_status);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to parse MMIO access, hr=%08lx", hr);
         return -1;
     }
 
     if (!emu_status.EmulationSuccessful) {
-        error_report("WHPX: Failed to emulate MMIO access");
+        error_report("WHPX: Failed to emulate MMIO access with"
+                     " EmulatorReturnStatus: %u", emu_status.AsUINT32);
         return -1;
     }
 
@@ -646,16 +656,18 @@ static int whpx_handle_portio(CPUState *cpu,
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
     WHV_EMULATOR_STATUS emu_status;
 
-    hr = WHvEmulatorTryIoEmulation(vcpu->emulator, cpu,
-                                   &vcpu->exit_ctx.VpContext, ctx,
-                                   &emu_status);
+    hr = whp_dispatch.WHvEmulatorTryIoEmulation(
+        vcpu->emulator, cpu,
+        &vcpu->exit_ctx.VpContext, ctx,
+        &emu_status);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to parse PortIO access, hr=%08lx", hr);
         return -1;
     }
 
     if (!emu_status.EmulationSuccessful) {
-        error_report("WHPX: Failed to emulate PortMMIO access");
+        error_report("WHPX: Failed to emulate PortIO access with"
+                     " EmulatorReturnStatus: %u", emu_status.AsUINT32);
         return -1;
     }
 
@@ -770,8 +782,9 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     qemu_mutex_unlock_iothread();
 
     if (reg_count) {
-        hr = WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
-                                             reg_names, reg_count, reg_values);
+        hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+            whpx->partition, cpu->cpu_index,
+            reg_names, reg_count, reg_values);
         if (FAILED(hr)) {
             error_report("WHPX: Failed to set interrupt state registers,"
                          " hr=%08lx", hr);
@@ -879,8 +892,9 @@ static int whpx_vcpu_run(CPUState *cpu)
             whpx_vcpu_kick(cpu);
         }
 
-        hr = WHvRunVirtualProcessor(whpx->partition, cpu->cpu_index,
-                                    &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
+        hr = whp_dispatch.WHvRunVirtualProcessor(
+            whpx->partition, cpu->cpu_index,
+            &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
 
         if (FAILED(hr)) {
             error_report("WHPX: Failed to exec a virtual processor,"
@@ -951,11 +965,11 @@ static int whpx_vcpu_run(CPUState *cpu)
             reg_values[3].Reg64 = rdx;
             reg_values[4].Reg64 = rbx;
 
-            hr = WHvSetVirtualProcessorRegisters(whpx->partition,
-                                                 cpu->cpu_index,
-                                                 reg_names,
-                                                 reg_count,
-                                                 reg_values);
+            hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+                whpx->partition, cpu->cpu_index,
+                reg_names,
+                reg_count,
+                reg_values);
 
             if (FAILED(hr)) {
                 error_report("WHPX: Failed to set CpuidAccess state registers,"
@@ -1067,8 +1081,8 @@ int whpx_init_vcpu(CPUState *cpu)
         (void)migrate_add_blocker(whpx_migration_blocker, &local_error);
         if (local_error) {
             error_report_err(local_error);
-            error_free(whpx_migration_blocker);
             migrate_del_blocker(whpx_migration_blocker);
+            error_free(whpx_migration_blocker);
             return -EINVAL;
         }
     }
@@ -1080,7 +1094,9 @@ int whpx_init_vcpu(CPUState *cpu)
         return -ENOMEM;
     }
 
-    hr = WHvEmulatorCreateEmulator(&whpx_emu_callbacks, &vcpu->emulator);
+    hr = whp_dispatch.WHvEmulatorCreateEmulator(
+        &whpx_emu_callbacks,
+        &vcpu->emulator);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup instruction completion support,"
                      " hr=%08lx", hr);
@@ -1088,11 +1104,12 @@ int whpx_init_vcpu(CPUState *cpu)
         return -EINVAL;
     }
 
-    hr = WHvCreateVirtualProcessor(whpx->partition, cpu->cpu_index, 0);
+    hr = whp_dispatch.WHvCreateVirtualProcessor(
+        whpx->partition, cpu->cpu_index, 0);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create a virtual processor,"
                      " hr=%08lx", hr);
-        WHvEmulatorDestroyEmulator(vcpu->emulator);
+        whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
         g_free(vcpu);
         return -EINVAL;
     }
@@ -1133,8 +1150,8 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
 
-    WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-    WHvEmulatorDestroyEmulator(vcpu->emulator);
+    whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
     g_free(cpu->hax_vcpu);
     return;
 }
@@ -1142,7 +1159,8 @@ void whpx_destroy_vcpu(CPUState *cpu)
 void whpx_vcpu_kick(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
-    WHvCancelRunVirtualProcessor(whpx->partition, cpu->cpu_index, 0);
+    whp_dispatch.WHvCancelRunVirtualProcessor(
+        whpx->partition, cpu->cpu_index, 0);
 }
 
 /*
@@ -1168,17 +1186,17 @@ static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
     */
 
     if (add) {
-        hr = WHvMapGpaRange(whpx->partition,
-                            host_va,
-                            start_pa,
-                            size,
-                            (WHvMapGpaRangeFlagRead |
-                             WHvMapGpaRangeFlagExecute |
-                             (rom ? 0 : WHvMapGpaRangeFlagWrite)));
+        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
+                                         host_va,
+                                         start_pa,
+                                         size,
+                                         (WHvMapGpaRangeFlagRead |
+                                          WHvMapGpaRangeFlagExecute |
+                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
     } else {
-        hr = WHvUnmapGpaRange(whpx->partition,
-                              start_pa,
-                              size);
+        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
+                                           start_pa,
+                                           size);
     }
 
     if (FAILED(hr)) {
@@ -1292,18 +1310,24 @@ static int whpx_accel_init(MachineState *ms)
 
     whpx = &whpx_global;
 
+    if (!init_whp_dispatch()) {
+        ret = -ENOSYS;
+        goto error;
+    }
+
     memset(whpx, 0, sizeof(struct whpx_state));
     whpx->mem_quota = ms->ram_size;
 
-    hr = WHvGetCapability(WHvCapabilityCodeHypervisorPresent, &whpx_cap,
-                          sizeof(whpx_cap), &whpx_cap_size);
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeHypervisorPresent, &whpx_cap,
+        sizeof(whpx_cap), &whpx_cap_size);
     if (FAILED(hr) || !whpx_cap.HypervisorPresent) {
         error_report("WHPX: No accelerator found, hr=%08lx", hr);
         ret = -ENOSPC;
         goto error;
     }
 
-    hr = WHvCreatePartition(&whpx->partition);
+    hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create partition, hr=%08lx", hr);
         ret = -EINVAL;
@@ -1312,10 +1336,11 @@ static int whpx_accel_init(MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ProcessorCount = smp_cpus;
-    hr = WHvSetPartitionProperty(whpx->partition,
-                                 WHvPartitionPropertyCodeProcessorCount,
-                                 &prop,
-                                 sizeof(WHV_PARTITION_PROPERTY));
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeProcessorCount,
+        &prop,
+        sizeof(WHV_PARTITION_PROPERTY));
 
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set partition core count to %d,"
@@ -1326,10 +1351,11 @@ static int whpx_accel_init(MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64CpuidExit = 1;
-    hr = WHvSetPartitionProperty(whpx->partition,
-                                 WHvPartitionPropertyCodeExtendedVmExits,
-                                 &prop,
-                                 sizeof(WHV_PARTITION_PROPERTY));
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeExtendedVmExits,
+        &prop,
+        sizeof(WHV_PARTITION_PROPERTY));
 
     if (FAILED(hr)) {
         error_report("WHPX: Failed to enable partition extended X64CpuidExit"
@@ -1339,11 +1365,11 @@ static int whpx_accel_init(MachineState *ms)
     }
 
     UINT32 cpuidExitList[] = {1};
-    hr = WHvSetPartitionProperty(whpx->partition,
-                                 WHvPartitionPropertyCodeCpuidExitList,
-                                 cpuidExitList,
-                                 RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
-
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeCpuidExitList,
+        cpuidExitList,
+        RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
                      hr);
@@ -1360,11 +1386,11 @@ static int whpx_accel_init(MachineState *ms)
     cpuidResultList[0].Ebx = signature[0];
     cpuidResultList[0].Ecx = signature[1];
     cpuidResultList[0].Edx = signature[2];
-    hr = WHvSetPartitionProperty(whpx->partition,
-                                 WHvPartitionPropertyCodeCpuidResultList,
-                                 cpuidResultList,
-                                 RTL_NUMBER_OF(cpuidResultList) *
-                                    sizeof(WHV_X64_CPUID_RESULT));
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeCpuidResultList,
+        cpuidResultList,
+        RTL_NUMBER_OF(cpuidResultList) * sizeof(WHV_X64_CPUID_RESULT));
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set partition CpuidResultList hr=%08lx",
                      hr);
@@ -1372,7 +1398,7 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
-    hr = WHvSetupPartition(whpx->partition);
+    hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
         ret = -EINVAL;
@@ -1389,7 +1415,7 @@ static int whpx_accel_init(MachineState *ms)
   error:
 
     if (NULL != whpx->partition) {
-        WHvDeletePartition(whpx->partition);
+        whp_dispatch.WHvDeletePartition(whpx->partition);
         whpx->partition = NULL;
     }
 
@@ -1421,4 +1447,54 @@ static void whpx_type_init(void)
     type_register_static(&whpx_accel_type);
 }
 
+bool init_whp_dispatch(void)
+{
+    const char *lib_name;
+    HMODULE hLib;
+
+    if (whp_dispatch_initialized) {
+        return true;
+    }
+
+    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
+        whp_dispatch.function_name = \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+        if (!whp_dispatch.function_name) { \
+            error_report("Could not load function %s from library %s.", \
+                         #function_name, lib_name); \
+            goto error; \
+        } \
+
+    lib_name = "WinHvPlatform.dll";
+    hWinHvPlatform = LoadLibrary(lib_name);
+    if (!hWinHvPlatform) {
+        error_report("Could not load library %s.", lib_name);
+        goto error;
+    }
+    hLib = hWinHvPlatform;
+    LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
+
+    lib_name = "WinHvEmulation.dll";
+    hWinHvEmulation = LoadLibrary(lib_name);
+    if (!hWinHvEmulation) {
+        error_report("Could not load library %s.", lib_name);
+        goto error;
+    }
+    hLib = hWinHvEmulation;
+    LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+
+    whp_dispatch_initialized = true;
+    return true;
+
+    error:
+
+    if (hWinHvPlatform) {
+        FreeLibrary(hWinHvPlatform);
+    }
+    if (hWinHvEmulation) {
+        FreeLibrary(hWinHvEmulation);
+    }
+    return false;
+}
+
 type_init(whpx_type_init);
-- 
2.7.4
