Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWR-0006Bp-QO
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWQ-0005b7-27
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:32 +0200
Message-Id: <20180409151533.2253-8-cohuck@redhat.com>
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 7/8] s390x/mmu: don't overwrite pending
 exception in mmu translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

If we already triggered another exception, don't overwrite it with a
protection exception.

Only applies to old KVM instances without the virtual memory access
IOCTL in KVM.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180409113019.14568-2-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 1deeb6e6e4..a25deef5dd 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -325,7 +325,7 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
 
     r = mmu_translate_region(env, vaddr, asc, asce, level, raddr, flags, rw,
                              exc);
-    if (rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
+    if (!r && rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE)) {
         trigger_prot_fault(env, vaddr, asc, rw, exc);
         return -1;
     }
-- 
2.14.3
