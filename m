Received: from eggs.gnu.org ([2001:4830:134:3::10]:48366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVr-0005aw-U7
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVn-0006fl-Pf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:15 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVn-0006ew-IB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:11 -0500
Received: by mail-wm0-x244.google.com with SMTP id w128so22837323wmw.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:26 +0100
Message-Id: <1520342370-123606-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/34] Fix WHPX issue leaking tpr values
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

Fixes an issue where if the tpr is assigned to the array but not a different
value from what is already expected on the vp the code will skip incrementing
the reg_count. In this case its possible that we set an invalid memory section
of the next call for DeliverabilityNotifications that was not expected.

The fix is to use a local variable to store the temporary tpr and only update
the array if the local tpr value is different than the vp context.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-7-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 7e58d5f..47a6935 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -687,6 +687,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
     X86CPU *x86_cpu = X86_CPU(cpu);
     int irq;
+    uint8_t tpr;
     WHV_X64_PENDING_INTERRUPTION_REGISTER new_int = {0};
     UINT32 reg_count = 0;
     WHV_REGISTER_VALUE reg_values[3] = {0};
@@ -746,9 +747,10 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
-    reg_values[reg_count].Reg64 = cpu_get_apic_tpr(x86_cpu->apic_state);
-    if (reg_values[reg_count].Reg64 != vcpu->tpr) {
-        vcpu->tpr = reg_values[reg_count].Reg64;
+    tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
+    if (tpr != vcpu->tpr) {
+        vcpu->tpr = tpr;
+        reg_values[reg_count].Reg64 = tpr;
         cpu->exit_request = 1;
         reg_names[reg_count] = WHvX64RegisterCr8;
         reg_count += 1;
-- 
1.8.3.1
