Received: from eggs.gnu.org ([2001:4830:134:3::10]:46354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLt-0007JU-IM
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLp-0004e8-Dv
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:13 -0500
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com
	([104.47.36.132]:37730
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLp-0004dW-6J
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:09 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:31 -0800
Message-Id: <1519665216-1078-4-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/8] Remove unnecessary WHPX __debugbreak();
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Minor code cleanup. The calls to __debugbreak() are not required and should
no longer be used to prevent unnecessary breaks.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 969c2f5f93..14ea732ec6 100644
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
2.13.6
