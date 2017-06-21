Received: from eggs.gnu.org ([2001:4830:134:3::10]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckJ-0002PB-P2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckG-0004yt-OA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:52640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckG-0004yR-Gw
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:20 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:47 +0800
Message-Id: <1498040401-16361-2-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 01/15] configure: add the disable-tcg option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Add the disable-tcg option into configure and echo CONFIG_TCG=y into
$config_target_mak. The default tcg is enabled for all build. If tcg
is disabled in the build, only i386|x86_64 softmmu option can be disabled,
other softmmu of tagets and users build defaultly enabled the tcg. This
operation do not make big change with the older build command.

The new configure build command like below
(1)./configure
   tcg is defaultly enabled
(2)./configure --disable-tcg
   tcg is disabled in i386 and x86_64 softmmu build
   tcg is enabled in others softmmu and all users build
(3)./configure --disable-tcg --target-list=x86_64-softmmu, x86_64-linux-user
   tcg is disabled in x86_64 softmmu build
   tcg is enabled in x86_64 linux user build

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 configure | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index ff0f8b9..b4d80e5 100755
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
@@ -5117,7 +5122,6 @@ echo "module support    $modules"
 echo "host CPU          $cpu"
 echo "host big endian   $bigendian"
 echo "target list       $target_list"
-echo "tcg debug enabled $debug_tcg"
 echo "gprof enabled     $gprof"
 echo "sparse enabled    $sparse"
 echo "strip binaries    $strip_opt"
@@ -5171,6 +5175,11 @@ echo "Linux AIO support $linux_aio"
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
@@ -6229,6 +6238,7 @@ fi
 if test "$target_user_only" = "yes" ; then
   echo "CONFIG_USER_ONLY=y" >> $config_target_mak
   echo "CONFIG_QEMU_INTERP_PREFIX=\"$interp_prefix1\"" >> $config_target_mak
+  echo "CONFIG_TCG=y" >> $config_target_mak
 fi
 if test "$target_linux_user" = "yes" ; then
   echo "CONFIG_LINUX_USER=y" >> $config_target_mak
@@ -6248,6 +6258,22 @@ if test "$target_bsd_user" = "yes" ; then
   echo "CONFIG_BSD_USER=y" >> $config_target_mak
 fi
 
+case "$target_name" in
+  alpha|arm|armeb|aarch64|cris|hppa|lm32|m68k|microblaze|microblazeel|mips|mipsel| \
+  mipsn32|mipsn32el|mips64|mips64el|moxie|nios2|or1k|ppc|ppcemb|ppc64|ppc64le|ppc64abi32| \
+  sh4|sh4eb|sparc|sparc64|sparc32plus|s390x|tilegx|tricore|unicore32|xtensa|xtensaeb)
+  if test "$target_softmmu" = "yes" ; then
+    echo "CONFIG_TCG=y" >> $config_target_mak
+  fi
+  ;;
+esac
+case "$target_name" in
+  i386|x86_64)
+  if test "$tcg" = "yes" -a "$target_softmmu" = "yes" ; then
+    echo "CONFIG_TCG=y" >> $config_target_mak
+  fi
+  ;;
+esac
 # generate QEMU_CFLAGS/LDFLAGS for targets
 
 cflags=""
-- 
1.9.1
