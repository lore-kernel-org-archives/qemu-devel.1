Received: from eggs.gnu.org ([2001:4830:134:3::10]:49542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1f1GVD-0006Eb-Na
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apilotti@cloudbasesolutions.com>) id 1f1GVC-0004WA-MC
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:12:55 -0400
Received: from smtp1.cloudbase.it ([46.107.15.2]:44659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apilotti@cloudbasesolutions.com>)
	id 1f1GVC-0004Vm-Do
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 15:12:54 -0400
From: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Date: Wed, 28 Mar 2018 22:12:21 +0300
Message-Id: <20180328191221.64777-2-apilotti@cloudbasesolutions.com>
In-Reply-To: <20180328191221.64777-1-apilotti@cloudbasesolutions.com>
References: <20180328191221.64777-1-apilotti@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH 1/1] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, juterry@microsoft.com, Alessandro Pilotti <apilotti@cloudbasesolutions.com>

Adds the CPUID trap for CPUID 0x40000000, sending the WHPX signature
to the guest upon request. This is consistent with other QEMU
accelerators (KVM).

Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
---
 target/i386/whpx-all.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index efa1441479..4085002428 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -29,6 +29,8 @@
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
 
+#define WHPX_CPUID_SIGNATURE 0x40000000
+
 struct whpx_state {
     uint64_t mem_quota;
     WHV_PARTITION_HANDLE partition;
@@ -918,6 +920,7 @@ static int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_NAME reg_names[5];
             UINT32 reg_count = 5;
             UINT64 rip, rax, rcx, rdx, rbx;
+            UINT32 signature[3] = {0};
 
             rip = vcpu->exit_ctx.VpContext.Rip +
                   vcpu->exit_ctx.VpContext.InstructionLength;
@@ -932,6 +935,13 @@ static int whpx_vcpu_run(CPUState *cpu)
                     rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
                     rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
                     break;
+                case WHPX_CPUID_SIGNATURE:
+                    memcpy(signature, "WHPXWHPXWHPX", 12);
+                    rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                    rbx = signature[0];
+                    rcx = signature[1];
+                    rdx = signature[2];
+                    break;
                 default:
                     rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                     rcx = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
@@ -1338,7 +1348,7 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
-    UINT32 cpuidExitList[] = {1};
+    UINT32 cpuidExitList[] = {1, WHPX_CPUID_SIGNATURE};
     hr = WHvSetPartitionProperty(whpx->partition,
                                  WHvPartitionPropertyCodeCpuidExitList,
                                  cpuidExitList,
-- 
2.13.2
