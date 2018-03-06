Received: from eggs.gnu.org ([2001:4830:134:3::10]:48297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVl-0005RV-32
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVi-0006Xy-Cf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:09 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVi-0006XO-5s
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:06 -0500
Received: by mail-wm0-x244.google.com with SMTP id t6so22235844wmt.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:22 +0100
Message-Id: <1520342370-123606-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/34] Resolves WHPX breaking changes in SDK
 17095
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM) via Qemu-devel" <qemu-devel@nongnu.org>

1. Fixes the changes required to the WHvTryMmioEmulation, WHvTryIoEmulation, and
WHvEmulatorCreateEmulator based on the new VpContext forwarding.
2. Removes the WHvRunVpExitReasonAlerted case.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-3-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index eeee43e..969c2f5 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -613,6 +613,7 @@ static HRESULT CALLBACK whpx_emu_translate_callback(
 }
 
 static const WHV_EMULATOR_CALLBACKS whpx_emu_callbacks = {
+    .Size = sizeof(WHV_EMULATOR_CALLBACKS),
     .WHvEmulatorIoPortCallback = whpx_emu_ioport_callback,
     .WHvEmulatorMemoryCallback = whpx_emu_memio_callback,
     .WHvEmulatorGetVirtualProcessorRegisters = whpx_emu_getreg_callback,
@@ -626,7 +627,9 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
     WHV_EMULATOR_STATUS emu_status;
 
-    hr = WHvEmulatorTryMmioEmulation(vcpu->emulator, cpu, ctx, &emu_status);
+    hr = WHvEmulatorTryMmioEmulation(vcpu->emulator, cpu,
+                                     &vcpu->exit_ctx.VpContext, ctx,
+                                     &emu_status);
     if (FAILED(hr)) {
         __debugbreak();
         error_report("WHPX: Failed to parse MMIO access, hr=%08lx", hr);
@@ -649,7 +652,9 @@ static int whpx_handle_portio(CPUState *cpu,
     struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
     WHV_EMULATOR_STATUS emu_status;
 
-    hr = WHvEmulatorTryIoEmulation(vcpu->emulator, cpu, ctx, &emu_status);
+    hr = WHvEmulatorTryIoEmulation(vcpu->emulator, cpu,
+                                   &vcpu->exit_ctx.VpContext, ctx,
+                                   &emu_status);
     if (FAILED(hr)) {
         __debugbreak();
         error_report("WHPX: Failed to parse PortIO access, hr=%08lx", hr);
@@ -905,18 +910,8 @@ static int whpx_vcpu_run(CPUState *cpu)
             whpx_vcpu_kick(cpu);
         }
 
-        for (;;) {
-            hr = WHvRunVirtualProcessor(whpx->partition, cpu->cpu_index,
-                                        &vcpu->exit_ctx, whpx->exit_ctx_size);
-
-            if (SUCCEEDED(hr) && (vcpu->exit_ctx.ExitReason ==
-                                  WHvRunVpExitReasonAlerted)) {
-                WHvCancelRunVirtualProcessor(whpx->partition, cpu->cpu_index,
-                                             0);
-            } else {
-                break;
-            }
-        }
+        hr = WHvRunVirtualProcessor(whpx->partition, cpu->cpu_index,
+                                    &vcpu->exit_ctx, whpx->exit_ctx_size);
 
         if (FAILED(hr)) {
             error_report("WHPX: Failed to exec a virtual processor,"
@@ -956,7 +951,6 @@ static int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonX64MsrAccess:
         case WHvRunVpExitReasonX64Cpuid:
         case WHvRunVpExitReasonException:
-        case WHvRunVpExitReasonAlerted:
         default:
             error_report("WHPX: Unexpected VP exit code %d",
                          vcpu->exit_ctx.ExitReason);
@@ -1068,7 +1062,7 @@ int whpx_init_vcpu(CPUState *cpu)
         return -ENOMEM;
     }
 
-    hr = WHvEmulatorCreateEmulator(whpx_emu_callbacks, &vcpu->emulator);
+    hr = WHvEmulatorCreateEmulator(&whpx_emu_callbacks, &vcpu->emulator);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup instruction completion support,"
                      " hr=%08lx", hr);
-- 
1.8.3.1
