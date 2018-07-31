Received: from eggs.gnu.org ([2001:4830:134:3::10]:37592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkQFB-0003PY-N1
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkQF8-0006dQ-Kv
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:43:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkQF8-0006c1-Ax
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:42:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6V8d09i058364
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 04:42:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjhhkq26c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 04:42:55 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 09:42:53 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 09:42:36 +0100
Message-Id: <20180731084236.184728-1-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x: Enable KVM huge page backing support
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

From: Janosch Frank <frankja@linux.vnet.ibm.com>

QEMU has had huge page support for a longer time already, but KVM
memory management under s390x needed some changes to work with huge
backings.

Now that we have support, let's enable it if requested and
available. Otherwise we now properly tell the user if there is no
support and back out instead of failing to run the VM later on.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---

Right now there's a conflict with arm for the capability, so I guess
I'll have to touch the cap number soonish. :)

---
 linux-headers/linux/kvm.h | 1 +
 target/s390x/kvm.c        | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a5a3..e3b1e3070c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d923cf4240..1ce0b42039 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -285,6 +285,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
+    if (mem_path && kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE, 0)) {
+        error_report("Huge page backing was specified, "
+                     "but this KVM does not support huge pages.");
+        return -EINVAL;
+    }
+
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
-- 
2.14.3
