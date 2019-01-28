Received: from eggs.gnu.org ([209.51.188.92]:48792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go6GZ-0006nq-Cf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go6GX-0002rv-O1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:43:55 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 28 Jan 2019 13:31:39 +0100
Message-Id: <1548678699-15717-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2] s390x: remove direct reference to mem_path
 global form s390x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com

I plan to deprecate -mem-path option and replace it with memory-backend,
for that it's necessary to get rid of mem_path global variable.
Do it for s390x case, replacing it with alternative way to enable
1Mb hugepages capability.

Todo that replace qemu_mempath_getpagesize() with qemu_getrampagesize()
which also checks for -mem-path provided RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * s/qemu_mempath_getpagesize/qemu_getrampagesiz/ and drop the rest of changes
          David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2ebf26a..90766fa 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -287,7 +287,7 @@ void kvm_s390_crypto_reset(void)
 
 static int kvm_s390_configure_mempath_backing(KVMState *s)
 {
-    size_t path_psize = qemu_mempath_getpagesize(mem_path);
+    size_t path_psize = qemu_getrampagesize();
 
     if (path_psize == 4 * KiB) {
         return 0;
@@ -319,7 +319,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
+    if (kvm_s390_configure_mempath_backing(s)) {
         return -EINVAL;
     }
 
-- 
2.7.4
