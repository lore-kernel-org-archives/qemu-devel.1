Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eHlDJ-0000qV-W4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 01:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eHlDF-00052e-8h
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 01:42:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:52827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eHlDE-00051t-WE
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 01:42:17 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 23 Nov 2017 14:41:16 +0800
Message-Id: <1511419276-31212-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2] rcu: reduce more than 7MB heap memory by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, yang.zhong@intel.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com

Since there are some issues in memory alloc/free machenism
in glibc for little chunk memory, if Qemu frequently
alloc/free little chunk memory, the glibc doesn't alloc
little chunk memory from free list of glibc and still
allocate from OS, which make the heap size bigger and bigger.

This patch introduce malloc_trim(), which will free heap memory.

Below are test results from smaps file.
(1)without patch
55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
Size:              21796 kB
Rss:               14260 kB
Pss:               14260 kB

(2)with patch
55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
Size:              21668 kB
Rss:                6940 kB
Pss:                6940 kB

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 configure  | 4 ++++
 util/rcu.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/configure b/configure
index 0e856bb..5b463d4 100755
--- a/configure
+++ b/configure
@@ -6012,6 +6012,10 @@ if test "$opengl" = "yes" ; then
   fi
 fi
 
+if test "$tcmalloc" = "yes" || test "$jemalloc" = "yes" ; then
+  echo "CONFIG_NONGLIBMALLOC=y" >> $config_host_mak
+fi
+
 if test "$avx2_opt" = "yes" ; then
   echo "CONFIG_AVX2_OPT=y" >> $config_host_mak
 fi
diff --git a/util/rcu.c b/util/rcu.c
index ca5a63e..f3e96a8 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -32,6 +32,9 @@
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#if defined(CONFIG_LINUX)
+#include <malloc.h>
+#endif
 
 /*
  * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
@@ -272,6 +275,9 @@ static void *call_rcu_thread(void *opaque)
             node->func(node);
         }
         qemu_mutex_unlock_iothread();
+#if defined(CONFIG_LINUX) && !defined(CONFIG_NONGLIBMALLOC)
+        malloc_trim(4 * 1024 * 1024);
+#endif
     }
     abort();
 }
-- 
1.9.1
