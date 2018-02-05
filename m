Received: from eggs.gnu.org ([2001:4830:134:3::10]:45133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSl-0004yV-Fh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSk-0005C9-6l
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:59 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:54138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSj-0005Bs-Tj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:58 -0500
Received: by mail-wm0-x231.google.com with SMTP id t74so28416658wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:58 +0100
Message-Id: <1517858941-5538-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/47] Add the Windows Hypervisor Platform
 accelerator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

From: "Justin Terry (VM)" <juterry@microsoft.com>

Introduces the configure support for the new Windows Hypervisor Platform that
allows for hypervisor acceleration from usermode components on the Windows
platform.

Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Message-Id: <1516655269-1785-2-git-send-email-juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure       | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx |  8 ++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 0b5c812..0e79dee 100755
--- a/configure
+++ b/configure
@@ -222,6 +222,17 @@ supported_hvf_target() {
     return 1
 }
 
+supported_whpx_target() {
+    test "$whpx" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}" in
+        i386|x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
 supported_target() {
     case "$1" in
         *-softmmu)
@@ -248,6 +259,7 @@ supported_target() {
     supported_xen_target "$1" && return 0
     supported_hax_target "$1" && return 0
     supported_hvf_target "$1" && return 0
+    supported_whpx_target "$1" && return 0
     print_error "TCG disabled, but hardware accelerator not available for '$target'"
     return 1
 }
@@ -338,6 +350,7 @@ vhost_user=""
 kvm="no"
 hax="no"
 hvf="no"
+whpx="no"
 rdma=""
 gprof="no"
 debug_tcg="no"
@@ -1058,6 +1071,10 @@ for opt do
   ;;
   --enable-hvf) hvf="yes"
   ;;
+  --disable-whpx) whpx="no"
+  ;;
+  --enable-whpx) whpx="yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
@@ -1557,6 +1574,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   kvm             KVM acceleration support
   hax             HAX acceleration support
   hvf             Hypervisor.framework acceleration support
+  whpx            Windows Hypervisor Platform acceleration support
   rdma            RDMA-based migration support
   vde             support for vde network
   netmap          support for netmap network
@@ -2456,6 +2474,30 @@ if test "$xen_pv_domain_build" = "yes" &&
 fi
 
 ##########################################
+# Windows Hypervisor Platform accelerator (WHPX) check
+if test "$whpx" != "no" ; then
+    cat > $TMPC << EOF
+#include <windows.h>
+#include <winhvplatform.h>
+#include <winhvemulation.h>
+int main(void) {
+    WHV_CAPABILITY whpx_cap;
+    WHvGetCapability(WHvCapabilityCodeFeatures, &whpx_cap, sizeof(whpx_cap));
+    return 0;
+}
+EOF
+    if compile_prog "" "-lwinhvplatform -lwinhvemulation" ; then
+        libs_softmmu="$libs_softmmu -lwinhvplatform -lwinhvemulation"
+        whpx="yes"
+    else
+        if test "$whpx" = "yes"; then
+            feature_not_found "winhvplatform" "winhvemulation is not installed"
+        fi
+        whpx="no"
+    fi
+fi
+
+##########################################
 # Sparse probe
 if test "$sparse" != "no" ; then
   if has cgcc; then
@@ -5653,6 +5695,7 @@ echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
+echo "WHPX support      $whpx"
 echo "TCG support       $tcg"
 if test "$tcg" = "yes" ; then
     echo "TCG debug enabled $debug_tcg"
@@ -5820,7 +5863,7 @@ if test "$mingw32" = "yes" ; then
     echo "CONFIG_QGA_NTDDDISK=y" >> $config_host_mak
   fi
   if test "$guest_agent_msi" = "yes"; then
-    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak  
+    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
     echo "QEMU_GA_MSI_MINGW_DLL_PATH=${QEMU_GA_MSI_MINGW_DLL_PATH}" >> $config_host_mak
     echo "QEMU_GA_MSI_WITH_VSS=${QEMU_GA_MSI_WITH_VSS}" >> $config_host_mak
     echo "QEMU_GA_MSI_ARCH=${QEMU_GA_MSI_ARCH}" >> $config_host_mak
@@ -6753,6 +6796,9 @@ fi
 if supported_hvf_target $target; then
     echo "CONFIG_HVF=y" >> $config_target_mak
 fi
+if supported_whpx_target $target; then
+    echo "CONFIG_WHPX=y" >> $config_target_mak
+fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
diff --git a/qemu-options.hx b/qemu-options.hx
index 265cf9f..d15c171 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hax, hvf or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax, hvf, whpx or tcg (default: tcg)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
@@ -66,7 +66,7 @@ Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax, hvf or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @item kernel_irqchip=on|off
@@ -126,13 +126,13 @@ ETEXI
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
-    "                select accelerator (kvm, xen, hax, hvf or tcg; use 'help' for a list)\n"
+    "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
     "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax, hvf or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @table @option
-- 
1.8.3.1
