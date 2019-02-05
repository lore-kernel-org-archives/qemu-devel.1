Received: from eggs.gnu.org ([209.51.188.92]:54592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3mk-00012t-Ln
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3mj-0007vp-Rv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:22 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:01 +0100
Message-Id: <20190205164109.25413-3-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] s390x: remove direct reference to
 mem_path global from s390x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

I plan to deprecate -mem-path option and replace it with memory-backend,
for that it's necessary to get rid of mem_path global variable.
Do it for s390x case, replacing it with alternative way to enable
1Mb hugepages capability.

Todo that replace qemu_mempath_getpagesize() with qemu_getrampagesize()
which also checks for -mem-path provided RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <1548834906-133241-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2ebf26adfe..8613e19d11 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -42,6 +42,7 @@
 #include "hw/hw.h"
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
+#include "exec/ram_addr.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -287,7 +288,7 @@ void kvm_s390_crypto_reset(void)
 
 static int kvm_s390_configure_mempath_backing(KVMState *s)
 {
-    size_t path_psize = qemu_mempath_getpagesize(mem_path);
+    size_t path_psize = qemu_getrampagesize();
 
     if (path_psize == 4 * KiB) {
         return 0;
@@ -319,7 +320,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
+    if (kvm_s390_configure_mempath_backing(s)) {
         return -EINVAL;
     }
 
-- 
2.17.2
