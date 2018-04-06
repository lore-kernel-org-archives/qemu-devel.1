Received: from eggs.gnu.org ([2001:4830:134:3::10]:36179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uti-0007mx-Pn
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uth-0007Vl-GE
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:34 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Uth-0007SI-5i
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:33 -0400
Received: by mail-wm0-x243.google.com with SMTP id w2so8774618wmw.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:06 +0200
Message-Id: <1523034681-33787-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/20] target/i386: WHPX: set
 CPUID_EXT_HYPERVISOR bit
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

From: "Justin Terry (VM)" <juterry@microsoft.com>

Implements the CPUID trap for CPUID 1 to include the
CPUID_EXT_HYPERVISOR flag in the ECX results. This was preventing some
older linux kernels from booting when trying to access MSR's that dont
make sense when virtualized.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <20180326170658.606-1-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index bf33d32..5843517 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -911,12 +911,62 @@ static int whpx_vcpu_run(CPUState *cpu)
             ret = 1;
             break;
 
+        case WHvRunVpExitReasonX64Cpuid: {
+            WHV_REGISTER_VALUE reg_values[5] = {0};
+            WHV_REGISTER_NAME reg_names[5];
+            UINT32 reg_count = 5;
+            UINT64 rip, rax, rcx, rdx, rbx;
+
+            rip = vcpu->exit_ctx.VpContext.Rip +
+                  vcpu->exit_ctx.VpContext.InstructionLength;
+            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+            case 1:
+                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                /* Advertise that we are running on a hypervisor */
+                rcx =
+                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
+                    CPUID_EXT_HYPERVISOR;
+
+                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                break;
+            default:
+                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                rcx = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+            }
+
+            reg_names[0] = WHvX64RegisterRip;
+            reg_names[1] = WHvX64RegisterRax;
+            reg_names[2] = WHvX64RegisterRcx;
+            reg_names[3] = WHvX64RegisterRdx;
+            reg_names[4] = WHvX64RegisterRbx;
+
+            reg_values[0].Reg64 = rip;
+            reg_values[1].Reg64 = rax;
+            reg_values[2].Reg64 = rcx;
+            reg_values[3].Reg64 = rdx;
+            reg_values[4].Reg64 = rbx;
+
+            hr = WHvSetVirtualProcessorRegisters(whpx->partition,
+                                                 cpu->cpu_index,
+                                                 reg_names,
+                                                 reg_count,
+                                                 reg_values);
+
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to set CpuidAccess state registers,"
+                             " hr=%08lx", hr);
+            }
+            ret = 0;
+            break;
+        }
         case WHvRunVpExitReasonNone:
         case WHvRunVpExitReasonUnrecoverableException:
         case WHvRunVpExitReasonInvalidVpRegisterValue:
         case WHvRunVpExitReasonUnsupportedFeature:
         case WHvRunVpExitReasonX64MsrAccess:
-        case WHvRunVpExitReasonX64Cpuid:
         case WHvRunVpExitReasonException:
         default:
             error_report("WHPX: Unexpected VP exit code %d",
@@ -1272,6 +1322,33 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.ExtendedVmExits.X64CpuidExit = 1;
+    hr = WHvSetPartitionProperty(whpx->partition,
+                                 WHvPartitionPropertyCodeExtendedVmExits,
+                                 &prop,
+                                 sizeof(WHV_PARTITION_PROPERTY));
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable partition extended X64CpuidExit"
+                     " hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    UINT32 cpuidExitList[] = {1};
+    hr = WHvSetPartitionProperty(whpx->partition,
+                                 WHvPartitionPropertyCodeCpuidExitList,
+                                 cpuidExitList,
+                                 RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
+                     hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     hr = WHvSetupPartition(whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
-- 
1.8.3.1
