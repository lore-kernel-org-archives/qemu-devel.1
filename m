Received: from eggs.gnu.org ([2001:4830:134:3::10]:44484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1cmDOC-000100-IZ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 00:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1cmDOA-0002RC-02
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 00:46:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:48331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1cmDO9-0002Pn-O0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 00:46:53 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 10 Mar 2017 21:44:35 +0800
Message-Id: <1489153475-14888-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2] memory: reduce heap Rss size around 3M
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
index 284894b..6af80e7 100644
--- a/memory.c
+++ b/memory.c
@@ -2422,7 +2422,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
     AddressSpace *as;
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
+        if (root == as->root) {
             as->ref_count++;
             return as;
         }
-- 
1.9.1
