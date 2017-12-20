Received: from eggs.gnu.org ([2001:4830:134:3::10]:53266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eReG4-00036Z-Mg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eReG0-0003X6-Fh
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:18:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:20228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eReG0-0003Tk-5Y
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:18:00 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 20 Dec 2017 21:16:46 +0800
Message-Id: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v4] rcu: reduce more than 7MB heap memory by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, zhaoshenglong@huawei.com, yang.zhong@intel.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com

Since there are some issues in memory alloc/free machenism
in glibc for little chunk memory, if Qemu frequently
alloc/free little chunk memory, the glibc doesn't alloc
little chunk memory from free list of glibc and still
allocate from OS, which make the heap size bigger and bigger.

This patch introduce malloc_trim(), which will free heap
memory when there is no rcu call during rcu thread loop.
malloc_trim() can be enabled/disabled by --enable-malloc-trim/
--disable-malloc-trim in the Qemu configure command. The
default malloc_trim() is enabled for libc.

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
 configure  | 35 +++++++++++++++++++++++++++++++++++
 util/rcu.c |  6 ++++++
 2 files changed, 41 insertions(+)

diff --git a/configure b/configure
index 9c8aa5a..afdb1ef 100755
--- a/configure
+++ b/configure
@@ -426,6 +426,7 @@ vxhs=""
 supported_cpu="no"
 supported_os="no"
 bogus_os="no"
+malloc_trim=""
 
 # parse CC options first
 for opt do
@@ -1047,6 +1048,10 @@ for opt do
   ;;
   --enable-tcg) tcg="yes"
   ;;
+  --disable-malloc-trim) malloc_trim="no"
+  ;;
+  --enable-malloc-trim) malloc_trim="yes"
+  ;;
   --disable-spice) spice="no"
   ;;
   --enable-spice) spice="yes"
@@ -1466,6 +1471,7 @@ Advanced options (experts only):
                            Default:trace-<pid>
   --disable-slirp          disable SLIRP userspace network connectivity
   --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
+  --enable-malloc-trim     enable libc malloc_trim() for memory optimization
   --oss-lib                path to OSS library
   --cpu=CPU                Build for host CPU [$cpu]
   --with-coroutine=BACKEND coroutine backend. Supported options:
@@ -3860,6 +3866,30 @@ if test "$tcmalloc" = "yes" && test "$jemalloc" = "yes" ; then
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
 
@@ -5505,6 +5535,7 @@ if test "$tcg" = "yes" ; then
     echo "TCG debug enabled $debug_tcg"
     echo "TCG interpreter   $tcg_interpreter"
 fi
+echo "malloc trim support $malloc_trim"
 echo "RDMA support      $rdma"
 echo "fdt support       $fdt"
 echo "preadv support    $preadv"
@@ -6015,6 +6046,10 @@ if test "$opengl" = "yes" ; then
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
index ca5a63e..f4d09c8 100644
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
@@ -246,6 +249,9 @@ static void *call_rcu_thread(void *opaque)
                 qemu_event_reset(&rcu_call_ready_event);
                 n = atomic_read(&rcu_call_count);
                 if (n == 0) {
+#if defined(CONFIG_MALLOC_TRIM)
+                    malloc_trim(4 * 1024 * 1024);
+#endif
                     qemu_event_wait(&rcu_call_ready_event);
                 }
             }
-- 
1.9.1
