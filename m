Received: from eggs.gnu.org ([2001:4830:134:3::10]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqEEO-0000yO-DN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqEEK-0003uq-Du
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:06:12 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqEEK-0003tr-78
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:06:08 -0400
Received: by mail-wm0-x242.google.com with SMTP id o18-v6so3646463wmc.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 02:06:08 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 16 Aug 2018 12:06:04 +0300
Message-Id: <20180816090604.3970-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH] config: split PVRDMA from RDMA
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
the pvrdma device can't be compiled because the mremap
system call is missing.

Reported-by: Rebecca Cran <rebecca@bluestop.org>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 configure             | 41 ++++++++++++++++++++++++++++++++++++++++-
 hw/rdma/Makefile.objs |  2 +-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 2a7796ea80..92591302d7 100755
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
@@ -3064,6 +3070,34 @@ EOF
   fi
 fi
 
+##########################################
+# PVRDMA detection
+
+if test "$rdma" = "yes" ; then
+    case "$pvrdma" in
+    "")
+        if test "$bsd" = "yes"; then
+            pvrdma="no"
+        else
+            pvrdma="yes"
+        fi
+        ;;
+    "yes")
+        if test "$bsd" = "yes"; then
+            error_exit "PVRDMA is not supported for bsd"
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
@@ -5952,6 +5986,7 @@ if test "$tcg" = "yes" ; then
 fi
 echo "malloc trim support $malloc_trim"
 echo "RDMA support      $rdma"
+echo "PVRDMA support    $pvrdma"
 echo "fdt support       $fdt"
 echo "membarrier        $membarrier"
 echo "preadv support    $preadv"
@@ -6708,6 +6743,10 @@ if test "$rdma" = "yes" ; then
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
