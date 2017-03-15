Received: from eggs.gnu.org ([2001:4830:134:3::10]:53943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1co1hC-0000dU-8v
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1co1h9-0001RS-63
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:42:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:2593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1co1h8-0001Oz-Rx
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:41:59 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 15 Mar 2017 21:39:48 +0800
Message-Id: <1489585188-14504-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v3] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Since cpu-memory and memory have same address space,one malloced
memory is enough. This patch will skip memory malloc for memory
address space,which will reduce around 3M physical memory in heap.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 64b0a60..0003b1e 100644
--- a/memory.c
+++ b/memory.c
@@ -2422,7 +2422,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
     AddressSpace *as;
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
+        if (root == as->root && as == &address_space_memory) {
             as->ref_count++;
             return as;
         }
-- 
1.9.1
