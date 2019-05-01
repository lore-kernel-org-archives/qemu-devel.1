Received: from eggs.gnu.org ([209.51.188.92]:46665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs2-0001z7-DJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxs0-0007xl-5q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLxrw-0007uz-KU
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so121951pfo.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 15:38:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  1 May 2019 15:38:18 -0700
Message-Id: <20190501223819.8584-2-richard.henderson@linaro.org>
In-Reply-To: <20190501223819.8584-1-richard.henderson@linaro.org>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] configure: Distinguish ppc64 and ppc64le
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org

We cannot use the ppc64le host compiler to build ppc64(be) guest code.
Clean up confusion between cross_cc_powerpc and cross_cc_ppc; make use
of the cflags variable as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5..234cb929ca 100755
--- a/configure
+++ b/configure
@@ -198,7 +198,7 @@ supported_kvm_target() {
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
         mips:mips | mipsel:mips | \
-        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | \
+        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
         s390x:s390x)
             return 0
         ;;
@@ -502,8 +502,11 @@ cross_cc_arm="arm-linux-gnueabihf-gcc"
 cross_cc_cflags_armeb="-mbig-endian"
 cross_cc_i386="i386-pc-linux-gnu-gcc"
 cross_cc_cflags_i386=""
-cross_cc_powerpc="powerpc-linux-gnu-gcc"
-cross_cc_powerpc="powerpc-linux-gnu-gcc"
+cross_cc_ppc="powerpc-linux-gnu-gcc"
+cross_cc_cflags_ppc="-m32"
+cross_cc_ppc64="powerpc-linux-gnu-gcc"
+cross_cc_cflags_ppc64="-m64"
+cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"
 
 enabled_cross_compilers=""
 
@@ -700,7 +703,11 @@ elif check_define __sparc__ ; then
   fi
 elif check_define _ARCH_PPC ; then
   if check_define _ARCH_PPC64 ; then
-    cpu="ppc64"
+    if check_define _LITTLE_ENDIAN ; then
+      cpu="ppc64le"
+    else
+      cpu="ppc64"
+    fi
   else
     cpu="ppc"
   fi
@@ -731,10 +738,14 @@ ARCH=
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
   ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
-    cpu="$cpu"
     supported_cpu="yes"
     eval "cross_cc_${cpu}=\$host_cc"
   ;;
+  ppc64le)
+    ARCH="ppc64"
+    supported_cpu="yes"
+    cross_cc_ppc64le=$host_cc
+  ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
     supported_cpu="yes"
@@ -1525,8 +1536,8 @@ case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
-           cross_cc_powerpc=$cc
-           cross_cc_cflags_powerpc=$CPU_CFLAGS
+           cross_cc_ppc=$cc
+           cross_cc_cflags_ppc="$CPU_CFLAGS"
            ;;
     ppc64)
            CPU_CFLAGS="-m64"
@@ -2379,7 +2390,7 @@ if test "$seccomp" != "no" ; then
     arm|aarch64)
         libseccomp_minver="2.2.3"
         ;;
-    ppc|ppc64|s390x)
+    ppc|ppc64|ppc64le|s390x)
         libseccomp_minver="2.3.0"
         ;;
     *)
@@ -6160,7 +6171,7 @@ if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
         fi
     done
 fi
-if test "$cpu" = "ppc64" && test "$targetos" != "Darwin" ; then
+if test "$ARCH" = "ppc64" && test "$targetos" != "Darwin" ; then
   roms="$roms spapr-rtas"
 fi
 
@@ -7345,7 +7356,7 @@ if test "$linux" = "yes" ; then
   i386|x86_64|x32)
     linux_arch=x86
     ;;
-  ppc|ppc64)
+  ppc|ppc64|ppc64le)
     linux_arch=powerpc
     ;;
   s390x)
@@ -7506,7 +7517,8 @@ case "$target_name" in
   ;;
   ppc)
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
-    target_compiler=$cross_cc_powerpc
+    target_compiler=$cross_cc_ppc
+    target_compiler_cflags="$cross_cc_cflags_ppc"
   ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
@@ -7514,6 +7526,7 @@ case "$target_name" in
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
     target_compiler=$cross_cc_ppc64
+    target_compiler_cflags="$cross_cc_cflags_ppc64"
   ;;
   ppc64le)
     TARGET_ARCH=ppc64
@@ -7529,7 +7542,8 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64abi32
+    target_compiler=$cross_cc_ppc
+    target_compiler_cflags="$cross_cc_cflags_ppc"
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
-- 
2.17.1
