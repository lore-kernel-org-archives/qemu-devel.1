Received: from eggs.gnu.org ([2001:4830:134:3::10]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVx-0005su-Aw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVr-0006hq-7G
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:21 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVq-0006gi-KT
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:14 -0500
Received: by mail-wm0-x244.google.com with SMTP id w128so22837638wmw.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:28 +0100
Message-Id: <1520342370-123606-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 32/34] WHPX improve interrupt notification
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
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM) via Qemu-devel" <qemu-devel@nongnu.org>

Improves the usage of the InterruptNotification registration by skipping the
additional call to WHvSetVirtualProcessorRegisters if we have already
registered for the window exit.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-9-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 24387be..940bbe5 100644
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
1.8.3.1
