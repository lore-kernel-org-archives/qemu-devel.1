Received: from eggs.gnu.org ([2001:4830:134:3::10]:42587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crLUs-0005aL-Cr
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crLUp-0005St-81
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1crLUp-0005SE-24
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:26:59 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 24 Mar 2017 10:26:55 +0100
Message-Id: <1490347615-19222-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

When running QEMU with KVM under z/VM, the memory for the guest
is allocated via legacy_s390_alloc() since the KVM_CAP_S390_COW
extension is not supported on z/VM. legacy_s390_alloc() then uses
mmap(... PROT_EXEC ...) for the guest memory - but this does not
work when running with SELinux enabled, mmap() fails and QEMU aborts
with the following error message:

 cannot set up guest memory 's390.ram': Permission denied

Looking at the other allocator function qemu_anon_ram_alloc(), it
seems like PROT_EXEC is normally not needed for allocating the
guest RAM, and indeed, the guest also starts successfully under
z/VM when we remove the PROT_EXEC from the legacy_s390_alloc()
function. So let's get rid of that flag here to be able to run
with SELinux under z/VM, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ac47154..5167436 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -678,8 +678,7 @@ static void *legacy_s390_alloc(size_t size, uint64_t *align)
 {
     void *mem;
 
-    mem = mmap((void *) 0x800000000ULL, size,
-               PROT_EXEC|PROT_READ|PROT_WRITE,
+    mem = mmap((void *) 0x800000000ULL, size, PROT_READ | PROT_WRITE,
                MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
     return mem == MAP_FAILED ? NULL : mem;
 }
-- 
1.8.3.1
