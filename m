Received: from eggs.gnu.org ([2001:4830:134:3::10]:37240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1F-0002Vn-0A
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fGb1D-0006km-Qc
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:24344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fGb1D-0006fc-ID
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:09:19 -0400
From: junyan.he@gmx.com
Date: Thu, 10 May 2018 10:08:52 +0800
Message-Id: <1525918138-6189-4-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
Subject: [Qemu-devel] [PATCH 3/9 V5] configure: add libpmem support
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

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 configure | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/configure b/configure
index 1443422..cbb3793 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+libpmem=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1379,6 +1380,10 @@ for opt do
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
@@ -1636,6 +1641,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   crypto-afalg    Linux AF_ALG crypto backend driver
   vhost-user      vhost-user support
   capstone        capstone disassembler support
+  libpmem         libpmem support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5443,6 +5449,30 @@ EOF
 fi
 
 ##########################################
+# check for libpmem
+
+if test "$libpmem" != "no"; then
+  cat > $TMPC <<EOF
+#include <libpmem.h>
+int main(void)
+{
+  pmem_is_pmem(0, 0);
+  return 0;
+}
+EOF
+  libpmem_libs="-lpmem"
+  if compile_prog "" "$libpmem_libs" ; then
+    libs_softmmu="$libpmem_libs $libs_softmmu"
+    libpmem="yes"
+  else
+    if test "$libpmem" = "yes" ; then
+      feature_not_found "libpmem" "Install nvml or pmdk"
+    fi
+    libpmem="no"
+  fi
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -5903,6 +5933,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "libpmem support   $libpmem"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6647,6 +6678,10 @@ if test "$vxhs" = "yes" ; then
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
