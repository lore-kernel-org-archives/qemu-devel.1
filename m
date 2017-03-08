Received: from eggs.gnu.org ([2001:4830:134:3::10]:40835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1clVmm-0008As-0x
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1clVmi-0000ZE-Uf
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:13:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:6123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1clVmi-0000Xg-NE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:13:20 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed,  8 Mar 2017 23:11:12 +0800
Message-Id: <1488985872-22447-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH] memory: reduce heap Rss size around 3M
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
 memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 284894b..799ca4c 100644
--- a/memory.c
+++ b/memory.c
@@ -2422,8 +2422,10 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
     AddressSpace *as;
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
-            as->ref_count++;
+        if (root == as->root) {
+            if (as->malloced) {
+                as->ref_count++;
+            }
             return as;
         }
     }
-- 
1.9.1
