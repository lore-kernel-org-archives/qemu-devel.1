Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLw-0007Li-5i
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLs-0004fV-EW
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:16 -0500
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com
	([104.47.36.111]:45325
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLs-0004es-7o
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:12 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:35 -0800
Message-Id: <1519665216-1078-8-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 7/8] WHXP Removes the use of
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

The use of WHvGetExitContextSize will break ABI compatibility if the platform
changes the context size while a qemu compiled executable does not recompile.
To avoid this we now use sizeof and let the platform determine which version
of the struction was passed for ABI compatibility.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 47a6935288..24387bebad 100644
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
2.13.6
