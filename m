Received: from eggs.gnu.org ([2001:4830:134:3::10]:58752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8k-0003s2-04
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8h-0000Nw-SW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41036 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8h-0000NG-MC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:27 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:34 +0200
Message-Id: <20180531171253.21012-35-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/53] WHPX: dynamically load WHP libraries
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
Message-Id: <1526405722-10887-2-git-send-email-lpetrut@cloudbasesolutions.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure              |  15 +--
 target/i386/whpx-all.c | 212 ++++++++++++++++++++++++++++-------------
 2 files changed, 145 insertions(+), 82 deletions(-)

diff --git a/configure b/configure
index a8498ab393..99b4a287dd 100755
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
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index bd7df10ba5..32695d47f9 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -24,6 +24,7 @@
 #include "qemu/queue.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "whp-dispatch.h"
 
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
@@ -159,8 +160,11 @@ struct whpx_vcpu {
 };
 
 static bool whpx_allowed;
+static bool whp_dispatch_initialized;
+static HMODULE hWinHvPlatform, hWinHvEmulation;
 
 struct whpx_state whpx_global;
+struct WHPDispatch whp_dispatch;
 
 
 /*
@@ -354,10 +358,11 @@ static void whpx_set_registers(CPUState *cpu)
 
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
@@ -381,10 +386,11 @@ static void whpx_get_registers(CPUState *cpu)
 
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
@@ -544,9 +550,10 @@ static HRESULT CALLBACK whpx_emu_getreg_callback(
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
@@ -565,9 +572,10 @@ static HRESULT CALLBACK whpx_emu_setreg_callback(
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
@@ -594,8 +602,8 @@ static HRESULT CALLBACK whpx_emu_translate_callback(
     CPUState *cpu = (CPUState *)ctx;
     WHV_TRANSLATE_GVA_RESULT res;
 
-    hr = WHvTranslateGva(whpx->partition, cpu->cpu_index,
-                         Gva, TranslateFlags, &res, Gpa);
+    hr = whp_dispatch.WHvTranslateGva(whpx->partition, cpu->cpu_index,
+                                      Gva, TranslateFlags, &res, Gpa);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to translate GVA, hr=%08lx", hr);
     } else {
@@ -620,16 +628,18 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
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
 
@@ -643,16 +653,18 @@ static int whpx_handle_portio(CPUState *cpu,
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
 
@@ -767,8 +779,9 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
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
@@ -876,8 +889,9 @@ static int whpx_vcpu_run(CPUState *cpu)
             whpx_vcpu_kick(cpu);
         }
 
-        hr = WHvRunVirtualProcessor(whpx->partition, cpu->cpu_index,
-                                    &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
+        hr = whp_dispatch.WHvRunVirtualProcessor(
+            whpx->partition, cpu->cpu_index,
+            &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
 
         if (FAILED(hr)) {
             error_report("WHPX: Failed to exec a virtual processor,"
@@ -948,11 +962,11 @@ static int whpx_vcpu_run(CPUState *cpu)
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
@@ -1064,8 +1078,8 @@ int whpx_init_vcpu(CPUState *cpu)
         (void)migrate_add_blocker(whpx_migration_blocker, &local_error);
         if (local_error) {
             error_report_err(local_error);
-            error_free(whpx_migration_blocker);
             migrate_del_blocker(whpx_migration_blocker);
+            error_free(whpx_migration_blocker);
             return -EINVAL;
         }
     }
@@ -1077,7 +1091,9 @@ int whpx_init_vcpu(CPUState *cpu)
         return -ENOMEM;
     }
 
-    hr = WHvEmulatorCreateEmulator(&whpx_emu_callbacks, &vcpu->emulator);
+    hr = whp_dispatch.WHvEmulatorCreateEmulator(
+        &whpx_emu_callbacks,
+        &vcpu->emulator);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup instruction completion support,"
                      " hr=%08lx", hr);
@@ -1085,11 +1101,12 @@ int whpx_init_vcpu(CPUState *cpu)
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
@@ -1130,8 +1147,8 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
 
-    WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-    WHvEmulatorDestroyEmulator(vcpu->emulator);
+    whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
     g_free(cpu->hax_vcpu);
     return;
 }
@@ -1139,7 +1156,8 @@ void whpx_destroy_vcpu(CPUState *cpu)
 void whpx_vcpu_kick(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
-    WHvCancelRunVirtualProcessor(whpx->partition, cpu->cpu_index, 0);
+    whp_dispatch.WHvCancelRunVirtualProcessor(
+        whpx->partition, cpu->cpu_index, 0);
 }
 
 /*
@@ -1165,17 +1183,17 @@ static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
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
@@ -1289,18 +1307,24 @@ static int whpx_accel_init(MachineState *ms)
 
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
@@ -1309,10 +1333,11 @@ static int whpx_accel_init(MachineState *ms)
 
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
@@ -1323,10 +1348,11 @@ static int whpx_accel_init(MachineState *ms)
 
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
@@ -1336,11 +1362,11 @@ static int whpx_accel_init(MachineState *ms)
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
@@ -1348,7 +1374,7 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
-    hr = WHvSetupPartition(whpx->partition);
+    hr = whp_dispatch.WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
         ret = -EINVAL;
@@ -1365,7 +1391,7 @@ static int whpx_accel_init(MachineState *ms)
   error:
 
     if (NULL != whpx->partition) {
-        WHvDeletePartition(whpx->partition);
+        whp_dispatch.WHvDeletePartition(whpx->partition);
         whpx->partition = NULL;
     }
 
@@ -1397,4 +1423,54 @@ static void whpx_type_init(void)
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
2.17.0
