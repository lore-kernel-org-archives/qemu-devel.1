Received: from eggs.gnu.org ([2001:4830:134:3::10]:41980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1er7nB-00028U-FS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1er7n6-0002I9-JS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:53:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1er7n6-0002Hi-A6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:53:28 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1SJrOlW012158
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:53:26 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gdx7ensvd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:53:26 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 28 Feb 2018 19:53:24 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Feb 2018 19:53:20 +0000
Message-Id: <20180228195320.165230-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of IPL
 clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

When a guests reboots with diagnose 308 subcode 3 it requests the memory
to be cleared. We did not do it so far. This does not only violate the
architecture, it also misses the chance to free up that memory on
reboot, which would help on host memory over commitment.  By using
ram_block_discard_range we can cover both cases.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/kvm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8f3a422288..2e145ad5c3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -34,6 +34,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qemu/rcu_queue.h"
+#include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "hw/boards.h"
@@ -41,6 +43,7 @@
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
+#include "exec/ram_addr.h"
 #include "trace.h"
 #include "qapi-event.h"
 #include "hw/s390x/s390-pci-inst.h"
@@ -1841,6 +1844,14 @@ static int kvm_arch_handle_debug_exit(S390CPU *cpu)
     return ret;
 }
 
+static void release_all_rams(void)
+{
+    struct RAMBlock *rb;
+
+    QLIST_FOREACH_RCU(rb, &ram_list.blocks, next)
+        ram_block_discard_range(rb, 0, rb->used_length);
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -1853,6 +1864,14 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = handle_intercept(cpu);
             break;
         case KVM_EXIT_S390_RESET:
+            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
+                /*
+                 * We will stop other CPUs anyway, avoid spurious crashes and
+                 * get all CPUs out. The reset will take care of the resume.
+                 */
+                pause_all_vcpus();
+                release_all_rams();
+            }
             s390_reipl_request();
             break;
         case KVM_EXIT_S390_TSCH:
-- 
2.14.3
