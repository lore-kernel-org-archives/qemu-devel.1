Received: from eggs.gnu.org ([2001:4830:134:3::10]:39819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkr2K-0003cC-9D
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkr2H-0001RP-3N
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkr2G-0001P7-Ph
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w71DIqt8110502
	for <qemu-devel@nongnu.org>; Wed, 1 Aug 2018 09:19:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kkbm3dgad-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 09:19:19 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Wed, 1 Aug 2018 14:19:17 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed,  1 Aug 2018 14:19:05 +0100
In-Reply-To: <20180801131905.148778-1-frankja@linux.ibm.com>
References: <20180801131905.148778-1-frankja@linux.ibm.com>
Message-Id: <20180801131905.148778-3-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 2/2] s390x: Enable KVM huge page backing
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
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org

QEMU has had huge page support for a longer time already, but KVM
memory management under s390x needed some changes to work with huge
backings.

Now that we have support, let's enable it if requested and
available. Otherwise we now properly tell the user if there is no
support and back out instead of failing to run the VM later on.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/kvm.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d923cf4240..d1c72975cf 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -34,6 +34,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qemu/units.h"
+#include "qemu/mmap-alloc.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "hw/hw.h"
@@ -139,6 +141,7 @@ static int cap_mem_op;
 static int cap_s390_irq;
 static int cap_ri;
 static int cap_gs;
+static int cap_hpage_1m;
 
 static int active_cmma;
 
@@ -220,9 +223,9 @@ static void kvm_s390_enable_cmma(void)
         .attr = KVM_S390_VM_MEM_ENABLE_CMMA,
     };
 
-    if (mem_path) {
+    if (cap_hpage_1m) {
         warn_report("CMM will not be enabled because it is not "
-                    "compatible with hugetlbfs.");
+                    "compatible with huge memory backings.");
         return;
     }
     rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
@@ -281,10 +284,37 @@ void kvm_s390_crypto_reset(void)
     }
 }
 
+static int kvm_s390_configure_mempath_backing(KVMState *s)
+{
+    size_t path_psize = qemu_mempath_getpagesize(mem_path);
+
+    if (path_psize == 4 * KiB)
+        return 0;
+
+    if (path_psize != 1 * MiB) {
+        error_report("Memory backing with 2G pages was specified, "
+                     "but KVM does not support this memory backing");
+        return -EINVAL;
+    }
+
+    if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
+        error_report("Memory backing with 1M pages was specified, "
+                     "but KVM does not support this memory backing");
+        return -EINVAL;
+    }
+
+    cap_hpage_1m = 1;
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
+    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
+        return -EINVAL;
+    }
+
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
-- 
2.14.3
