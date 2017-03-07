Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1clFxU-0001jK-OM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1clFxR-0000h8-KY
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:19:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1clFxR-0000gq-B7
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:19:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v27EJGxc070298
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 09:19:19 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 291w4wcu69-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 09:19:18 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 7 Mar 2017 14:19:13 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  7 Mar 2017 15:19:08 +0100
Message-Id: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC] exec: add cpu_synchronize_state to
 cpu_memory_rw_debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

I sometimes got "Cannot access memory" when using the x command
on the monitor. Turns out that the cpu env did contain stale data
(e.g. wrong control register content for page table origin).
We must synchronize the state of the CPU before walking the page
tables. A similar issues happens for a remote gdb, so lets
do the cpu_synchronize_state in cpu_memory_rw_debug.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/exec.c b/exec.c
index aabb035..e754a03 100644
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
2.7.4
