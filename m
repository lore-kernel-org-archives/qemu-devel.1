Received: from eggs.gnu.org ([2001:4830:134:3::10]:48354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVr-0005aD-6W
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVq-0006gw-6S
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:15 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVo-0006ft-JB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:12 -0500
Received: by mail-wr0-x242.google.com with SMTP id v18so20261543wrv.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:27 +0100
Message-Id: <1520342370-123606-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/34] WHXP Removes the use of
 WHvGetExitContextSize
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

The use of WHvGetExitContextSize will break ABI compatibility if the platform
changes the context size while a qemu compiled executable does not recompile.
To avoid this we now use sizeof and let the platform determine which version
of the struction was passed for ABI compatibility.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-8-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 47a6935..24387be 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -32,7 +32,6 @@
 struct whpx_state {
     uint64_t mem_quota;
     WHV_PARTITION_HANDLE partition;
-    uint32_t exit_ctx_size;
 };
 
 static const WHV_REGISTER_NAME whpx_register_names[] = {
@@ -899,7 +898,7 @@ static int whpx_vcpu_run(CPUState *cpu)
         }
 
         hr = WHvRunVirtualProcessor(whpx->partition, cpu->cpu_index,
-                                    &vcpu->exit_ctx, whpx->exit_ctx_size);
+                                    &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
 
         if (FAILED(hr)) {
             error_report("WHPX: Failed to exec a virtual processor,"
@@ -1042,8 +1041,7 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
 
-    vcpu = g_malloc0(FIELD_OFFSET(struct whpx_vcpu, exit_ctx) +
-                     whpx->exit_ctx_size);
+    vcpu = g_malloc0(sizeof(struct whpx_vcpu));
 
     if (!vcpu) {
         error_report("WHPX: Failed to allocte VCPU context.");
@@ -1300,9 +1298,6 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
-    whpx->exit_ctx_size = WHvGetRunExitContextSize();
-    assert(whpx->exit_ctx_size);
-
     whpx_memory_init();
 
     cpu_interrupt_handler = whpx_handle_interrupt;
-- 
1.8.3.1
