Received: from eggs.gnu.org ([2001:4830:134:3::10]:53415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNR-0007If-Cn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNO-0006oI-Ii
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:58242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fYoNO-0006kl-9o
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:30 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 29 Jun 2018 11:03:19 +0300
Message-Id: <20180629080320.320144-7-dplotnikov@virtuozzo.com>
In-Reply-To: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 6/7] kvm: add vCPU failed memeory access
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Is done with support of the KVM patch returning the faulting address.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 target/i386/kvm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3ac5302bc5..b87881a8f1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -45,6 +45,8 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "migration/blocker.h"
+#include "migration/savevm.h"
+#include "migration/ram.h"
 #include "exec/memattrs.h"
 #include "trace.h"
 
@@ -3130,6 +3132,18 @@ static bool host_supports_vmx(void)
     return ecx & CPUID_EXT_VMX;
 }
 
+static int kvm_handle_fail_mem_access(CPUState *cpu)
+{
+    struct kvm_run *run = cpu->kvm_run;
+    int ret = ram_process_page_fault((void*)run->fail_mem_access.hva);
+
+    if (ret >= 0) {
+        cpu_resume(cpu);
+    }
+
+    return ret;
+}
+
 #define VMX_INVALID_GUEST_STATE 0x80000021
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
@@ -3188,6 +3202,10 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ioapic_eoi_broadcast(run->eoi.vector);
         ret = 0;
         break;
+    case KVM_EXIT_FAIL_MEM_ACCESS:
+        ret = kvm_handle_fail_mem_access(cs);
+        //ret = -1; -- to prevent further execution ret = 0; -- to continue without errors
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
-- 
2.17.0
