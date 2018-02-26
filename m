Received: from eggs.gnu.org ([2001:4830:134:3::10]:46428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLx-0007NA-S3
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLt-0004g9-QC
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:17 -0500
Received: from mail-sn1nam02on0137.outbound.protection.outlook.com
	([104.47.36.137]:41302
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLt-0004fp-Hw
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:13 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:36 -0800
Message-Id: <1519665216-1078-9-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 8/8] WHPX improve interrupt notification
 registration
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

Improves the usage of the InterruptNotification registration by skipping the
additional call to WHvSetVirtualProcessorRegisters if we have already
registered for the window exit.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 24387bebad..940bbe590d 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -756,12 +756,11 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Update the state of the interrupt delivery notification */
-    if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (!vcpu->window_registered &&
+        cpu->interrupt_request & CPU_INTERRUPT_HARD) {
         reg_values[reg_count].DeliverabilityNotifications.InterruptNotification
             = 1;
-        if (vcpu->window_registered != 1) {
-            vcpu->window_registered = 1;
-        }
+        vcpu->window_registered = 1;
         reg_names[reg_count] = WHvX64RegisterDeliverabilityNotifications;
         reg_count += 1;
     }
-- 
2.13.6
