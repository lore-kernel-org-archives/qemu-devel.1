Received: from eggs.gnu.org ([2001:4830:134:3::10]:38317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAy-0007ce-7m
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAx-0000y1-7v
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:56 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAx-0000wu-0S
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:55 -0400
Received: by mail-wr0-x242.google.com with SMTP id c5-v6so6682014wrs.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:51 +0200
Message-Id: <1530216310-52873-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/60] WHPX: register for unrecognized MSR exits
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

Some variations of Linux kernels end up accessing MSR's that the Windows
Hypervisor doesn't implement which causes a GP to be returned to the guest.
This fix registers QEMU for unimplemented MSR access and globally returns 0 on
reads and ignores writes. This behavior is allows the Linux kernel to probe the
MSR with a write/read/check sequence it does often without failing the access.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <20180605221500.21674-2-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 99501ba..57e53e1 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -932,6 +932,7 @@ static int whpx_vcpu_run(CPUState *cpu)
 
         case WHvRunVpExitReasonX64InterruptWindow:
             vcpu->window_registered = 0;
+            ret = 0;
             break;
 
         case WHvRunVpExitReasonX64Halt:
@@ -943,6 +944,40 @@ static int whpx_vcpu_run(CPUState *cpu)
             ret = 1;
             break;
 
+        case WHvRunVpExitReasonX64MsrAccess: {
+            WHV_REGISTER_VALUE reg_values[3] = {0};
+            WHV_REGISTER_NAME reg_names[3];
+            UINT32 reg_count;
+
+            reg_names[0] = WHvX64RegisterRip;
+            reg_names[1] = WHvX64RegisterRax;
+            reg_names[2] = WHvX64RegisterRdx;
+
+            reg_values[0].Reg64 =
+                vcpu->exit_ctx.VpContext.Rip +
+                vcpu->exit_ctx.VpContext.InstructionLength;
+
+            /*
+             * For all unsupported MSR access we:
+             *     ignore writes
+             *     return 0 on read.
+             */
+            reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
+                        1 : 3;
+
+            hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+                whpx->partition,
+                cpu->cpu_index,
+                reg_names, reg_count,
+                reg_values);
+
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to set MsrAccess state "
+                             " registers, hr=%08lx", hr);
+            }
+            ret = 0;
+            break;
+        }
         case WHvRunVpExitReasonX64Cpuid: {
             WHV_REGISTER_VALUE reg_values[5];
             WHV_REGISTER_NAME reg_names[5];
@@ -1010,7 +1045,6 @@ static int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonUnrecoverableException:
         case WHvRunVpExitReasonInvalidVpRegisterValue:
         case WHvRunVpExitReasonUnsupportedFeature:
-        case WHvRunVpExitReasonX64MsrAccess:
         case WHvRunVpExitReasonException:
         default:
             error_report("WHPX: Unexpected VP exit code %d",
@@ -1378,6 +1412,7 @@ static int whpx_accel_init(MachineState *ms)
     }
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.X64CpuidExit = 1;
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
@@ -1386,8 +1421,8 @@ static int whpx_accel_init(MachineState *ms)
         sizeof(WHV_PARTITION_PROPERTY));
 
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to enable partition extended X64CpuidExit"
-                     " hr=%08lx", hr);
+        error_report("WHPX: Failed to enable partition extended X64MsrExit and"
+                     " X64CpuidExit hr=%08lx", hr);
         ret = -EINVAL;
         goto error;
     }
-- 
1.8.3.1
