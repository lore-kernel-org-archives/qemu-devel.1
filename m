Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Im-0004mb-IW
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dm9Il-0000uy-Bm
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:20 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dm9Il-0000ug-6A
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 21:57:19 -0400
Received: by mail-ua0-x243.google.com with SMTP id b3so2018467uag.3
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 18:57:19 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Sun, 27 Aug 2017 20:56:41 -0500
Message-Id: <20170828015654.2530-2-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH 01/14] hvf: add support for
 Hypervisor.framework in the configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This patch adds to the configure script the code to support the
--enable-hvf argument. If the OS is Darwin, it checks for presence of
HVF in the system. The patch also adds strings related to HVF in the
file qemu-options.hx

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 configure       | 32 ++++++++++++++++++++++++++++++++
 qemu-options.hx | 20 +++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index dd73cce62f..d9126462a1 100755
--- a/configure
+++ b/configure
@@ -309,6 +309,7 @@ vhost_vsock="no"
 vhost_user=""
 kvm="no"
 hax="no"
+hvf="no"
 rdma=""
 gprof="no"
 debug_tcg="no"
@@ -727,6 +728,7 @@ Darwin)
   bsd="yes"
   darwin="yes"
   hax="yes"
+  hvf="yes"
   LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
@@ -1027,6 +1029,10 @@ for opt do
   ;;
   --enable-hax) hax="yes"
   ;;
+  --disable-hvf) hvf="no"
+  ;;
+  --enable-hvf) hvf="yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
@@ -1499,6 +1505,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
   hax             HAX acceleration support
+  hvf             Hypervisor.framework acceleration support
   rdma            RDMA-based migration support
   vde             support for vde network
   netmap          support for netmap network
@@ -4900,6 +4907,21 @@ then
 fi
 
 
+#################################################
+# Check to see if we have the Hypervisor framework
+if [ "$darwin" == "yes" ] ; then
+  cat > $TMPC << EOF
+#include <Hypervisor/hv.h>
+int main() { return 0;}
+EOF
+  if ! compile_object ""; then
+    hvf='no'
+  else
+    hvf='yes'
+    LDFLAGS="-framework Hypervisor $LDFLAGS"
+  fi
+fi
+
 #################################################
 # Sparc implicitly links with --relax, which is
 # incompatible with -r, so --no-relax should be
@@ -5356,6 +5378,7 @@ if test "$tcg" = "yes" ; then
     echo "TCG debug enabled $debug_tcg"
     echo "TCG interpreter   $tcg_interpreter"
 fi
+echo "HVF support       $hvf"
 echo "RDMA support      $rdma"
 echo "fdt support       $fdt"
 echo "preadv support    $preadv"
@@ -6388,6 +6411,15 @@ fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
 fi
+if test "$hvf" = "yes" ; then
+  if test "$target_softmmu" = "yes" ; then
+    case "$target_name" in
+    i386|x86_64)
+      echo "CONFIG_HVF=y" >> $config_target_mak
+    ;;
+    esac
+  fi
+fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2adfff..841d75cf6c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hax or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax, hvf or tcg (default: tcg)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
@@ -66,7 +66,7 @@ Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax, hvf or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @item kernel_irqchip=on|off
@@ -120,13 +120,13 @@ ETEXI
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
-    "                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)\n"
-    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
+    "                select accelerator (kvm, xen, hax, hvf or tcg; use 'help' for a list)\n"
+    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax, hvf or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @table @option
@@ -3619,6 +3619,16 @@ applicable to MAC and Windows platform, and thus does not conflict with
 KVM.
 ETEXI
 
+DEF("enable-hvf", 0, QEMU_OPTION_enable_hvf, \
+    "-enable-hvf     enable Hypervisor.framework virtualization support\n", QEMU_ARCH_I386)
+STEXI
+@item -enable-hvf
+@findex -enable-hvf
+Enable Hypervisor.framework support. This option is only available if
+HVF support is enabled when compiling. HVF is only applicable to MAC
+platform, and thus does not conflict with KVM.
+ETEXI
+
 DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
     "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
 DEF("xen-create", 0, QEMU_OPTION_xen_create,
-- 
2.14.1
