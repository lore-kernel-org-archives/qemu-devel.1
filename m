Received: from eggs.gnu.org ([2001:4830:134:3::10]:35017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoD-0006Um-Sm
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoB-0006JP-2h
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:41 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoA-0006J1-Pl
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:39 -0400
Received: by mail-wr0-x241.google.com with SMTP id k16-v6so169504wro.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:40 +0100
Message-Id: <20180619154435.18898-2-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/56] configure: add support for --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This allows us to specify cross compilers for our guests. This is
useful for building test images/programs. Currently we re-run the
compile test for each target. I couldn't think of a way to cache the
value for a given arch without getting messier configure code.

The cross compiler for the guest is visible to each target as
CROSS_CC_GUEST in config-target.mak.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit...
  - --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
  - add remaining target_compiler definitions
v4
  - also set cross_cc_$cpu=$host_cc
  - try a non-static build if static fails
  - use write_c_skeleton
  - add doc string in help

diff --git a/configure b/configure
index a8c4094c87..089de03918 100755
--- a/configure
+++ b/configure
@@ -458,6 +458,13 @@ vxhs=""
 libxml2=""
 docker="no"
 
+# cross compilers defaults, can be overridden with --cross-cc-ARCH
+cross_cc_aarch64="aarch64-linux-gnu-gcc"
+cross_cc_arm="arm-linux-gnueabihf-gcc"
+cross_cc_powerpc="powerpc-linux-gnu-gcc"
+
+enabled_cross_compilers=""
+
 supported_cpu="no"
 supported_os="no"
 bogus_os="no"
@@ -488,6 +495,11 @@ for opt do
   ;;
   --disable-debug-info) debug_info="no"
   ;;
+  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
+  ;;
+  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
+                eval "cross_cc_${cc_arch}=\$optarg"
+  ;;
   esac
 done
 # OS specific
@@ -676,30 +688,37 @@ case "$cpu" in
   ppc|ppc64|s390|s390x|sparc64|x32)
     cpu="$cpu"
     supported_cpu="yes"
+    eval "cross_cc_${cpu}=\$host_cc"
   ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
     supported_cpu="yes"
+    cross_cc_i386=$host_cc
   ;;
   x86_64|amd64)
     cpu="x86_64"
     supported_cpu="yes"
+    cross_cc_x86_64=$host_cc
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
     supported_cpu="yes"
+    cross_cc_arm=$host_cc
   ;;
   aarch64)
     cpu="aarch64"
     supported_cpu="yes"
+    cross_cc_aarch64=$host_cc
   ;;
   mips*)
     cpu="mips"
     supported_cpu="yes"
+    cross_cc_mips=$host_cc
   ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
     supported_cpu="yes"
+    cross_cc_sparc=$host_cc
   ;;
   *)
     # This will result in either an error or falling back to TCI later
@@ -917,6 +936,8 @@ for opt do
   ;;
   --disable-debug-info)
   ;;
+  --cross-cc-*)
+  ;;
   --enable-modules)
       modules="yes"
   ;;
@@ -1501,6 +1522,7 @@ Advanced options (experts only):
   --extra-cflags=CFLAGS    append extra C compiler flags QEMU_CFLAGS
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags QEMU_CXXFLAGS
   --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
+  --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
   --make=MAKE              use specified make [$make]
   --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
@@ -6820,6 +6842,9 @@ case "$target" in
     ;;
 esac
 
+target_compiler=""
+target_compiler_static=""
+
 mkdir -p $target_dir
 echo "# Automatically generated by configure - do not modify" > $config_target_mak
 
@@ -6835,19 +6860,23 @@ TARGET_ABI_DIR=""
 case "$target_name" in
   i386)
     gdb_xml_files="i386-32bit.xml i386-32bit-core.xml i386-32bit-sse.xml"
+    target_compiler=$cross_cc_i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
     gdb_xml_files="i386-64bit.xml i386-64bit-core.xml i386-64bit-sse.xml"
+    target_compiler=$cross_cc_x86_64
   ;;
   alpha)
     mttcg="yes"
+    target_compiler=$cross_cc_alpha
   ;;
   arm|armeb)
     TARGET_ARCH=arm
     bflt="yes"
     mttcg="yes"
     gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
+    target_compiler=$cross_cc_arm
   ;;
   aarch64|aarch64_be)
     TARGET_ARCH=aarch64
@@ -6855,59 +6884,74 @@ case "$target_name" in
     bflt="yes"
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
+    target_compiler=$cross_cc_aarch64
   ;;
   cris)
+    target_compiler=$cross_cc_cris
   ;;
   hppa)
     mttcg="yes"
+    target_compiler=$cross_cc_hppa
   ;;
   lm32)
+    target_compiler=$cross_cc_lm32
   ;;
   m68k)
     bflt="yes"
     gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
+    target_compiler=$cross_cc_m68k
   ;;
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
     bflt="yes"
     echo "TARGET_ABI32=y" >> $config_target_mak
+    target_compiler=$cross_cc_microblaze
   ;;
   mips|mipsel)
     TARGET_ARCH=mips
+    target_compiler=$cross_cc_mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
   ;;
   mipsn32|mipsn32el)
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
+    target_compiler=$cross_cc_mipsn32
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips64|mips64el)
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
+    target_compiler=$cross_cc_mips64
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
   ;;
   moxie)
+    target_compiler=$cross_cc_moxie
   ;;
   nios2)
+    target_compiler=$cross_cc_nios2
   ;;
   or1k)
+    target_compiler=$cross_cc_or1k
     TARGET_ARCH=openrisc
     TARGET_BASE_ARCH=openrisc
   ;;
   ppc)
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
+    target_compiler=$cross_cc_powerpc
   ;;
   ppcemb)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
+    target_compiler=$cross_cc_ppcemb
   ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
+    target_compiler=$cross_cc_ppc64
   ;;
   ppc64le)
     TARGET_ARCH=ppc64
@@ -6915,6 +6959,7 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
+    target_compiler=$cross_cc_ppc64le
   ;;
   ppc64abi32)
     TARGET_ARCH=ppc64
@@ -6922,45 +6967,57 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
+    target_compiler=$cross_cc_ppc64abi32
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
+    target_compiler=$cross_cc_riscv32
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
+    target_compiler=$cross_cc_riscv64
   ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
+    target_compiler=$cross_cc_sh4
   ;;
   sparc)
+    target_compiler=$cross_cc_sparc
   ;;
   sparc64)
     TARGET_BASE_ARCH=sparc
+    target_compiler=$cross_cc_sparc64
   ;;
   sparc32plus)
     TARGET_ARCH=sparc64
     TARGET_BASE_ARCH=sparc
     TARGET_ABI_DIR=sparc
+    target_compiler=$cross_cc_sparc32plus
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
     mttcg=yes
     gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
+    target_compiler=$cross_cc_s390x
   ;;
   tilegx)
+    target_compiler=$cross_cc_tilegx
   ;;
   tricore)
+    target_compiler=$cross_cc_tricore
   ;;
   unicore32)
+    target_compiler=$cross_cc_unicore32
   ;;
   xtensa|xtensaeb)
     TARGET_ARCH=xtensa
     mttcg="yes"
+    target_compiler=$cross_cc_xtensa
   ;;
   *)
     error_exit "Unsupported target CPU"
@@ -6971,6 +7028,27 @@ if [ "$TARGET_BASE_ARCH" = "" ]; then
   TARGET_BASE_ARCH=$TARGET_ARCH
 fi
 
+# Do we have a cross compiler for this target?
+if has $target_compiler; then
+
+    write_c_skeleton
+
+    if ! do_compiler $target_compiler -o $TMPE $TMPC -static ; then
+        # For host systems we might get away with building without -static
+        if ! do_compiler $target_compiler -o $TMPE $TMPC ; then
+            target_compiler=""
+        else
+            enabled_cross_compilers="${enabled_cross_compilers} ${target_compiler}"
+            target_compiler_static="n"
+        fi
+    else
+        enabled_cross_compilers="${enabled_cross_compilers} ${target_compiler}"
+        target_compiler_static="y"
+    fi
+else
+    target_compiler=""
+fi
+
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
 
 upper() {
@@ -7044,6 +7122,14 @@ if test "$target_bsd_user" = "yes" ; then
   echo "CONFIG_BSD_USER=y" >> $config_target_mak
 fi
 
+if test -n "$target_compiler"; then
+  echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
+
+  if test -n "$target_compiler_static"; then
+      echo "CROSS_CC_GUEST_STATIC=$target_compiler_static" >> $config_target_mak
+  fi
+fi
+
 # generate QEMU_CFLAGS/LDFLAGS for targets
 
 cflags=""
@@ -7166,6 +7252,12 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
 done # for target in $targets
 
+if test -n "$enabled_cross_compilers"; then
+    echo
+    echo "NOTE: cross-compilers enabled:"
+    printf '%s\n' $enabled_cross_compilers | sort -u
+fi
+
 if [ "$fdt" = "git" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
-- 
2.17.1
