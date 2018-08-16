Received: from eggs.gnu.org ([2001:4830:134:3::10]:36423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqKBT-0005xq-Q0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqKBJ-00006w-N4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:27:33 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqKBH-00005A-Gk
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:27:23 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t25-v6so4707352wmi.3
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:27:22 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 16 Aug 2018 18:16:37 +0300
Message-Id: <20180816151637.24553-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH V2] config: split PVRDMA from RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, rebecca@bluestop.org, peter.maydell@linaro.org

In some BSD systems RDMA migration is possible while
the pvrdma device can't be used because the mremap system call
is missing.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 configure             | 55 ++++++++++++++++++++++++++++++++++++++++++-
 hw/rdma/Makefile.objs |  2 +-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 2a7796ea80..b6d37a735b 100755
--- a/configure
+++ b/configure
@@ -375,6 +375,7 @@ hax="no"
 hvf="no"
 whpx="no"
 rdma=""
+pvrdma=""
 gprof="no"
 debug_tcg="no"
 debug="no"
@@ -1363,6 +1364,10 @@ for opt do
   ;;
   --disable-rdma) rdma="no"
   ;;
+  --enable-pvrdma) pvrdma="yes"
+  ;;
+  --disable-pvrdma) pvrdma="no"
+  ;;
   --with-gtkabi=*) gtkabi="$optarg"
   ;;
   --disable-vte) vte="no"
@@ -1669,7 +1674,8 @@ disabled with --disable-FEATURE, default is enabled if available:
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
   whpx            Windows Hypervisor Platform acceleration support
-  rdma            Enable RDMA-based migration and PVRDMA support
+  rdma            Enable RDMA-based migration
+  pvrdma          Enable PVRDMA support
   vde             support for vde network
   netmap          support for netmap network
   linux-aio       Linux AIO support
@@ -3064,6 +3070,48 @@ EOF
   fi
 fi
 
+##########################################
+# PVRDMA detection
+
+cat > $TMPC <<EOF &&
+#include <sys/mman.h>
+
+int
+main(void)
+{
+    char buf = 0;
+    void *addr = &buf;
+    addr = mremap(addr, 0, 1, MREMAP_MAYMOVE | MREMAP_FIXED);
+
+    return 0;
+}
+EOF
+
+if test "$rdma" = "yes" ; then
+    case "$pvrdma" in
+    "")
+        if compile_prog "" ""; then
+            pvrdma="yes"
+        else
+            pvrdma="no"
+        fi
+        ;;
+    "yes")
+        if ! compile_prog "" ""; then
+            error_exit "PVRDMA is not supported since mremap is not implemented"
+        fi
+        pvrdma="yes"
+        ;;
+    "no")
+        pvrdma="no"
+        ;;
+    esac
+else
+    if test "$pvrdma" = "yes" ; then
+        error_exit "PVRDMA requires rdma suppport"
+    fi
+    pvrdma="no"
+fi
 
 ##########################################
 # VNC SASL detection
@@ -5952,6 +6000,7 @@ if test "$tcg" = "yes" ; then
 fi
 echo "malloc trim support $malloc_trim"
 echo "RDMA support      $rdma"
+echo "PVRDMA support    $pvrdma"
 echo "fdt support       $fdt"
 echo "membarrier        $membarrier"
 echo "preadv support    $preadv"
@@ -6708,6 +6757,10 @@ if test "$rdma" = "yes" ; then
   echo "RDMA_LIBS=$rdma_libs" >> $config_host_mak
 fi
 
+if test "$pvrdma" = "yes" ; then
+  echo "CONFIG_PVRDMA=y" >> $config_host_mak
+fi
+
 if test "$have_rtnetlink" = "yes" ; then
   echo "CONFIG_RTNETLINK=y" >> $config_host_mak
 fi
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
index 3504c39d21..bd36cbf51c 100644
--- a/hw/rdma/Makefile.objs
+++ b/hw/rdma/Makefile.objs
@@ -1,4 +1,4 @@
-ifeq ($(CONFIG_RDMA),y)
+ifeq ($(CONFIG_PVRDMA),y)
 obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
 obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
                      vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
-- 
2.17.1
