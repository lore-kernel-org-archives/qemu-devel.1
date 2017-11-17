Received: from eggs.gnu.org ([2001:4830:134:3::10]:56835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eFa4b-0000T4-QN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eFa4Y-0005Np-KD
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:24:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:56601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eFa4Y-0005Iy-C0
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:24:18 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 17 Nov 2017 14:23:34 +0800
Message-Id: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH] rcu: reduce half heap memory size by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: stefanha@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com

Since there are some issues in memory alloc/free machenism
in glibc for little chunk memory, if Qemu frequently
alloc/free little chunk memory, the glibc doesn't alloc
little chunk memory from free list of glibc and still
allocate from OS, which make the heap size bigger and bigger.

This patch introduce malloc_trim(), which will free heap memory.

Below are test results from smaps file.
55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
Size:              21796 kB
Rss:               14260 kB
Pss:               14260 kB

55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
Size:              21668 kB
Rss:                6940 kB
Pss:                6940 kB

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 util/rcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/util/rcu.c b/util/rcu.c
index ca5a63e..8d491a6 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -26,6 +26,7 @@
  * IBM's contributions to this file may be relicensed under LGPLv2 or later.
  */
 
+#include <malloc.h>
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/rcu.h"
@@ -272,6 +273,9 @@ static void *call_rcu_thread(void *opaque)
             node->func(node);
         }
         qemu_mutex_unlock_iothread();
+#ifdef CONFIG_LINUX
+        malloc_trim(0);
+#endif
     }
     abort();
 }
-- 
1.9.1
