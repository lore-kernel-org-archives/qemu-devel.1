Received: from eggs.gnu.org ([2001:4830:134:3::10]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJX7-0002yA-SP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1ffJX6-0007Xw-GR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:18700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1ffJX6-0007Ug-2W
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:32:24 -0400
From: junyan.he@gmx.com
Date: Tue, 17 Jul 2018 14:32:06 +0800
Message-Id: <1531809130-31088-4-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 3/7 V10] configure: add libpmem support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Junyan He <junyan.he@intel.com>

Add a pair of configure options --{enable,disable}-libpmem to control
whether QEMU is compiled with PMDK libpmem [1].

QEMU may write to the host persistent memory (e.g. in vNVDIMM label
emulation and live migration), so it must take the proper operations
to ensure the persistence of its own writes. Depending on the CPU
models and available instructions, the optimal operation can vary [2].
PMDK libpmem have already implemented those operations on multiple CPU
models (x86 and ARM) and the logic to select the optimal ones, so QEMU
can just use libpmem rather than re-implement them.

Libpem is a part of PMDK project(formerly known as NMVL).
The project's home page is: http://pmem.io/pmdk/
And the project's repository is: https://github.com/pmem/pmdk/

For more information about libpmem APIs, you can refer to the comments
in source code of: pmdk/src/libpmem/pmem.c, begin at line 33.

Signed-off-by: Junyan He <junyan.he@intel.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 configure | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/configure b/configure
index 2a7796e..1c9288b 100755
--- a/configure
+++ b/configure
@@ -475,6 +475,7 @@ vxhs=""
 libxml2=""
 docker="no"
 debug_mutex="no"
+libpmem=""
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1435,6 +1436,10 @@ for opt do
   ;;
   --disable-debug-mutex) debug_mutex=no
   ;;
+  --enable-libpmem) libpmem=yes
+  ;;
+  --disable-libpmem) libpmem=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1710,6 +1715,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vhost-user      vhost-user support
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
+  libpmem         libpmem support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5546,6 +5552,24 @@ if has "docker"; then
 fi
 
 ##########################################
+# check for libpmem
+
+if test "$libpmem" != "no"; then
+	if $pkg_config --exists "libpmem"; then
+		libpmem="yes"
+		libpmem_libs=$($pkg_config --libs libpmem)
+		libpmem_cflags=$($pkg_config --cflags libpmem)
+		libs_softmmu="$libs_softmmu $libpmem_libs"
+		QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
+	else
+		if test "$libpmem" = "yes" ; then
+			feature_not_found "libpmem" "Install nvml or pmdk"
+		fi
+		libpmem="no"
+	fi
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -6010,6 +6034,7 @@ echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
 echo "docker            $docker"
+echo "libpmem support   $libpmem"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6763,6 +6788,10 @@ if test "$vxhs" = "yes" ; then
   echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
 fi
 
+if test "$libpmem" = "yes" ; then
+  echo "CONFIG_LIBPMEM=y" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.7.4
