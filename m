Received: from eggs.gnu.org ([2001:4830:134:3::10]:48380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVu-0005dE-8x
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVk-0006bU-SS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:18 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVk-0006aK-M4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:08 -0500
Received: by mail-wm0-x244.google.com with SMTP id t6so22236132wmt.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:20:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:24 +0100
Message-Id: <1520342370-123606-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/34] Fix WHPX additional lock acquisition
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

The code already is holding the qemu_mutex for the IO thread. We do not need
to additionally take the lock again in this case.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1519665216-1078-5-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
---
 target/i386/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 14ea732..74a8f4d 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -705,9 +705,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             new_int.InterruptionVector = 2;
         }
         if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
-            qemu_mutex_lock_iothread();
             cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
-            qemu_mutex_unlock_iothread();
         }
     }
 
-- 
1.8.3.1
