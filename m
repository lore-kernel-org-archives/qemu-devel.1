Received: from eggs.gnu.org ([2001:4830:134:3::10]:35499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLkp-0006Rp-If
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLko-0001mK-J7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:27 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLko-0001lo-CT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:26 -0400
Received: by mail-wm0-x243.google.com with SMTP id u23so25602136wma.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:11:56 +0200
Message-Id: <1499166735-39360-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/22] configure: add --disable-tcg configure
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com, Anthony Liguori <aliguori@us.ibm.com>

From: Anthony Liguori <aliguori@us.ibm.com>

This lets you build without TCG (hardware accelerationor qtest only).  When
this flag is passed to configure, it will automatically filter out the target
list to only those that support KVM or Xen or HAX.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index ae69e96..806658c 100755
--- a/configure
+++ b/configure
@@ -232,7 +232,12 @@ supported_target() {
             return 1
             ;;
     esac
-    return 0
+    test "$tcg" = "yes" && return 0
+    supported_kvm_target "$1" && return 0
+    supported_xen_target "$1" && return 0
+    supported_hax_target "$1" && return 0
+    print_error "TCG disabled, but hardware accelerator not available for '$target'"
+    return 1
 }
 
 # default parameters
@@ -296,6 +301,7 @@ cap_ng=""
 attr=""
 libattr=""
 xfs=""
+tcg="yes"
 
 vhost_net="no"
 vhost_scsi="no"
@@ -1033,6 +1039,10 @@ for opt do
   ;;
   --enable-cap-ng) cap_ng="yes"
   ;;
+  --disable-tcg) tcg="no"
+  ;;
+  --enable-tcg) tcg="yes"
+  ;;
   --disable-spice) spice="no"
   ;;
   --enable-spice) spice="yes"
@@ -5195,7 +5205,6 @@ echo "module support    $modules"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
-echo "tcg debug enabled $debug_tcg"
 echo "gprof enabled     $gprof"
 echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
@@ -5250,8 +5259,12 @@ echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
 echo "HAX support       $hax"
+echo "TCG support       $tcg"
+if test "$tcg" = "yes" ; then
+    echo "TCG debug enabled $debug_tcg"
+    echo "TCG interpreter   $tcg_interpreter"
+fi
 echo "RDMA support      $rdma"
-echo "TCG interpreter   $tcg_interpreter"
 echo "fdt support       $fdt"
 echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
@@ -5694,8 +5707,11 @@ fi
 if test "$signalfd" = "yes" ; then
   echo "CONFIG_SIGNALFD=y" >> $config_host_mak
 fi
-if test "$tcg_interpreter" = "yes" ; then
-  echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
+if test "$tcg" = "yes"; then
+  echo "CONFIG_TCG=y" >> $config_host_mak
+  if test "$tcg_interpreter" = "yes" ; then
+    echo "CONFIG_TCG_INTERPRETER=y" >> $config_host_mak
+  fi
 fi
 if test "$fdatasync" = "yes" ; then
   echo "CONFIG_FDATASYNC=y" >> $config_host_mak
-- 
1.8.3.1
