Received: from eggs.gnu.org ([2001:4830:134:3::10]:46389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLw-0007Lk-6t
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLs-0004fL-3L
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:16 -0500
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com
	([104.47.36.111]:45325
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLr-0004es-Rf
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:12 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:34 -0800
Message-Id: <1519665216-1078-7-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 6/8] Fix WHPX issue leaking tpr values
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

Fixes an issue where if the tpr is assigned to the array but not a different
value from what is already expected on the vp the code will skip incrementing
the reg_count. In this case its possible that we set an invalid memory section
of the next call for DeliverabilityNotifications that was not expected.

The fix is to use a local variable to store the temporary tpr and only update
the array if the local tpr value is different than the vp context.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 7e58d5f68c..47a6935288 100644
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
2.13.6
