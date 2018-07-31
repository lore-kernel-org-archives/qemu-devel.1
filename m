Received: from eggs.gnu.org ([2001:4830:134:3::10]:46784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkTT4-0005gI-Am
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkTSz-0005VZ-CD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkTSz-0005VC-27
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VC45TI133462
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:09:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjmepyxw4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:09:25 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 13:09:23 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 13:09:08 +0100
In-Reply-To: <20180731120908.9202-1-frankja@linux.ibm.com>
References: <20180731120908.9202-1-frankja@linux.ibm.com>
Message-Id: <20180731120908.9202-3-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com

QEMU has had huge page support for a longer time already, but KVM
memory management under s390x needed some changes to work with huge
backings.

Now that we have support, let's enable it if requested and
available. Otherwise we now properly tell the user if there is no
support and back out instead of failing to run the VM later on.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/kvm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d923cf4240..f961c3b84a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qemu/mmap-alloc.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "hw/hw.h"
@@ -285,6 +286,20 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
+    if (mem_path) {
+        if (qemu_mempath_getpagesize(mem_path) != (1 << 20)) {
+            error_report("Huge page backing with pages > 1M was specified, "
+                         "but KVM does not support this memory backing");
+            return -EINVAL;
+
+        }
+        if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
+            error_report("Huge page backing with 1M pages was specified, "
+                         "but KVM does not support this memory backing");
+            return -EINVAL;
+        }
+    }
+
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
-- 
2.14.3
