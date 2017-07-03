Received: from eggs.gnu.org ([2001:4830:134:3::10]:57758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLp-0008Vt-Tl
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLn-0001cF-3Q
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:22067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyLm-0001bx-Qy
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:03 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:09 +0800
Message-Id: <1499076743-15477-2-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Add the disable-tcg option into configure and echo CONFIG_TCG=y into
$config_target_mak. The default tcg is enabled for all build, only i386
and x86_64 softmmu option can be disabled. This operation do not make
big change with the older build command.

The new configure build command like below
(1)./configure
   tcg is defaultly enabled

(2)./configure --disable-tcg --target-list=x86_64-softmmu
   tcg is disabled in x86_64-softmmu

(3)./configure --disable-tcg --target-list=i386-softmmu
   tcg is disabled in i386-softmmu

If the --target-list include other softmmus or user options, the configure
command will report error and configure is aborted.
The error as:
ERROR: The current aarch64-softmmu can't support disable-tcg,
    only i386-softmmu|x86_64-softmmu support disable-tcg
or
ERROR: The user build can't support disable-tcg,
    only i386-softmmu|x86_64-softmmu support disable-tcg

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 configure | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index c571ad1..61ce514 100755
--- a/configure
+++ b/configure
@@ -224,6 +224,7 @@ cap_ng=""
 attr=""
 libattr=""
 xfs=""
+tcg="yes"
 
 vhost_net="no"
 vhost_scsi="no"
@@ -953,6 +954,10 @@ for opt do
   ;;
   --enable-hax) hax="yes"
   ;;
+  --disable-tcg) tcg="no"
+  ;;
+  --enable-tcg) tcg="yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
@@ -1715,6 +1720,24 @@ case " $target_list " in
   ;;
 esac
 
+if test "$tcg" = "no"; then
+   for target in $target_list; do
+      if test "$softmmu" = "yes"; then
+        case $target in
+           i386-softmmu|x86_64-softmmu)
+           ;;
+        *)
+           error_exit "The current $target can't support disable-tcg,"\
+              "only i386-softmmu|x86_64-softmmu support disable-tcg"
+           ;;
+        esac
+     else
+        error_exit "The user build can't support disable-tcg,"\
+           "only i386-softmmu|x86_64-softmmu support disable-tcg"
+     fi
+   done
+fi
+
 feature_not_found() {
   feature=$1
   remedy=$2
@@ -5119,7 +5142,6 @@ echo "module support    $modules"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
-echo "tcg debug enabled $debug_tcg"
 echo "gprof enabled     $gprof"
 echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
@@ -5173,6 +5195,11 @@ echo "Linux AIO support $linux_aio"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
+echo "TCG support       $tcg"
+if test "$tcg" = "yes" ; then
+    echo "TCG debug enabled $debug_tcg"
+    echo "TCG interpreter   $tcg_interpreter"
+fi
 echo "HAX support       $hax"
 echo "RDMA support      $rdma"
 echo "TCG interpreter   $tcg_interpreter"
@@ -6231,6 +6258,7 @@ fi
 if test "$target_user_only" = "yes" ; then
   echo "CONFIG_USER_ONLY=y" >> $config_target_mak
   echo "CONFIG_QEMU_INTERP_PREFIX=\"$interp_prefix1\"" >> $config_target_mak
+  echo "CONFIG_TCG=y" >> $config_target_mak
 fi
 if test "$target_linux_user" = "yes" ; then
   echo "CONFIG_LINUX_USER=y" >> $config_target_mak
@@ -6250,6 +6278,19 @@ if test "$target_bsd_user" = "yes" ; then
   echo "CONFIG_BSD_USER=y" >> $config_target_mak
 fi
 
+if test "$target_softmmu" = "yes" ; then
+   case "$target_name" in
+     i386|x86_64)
+       if test "$tcg" = "yes" ; then
+         echo "CONFIG_TCG=y" >> $config_target_mak
+       fi
+       ;;
+     *)
+       echo "CONFIG_TCG=y" >> $config_target_mak
+       ;;
+   esac
+fi
+
 # generate QEMU_CFLAGS/LDFLAGS for targets
 
 cflags=""
-- 
1.9.1
