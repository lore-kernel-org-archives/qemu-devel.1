Received: from eggs.gnu.org ([2001:4830:134:3::10]:46369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLu-0007KA-Fs
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1eqMLq-0004eT-CQ
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:14 -0500
Received: from mail-sn1nam02on0130.outbound.protection.outlook.com
	([104.47.36.130]:17056
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1eqMLq-0004eC-3k
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:14:10 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 26 Feb 2018 09:13:32 -0800
Message-Id: <1519665216-1078-5-git-send-email-juterry@microsoft.com>
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/8] Fix WHPX additional lock acquisition
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

The code already is holding the qemu_mutex for the IO thread. We do not need
to additionally take the lock again in this case.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 14ea732ec6..74a8f4d599 100644
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
2.13.6
