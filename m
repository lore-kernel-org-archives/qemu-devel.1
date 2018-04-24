Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzng-0006Tt-28
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzne-0005Ip-3f
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAznd-0005H5-TH
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:24:10 -0400
Received: by mail-wm0-x241.google.com with SMTP id f6so1802899wmc.4
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:24:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:21 +0100
Message-Id: <20180424152405.10304-3-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/46] configure: add test for docker
 availability
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

This tests for a working docker installation without sudo and sets up
config-host.mak accordingly. This will be useful from cross compiling
things in the future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configure b/configure
index 0a19b033bc..b0ae632ee4 100755
--- a/configure
+++ b/configure
@@ -451,6 +451,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+docker="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -5413,6 +5414,17 @@ EOF
   fi
 fi
 
+##########################################
+# Docker and cross-compiler support
+#
+# This is specifically for building test
+# cases for foreign architectures, not
+# cross-compiling QEMU itself.
+
+if has "docker"; then
+    docker=$($python $source_path/tests/docker/docker.py probe)
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -5874,6 +5886,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "docker            $docker"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6697,6 +6710,10 @@ if test "$gcov" = "yes" ; then
   echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
+if test "$docker" != "no"; then
+    echo "HAVE_USER_DOCKER=y" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
-- 
2.17.0
