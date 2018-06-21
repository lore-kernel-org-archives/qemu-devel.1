Received: from eggs.gnu.org ([2001:4830:134:3::10]:53007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2p-0000sr-Bc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2o-0000XI-4A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:11 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt2n-0000WK-TH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:10 -0400
Received: by mail-wr0-x244.google.com with SMTP id w7-v6so1812681wrn.6
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:26:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:12 +0100
Message-Id: <20180621062605.941-5-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 04/57] configure: allow user to specify
 --cross-cc-cflags-foo=
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

As an individual compiler may be able to support several targets with
the appropriate flags we need to expose this to the user as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/configure b/configure
index a5676cf15f..259938e177 100755
--- a/configure
+++ b/configure
@@ -459,10 +459,14 @@ docker="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
+cross_cc_aarch64_be="$cross_cc_aarch64"
+cross_cc_cflags_aarch64_be="-mbig-endian"
 cross_cc_arm="arm-linux-gnueabihf-gcc"
+cross_cc_cflags_armeb="-mbig-endian"
 cross_cc_i386="i386-pc-linux-gnu-gcc"
 cross_cc_cflags_i386=""
 cross_cc_powerpc="powerpc-linux-gnu-gcc"
+cross_cc_powerpc="powerpc-linux-gnu-gcc"
 
 enabled_cross_compilers=""
 
@@ -498,6 +502,9 @@ for opt do
   ;;
   --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
   ;;
+  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-flags-}; cc_arch=${cc_arch%%=*}
+                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
+  ;;
   --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
                 eval "cross_cc_${cc_arch}=\$optarg"
   ;;
@@ -1527,6 +1534,7 @@ Advanced options (experts only):
   --extra-cxxflags=CXXFLAGS append extra C++ compiler flags QEMU_CXXFLAGS
   --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
   --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
+  --cross-cc-flags-ARCH=   use compiler flags when building ARCH guest tests
   --make=MAKE              use specified make [$make]
   --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
@@ -6883,6 +6891,7 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
     target_compiler=$cross_cc_arm
+    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   aarch64|aarch64_be)
     TARGET_ARCH=aarch64
@@ -6891,6 +6900,7 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
     target_compiler=$cross_cc_aarch64
+    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   cris)
     target_compiler=$cross_cc_cris
-- 
2.17.1
