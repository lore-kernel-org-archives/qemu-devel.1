Received: from eggs.gnu.org ([2001:4830:134:3::10]:46885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAznj-0006Wf-7m
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzni-0005Rd-9M
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:15 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAzni-0005QN-2Y
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:14 -0400
Received: by mail-wr0-x242.google.com with SMTP id c14-v6so10251727wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:24:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:24 +0100
Message-Id: <20180424152405.10304-6-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/46] configure: allow user to specify
 --cross-cc-cflags-foo=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As an individual compiler may be able to support several targets with
the appropriate flags we need to expose this to the user as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fix up the cross-cc
---
 configure | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure b/configure
index ffd96d930f..282e1f1e2b 100755
--- a/configure
+++ b/configure
@@ -454,7 +454,10 @@ docker="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
+cross_cc_aarch64_be="$cross_cc_aarch64"
+cross_cc_cflags_aarch64_be="-mbig-endian"
 cross_cc_arm="arm-linux-gnueabihf-gcc"
+cross_cc_cflags_armeb="-mbig-endian"
 cross_cc_powerpc="powerpc-linux-gnu-gcc"
 cross_cc_i386="i386-pc-linux-gnu-gcc"
 cross_cc_cflags_i386=""
@@ -493,6 +496,9 @@ for opt do
   ;;
   --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
   ;;
+  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-flags-}; cc_arch=${cc_arch%%=*}
+                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
+  ;;
   --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
                 eval "cross_cc_${cc_arch}=\$optarg"
   ;;
@@ -6830,6 +6836,7 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
     target_compiler=$cross_cc_arm
+    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   aarch64|aarch64_be)
     TARGET_ARCH=aarch64
@@ -6838,6 +6845,7 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
     target_compiler=$cross_cc_aarch64
+    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   cris)
     target_compiler=$cross_cc_cris
-- 
2.17.0
