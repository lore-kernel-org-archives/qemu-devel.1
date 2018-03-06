Received: from eggs.gnu.org ([2001:4830:134:3::10]:48305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVl-0005Sj-Sk
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVj-0006Z3-FX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:09 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVj-0006YA-8H
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:07 -0500
Received: by mail-wr0-x241.google.com with SMTP id w77so20920791wrc.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:23 +0100
Message-Id: <1520342370-123606-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/34] Remove unnecessary WHPX __debugbreak();
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

Minor code cleanup. The calls to __debugbreak() are not required and should
no longer be used to prevent unnecessary breaks.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-4-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 969c2f5..14ea732 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -364,7 +364,6 @@ static void whpx_set_registers(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
                      hr);
-        __debugbreak();
     }
 
     return;
@@ -391,7 +390,6 @@ static void whpx_get_registers(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
                      hr);
-        __debugbreak();
     }
 
     /* Indexes for first 16 registers match between HV and QEMU definitions */
@@ -554,7 +552,6 @@ static HRESULT CALLBACK whpx_emu_getreg_callback(
     if (FAILED(hr)) {
         error_report("WHPX: Failed to get virtual processor registers,"
                      " hr=%08lx", hr);
-        __debugbreak();
     }
 
     return hr;
@@ -576,7 +573,6 @@ static HRESULT CALLBACK whpx_emu_setreg_callback(
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set virtual processor registers,"
                      " hr=%08lx", hr);
-        __debugbreak();
     }
 
     /*
@@ -604,7 +600,6 @@ static HRESULT CALLBACK whpx_emu_translate_callback(
                          Gva, TranslateFlags, &res, Gpa);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to translate GVA, hr=%08lx", hr);
-        __debugbreak();
     } else {
         *TranslationResult = res.ResultCode;
     }
@@ -631,13 +626,11 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
                                      &vcpu->exit_ctx.VpContext, ctx,
                                      &emu_status);
     if (FAILED(hr)) {
-        __debugbreak();
         error_report("WHPX: Failed to parse MMIO access, hr=%08lx", hr);
         return -1;
     }
 
     if (!emu_status.EmulationSuccessful) {
-        __debugbreak();
         error_report("WHPX: Failed to emulate MMIO access");
         return -1;
     }
@@ -656,13 +649,11 @@ static int whpx_handle_portio(CPUState *cpu,
                                    &vcpu->exit_ctx.VpContext, ctx,
                                    &emu_status);
     if (FAILED(hr)) {
-        __debugbreak();
         error_report("WHPX: Failed to parse PortIO access, hr=%08lx", hr);
         return -1;
     }
 
     if (!emu_status.EmulationSuccessful) {
-        __debugbreak();
         error_report("WHPX: Failed to emulate PortMMIO access");
         return -1;
     }
@@ -716,7 +707,6 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
             qemu_mutex_lock_iothread();
             cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
-            __debugbreak();
             qemu_mutex_unlock_iothread();
         }
     }
@@ -785,7 +775,6 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         if (FAILED(hr)) {
             error_report("WHPX: Failed to set interrupt state registers,"
                          " hr=%08lx", hr);
-            __debugbreak();
         }
     }
 
@@ -812,7 +801,6 @@ static void whpx_vcpu_post_run(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to get interrupt state regusters,"
                      " hr=%08lx", hr);
-        __debugbreak();
         vcpu->interruptable = false;
         return;
     }
-- 
1.8.3.1
