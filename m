Received: from eggs.gnu.org ([2001:4830:134:3::10]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1cmEo2-0006aw-Av
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1cmEnz-0004KT-7O
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:17:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:50058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1cmEny-0004IN-UB
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:17:39 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 10 Mar 2017 23:14:57 +0800
Message-Id: <1489158897-9206-2-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, chao.p.peng@intel.com, Yang Zhong <yang.zhong@intel.com>

There is no need to delete subregion and do memory begin/commit for
subpage in memory_region_finalize().

This patch is from Anthony Xu <anthony.xu@intel.com>.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index 284894b..3e9bfff 100644
--- a/memory.c
+++ b/memory.c
@@ -1505,13 +1505,14 @@ static void memory_region_finalize(Object *obj)
      * and cause an infinite loop.
      */
     mr->enabled = false;
-    memory_region_transaction_begin();
-    while (!QTAILQ_EMPTY(&mr->subregions)) {
-        MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
-        memory_region_del_subregion(mr, subregion);
+    if (!mr->subpage) {
+        memory_region_transaction_begin();
+        while (!QTAILQ_EMPTY(&mr->subregions)) {
+            MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
+            memory_region_del_subregion(mr, subregion);
+        }
+        memory_region_transaction_commit();
     }
-    memory_region_transaction_commit();
-
     mr->destructor(mr);
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
-- 
1.9.1
