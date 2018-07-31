Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkQed-00072b-J9
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkQeY-0000ee-KX
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:09:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42482
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkQeY-0000eR-EA
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:09:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6V94iAr120719
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:09:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kjm679r75-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:09:13 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 10:09:12 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 10:09:00 +0100
In-Reply-To: <20180731090900.187430-1-frankja@linux.ibm.com>
References: <20180731090900.187430-1-frankja@linux.ibm.com>
Message-Id: <20180731090900.187430-3-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] s390x: Enable KVM huge page backing
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
 target/s390x/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d923cf4240..26e6937498 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -285,6 +285,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
+    if (mem_path && kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE, 0)) {
+        error_report("Huge page backing was specified, "
+                     "but this KVM does not support huge pages");
+        return -EINVAL;
+    }
+
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
-- 
2.14.3
