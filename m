Received: from eggs.gnu.org ([2001:4830:134:3::10]:55762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5V0N-0005FZ-LK
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5V0H-0007SO-T3
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:30:35 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  9 Apr 2018 13:30:18 +0200
Message-Id: <20180409113019.14568-2-david@redhat.com>
In-Reply-To: <20180409113019.14568-1-david@redhat.com>
References: <20180409113019.14568-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 1/2] s390x/mmu: don't overwrite
 pending exception in mmu translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

If we already triggered another exception, don't overwrite it with a
protection exception.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
