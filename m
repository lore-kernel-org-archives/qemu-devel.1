Received: from eggs.gnu.org ([2001:4830:134:3::10]:51260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4JV-0008P9-4m
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4JT-0007K4-JG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:05 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4JT-0007JY-Cw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:03 -0400
Received: by mail-wm0-x244.google.com with SMTP id y5so21469588wmh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:34 +0200
Message-Id: <1499099693-22903-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
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

This lets you build without TCG (hardware accelerationor qtest only).  When
this flag is passed to configure, it will automatically filter out the target
list to only those that support KVM or Xen or HAX.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 6d1a6a9..cc8f5e3 100755
--- a/configure
+++ b/configure
@@ -227,7 +227,12 @@ supported_target() {
             fi
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
@@ -291,6 +296,7 @@ cap_ng=""
 attr=""
 libattr=""
 xfs=""
+tcg="yes"
 
 vhost_net="no"
 vhost_scsi="no"
@@ -1028,6 +1034,10 @@ for opt do
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
@@ -5190,7 +5200,6 @@ echo "module support    $modules"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
-echo "tcg debug enabled $debug_tcg"
 echo "gprof enabled     $gprof"
 echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
@@ -5245,8 +5254,12 @@ echo "ATTR/XATTR support $attr"
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
@@ -5689,8 +5702,11 @@ fi
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
