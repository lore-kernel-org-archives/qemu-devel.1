Received: from eggs.gnu.org ([2001:4830:134:3::10]:36592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9a-0003PP-V4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9a-0006Yf-4n
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:30 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9Z-0006Xw-UJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:30 -0400
Received: by mail-wm0-x243.google.com with SMTP id u132so610113wmg.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:06 +0100
Message-Id: <1489508300-48184-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/18] exec: add cpu_synchronize_state to
 cpu_memory_rw_debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

I sometimes got "Cannot access memory" when using the x command
on the monitor. Turns out that the cpu env did contain stale data
(e.g. wrong control register content for page table origin).
We must synchronize the state of the CPU before walking the page
tables. A similar issues happens for a remote gdb, so lets
do the cpu_synchronize_state in cpu_memory_rw_debug.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/exec.c b/exec.c
index 68135a9..a22f5a0 100644
--- a/exec.c
+++ b/exec.c
@@ -43,6 +43,7 @@
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
 #include "sysemu/numa.h"
+#include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace-root.h"
@@ -3309,6 +3310,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
     hwaddr phys_addr;
     target_ulong page;
 
+    cpu_synchronize_state(cpu);
     while (len > 0) {
         int asidx;
         MemTxAttrs attrs;
-- 
1.8.3.1
