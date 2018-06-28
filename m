Received: from eggs.gnu.org ([2001:4830:134:3::10]:38301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAx-0007b4-FF
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAw-0000wj-Az
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:55 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAw-0000vZ-2e
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:54 -0400
Received: by mail-wr0-x242.google.com with SMTP id u7-v6so6680561wrn.12
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:50 +0200
Message-Id: <1530216310-52873-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/60] WHPX workaround bug in OSVW handling
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

Adds a workaround to an incorrect value setting
CPUID Fn8000_0001_ECX[bit 9 OSVW] = 1. This can cause a guest linux kernel
to panic when an issue to rdmsr C001_0140h returns 0. Disabling this feature
correctly allows the guest to boot without accessing the osv workarounds.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <20180605221500.21674-1-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 6b42096..99501ba 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -964,6 +964,16 @@ static int whpx_vcpu_run(CPUState *cpu)
                 rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
                 rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
                 break;
+            case 0x80000001:
+                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                /* Remove any support of OSVW */
+                rcx =
+                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
+                    ~CPUID_EXT3_OSVW;
+
+                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                break;
             default:
                 rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                 rcx = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
@@ -1382,12 +1392,13 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
-    UINT32 cpuidExitList[] = {1};
+    UINT32 cpuidExitList[] = {1, 0x80000001};
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
         cpuidExitList,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
                      hr);
-- 
1.8.3.1
