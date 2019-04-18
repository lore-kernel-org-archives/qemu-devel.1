Received: from eggs.gnu.org ([209.51.188.92]:54515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0U-00056N-4F
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0S-0005Ci-MV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:11 +0200
Message-Id: <20190418205135.6686-13-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 12/36] s390x/kvm: Report warnings with
 warn_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org

kvm_s390_mem_op() can fail in two ways: when !cap_mem_op, it returns
-ENOSYS, and when kvm_vcpu_ioctl() fails, it returns -errno set by
ioctl().  Its caller s390_cpu_virt_mem_rw() recovers from both
failures.

kvm_s390_mem_op() prints "KVM_S390_MEM_OP failed" with error_printf()
in the latter failure mode.  Since this is obviously a warning, use
warn_report().

Perhaps the reporting should be left to the caller.  It could warn on
failure other than -ENOSYS.

Cc: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190417190641.26814-9-armbru@redhat.com>
---
 target/s390x/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 19530fb94e..2c6e35b5aa 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -782,7 +782,7 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
 
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
     if (ret < 0) {
-        error_printf("KVM_S390_MEM_OP failed: %s\n", strerror(-ret));
+        warn_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
     }
     return ret;
 }
-- 
2.17.2
