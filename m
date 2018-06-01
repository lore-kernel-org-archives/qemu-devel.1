Received: from eggs.gnu.org ([2001:4830:134:3::10]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf9Q-0000eV-UZ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fOf9M-0000YP-Pk
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:11:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:62486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fOf9M-0000XH-Gq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:11:04 -0400
From: junyan.he@gmx.com
Date: Fri,  1 Jun 2018 16:10:26 +0800
Message-Id: <1527840629-18648-5-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH V6 4/7] configure: add libpmem support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

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

[1] PMDK (formerly known as NMVL), https://github.com/pmem/pmdk/
[2] https://github.com/pmem/pmdk/blob/38bfa652721a37fd94c0130ce0e3f5d8baa3ed40/src/libpmem/pmem.c#L33

Signed-off-by: Junyan He <junyan.he@intel.com>
Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 configure | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/configure b/configure
index a6a4616..f44d669 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+libpmem=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1381,6 +1382,10 @@ for opt do
   ;;
   --disable-git-update) git_update=no
   ;;
+  --enable-libpmem) libpmem=yes
+  ;;
+  --disable-libpmem) libpmem=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1638,6 +1643,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   crypto-afalg    Linux AF_ALG crypto backend driver
   vhost-user      vhost-user support
   capstone        capstone disassembler support
+  libpmem         libpmem support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5445,6 +5451,24 @@ EOF
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
 
@@ -5907,6 +5931,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "libpmem support   $libpmem"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6651,6 +6676,10 @@ if test "$vxhs" = "yes" ; then
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
