Received: from eggs.gnu.org ([2001:4830:134:3::10]:40542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eI7WP-00028J-P1
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eI7WM-00066P-8W
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:31:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:59862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eI7WM-00065g-1T
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 01:31:30 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 24 Nov 2017 14:30:30 +0800
Message-Id: <1511505030-3669-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v3] rcu: reduce more than 7MB heap memory by
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
 configure  | 29 +++++++++++++++++++++++++++++
 util/rcu.c |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/configure b/configure
index 0c6e757..6292ab0 100755
--- a/configure
+++ b/configure
@@ -426,6 +426,7 @@ vxhs=""
 supported_cpu="no"
 supported_os="no"
 bogus_os="no"
+malloc_trim="yes"
 
 # parse CC options first
 for opt do
@@ -3857,6 +3858,30 @@ if test "$tcmalloc" = "yes" && test "$jemalloc" = "yes" ; then
     exit 1
 fi
 
+# Even if malloc_trim() is available, these non-libc memory allocators
+# do not support it.
+if test "$tcmalloc" = "yes" || test "$jemalloc" = "yes" ; then
+    if test "$malloc_trim" = "yes" ; then
+        echo "Disabling malloc_trim with non-libc memory allocator"
+    fi
+    malloc_trim="no"
+fi
+
+#######################################
+# malloc_trim
+
+if test "$malloc_trim" != "no" ; then
+    cat > $TMPC << EOF
+#include <malloc.h>
+int main(void) { malloc_trim(0); return 0; }
+EOF
+    if compile_prog "" "" ; then
+        malloc_trim="yes"
+    else
+        malloc_trim="no"
+    fi
+fi
+
 ##########################################
 # tcmalloc probe
 
@@ -6012,6 +6037,10 @@ if test "$opengl" = "yes" ; then
   fi
 fi
 
+if test "$malloc_trim" = "yes" ; then
+  echo "CONFIG_MALLOC_TRIM=y" >> $config_host_mak
+fi
+
 if test "$avx2_opt" = "yes" ; then
   echo "CONFIG_AVX2_OPT=y" >> $config_host_mak
 fi
diff --git a/util/rcu.c b/util/rcu.c
index ca5a63e..f403b77 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -32,6 +32,9 @@
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#if defined(CONFIG_MALLOC_TRIM)
+#include <malloc.h>
+#endif
 
 /*
  * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
@@ -272,6 +275,9 @@ static void *call_rcu_thread(void *opaque)
             node->func(node);
         }
         qemu_mutex_unlock_iothread();
+#if defined(CONFIG_MALLOC_TRIM)
+        malloc_trim(4 * 1024 * 1024);
+#endif
     }
     abort();
 }
-- 
1.9.1
